/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.flowtasks
{
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.FlowInfo;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent;

	import com.developmentarc.core.tasks.events.TaskEvent;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.InteractionParams;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.flowtasks.FlowTask;


	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class Flow extends FlowTask 
	{		
		static public function addTask( $instanceGuid:String, gc:GrainCursor, $type:int, $flowInfo:FlowInfo, $taskPriority:int ):void 
		{
			Globals.g_flowTaskController.addTask( new Flow( $instanceGuid, gc, $type, $flowInfo, FlowTask.TASK_TYPE, FlowTask.TASK_PRIORITY + $taskPriority ) );
		}
		
		public function Flow( $instanceGuid:String, $gc:GrainCursor, $type:int, $flowInfo:FlowInfo, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			//Log.out( "Flow.create" );
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
				if ( null == flowOxel )
					return;

				// If we are flowing from another oxel, we need to grab its count if we dont have flow info.
				if ( (null != _flowInfo) )
				{
					if ( null ==  flowOxel.flowInfo ) // existing flow info, dont copy over it. ??? RSF Not sure
						flowOxel.flowInfo = _flowInfo; // Flow info has to be present when write is performed
					else if ( FlowInfo.FLOW_TYPE_UNDEFINED == flowOxel.flowInfo.type )
						flowOxel.flowInfo = _flowInfo; // This oxel has a undefine flow type, so no data in it.
				}
				else {	
					flowOxel.flowInfo = new FlowInfo()
					flowOxel.flowInfo = Globals.Info[_type].flowInfo;
				}
					
				flowTerminal(flowOxel);
				scale( flowOxel );
			}
			else
			{
				Log.out( "Flow.start - VoxelModel not found: " + _guid, Log.ERROR );
			}	
			super.complete();
		}
		
		public function flowTerminal( flowOxel:Oxel ):void {

			var ft:int = flowOxel.flowInfo.type;
			Log.out( "Flow.flowTerminal - flowable oxel of type: " + ft );
			if ( FlowInfo.FLOW_TYPE_CONTINUOUS == ft )
				flowStartContinous(flowOxel);
			else if ( FlowInfo.FLOW_TYPE_MELT == ft )
				flowStartMelt(flowOxel);
			else if ( FlowInfo.FLOW_TYPE_SPRING == ft )
				flowStartSpring(flowOxel);
			else
				Log.out( "Flow.flowTerminal - NO FLOW TYPE FOUND", Log.ERROR );
		}
		
		private function scale( flowOxel:Oxel ):void
		{
			Log.out( "Flow.scale.start - FlowOxel scaleInfo: " + flowOxel.flowInfo.flowScaling.toString() );
			if ( flowOxel.gc.eval( 4, 0, 7, 6 ) )
				Log.out( "Flow.start - THIS ONE" );
//			if ( flowOxel.gc.eval( 4, 6, 8, 12 ) )
//				Log.out( "Flow.start - THIS ONE" );
				
			if ( flowOxel.type == _type )
			{
				Log.out( "Flow.start - ALREADY " + Globals.Info[_type].name + " here" );
				return; 
			}
			else if ( null == flowOxel.gc )
			{
				Log.out( "Flow.start - oxel released" );
				return; 
			}
				
			Log.out( "Flow.scale.past returns" );
			if ( Globals.getTypeId( "obsidian" ) == flowOxel.type )
			{
				flowOxel.flowInfo.flowScaling.scaleRecalculate( flowOxel );
			}
			else if ( Globals.AIR != flowOxel.type )
			{
				// Is it still the type I am expected?
				// I would need to do a reverse lookup.
				var toTypeName:String = Globals.Info[type].name;
				var ip:InteractionParams = Globals.Info[flowOxel.type].interactions.IOGet( toTypeName );
				var writeType:int = Globals.getTypeId( ip.type );
				//var writeType:int = Globals.Info[type].interactions.IOGet( Globals.Info[flowOxel.type].name ).type
				if ( flowOxel.type != writeType )
				{
					Log.out( "Flow.scale - wrong write type is: " + Globals.Info[flowOxel.type].name + " expecting: " + Globals.Info[writeType].name );
					return; 
				}
			}
			else
			{
				flowOxel.write( _guid, flowOxel.gc, type );
				flowOxel.flowInfo.flowScaling.scalingCalculate( flowOxel );

				// if I flow under another of the same type
				var flowUnder:Oxel = flowOxel.neighbor( Globals.POSY );
				if ( Globals.BAD_OXEL != flowUnder && flowUnder.type == flowOxel.type )
				{
					flowOxel.flowInfo.flowScaling.scalingReset( flowOxel );
				}
				// if I flow over another oxel of the same type, reset its scaling
				var flowOver:Oxel = flowOxel.neighbor( Globals.NEGY );
				if ( Globals.BAD_OXEL != flowOver && flowOver.type == flowOxel.type )
				{
					flowOver.flowInfo.flowScaling.scalingReset( flowOver );
				}
				flowOxel.flowInfo.flowScaling.neighborsRecalc( flowOxel );

				_flowInfo = null;
			}
			Log.out( "Flow.scale.end - FlowOxel scaleInfo: " + flowOxel.flowInfo.flowScaling.toString() );
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}

		private function flowStartSpring(flowOxel:Oxel):void {
		}
		
		static private const MIN_MELT_GRAIN:int = 2;
		private function flowStartMelt( flowOxel:Oxel ):void {
			// Figure out what direction I can flow in.
			// Crack oxel and send 1/8 down in flow direction
			// go from 1,1,1 to 0,0,0 for flow order
			// each child voxel should try to flow at least 8 before stopping
			if ( MIN_MELT_GRAIN > flowOxel.gc.grain )
				return;
				
			FlowFlop.addTask( _guid, flowOxel.gc, flowOxel.type, flowOxel.flowInfo, 1 );
		}

		private function flowStartContinous(flowOxel:Oxel):void {
			// Prefer going down if possible (or up for floatium)
			var fc:Vector.<FlowTest> = new Vector.<FlowTest>;
			var partial:Boolean = false;
			if ( Globals.getTypeId( "floatium" ) == type )
			{
				partial = flowable( flowOxel, Globals.POSY, fc );
			}
			else
			{
				partial = flowable( flowOxel, Globals.NEGY, fc );
			}
				
			// if there is water below us, dont do anything
			if ( 0 == fc.length && partial )
				return;
			// if we found a down, add that as a priority
			else if ( 0 < fc.length )
			{
				flowTasksAdd( fc, true, flowOxel.flowInfo );
				// if we only went partially down, try the sides	
				if ( false == partial )
					return;
				// reset list
				fc.length = 0;	
			}
				
			// no downs found, so check outs
			if ( 0 == fc.length )
			{
				// check sides once
				flowable( flowOxel, Globals.POSX, fc );
				flowable( flowOxel, Globals.NEGX, fc );
				flowable( flowOxel, Globals.POSZ, fc );
				flowable( flowOxel, Globals.NEGZ, fc );
				if ( 0 < fc.length )
				{
					flowTasksAdd( fc, false, flowOxel.flowInfo );
				}
			}
		}
		
		private function flowTasksAdd( $fc:Vector.<FlowTest>, $upOrDown:Boolean, $flowInfo:FlowInfo ):void {
			for each ( var flowTest:FlowTest in $fc )
			{
				//Log.out( "Oxel.flowTaskAdd - $count: " + $countDown + "  countOut: " + $countOut + " gc data: " + flowCanditate.gc.toString() + " tasks: " + (Globals.g_flowTaskController.queueSize() + 1) );
				var	taskPriority:int = 0;
				if ( $upOrDown )
					taskPriority = 1;
				else
					taskPriority = 3;
				
				var fi:FlowInfo = $flowInfo.clone();
				fi.direction = flowTest.dir;
				if ( 0 == fi.out )
					continue;

				Flow.addTask( _guid, flowTest.flowCandidate.gc, type, fi, taskPriority + 1 )
			}
		}
		
		static private const FLOW_NO_FACE_FOUND:int = -1;
		private function flowFindMeltableDirection(flowOxel:Oxel):int {
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				if ( Globals.POSY == face )
					continue;
					
				var no:Oxel = flowOxel.neighbor( face );
				if ( Globals.AIR == no.type )
					return face;
					
			}
			
			return FLOW_NO_FACE_FOUND;
		}
		
		private const MIN_FLOW_GRAIN:int = 2;
		private function flowable( flowOxel:Oxel, $face:int, $fc:Vector.<FlowTest> ):Boolean {
		
			var co:Oxel = flowOxel.neighbor($face);
			var partial:Boolean = false;
			var ft:FlowTest = null;
			if ( Globals.BAD_OXEL != co && co.gc && co.gc.grain >= MIN_FLOW_GRAIN )
			{
				// if our neighbor is air, just flow into it.o
				if ( co.type == Globals.AIR && !co.childrenHas() )
				{
					// Our neighbor oxel might be larger then this oxel
					// in which case just ask for oxel of same size
					if ( co.gc.grain == flowOxel.gc.grain )
					{
						ft = new FlowTest();
						ft.dir = $face;
						ft.flowCandidate = co;
						$fc.push( ft );
					}
					else	
					{
						// neighbor might be larger, never smaller
						var gct:GrainCursor = GrainCursorPool.poolGet( flowOxel.gc.bound );
						gct.copyFrom( flowOxel.gc );
						gct.move( $face );
						// getChild will crack the neighbor, if neighbor was larger to start
						var crackedOxel:Oxel = co.childGetOrCreate( gct );
						GrainCursorPool.poolDispose( gct );
						if ( Globals.BAD_OXEL != crackedOxel )
						{
							ft = new FlowTest();
							ft.dir = $face;
							ft.flowCandidate = crackedOxel;
							$fc.push( ft );
						}
					}
				}
				// if the neighbor is a flowable type, look up its interaction with that type
				else if ( Globals.Info[co.type].flowable )
				{
					if ( co.type != type )
					{
						//Log.out( "Oxel.flowable - 2 Different flow types here! getting IP for: " + Globals.Info[type].name + "  with " + Globals.Info[co.type].name );
						
						var ip:InteractionParams = Globals.Info[type].interactions.IOGet( Globals.Info[co.type].name );
						var writeType:int = Globals.getTypeId( ip.type );
						if ( type != writeType )
						{
							if ( Globals.Info[writeType].flowable )
							{
								// if write type is same as flow type, add it.
								if ( type == writeType )
								{
									ft = new FlowTest();
									ft.dir = $face;
									ft.flowCandidate = co;
									$fc.push( ft );
								}
							}
							else
							{
								co.write( _guid, co.gc, writeType, false );
								// defer the scaling until after the water has been written
								// this makes the obsidian reach up to the water, is that right?
								ft = new FlowTest();
								ft.dir = $face;
								ft.flowCandidate = co;
								$fc.push( ft );
							}
						}
					}
					else
					{
						//Log.out( "Oxel.flowable - ALREADY " + Globals.Info[co.type].name + " here" );
						if ( Globals.getTypeId( "floatium" ) == co.type )
						{
							// there is floatium above us, we should not flow out.
							if ( Globals.POSY == $face )
							{
								partial = true;
							}
						}
						else
						{
							// there is water below us, we should not flow out.
							if ( Globals.NEGY == $face )
							{
								partial = true;
							}
						}
					}
				}
				else if ( co.childrenHas() )
				{
					const dchildren:Vector.<Oxel> = co.childrenForDirection( Oxel.face_get_opposite( $face ) );
					for each ( var dchild:Oxel in dchildren ) 
					{
						if ( Globals.AIR == dchild.type )
						{
							if ( Globals.getTypeId( "floatium" ) == type )
							{
								ft = new FlowTest();
								ft.dir = $face;
								ft.flowCandidate = dchild;
								$fc.push( ft );
								partial = true;
								
							}
							else if ( flowOxel.gc.grainY == dchild.gc.grainY && flowOxel.gc.grain == dchild.gc.grain )
							{
								ft = new FlowTest();
								ft.dir = $face;
								ft.flowCandidate = dchild;
								$fc.push( ft );
								partial = true;
							}
						}
							
					}
				}
			}
			return partial;
		}
	}
}

import com.voxelengine.worldmodel.oxel.Oxel;
import com.voxelengine.worldmodel.oxel.FlowInfo;
internal class FlowTest
{
	public var flowCandidate:Oxel = null;
	public var dir:int = FlowInfo.FLOW_DIR_UNDEFINED;
}