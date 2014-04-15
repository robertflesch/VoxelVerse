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
	public class TestFlowRemoveCircular extends FlowTask 
	{	
		static private var count:int = 0;
		public function TestFlowRemoveCircular( guid:String, gc:GrainCursor ):void {
			super( guid,  gc );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();

			if ( count > 0 )
			{
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var size:uint = vm.oxel.size_of_grain();						
			_gc.grain = 0;
			vm.write( _gc, Globals.AIR );
			
			if ( !_gc.move_posx(size) )
			{
				_gc.set_values( 0, _gc.grainY, _gc.grainZ, _gc.grain )
				if ( !_gc.move_posz(size) )
				{
					_gc.set_values( 0, _gc.grainY, 0, _gc.grain )
					if ( !_gc.move_posy(size) )
						return;
				}
			}
			count = 0;
			}

			count++;
			addFlowTask(_gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "adding new TestFlowRemoveCircular task");
			Globals.g_flowTaskController.addFlowTask( this );
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}