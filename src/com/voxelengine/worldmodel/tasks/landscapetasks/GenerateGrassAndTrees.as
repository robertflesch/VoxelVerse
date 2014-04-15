/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class GenerateGrassAndTrees extends LandscapeTask 
	{		
		public function GenerateGrassAndTrees( guid:String, layer:LayerInfo ):void {
			//Log.out( "GenerateGrassAndTrees - created", Log.WARN );					
			super(guid, layer);
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var size:uint = vm.oxel.size_in_world_coordinates();
			var outOf:int = _layer.range;
			Log.out( "GenerateGrassAndTrees - start - enter: ");					
			
			vm.oxel.dirtToGrassAndSand();
			//vm.oxel.growTreesOn( _guid, Globals.DIRT, outOf ? outOf : 2000 );
			
			Log.out( "GenerateGrassAndTrees - complete & trees - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime) );	
			
			super.complete();
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}