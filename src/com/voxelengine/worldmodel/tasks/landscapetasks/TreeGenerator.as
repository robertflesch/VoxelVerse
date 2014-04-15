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
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.geom.Point;	
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class  TreeGenerator
	{
		private static var _worldModel:VoxelModel;

		public static function generateTree( $guid:String, oxel:Oxel, $chance:int = 2000 ):void {
			// by default the chance is 1/2000
			var chance:Number = 1 / $chance;
			if ( chance > Math.random() ) {
				if ( 0.5 > Math.random() )
					buildPineTree( $guid, oxel );
				else	
					buildTraditionalTree( $guid, oxel );
			}
			//buildSplitTree( oxel );
			//buildAfricanTree( oxel );
		}
		
		private static function buildSplitTree( oxel:Oxel ):void {
			/*
            var trunk:int = 5 + Math.random() * 5;
            var startingLeafLevel:int = y + trunk + trunk/2 - 1;
			const leafLevels:int = 3;
*/
			// Make sure top is not cut off AND
			// check to make sure we are not growing INTO something
			/*
			var bid:VoxelBase = voxelVector.getVoxel(x, startingLeafLevel + leafLevels, z);
			if ( Globals.AIR != bid.type || Globals.VOXEL_INVALID == bid ) {
				//trace( "TreeGenerator - buildSplitTree - spot rejected empty or invalid" );
				return;
			}
			*/
			if ( 0.05 > Math.random() ) return; // 5 percent chance of tree being dead
			/*
			var offset:Point = buildForkedTrunk( voxelVector, x, y, z, trunk, trunk / 2 );
			var leaf:int = Globals.LEAF;
			generateLeafLevel(voxelVector, x           , startingLeafLevel-2, z,            2, leaf, 0.4);
			generateLeafLevel(voxelVector, x + offset.x, startingLeafLevel,   z + offset.y, 2, leaf, 0.8);
			generateLeafLevel(voxelVector, x + offset.x, startingLeafLevel+1, z + offset.y, 4, leaf, 0.6);
			generateLeafLevel(voxelVector, x + offset.x, startingLeafLevel+2, z + offset.y, 2, leaf, 0.8);
			generateLeafLevel(voxelVector, x           , startingLeafLevel,   z,            3, leaf, 0.8);
			generateLeafLevel(voxelVector, x           , startingLeafLevel+2, z,            3, leaf, 0.8);
			generateLeafLevel(voxelVector, x - offset.x, startingLeafLevel,   z - offset.y, 2, leaf, 0.8);
			generateLeafLevel(voxelVector, x - offset.x, startingLeafLevel+1, z - offset.y, 4, leaf, 0.6);
			generateLeafLevel(voxelVector, x - offset.x, startingLeafLevel+2, z - offset.y, 2, leaf, 0.8);
			*/
		}
		
		private static function buildAfricanTree( oxel:Oxel ):void {
			/*
            var trunk:int = 10 + Math.random() * 5;
            var startingLeafLevel:int = y + trunk;
			const leafLevels:int = 3;
			*/
/*
			// Make sure top is not cut off AND
			// check to make sure we are not growing INTO something
			var bid:VoxelBase = voxelVector.getVoxel(x, startingLeafLevel + leafLevels, z);
			if ( Globals.AIR != bid.type || Globals.VOXEL_INVALID == bid ) {
				//trace( "TreeGenerator - buildAfricanTree - spot rejected empty or invalid" );
				return;
			}
			
			buildTrunk( voxelVector, x, y, z, trunk + 3 );
			generateLeafLevel( $guid, oxel, gct, 3, Globals.LEAF, 0.5);
			generateLeafLevel( $guid, oxel, gct, 6, Globals.LEAF, 0.5);
			generateLeafLevel( $guid, oxel, gct, 3, Globals.LEAF, 0.5);
			*/
		}

		private static function roomToGrow( gct:GrainCursor, $oxel:Oxel, trunk:int ):Boolean {

			// Todo - check to make sure we are not growing into something?
			var gct:GrainCursor = GrainCursorPool.poolGet( $oxel.gc.bound );
			gct.copyFrom( $oxel.gc );
			var roomToGrow:Boolean = true;
			test: for ( var i:int = 0; i < trunk; i ++ )
			{
				roomToGrow = gct.move_posy();
				if ( !roomToGrow )
				{
					break test;
				}
			}
			
			GrainCursorPool.poolDispose( gct );
			return roomToGrow;
		}
		
		private static function buildTraditionalTree( $guid:String, $oxel:Oxel ):void
		{
			//var trunk:int = 12 + Math.random() * 5;
			var trunk:int = 7 + Math.random() * 5;
			
			// Make sure top is not cut off AND
			if ( !roomToGrow( gct, $oxel, trunk ) )
				return;
			
			var gct:GrainCursor = GrainCursorPool.poolGet( $oxel.gc.bound );
			gct.copyFrom( $oxel.gc );
			var e_trunkType:uint = Globals.BARK;
			// this returns gct at the top of the trunk
			buildTrunk( $guid, $oxel, gct, trunk, e_trunkType );
			
			// build down from the top, since we dont know how tall it is
			var e_leafType:uint = Globals.LEAF;
 			generateLeafLevel( $guid, $oxel, gct, 3, e_leafType, 0.5);
			gct.move_negy();
 			generateLeafLevel( $guid, $oxel, gct, 4, e_leafType, 0.5);
			gct.move_negy();
 			generateLeafLevel( $guid, $oxel, gct, 5, e_leafType, 0.5);
			gct.move_negy();
 			generateLeafLevel( $guid, $oxel, gct, 5, e_leafType, 0.5);
			gct.move_negy();
 			generateLeafLevel( $guid, $oxel, gct, 4, e_leafType, 0.5);
			gct.move_negy();
 			generateLeafLevel( $guid, $oxel, gct, 3, e_leafType, 0.5);
			
			GrainCursorPool.poolDispose( gct );
		}
		
        public static function buildPineTree( $guid:String, oxel:Oxel ):void
        {
			var trunk:int = 8 + Math.random() * 5;
			
			// Make sure top is not cut off AND
			// check to make sure we are not growing INTO something
			if ( !roomToGrow( gct, oxel, trunk ) )
				return;
			
			var gct:GrainCursor = GrainCursorPool.poolGet( oxel.gc.bound );
			gct.copyFrom( oxel.gc );
			var e_trunkType:uint = Globals.BARK;
			// this returns gct at the top of the trunk
			buildTrunk( $guid, oxel, gct, trunk, e_trunkType );
					
			// Add leaves and additional trunk levels
			var e_leafType:uint = Globals.LEAF;
			generateLeafLevel( $guid, oxel, gct, 1, e_leafType, 1 ); // 0.95);
			gct.move_negy();
			gct.move_negy();
			generateLeafLevel( $guid, oxel, gct, 2, e_leafType, 1 ); // , 0.9);
			gct.move_negy();
			gct.move_negy();
			generateLeafLevel( $guid, oxel, gct, 2, e_leafType, 1 ); // , 0.9);
			gct.move_negy();
			gct.move_negy();
			generateLeafLevel( $guid, oxel, gct, 3, e_leafType, 1 ); // , 0.7);
			gct.move_negy();
			gct.move_negy();
			generateLeafLevel( $guid, oxel, gct, 3, e_leafType, 1 ); // , 0.7);
			
        }
		
        private static function write( $guid:String, oxel:Oxel, gc:GrainCursor, e_type:int ):void 
		{
			var ao:Oxel = oxel.root_get().childFind( gc );
			if ( Globals.BAD_OXEL != ao )
				ao.write( $guid, gc, e_type, true );			
		}
		
        private static function generateLeafLevel( $guid:String, oxel:Oxel, gcc:GrainCursor, radius:int, e_type:int, percent:Number = 0.5 ):void 
		{
			var gct:GrainCursor = GrainCursorPool.poolGet( gcc.bound );
			gct.copyFrom( gcc );
			
			gct.grainX = gcc.grainX - (radius+1);
			gct.grainZ = gcc.grainZ - (radius);
			if ( gct.move_posy() )
			{
				gct.move_negy()
                for ( var i:int = -radius; i <= radius; i++)
				{
					for (var  j:int = -radius; j <= radius; j++) {
						{
							gct.move_posx();
							// cut off the corners
							var dist:int = i * i + j * j;
							if (dist < radius * radius) {
								if ( percent > Math.random() ) 
								{
									write( $guid, oxel, gct, e_type );
								}
							}
						}
					}
					gct.grainX = gcc.grainX - (radius+1);
					gct.move_posz();
				}
			}
			else
			{
				gct.grainX = gcc.grainX + (radius+1);
				gct.grainZ = gcc.grainZ + (radius);

                for ( var ia:int = radius; ia >= -radius; ia--)
				{
					for (var  ja:int = radius; ja >= -radius; ja--) {
						{
							gct.move_posx();
							// cut off the corners
							var dista:int = ia * ia + ja * ja;
							if (dista < radius * radius) {
								if ( percent > Math.random() ) 
								{
									write( $guid, oxel, gct, e_type );
								}
							}
						}
					}
					gct.grainX = gcc.grainX + (radius+1);
					gct.move_posz();
				}
			}
			
			
			GrainCursorPool.poolDispose( gct );
        }

        
		// this returns gct at the top of the trunk
		public static function buildTrunk( $guid:String, oxel:Oxel, gct:GrainCursor, trunkHeight:int, e_trunkType:uint ): void 
		{
//			gct.move_posy();  this lets tree grow into ground one level
			for ( var t:int = 0; t < trunkHeight; t++ ) {
				var ao:Oxel = oxel.root_get().childFind( gct );
				if ( Globals.BAD_OXEL != ao )
					ao.write( $guid, gct, e_trunkType );
				gct.move_posy();
			}
		}

		public static function buildForkedTrunk( oxel:Oxel, trunkHeight:int, splitLevels:int ): Point {
			/*
			// Add trunk
			for ( var t:int = y; t < y + trunkHeight - 1; t++ ) {
				voxelVector.setVoxelType(x, t, z, Globals.WOOD );
			}
			voxelVector.setVoxelType(x, t, z, Globals.BRANCH );
			*/
			var point:Point = new Point();
			/*
			if ( 0.5 < Math.random() ) {
				var i:int = 1;
				for ( var st:int = y + trunkHeight; st < y + trunkHeight + splitLevels; st++ ) {
					voxelVector.setVoxelType(x, st, z + i, Globals.BRANCH );
					voxelVector.setVoxelType(x, st, z - i, Globals.BRANCH );
					i++;
					point.y = i - 1;
				}
			} else {
				var j:int = 1;
				for ( var rt:int = y + trunkHeight; rt < y + trunkHeight + splitLevels; rt++ ) {
					voxelVector.setVoxelType(x + j, rt, z, Globals.BRANCH );
					voxelVector.setVoxelType(x - j, rt, z, Globals.BRANCH );
					j++;
					point.x = j - 1;
				}
			}
			*/
			return point;
		}
	}
}