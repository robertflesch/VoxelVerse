/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.flowtasks
{
	import com.developmentarc.core.tasks.tasks.AbstractTask;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.oxel.Oxel;
	
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.FlowInfo;
	
	// * @author Robert Flesch
	public class FlowTask extends AbstractTask 
	{		
		protected var _guid:String;
		protected var _gc:GrainCursor;
		protected var _type:int;
		protected var _ready:Boolean = false;
		protected var _flowInfo:FlowInfo;
		
		public static const TASK_TYPE:String = "FLOW_TASK";
        public static const TASK_PRIORITY:int = 1;
		
		public function FlowTask( $instanceGuid:String, $gc:GrainCursor, $type:int, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			// The model containing the grain 
			_guid = $instanceGuid
			// the grain id
			_gc = GrainCursorPool.poolGet( $gc.bound );
			_gc.copyFrom( $gc );
			// the type it is to be changed to
			_type = $type;
			
			super($taskType, $taskPriority);
		}

		protected function neighborGetOrCreate( flowOxel:Oxel, flowIntoNeighbor:Oxel ):Oxel {
			var flowIntoTarget:Oxel = null;
			var gct:GrainCursor = GrainCursorPool.poolGet( flowOxel.gc.bound );
			// this is oxel next to the one we want, but the flowIntoNeighbor might be a larger grain.
			// so find the address we want, then getChild on that oxel. Which causes the oxel to break up if needed.
			gct.copyFrom( flowOxel.gc );
			// move cursor to oxel we want.
			gct.move( _flowInfo.direction );
			// now get the possibly reduced oxel we want.
			flowIntoTarget = flowIntoNeighbor.childGetOrCreate( gct );
			GrainCursorPool.poolDispose( gct );
			return flowIntoTarget;
		}
		
		override public function complete():void
		{
			GrainCursorPool.poolDispose( _gc );
			super.complete();
		}
		
		public function get type():int 
		{
			return _type;
		}
	}
}