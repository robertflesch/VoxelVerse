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
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class DirtToGrassAndSand extends LandscapeTask 
	{		
		public function DirtToGrassAndSand( guid:String, layer:LayerInfo ):void {
			Log.out( "DirtToGrassAndSand.created" );					
			super(guid, layer);
		}
		
		override public function start():void {
			super.start();
			var timer:int = getTimer();
			Log.out( "DirtToGrassAndSand.start - enter: ");					
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			if ( vm )
			{
				vm.oxel.dirtToGrassAndSand();
			}
			else
				Log.out( "GrowTreesOn.start - VM not found for guid: " + _guid );
			
			Log.out( "DirtToGrassAndSand.start - complete - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime) );	
			
			super.complete();
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}