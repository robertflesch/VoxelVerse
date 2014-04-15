/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.biomes.*;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.Globals;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class CarveTunnels extends LandscapeTask 
	{		
		public function CarveTunnels( guid:String,layer:LayerInfo ):void {
			trace( "CarveTunnels - created" );					
			super(guid,layer);
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
        private function paintAtPoint( oxel:Oxel, x:int, y:int, z:int, paintRadius:int, bid:int ):void
        {/*
			var	voxels:VoxelVector = region.oxel.voxels;
            for ( var dx:int = -paintRadius; dx <= paintRadius; dx++)
                for (var dy:int = -paintRadius; dy <= paintRadius; dy++)
                    for (var dz:int = -paintRadius; dz <= paintRadius; dz++)
                            if (dx * dx + dy * dy + dz * dz < paintRadius * paintRadius)
                            {
								voxels.setVoxelType(x + dx, y + dy, z + dz, bid);
                            }
							*/
        }
		
        private function carveTunnel( oxel:Oxel, length:int, radius:int, bid:int ):void 
		{
		/*
            // pick a random starting location
			var sx:int = Math.random() * VoxelModel.modelWidth
            var sy:int = Math.random() * VoxelModel.modelHeight * 0.65;
            var sz:int = Math.random() * VoxelModel.modelDepth;

            // pick a random diections to go
            var xdir:int = Math.random() * 2; if (xdir == 0) xdir = -1;
            var ydir:int = ydir = -1; // Math.random() * 2); if (ydir == 0) ydir = -1;
            var zdir:int = Math.random() * 2; if (zdir == 0) zdir = -1;

            const radiusParameter:int = radius;
			while (length > 0)
            {
                if (sx>radius + 5 && sy >radius + 5 && sz>radius + 5 &&
                    sx < VoxelModel.modelWidth - radius - 5 &&
                    sy < VoxelModel.modelHeight - radius - 5 &&
                    sz < VoxelModel.modelDepth - radius - 5) {
                        paintAtPoint( region, sx, sy, sz, radius, bid );
                }
                sx += (Math.random() * 3 * xdir);
                sy += (Math.random() * 2 * ydir);
                sz += (Math.random() * 3 * zdir);

				// Old way
				//	radius += Math.random() * 2 - Math.random() * 2;

				//	if (radius < 1) radius = 2;
				//	if (radius > 4) radius = 3;
				 
                radius += Math.random() * radiusParameter - Math.random() * radiusParameter/2;

                if (radius < 1) radius = 0;
                if (radius > 4) radius = 3;

                length--;
            }
			*/
        }

		override public function start():void {
            super.start() // AbstractTask will send event
			trace( "CarveTunnels - THIS FUNCTION NEEDS SO MORE FINE TUNING -------" );					
			trace( "CarveTunnels - carveTunnels  - enter - carving " +_layer.offset + " tunnels of type " + (Globals.Info[_layer.type].name.toUpperCase()) );					
			var timer:int = getTimer();
            var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			
            var numberOfTunnels:int =_layer.offset;
			var tunnelLength:int = Math.random() * 200;
			if ( 0 <_layer.optionalInt )
				tunnelLength =_layer.optionalInt;
            var tunnelRadius:int =_layer.range;
			var voxelType:int =_layer.type;
			for (var x:int = 0; x < numberOfTunnels; x++)
            {
                carveTunnel( vm.oxel, tunnelLength, tunnelRadius, voxelType );
            }
			

			trace( "CarveTunnels - carveTunnels - took: " + (getTimer() - timer) + " in queue for: " + (timer-_startTime)  );					
            super.complete() // AbstractTask will send event
        }
	}
}