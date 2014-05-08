/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import flash.geom.Vector3D;
	
	import com.developmentarc.core.tasks.tasks.AbstractTask;
	
	import com.voxelengine.Globals;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	
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
			super($taskType, $taskPriority);
		}

		override public function complete():void
		{
			GrainCursorPool.poolDispose( _gc );
			super.complete();
		}
	}
}