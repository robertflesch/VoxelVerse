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
	public class CarveTunnel extends LandscapeTask 
	{		
		public function CarveTunnel( guid:String,layer:LayerInfo ):void {
			trace( "CarveTunnel - created" );					
			super(guid,layer);
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			var timer:int = getTimer();
            var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			if ( !vm ) {
				super.complete() // AbstractTask will send event
				return;
			}
			
			var tunnelLength:int = Math.random() * 500;
			if ( 0 <_layer.optionalInt )
				tunnelLength =_layer.optionalInt;
            var tunnelRadius:int =_layer.range;
			var voxelType:int = _layer.type;
			
            // pick a random starting location
			var sx:int = vm.editCursor.instanceInfo.positionGet.x;
            var sy:int = vm.editCursor.instanceInfo.positionGet.y;
            var sz:int = vm.editCursor.instanceInfo.positionGet.z;
			trace( "CarveTunnel.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " starting at x: " + sx + "  y: " + sy + "  z: " + sz );					
/*
            // pick a random diections to go
            var xdir:int = Math.random() * 2; if (xdir == 0) xdir = -1;
            var ydir:int = ydir = -1; // Math.random() * 2); if (ydir == 0) ydir = -1;
            var zdir:int = Math.random() * 2; if (zdir == 0) zdir = -1;

            const radiusParameter:int = radius;
			while (length > 0)
            {
                if (sx>radius + 5 && sy >radius + 5 && sz>radius + 5 &&
                    sx < ox.gc.size() - radius - 5 &&
                    sy < ox.gc.size() - radius - 5 &&
                    sz < ox.gc.size() - radius - 5) {
                        ox.empty_sphere( _guid, sx, sy, sz, radius, 2 );
                }
                sx += (Math.random() * 3 * xdir);
                sy += (Math.random() * 2 * ydir);
                sz += (Math.random() * 3 * zdir);

				// Old way
				//	radius += Math.random() * 2 - Math.random() * 2;

				//	if (radius < 1) radius = 2;
				//	if (radius > 4) radius = 3;
				 
                //radius += Math.random() * radiusParameter - Math.random() * radiusParameter/2;

                //if (radius < 1) radius = 0;
                //if (radius > 4) radius = 3;

                length--;
            }
*/			

			trace( "CarveTunnel - took: " + (getTimer() - timer) + " in queue for: " + (timer-_startTime)  );					
            super.complete() // AbstractTask will send event
		}

	}
}