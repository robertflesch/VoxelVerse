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
	import com.voxelengine.worldmodel.oxel.Oxel;
	
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.FlowInfo;
	
	// * @author Robert Flesch
	public class LightTask extends AbstractTask 
	{		
		protected var _guid:String;
		protected var _gc:GrainCursor;
		private var _id:String;
		private var _color:Vector3D;
		public function get id():String { return _id; }
		public function get color():Vector3D { return _color; }
		
		public static const TASK_TYPE:String = "LIGHT_TASK";
        public static const TASK_PRIORITY:int = 1;
		
		public function LightTask( $instanceGuid:String, $gc:GrainCursor, $id:String, $color:Vector3D, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			// The model containing the grain 
			_guid = $instanceGuid
			// the grain id
			_gc = GrainCursorPool.poolGet( $gc.bound );
			_gc.copyFrom( $gc );
			_id = $id;
			_color = $color;
			super($taskType, $taskPriority);
		}

		override public function complete():void
		{
			GrainCursorPool.poolDispose( _gc );
			super.complete();
		}
	}
}