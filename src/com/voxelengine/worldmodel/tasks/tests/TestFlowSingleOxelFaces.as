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
	public class TestFlowSingleOxelFaces extends FlowTask 
	{	
		static private var count:int = 10;
		static private var count2:int = 10;
		static private var on:Boolean = false;
		public function TestFlowSingleOxelFaces( guid:String, gc:GrainCursor ):void {
			super( guid,  gc );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();

			if ( count > 10 )
			{
				count = 0;
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
				var grainSize:uint = vm.oxel.size_of_grain();	
				var gc:GrainCursor = GrainCursorPool.poolGet();
				vm.oxel.cursor_copy_to( gc );
				gc.become_child();
				
				if ( on ) {
					//if ( 2 < count2 ) {
						vm.write( gc, Globals.AIR );
						trace( "TestFlowSingleOxelFaces.start - AIR" );
						count2 = 0;
					//}
					on = false;
					count2++;
				}
				else {
					vm.write( gc, Globals.GRASS );
					trace( "TestFlowSingleOxelFaces.start - GRASS" );
					on = true;
				}
			}

			count++;
			addFlowTask(_gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "adding new TestFlowSingleOxelFaces task");
			Globals.g_flowTaskController.addFlowTask( this );
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}