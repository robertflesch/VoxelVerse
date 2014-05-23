/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.worldmodel.oxel.GrainCursorIntersection;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;

	import com.developmentarc.core.tasks.events.TaskEvent;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask;


	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LightSunCheck extends LightTask 
	{		
		private static var _s_sunPos:Vector3D = new Vector3D( 0, 2000, 0 );
		private var _lastLightTime:uint = 0;
		private static var _s_sunLight:Number = 0.8;
		
		private var _face:int;
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $id:uint, $face:int, $taskPriority:int = 1 ):void 
		{
			Globals.g_lightTaskController.addTask( new LightSunCheck( $instanceGuid, $gc, $id, $face, LightTask.TASK_TYPE, LightTask.TASK_PRIORITY + $taskPriority ) );
		}
		
		public function LightSunCheck( $instanceGuid:String, $gc:GrainCursor, $id:uint, $face:int, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			//Log.out( "LightSunCheck.create" );
			_face = $face;
			super( $instanceGuid, $gc, lightID );
		}
		/*
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm )
			{
				var lo:Oxel = vm.oxel.childGetOrCreate( _gc );
				if ( null == lo.gc )
					//Log.out( "LightSunCheck.start - oxel released" );
					break main; 
				if ( null == lo.brightness )
					//Log.out( "LightSunCheck.start - oxel has no light?" );
					break main; 
					

				var location:Vector3D = vm.modelToWorld( lo.faceCenterGet( _face ) );
				
				var results:Vector.<GrainCursorIntersection> = Globals.g_modelManager.pathToSun( location, _s_sunPos );
				if ( results.length )
				{
					// if I have run into something, see if I ran into myself
					var first:GrainCursorIntersection = results.shift();
					// reset results to be used again.
					results.length = 0;
					// have I intersected with myself?
					if ( first.model == vm )
						// if I did run into my own oxel, do an intra oxel check.
						vm.oxel.lineIntersectWithChildren( location, _s_sunPos, results );
						
					if ( results.length )
					{
						//Log.out( "LightSunCheck.start - path to sun blocked for: " + lo.toStringShort(), Log.ERROR );
						// If something was in the way, we should get our light from something that WASN'T in the way
						break main; 
					}
				}

				//Log.out( "LightSunCheck.start - path to sun CLEAR for: " + lo.toStringShort(), Log.ERROR );
				lo.brightness.setByFace( _face, _s_sunLight, Brightness.FIXED, lo.gc.size() ) 
				lo.quadsDeleteAll( lo.type ); // All of the quads may have changed...
				
//				Light.addTask( _guid, _gc, id );

			}
			else
			{
				Log.out( "LightSunCheck.start - VoxelModel not found: " + _guid, Log.ERROR );
			}	
			super.complete();
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
		private function lightingFromSun():void {
			
			// once a second
			if ( 1000 > (getTimer() - _lastLightTime) )
				return;
			
			if ( Globals.g_lightTaskController.queueSize() )
				return;
				
			_lastLightTime = getTimer();

			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var location:Vector3D = vm.modelToWorld( vm.instanceInfo.center );
			var results:Vector.<GrainCursorIntersection> = new Vector.<GrainCursorIntersection>();
			//this returns the axis of intersection
			vm.lineIntersect(location, _s_sunPos, results);
			trace( "VoxelModel.light  results" + results.length );
			var gci:GrainCursorIntersection = results.shift()
			
			var face:int;
			var dist1:Vector3D;
			var dist2:Vector3D;
			if ( 0 == gci.axis ) { //  AXIS_X:uint = 0;
				dist1 = vm.modelToWorld( vm.oxel.faceCenterGet( Globals.POSX ) );
				dist1 = _s_sunPos.subtract( dist1 );
				dist2 = vm.modelToWorld( vm.oxel.faceCenterGet( Globals.NEGX ) );
				dist2 = _s_sunPos.subtract( dist2 );

				if ( dist2.length > dist1.length )
					face = Globals.POSX;
				else	
					face = Globals.NEGX;
			}
			else if ( 1 == gci.axis ) // AXIS_Y:uint = 1;
			{
				dist1 = vm.modelToWorld( vm.oxel.faceCenterGet( Globals.POSY ) );
				dist1 = _s_sunPos.subtract( dist1 );
				dist2 = vm.modelToWorld( vm.oxel.faceCenterGet( Globals.NEGY ) );
				dist2 = _s_sunPos.subtract( dist2 );
				
				if ( dist2.length > dist1.length )
					face = Globals.POSY;
				else	
					face = Globals.NEGY;
			}
			else // AXIS_Z:uint = 2;
			{
				dist1 = vm.modelToWorld( vm.oxel.faceCenterGet( Globals.POSZ ) );
				dist1 = _s_sunPos.subtract( dist1 );
				dist2 =vm. modelToWorld( vm.oxel.faceCenterGet( Globals.NEGZ ) );
				dist2 = _s_sunPos.subtract( dist2 );
				
				if ( dist2.length > dist1.length )
					face = Globals.POSZ;
				else	
					face = Globals.NEGZ;
			}
			
			Oxel._s_oxelsTested = 0;
			Oxel._s_oxelsEvaluated = 0;
			Oxel._s_lightsFound = 0;
			
			//vm.oxel.lightingFromSun( instanceInfo.instanceGuid, face );

			trace( "VM.light tested: " + Oxel._s_oxelsTested );
			trace( "VM.light evaluated: " + Oxel._s_oxelsEvaluated );
			trace( "VM.light lights found: " + Oxel._s_lightsFound );
		}
		*/
	}
}