/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.tests
{
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestSolid extends LandscapeTask 
	{		
		public function TestSolid( guid:String, layer:LayerInfo ):void {
			//Log.out( "TestSolid.construct of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer, "Test Solid");
		}
		
		override public function start():void 
		{
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//////////////////////////////////////////////////////////
			// Builds Solid Cube of any grain size
			//////////////////////////////////////////////////////////
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var root_grain_size:uint = vm.oxel.gc.bound;
			var min_grain_size:int = root_grain_size - _layer.range;
			if ( 0 > min_grain_size || min_grain_size > root_grain_size || ( 8 < (root_grain_size - min_grain_size)) )
			{
				min_grain_size = Math.max( 0, root_grain_size - 4 );
				Log.out( "TestSolid.start - WARNING - Adjusting range: " + min_grain_size, Log.WARN );
			}

			//trace("TestSolid.start on rootGrain of max size: " + root_grain_size + "  Filling with grain of size: " + min_grain_size + " of type: " + Globals.Info[_layer.type].name );
			var loco:GrainCursor = GrainCursorPool.poolGet(vm.oxel.gc.bound);
			
			var size:int = 1 << (root_grain_size - min_grain_size);
			for ( var x:int = 0; x < size; x++ ) {
				for ( var y:int = 0; y < size; y++ ) {
					for ( var z:int = 0; z < size; z++ ) {
						loco.set_values( x, y, z, min_grain_size )
						vm.oxel.write( _guid, loco, _layer.type );
						//vm.write( loco, _layer.type, true );
					}
				}
			}
			GrainCursorPool.poolDispose( loco );
			
			//vm.print();
			
			//trace( "TestSolid.start - took: "  + (getTimer() - timer) );					
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
