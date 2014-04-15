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
	public class TestFlowRemoveSequential extends FlowTask 
	{	
		static private var count:int = -600;
		public function TestFlowRemoveSequential( guid:String, gc:GrainCursor ):void {
			super( guid,  gc );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();

			if ( count > 0 )
			{
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var grainSize:uint = vm.oxel.size_of_grain();						
			_gc.grain = 2;
			//trace( "TestFlowRemoveSequential.start - removing face of size:" + _gc.grain );
			var repeatCount:int = 64;
			while ( 0 < repeatCount )
			{
				vm.write( _gc, Globals.AIR );
				_gc.child_inc(grainSize);
				repeatCount--;
			}
			count = 0;
			}

			count++;
			addFlowTask(_gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "adding new TestFlowRemoveSequential task");
			Globals.g_flowTaskController.addFlowTask( this );
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}