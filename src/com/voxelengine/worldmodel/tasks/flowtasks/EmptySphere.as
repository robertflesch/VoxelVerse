/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.flowtasks
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.Region;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.VoxelVector;
	import com.voxelengine.worldmodel.Location;
	import com.voxelengine.worldmodel.voxel.VoxelBase;
	
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class EmptySphere extends LandscapeTask
	{		
		private var _count:int = 0;
		public function EmptySphere( guid:String, layer:LayerInfo ):void {
			//trace( "EmptySphere - created" );					
			super( guid, layer, "EmptySphere" );
		}
		
		override public function start():void {
			super.start();
			//trace( "EmptySphere - start" );					
			
			var timer:int = getTimer();
			var	voxels:VoxelVector = _region.oxel.voxels;
			const layerOffset:int = voxels.getLayerSize();
			const sideOffset:int = voxels.regionDepth;

			var voxel:VoxelBase = Globals.VOXEL_INVALID;
			var testVoxel:VoxelBase = Globals.VOXEL_INVALID;
			// Go thru in this order so that the index points to the next element in the vector
			// Check between the range specified in the offset and range, this can be as small as one
			for ( var y:int = _layer.offset; y < _layer.range; y++) {
				var index:int = voxels.xyzToOffset( x,y,z );
				for (var z:int = 0; z < voxels.regionWidth; z++) {
					for (var x:int = 0; x < voxels.regionWidth; x++) {
						voxel = voxels.directGetVoxel( index );	
						if ( Globals.AIR == voxel.type ) {
							
							// check above us, could flow down? if tunnel cuts out voxel under?
							testVoxel = voxels.getVoxelOffset( index + layerOffset );
							if ( true == Globals.Info[testVoxel.type].flowable ) 
								addFlowTask( x, y, z, testVoxel.type );
							
							testVoxel = voxels.layerCheckedGetVoxel( index - sideOffset )
							if ( true == Globals.Info[testVoxel.type].flowable ) 
								addFlowTask( x, y, z, testVoxel.type );

							//var tvoxel:VoxelBase = voxels.directGetVoxel( index + sideOffset );	
							testVoxel = voxels.layerCheckedGetVoxel( index + sideOffset )
							if ( true == Globals.Info[testVoxel.type].flowable ) 
								addFlowTask( x, y, z, testVoxel.type );

							testVoxel = voxels.rowCheckedGetVoxel( index - 1 );
							if ( true == Globals.Info[testVoxel.type].flowable ) 
								addFlowTask( x, y, z, testVoxel.type );

							testVoxel = voxels.rowCheckedGetVoxel( index + 1 );
							if ( true == Globals.Info[testVoxel.type].flowable ) 
								addFlowTask( x, y, z, testVoxel.type );
						}
						index++;
					}
				}
			}
	
			//trace( "EmptySphere - flows: " + _count + "  took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime) );					
			super.complete();
		}
		
		private function addFlowTask( x:int, y:int, z:int, type:int ):void {
			//trace( "EmptySphere has created a new flow task at x: " + x + " y: " + y + " z: " + z + " flowed down for 0 and out for: 1" );
			Globals.g_flowTaskController.addFlowTask( new Flow( _region, new Location( x, y, z ), 0, 1, type ), true);
		}
		
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}