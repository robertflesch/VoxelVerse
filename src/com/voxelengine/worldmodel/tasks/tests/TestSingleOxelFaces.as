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
	import com.voxelengine.pools.GrainCursorPool;
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
	public class TestSingleOxelFaces extends LandscapeTask 
	{		
		public function TestSingleOxelFaces( guid:String, layer:LayerInfo ):void {
			super( guid,  layer );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();

			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var grainSize:uint = vm.oxel.size_of_grain();	
			var gc:GrainCursor = GrainCursorPool.poolGet();
			vm.oxel.cursor_copy_to( gc );
			vm.write( gc, Globals.GRASS );
			addFlowTask( gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "TestSingleOxelFaces.addFlowTask");
			Globals.g_flowTaskController.addFlowTask( new TestFlowSingleOxelFaces( _guid, gc ), true);
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}