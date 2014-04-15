/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.flowtasks
{
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent;

	import com.developmentarc.core.tasks.events.TaskEvent;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.InteractionParams;
	import com.voxelengine.worldmodel.oxel.FlowInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.flowtasks.FlowTask;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class FlowLimited extends FlowTask
	{		
		static public function addTask( $instanceGuid:String, gc:GrainCursor, $type:int, $flowInfo:FlowInfo, $taskPriority:int ):void 
		{
			Globals.g_flowTaskController.addTask( new FlowLimited( $instanceGuid, gc, $type, $flowInfo, "FlowLimited", FlowTask.TASK_PRIORITY + $taskPriority ) );
		}
		
		public function FlowLimited( $instanceGuid:String, $gc:GrainCursor, $type:int, $flowInfo:FlowInfo, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			Log.out( "FlowLimited.create" );
			_flowInfo = $flowInfo;
			super( $instanceGuid, $gc, $type, $taskType, $taskPriority );
			
			var pt:Timer = new Timer( 1000, 1 );
			pt.addEventListener(TimerEvent.TIMER, timeout );
			pt.start();
		}
		
		/**
		 * Defines if the task is in a ready state.
		 */
		override public function get ready():Boolean
		{
			return _ready;
		}
		
		private function timeout(e:TimerEvent):void
		{
			_ready = true;
			dispatchEvent(new TaskEvent(TaskEvent.TASK_READY));
		}
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm )
			{
				var flowOxel:Oxel = vm.oxel.childGetOrCreate( _gc );
				if ( null == flowOxel.gc )
					//Log.out( "FlowLimited.start - oxel released" );
					break main; 
					
				//////////////////////////////////////////////////////////
				// should always look down first, regardless of direction
				var flowIntoNeighbor:Oxel = null;
				if ( Globals.getTypeId( "floatium" ) == _type )
					flowIntoNeighbor = flowOxel.neighbor( Globals.POSY );
				else	
					flowIntoNeighbor = flowOxel.neighbor( Globals.NEGY );
				// is oxel above or below free?	
				var flowIntoTarget:Oxel = null;
				if ( Globals.BAD_OXEL != flowIntoNeighbor && Globals.AIR == flowIntoNeighbor.type )
				{
					flowIntoTarget = neighborGetOrCreate( flowOxel, flowIntoNeighbor );
					if ( Globals.BAD_OXEL != flowIntoTarget && Globals.AIR == flowIntoTarget.type )
					{
						flowIntoTarget.flowInfo = _flowInfo; // flowInfo has to be present when write is performed
						flowIntoTarget.write( _guid, flowIntoTarget.gc, _type );
						flowOxel.write( _guid, flowOxel.gc, Globals.AIR );
						FlowLimited.addTask( _guid, flowIntoTarget.gc, _type, flowIntoTarget.flowInfo, FlowTask.TASK_PRIORITY );
						break main;
					}
				}
					
				//////////////////////////////////////////////////////////
				// nothing below is free, so lets look in the direction of the flow
				if  ( Globals.horizontalDirections.indexOf( _flowInfo.direction ) < 0)
				{
					// If flow was down, then we have to choose another direction to look in.
					// picking a random dir for now
					var index:int = Globals.horizontalDirections[ int ( Math.random() * 4 ) ];
					flowIntoNeighbor = flowOxel.neighbor( index );
				}
				else
					// we have a valid flow direction
					flowIntoNeighbor = flowOxel.neighbor( _flowInfo.direction );
					
				if ( Globals.BAD_OXEL != flowIntoNeighbor && Globals.AIR == flowIntoNeighbor.type )
				{
					flowIntoTarget = neighborGetOrCreate( flowOxel, flowIntoNeighbor );
					if ( Globals.BAD_OXEL != flowIntoTarget && Globals.AIR == flowIntoTarget.type )
					{
						flowIntoTarget.flowInfo = _flowInfo; // flowInfo has to be present when write is performed
						flowIntoTarget.write( _guid, flowIntoTarget.gc, _type );
						//flowIntoTarget.flowInfo.direction = _flowInfo.direction;
						flowIntoTarget.flowInfo.flowScaling.scalingCalculate( flowIntoTarget );
						flowOxel.write( _guid, flowOxel.gc, Globals.AIR );
						FlowLimited.addTask( _guid, flowIntoTarget.gc, _type, flowIntoTarget.flowInfo, FlowTask.TASK_PRIORITY );
					}
					else
					{
						// cant go any farther in that direction
						if ( Globals.POSY == _flowInfo.direction || Globals.NEGY == _flowInfo.direction )
						{
							// look to sides
						}
						/*
						// The parent oxel has already been reduced to size we need
						flowOxel = $flowOxel.childGetFromDirection( Oxel.face_get_opposite( _flowInfo.direction ), BOTTOM_LEVEL, false );
						if ( Globals.AIR == flowIntoTarget.type )
						{
							flowIntoTarget.write( flowIntoTarget.gc, _type );
							flowIntoTarget.flowInfo.direction = $dir;
							flowIntoTarget.flowInfo.flowScaling.scalingCalculate( flowIntoTarget );
							flowOxel.write( flowOxel.gc, Globals.AIR );
							FlowLimited.addTask( _guid, flowIntoTarget.gc, _type, flowIntoTarget.flowInfo, FlowTask.TASK_PRIORITY );
						}
						*/
					}
				}
			}
				/*if ( Globals.AIR != flowOxel.type )
				{
					// Is it still the type I am expected?
					// I would need to do a reverse lookup.
					var toTypeName:String = Globals.Info[type].name;
					var ip:InteractionParams = Globals.Info[flowOxel.type].interactions.IOGet( toTypeName );
					var writeType:int = Globals.getTypeId( ip.type );
					//var writeType:int = Globals.Info[type].interactions.IOGet( Globals.Info[flowOxel.type].name ).type
					if ( flowOxel.type != writeType )
					{
						Log.out( "FlowLimited.start - wrong write type is: " + Globals.Info[flowOxel.type].name + " expecting: " + Globals.Info[writeType].name );
						break main; 
					}
				}
				else*/
			else
			{
				Log.out( "FlowLimited.start - VoxelModel not found: " + _guid, Log.ERROR );
			}	
			_flowInfo = null;
			
			super.complete();
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}