/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.biomes.*;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class GenerateLayer extends LandscapeTask 
	{		
		public function GenerateLayer( guid:String, layer:LayerInfo ):void {
			Log.out( "GenerateLayer of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super( guid, layer, "GenerateLayer: " + (Globals.Info[layer.type].name.toUpperCase()) );
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//Globals.g_seed = 0;
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var masterMapSize:uint = Math.min( vm.oxel.size_in_world_coordinates(), 1024 );
			
			var octaves:int  = ( Math.random() * 144 ) % (Math.random() * 12);
			if ( 0 == octaves )
				octaves = 6;
			Log.out( "GenerateLayer - start - generating random number of octives Octaves: " + octaves );					
			
			var masterHeightMap:Array = NoiseGenerator.generate_height_map( masterMapSize, octaves );
			//heightMap = generatePerlinNoise2DMap(voxels);
			Log.out( "GenerateLayer - start - generate_height_map took: " + (getTimer() - timer) );					
			timer = getTimer();
			
            // same thing
			//var t:int = vm.oxel.size_in_world_coordinates();
			//var t2:int = GrainCursor.get_the_g0_size_for_grain(vm.oxel.gc.grain);
			
			// range should use up what ever percentage leftover from the offset
			var offsetInG0:int = _layer.offset/100 * GrainCursor.get_the_g0_size_for_grain(vm.oxel.gc.grain);
			var remainingRange:int = vm.oxel.size_in_world_coordinates() - offsetInG0;
			var rangeInG0:int = remainingRange * _layer.range/100; 
			var normalizedMasterHeightMap:Array = NoiseGenerator.normalize_height_map_for_oxel( masterHeightMap
																							  , masterMapSize
																							  , rangeInG0
																							  , offsetInG0 );
					
			Log.out( "GenerateLayer - start - normalize_height_map_for_oxel took: " + (getTimer() - timer) );					
			timer = getTimer();
			// create a height map for each of the oxel levels
			var minHeightMapArray:Vector.<Array> = NoiseGenerator.get_height_mip_maps( normalizedMasterHeightMap, masterMapSize, NoiseGenerator.NOISE_MIN );
			var maxHeightMapArray:Vector.<Array> = NoiseGenerator.get_height_mip_maps( normalizedMasterHeightMap, masterMapSize, NoiseGenerator.NOISE_MAX );
			Log.out( "GenerateLayer - start - get_height_mip_maps took: " + (getTimer() - timer) );					
			timer = getTimer();

			// Array is only 10 in size, so if grain is larger then 10, we only calculate 10 levels down MAX.
			var arrayOffset:int = 0;
			if ( 10 < vm.oxel.gc.bound )
			{
				arrayOffset = 10;
			}
			else
				arrayOffset = vm.oxel.gc.bound;
			
			var minGrain:int = vm.oxel.gc.grain - _layer.optionalInt;
			if ( 0 > minGrain ) minGrain = 0;
			
			var ignoreSolid:Boolean = false;
			if ( Globals.AIR == _layer.type || Globals.RED == _layer.type )
				ignoreSolid = true;
			vm.oxel.write_height_map( _guid, _layer.type, minHeightMapArray, maxHeightMapArray, minGrain, arrayOffset, ignoreSolid );
			Log.out( "GenerateLayer - completed layer of type: " + (Globals.Info[_layer.type].name.toUpperCase()) + "  range: " + _layer.range + "  offset: " + _layer.offset + " took: " + (getTimer() - timer) ); // + " in queue for: " + (timer - _startTime));
			//timer = getTimer();
			//Log.out( "GenerateLayer - merging: ");
			//vm.oxel.mergeRecursive();
			//Oxel.nodes = 0;
			//vm.oxel.mergeRecursive();
			//Log.out( "GenerateLayer - merging recovered: " + Oxel.nodes + " took: " + (getTimer() - timer), Log.ERROR );
			//timer = getTimer();
			//Oxel.nodes = 0;
			//vm.oxel.mergeRecursive();
			//Log.out( "GenerateLayer - merging 2 recovered: " + Oxel.nodes + " took: " + (getTimer() - timer), Log.ERROR );
			
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}