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
	public class TestFlowRemove extends FlowTask 
	{		
		public function TestFlowRemove( guid:String, gc:GrainCursor ):void {
			super( guid,  gc );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();

			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			vm.oxel.cursor_copy_to(_gc );
			var size:uint = vm.oxel.size_of_grain();
			var max:uint =_gc.edgeval( size );
			max = GrainCursor.get_the_g0_size_for_grain(_gc.grain );
			var rx:uint = Math.random() * max;
			var ry:uint = Math.random() * max;
			var rz:uint = Math.random() * max;
			
			_gc.set_values( rx, ry, rz, int(Math.random()*6) );
			vm.write( _gc, Globals.AIR );
			
			addFlowTask(_gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "adding new TestFlowRemove task");
			Globals.g_flowTaskController.addFlowTask( this );
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}