/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.tests
{
	import com.voxelengine.worldmodel.Location;
	import com.voxelengine.worldmodel.Region;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.voxel.VoxelFactory;
	import com.voxelengine.worldmodel.VoxelVector;
	import com.voxelengine.worldmodel.NoiseGenerator;
	import com.voxelengine.worldmodel.voxel.VoxelBase;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.Globals;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestWater extends LandscapeTask 
	{		
		public function TestWater( guid:String, layer:LayerInfo ):void {
			//trace( "TestWater of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer, "TestWater" );
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			var	voxels:VoxelVector = _region.oxel.voxels;
				
			var endX:int = voxels.regionWidth;
			var endY:int = voxels.regionHeight;
			var endZ:int = voxels.regionDepth;

			//trace( "TestWater - add block at x: " + (endX / 2) + " y: " + (VoxelModel.seaFloor)  + " z: " + (endZ / 2) );
//			var holdBack:int = endZ / 4;
			var holdBack:int = 0;
			var index:int = 0;
			
/*
			var y:int = VoxelModel.seaFloor - 1;
			for ( var z:int = holdBack; z < endZ - holdBack; z++ ) {
				for ( var x:int = holdBack ; x < endX - holdBack; x++ ) {
					index = voxels.xyzToOffset( x, y, z );

					//_region.oxel.setVoxelTypeLoc( loc.setTo( x, VoxelModel.seaFloor - 1, z ), Globals.STONE );
					//_region.oxel.setVoxelTypeLoc( loc.setTo( x, y, z ), Globals.STONE );
					voxels.directSetVoxelType( index, Globals.STONE );
				}
			}
*/
			/*
			y = VoxelModel.seaFloor;
			for ( z = holdBack; z < endZ - holdBack; z++ ) {
				for ( x = holdBack ; x < endX - holdBack; x++ ) {
					index = voxels.xyzToOffset( x, y, z );

					//_region.oxel.setVoxelTypeLoc( loc.setTo( x, VoxelModel.seaFloor - 1, z ), Globals.STONE );
					//_region.oxel.setVoxelTypeLoc( loc.setTo( x, y, z ), Globals.STONE );
					voxels.directSetVoxelType( index, Globals.WATER );
				}
			}
			*/
			//for ( var y:int = holdBack; y < endZ - holdBack; y++ ) {
/*				var y:int = VoxelModel.seaFloor - 1;
				for ( var z:int = holdBack; z < endZ - holdBack; z++ ) {
					for ( var x:int = holdBack ; x < endX - holdBack; x++ ) {
						index = voxels.xyzToOffset( x, y, z );

						//_region.oxel.setVoxelTypeLoc( loc.setTo( x, VoxelModel.seaFloor - 1, z ), Globals.STONE );
						//_region.oxel.setVoxelTypeLoc( loc.setTo( x, y, z ), Globals.STONE );
						voxels.directSetVoxelType( index, Globals.STONE );
					}
				}
*/			//}		
/* WEDGE SHAPE*/
			for ( var y:int = holdBack; y < endZ - holdBack; y++ ) {
				for ( var z:int = holdBack; z < endZ - holdBack + (y-holdBack-12); z++ ) {
					for ( var x:int = holdBack ; x < endX/2 + (y-holdBack-12); x++ ) {
						//_region.oxel.setVoxelTypeLoc( loc.setTo( x, VoxelModel.seaFloor - 1, z ), Globals.STONE );
						//_region.oxel.setVoxelTypeLoc( loc.setTo( x, y, z ), Globals.STONE );
						index = voxels.xyzToOffset( x, y, z );
						voxels.directSetVoxelType( index, Globals.STONE );
					}
				}
			}
			/**/
			
			//for ( z = holdBack; z < endZ - holdBack; z++ ) {
				//for ( x = holdBack ; x < endX - holdBack; x++ ) {
					//voxels.setVoxelType( x, VoxelModel.seaFloor, z, Globals.DIRT );
				//}
			//}
			
			//voxels.setVoxelType( endX / 2 - 1, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 - 2, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 - 3, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 - 4, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 - 5, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 - 6, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 + 1, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 + 2, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 + 3, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 + 4, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 + 5, VoxelModel.seaFloor, endZ / 2, Globals.AIR );
			//voxels.setVoxelType( endX / 2 + 6, VoxelModel.seaFloor, endZ / 2, Globals.AIR );

//			voxels.setVoxelType( endX / 2 + 6, VoxelModel.seaFloor - 6, endZ / 2, Globals.STONE );
			
 			voxels.setVoxelType( endX / 2 + 1, VoxelModel.seaFloor, endY / 2, Globals.WATER );
 			//voxels.setVoxelType( endX / 2 + 1, VoxelModel.seaFloor + 1, endY / 2, Globals.WATER );
//			voxels.setVoxelType( endX / 2    , VoxelModel.seaFloor, endZ / 2, Globals.STONE );
//			voxels.setVoxelType( endX / 2 - 1, VoxelModel.seaFloor, endZ / 2, Globals.LAVA );
			//voxels.setVoxelType( endX / 2 + 1, VoxelModel.seaFloor, endZ / 2, Globals.WATER );
			//voxels.setVoxelType( endX / 2 - 1, VoxelModel.seaFloor, endZ / 2, Globals.WATER );
			
			//trace( "TestWater - took: "  + (getTimer() - timer) );					
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
