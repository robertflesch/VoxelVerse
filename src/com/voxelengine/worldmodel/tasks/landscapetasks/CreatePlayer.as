/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
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
	public class CreatePlayer extends LandscapeTask 
	{		
		public function CreatePlayer( guid:String, layer:LayerInfo ):void {
			Log.out( "CreatePlayer.construct of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer, "CreatePlayer");
		}
		
		override public function start():void 
		{
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			var root_grain_size:uint = 2;
			var min_grain_size:int = 0;
			Log.out( "CreatePlayer.start" );
			_layer.type = 106;

			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			if ( vm )
			{
				//var root_grain_size:uint = vm.oxel.gc.bound
				//var min_grain_size:int = root_grain_size - _layer.range;
				if ( 0 > min_grain_size || min_grain_size > (root_grain_size - 2) || ( 8 < (root_grain_size - min_grain_size)) )
				{
					min_grain_size = Math.max( 0, root_grain_size - 6 );
					Log.out( "CreatePlayer.start - WARNING - Adjusting range: " + min_grain_size, Log.WARN );
				}
				
				var c:int = vm.oxel.size_in_world_coordinates() / 2;
				//vm.oxel.write_sphere( c, c, c, c - 1, _layer.type, min_grain_size );
				vm.oxel.write_sphere( vm.instanceInfo.instanceGuid, c, c/2, c, c, _layer.type, min_grain_size );
			}
			else
			{
				Log.out("CreatePlayer.start - Didnt find model for: " + _guid, Log.ERROR );
			}
			
			//trace( "CreatePlayer.start - took: "  + (getTimer() - timer) );
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
