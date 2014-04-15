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
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.biomes.*;

	import flash.utils.getTimer;

	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.TaskController;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class GenerateLavaPockets extends LandscapeTask 
	{		
		public function GenerateLavaPockets( guid:String,layer:LayerInfo ):void {
			trace( "GenerateLavaPockets - created" );					
			super(guid,layer);
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
        // Make a round pocket, and fill it half way up with lava
		private function paintAtPoint( oxel:Oxel, x:int, y:int, z:int, paintRadius:int, type:int ):void
        {
			/*
			var	voxels:VoxelVector = region.oxel.voxels;
            for ( var dx:int = -paintRadius; dx <= paintRadius; dx++) {
                for (var dy:int = -paintRadius; dy <= paintRadius; dy++) {
                    for (var dz:int = -paintRadius; dz <= paintRadius; dz++) {
						if (dx * dx + dy * dy + dz * dz < paintRadius * paintRadius) {
							if ( dy >= -paintRadius && 0 >= dy ) {
								voxels.setVoxelType(x + dx, y + dy, z + dz, type);
							} else
								voxels.setVoxelType(x + dx, y + dy, z + dz, Globals.AIR);
						}
					}		
				}			
			}				
			var layer:LayerInfo = new LayerInfo( null, CheckForFlow, "CheckForFlow",  type,   y + 1, 0 <= (y - 4)? y - 4 : 0 );	
			var task:ITask = new CheckForFlow( _region, layer );
			Globals.g_landscapeTaskController.addTask( task );
			*/
        }
		
        private function placeLava( oxel:Oxel, length:int, radius:int, type:int ):void 
		{
			/*
			// puts a pocket in middle of map for testing
			//paintAtPoint( region, VoxelModel.modelWidth/2, VoxelModel.modelHeight/2, VoxelModel.modelDepth/2, radius, type );
			
            // pick a random starting location
			var sx:int = Math.random() * VoxelModel.modelWidth
            var sy:int = Math.random() * VoxelModel.seaFloor * 0.75;
            var sz:int = Math.random() * VoxelModel.modelDepth;

            // pick a random diections to go
            var xdir:int = Math.random() * 2; if (xdir == 0) xdir = -1;
            var ydir:int = ydir = -1; // Math.random() * 2); if (ydir == 0) ydir = -1;
            var zdir:int = Math.random() * 2; if (zdir == 0) zdir = -1;

            const radiusParameter:int = radius;
			var voxel:VoxelBase = _region.oxel.voxels.getVoxel( sx, sy, sz );
			//trace( "GenerateLavaPockets - placeLava - found point of type " + (Globals.Info[voxel.type].name) + "  at x: " + sx + " y: " + sy + " z: " + sz );					
			if ( Globals.AIR != voxel.type && false == Globals.Info[voxel.type].flowable ) {
				trace( "GenerateLavaPockets - placeLava - PLACED at x: " + sx + " y: " + sy + " z: " + sz );					
				paintAtPoint( region, sx, sy, sz, radius, type );
			}
			*/
        }

		override public function start():void {
            super.start() // AbstractTask will send event
			trace( "GenerateLavaPockets - enter - creating " +_layer.offset + " pockets of type " + (Globals.Info[_layer.type].name.toUpperCase()) );					
			var timer:int = getTimer();
            var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			
            var numberOfTunnels:int =_layer.offset;
			var tunnelLength:int = Math.random() * 200;
			if ( 0 <_layer.optionalInt )
				tunnelLength =_layer.optionalInt;
            var tunnelRadius:int =_layer.range;
			var type:int =_layer.type;
			for (var x:int = 0; x < numberOfTunnels; x++)
            {
                placeLava( vm.oxel, tunnelLength, tunnelRadius, type );
            }
			

			trace( "GenerateLavaPockets - GenerateLavaPockets - took: " + (getTimer() - timer) + " in queue for: " + (timer-_startTime)  );					
            super.complete() // AbstractTask will send event
        }
	}
}