/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.tests
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;

	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestRemoveSequential extends LandscapeTask 
	{		
		public function TestRemoveSequential( guid:String, layer:LayerInfo ):void {
			super( guid,  layer );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();

			//trace( "TestRemove.start" );
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var gc:GrainCursor = GrainCursorPool.poolGet( vm.oxel.size_of_grain() );
			addFlowTask( gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "TestRemoveSequential.addFlowTask");
			Globals.g_flowTaskController.addFlowTask( new TestFlowRemoveSequential( _guid, gc ), true);
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}