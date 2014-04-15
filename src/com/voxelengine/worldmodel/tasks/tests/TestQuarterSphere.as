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
	import com.voxelengine.worldmodel.Biomes;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.NoiseGenerator;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.PerlinNoise2D;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestQuarterSphere extends LandscapeTask 
	{		
		public function TestQuarterSphere( guid:String,layer:LayerInfo ):void {
			trace( "TestQuarterSphere.construct of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer, "TestQuarterSphere: " + (Globals.Info[layer.type].name.toUpperCase()) );
		}
		
		override public function start():void
		{
			super.start() // AbstractTask will send event

			var timer:int = getTimer();
			
			trace( "TestQuarterSphere.start " );					
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var root_grain_size:uint = vm.oxel.size_of_grain()
			var min_grain_size:int = root_grain_size - _layer.range;
			if ( 0 > min_grain_size || min_grain_size >= root_grain_size || ( 8 < (root_grain_size - min_grain_size)) )
			{
				min_grain_size = Math.max( 0, root_grain_size - 8 );
				trace( "TestQuarterSphere.start - WARNING - Adjusting range: " + min_grain_size );
			}
			
			var c:int = vm.oxel.size_in_world_coordinates() / 2;
			trace( "TestQuarterSphere.start - write sphere " );					
			vm.oxel.write_sphere( 0, 0, 0, c * 2 - 1, Globals.STONE, min_grain_size );
			trace( "TestQuarterSphere.start - after" );					

			trace( "TestQuarterSphere.start - completed layer of type: " + (Globals.Info[_layer.type].name.toUpperCase()) + "  range: " + _layer.range + "  offset: " + _layer.offset + " took: " + (getTimer()-timer) + " in queue for: " + (timer-_startTime));
			super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}