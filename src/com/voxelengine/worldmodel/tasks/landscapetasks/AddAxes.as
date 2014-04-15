/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.biomes.*;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.Globals;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class AddAxes extends LandscapeTask
	{		
		public function AddAxes( guid:String, layer:LayerInfo ):void {
			trace( "AddAxes of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer, "Add Axes");
		}
		
		// No parameters - auto adjust to grain size of oxel
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//////////////////////////////////////////////////////////
			// Builds Solid Cube of any grain size
			//////////////////////////////////////////////////////////
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var max:uint  = 1 << vm.instanceInfo.grainSize;
			
			var loco:GrainCursor = GrainCursorPool.poolGet(vm.oxel.gc.bound);
			for ( var x:int = 0; x < max; x++ ) {
				vm.write( loco.set_values( x, 0, 0, 0 ), Globals.RED, true );
				vm.write( loco.set_values( 0, x, 0, 0 ), Globals.GREEN, true );
				vm.write( loco.set_values( 0, 0, x, 0 ), Globals.BLUE, true );
			}
			
			//vm.print();
			
			GeneratePlusX( x-1, 6 , 12 );
			GeneratePlusY( 8, x-1 , 5 );
			GeneratePlusZ( 6, 6 , x-1 );
			
			
			
			trace( "AddAxes.start - took: "  + (getTimer() - timer) );					
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
		private function GeneratePlusX( xo:int, yo:int, zo:int ):void
        {
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var loco:GrainCursor = GrainCursorPool.poolGet(vm.oxel.gc.bound);
			
			vm.write( loco.set_values(xo, 0, 0, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo, zo, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+1, zo-1, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+2, zo-2, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+3, zo-3, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+4, zo-4, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+5, zo-5, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+6, zo-6, 0 ), Globals.RED, true );

            vm.write( loco.set_values(xo, yo+1, zo+1, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+2, zo+2, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+3, zo+3, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+4, zo+4, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+5, zo+5, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo+6, zo+6, 0 ), Globals.RED, true );

            vm.write( loco.set_values(xo, yo - 1, zo - 1, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 2, zo - 2, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 3, zo - 3, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 4, zo - 4, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 5, zo - 5, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 6, zo - 6, 0 ), Globals.RED, true );

            vm.write( loco.set_values(xo, yo - 1, zo + 1, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 2, zo + 2, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 3, zo + 3, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 4, zo + 4, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 5, zo + 5, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo - 6, zo + 6, 0 ), Globals.RED, true );

            vm.write( loco.set_values(xo, yo , zo - 7, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo , zo -8, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo , zo -9, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo , zo -10, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo , zo - 11, 0 ), Globals.RED, true );

            vm.write( loco.set_values(xo, yo +2, zo - 9, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo + 1, zo - 9, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo , zo - 9, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo -1, zo - 9, 0 ), Globals.RED, true );
            vm.write( loco.set_values(xo, yo -2, zo - 9, 0 ), Globals.RED, true );
        }	
		
		private function GeneratePlusY( xo:int, yo:int, zo:int ):void
        {
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var loco:GrainCursor = GrainCursorPool.poolGet(vm.oxel.gc.bound);

            vm.write( loco.set_values(xo + 0, yo, zo - 0, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 1, yo, zo - 1, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 2, yo, zo - 2, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 3, yo, zo - 3, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 4, yo, zo - 4, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 5, yo, zo - 5, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo - 1, yo, zo - 1, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo - 2, yo, zo - 2, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo - 3, yo, zo - 3, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo - 4, yo, zo - 4, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo - 5, yo, zo - 5, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo - 0, yo, zo + 1, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 0, yo, zo + 2, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 0, yo, zo + 3, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 0, yo, zo + 4, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 0, yo, zo + 5, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 7, yo, zo - 0, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 8, yo, zo - 0, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 9, yo, zo - 0, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 8, yo, zo + 1, 0 ), Globals.GREEN, true );
            vm.write( loco.set_values(xo + 8, yo, zo - 1, 0 ), Globals.GREEN, true );
        }	
		
		private function GeneratePlusZ( xo:int, yo:int, zo:int ):void
        {
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var loco:GrainCursor = GrainCursorPool.poolGet(vm.oxel.gc.bound);

            vm.write( loco.set_values(xo + 7, yo - 0, zo, 0 ), Globals.BLUE, true );
            vm.write( loco.set_values(xo + 8, yo - 0, zo, 0 ), Globals.BLUE, true );
            vm.write( loco.set_values(xo + 9, yo - 0, zo, 0 ), Globals.BLUE, true );
            vm.write( loco.set_values(xo + 8, yo + 1, zo, 0 ), Globals.BLUE, true );
            vm.write( loco.set_values(xo + 8, yo - 1, zo, 0 ), Globals.BLUE, true );
        }
	}
}
