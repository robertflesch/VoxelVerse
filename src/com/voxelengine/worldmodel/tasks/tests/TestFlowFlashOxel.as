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
	public class TestFlowFlashOxel extends FlowTask 
	{	
		static private var count:int = 0;
		public function TestFlowFlashOxel( guid:String, gc:GrainCursor ):void {
			super( guid,  gc );
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();


			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var size:uint = vm.oxel.size_of_grain();						
			_gc.grain = 0;
			var oxel:Oxel = vm.oxel.childFind( _gc );
			count++;
			if ( Globals.BAD_OXEL != oxel && Globals.AIR == oxel.type )
			{
				if ( 60 < count ) {
					trace( "STONE" );
					vm.write( _gc, Globals.STONE );
					count = 0;
				}
			}
			else
			{
				if ( 60 < count ) {
					trace( "AIR" );
					vm.write( _gc, Globals.AIR );
					count = 0;
				}
			}

			addFlowTask(_gc );
			super.complete();
		}
		
		private function addFlowTask( gc:GrainCursor ):void {
			//trace( "adding new TestFlowFlashOxel task");
			Globals.g_flowTaskController.addFlowTask( this );
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}