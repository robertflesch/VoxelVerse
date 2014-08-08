/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import com.developmentarc.core.tasks.tasks.AbstractTask;
	import com.voxelengine.events.LightEvent;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	
	// * @author Robert Flesch
	public class LightTask extends AbstractTask 
	{		
		protected var _guid:String; 	// The guid of model containing the grain 
		protected var _gc:GrainCursor; // grain id of thing to change
		private   var _lightID:uint;   // id of light to be added or removed
		
		public function get guid():String { return _guid; }
		public function get lightID():uint { return _lightID; }
		
		public static const TASK_TYPE:String = "LIGHT_TASK";
        public static const TASK_PRIORITY:int = 1;
		
		public function LightTask( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			
			_guid = $instanceGuid
			// the grain id
			_gc = GrainCursorPool.poolGet( $gc.bound );
			_gc.copyFrom( $gc );
			_lightID = $lightID;
			super($taskType, $taskPriority );
		}

		override public function complete():void
		{
			GrainCursorPool.poolDispose( _gc );
			super.complete();
		}
		
		static protected function isValidOxel( $le:LightEvent ):Oxel {
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
			if ( vm ) {
				var lo:Oxel = vm.oxel.childFind( $le.gc );
				if ( lo && valid( lo ) )
					return lo;
					
				Log.out( "LightTask.isValidOxel - valid oxel not found guid: " + $le.gc.toString(), Log.WARN );
				return null;
			}
			
			Log.out( "LightTask.isValidOxel - Voxel Model not found guid: " + $le.instanceGuid, Log.WARN );
			return null;
		}
		
		static protected function valid( $o:Oxel ):Boolean {
			
			if ( Globals.BAD_OXEL == $o ) // This is expected, if oxel is on edge of model
				return false;
			
			if ( !$o.lighting ) // does this oxel already have a brightness?
				return false;

			return true;
		}
	}
}