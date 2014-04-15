/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.biomes
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.biomes.PerlinNoise2D;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;

	import flash.utils.getTimer;
	import flash.geom.Matrix;
	
	

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class  NoiseGenerator
	{
		
		public static const NOISE_MIN:int = 0;
		public static const NOISE_MAX:int = 1;
		//private function generatePerlinNoise2DMap(voxels:VoxelVector):Array
		//{
            //var heightFunctions1:Vector.<PerlinNoise2D> = new Vector.<PerlinNoise2D>();
            //heightFunctions1.push(new PerlinNoise2D(1, 2.0));
            //heightFunctions1.push(new PerlinNoise2D(8, 1.5));
            //heightFunctions1.push(new PerlinNoise2D(12, .25));5
            //heightFunctions1.push(new PerlinNoise2D(26, 2.625)); // This factor adds TONS of surface noise
            //heightFunctions1.push(new PerlinNoise2D(34, .0625));
            //heightFunctions1.push(new PerlinNoise2D(64, 0.1425));
			//
            //return heightFunctions1[0].SumNoiseFunctions(voxels.regionWidth, voxels.regionDepth, heightFunctions1);
		//}
		
		private static function generate_subsample_min( src:Array, src_size:uint, dest_size:uint ):Array
		{
			// Initialize the heightmap
			var dest:Array = new Array();
		
			for (var i:uint=0; i < dest_size; i++) {  
				dest[i] = new Array();
				for (var j:uint=0; j < dest_size; j++) {
					dest[i][j] = new uint();
				}
			}
			
			var min:Number = 0;
			//Adjust values to a min of 0
			for (i = 0; i < src_size;  ) 
			{
				for (j = 0; j < src_size;  ) 
				{
					min = src[i][j] < src[i + 1][j] ? src[i][j] : src[i + 1][j];
					min = min < src[i][j + 1] ? min : src[i][j + 1];
					min = min < src[i + 1][j + 1] ? min : src[i + 1][j + 1];
					dest[i/2][j/2] = min;
					j += 2;
				}
				i += 2;
			}
			
			return dest;
		}

		private static function generate_subsample_max( src:Array, src_size:uint, dest_size:uint ):Array
		{
			// Initialize the heightmap
			var dest:Array = new Array();
		
			for (var i:uint=0; i < dest_size; i++) {  
				dest[i] = new Array();
				for (var j:uint=0; j < dest_size; j++) {
					dest[i][j] = new uint();
				}
			}
			
			var max:Number = 0;
			//Adjust values to a max of 0
			for (i = 0; i < src_size;  ) 
			{
				for (j = 0; j < src_size;  ) 
				{
					max = src[i][j] > src[i + 1][j] ? src[i][j] : src[i + 1][j];
					max = max > src[i][j + 1] ? max : src[i][j + 1];
					max = max > src[i + 1][j + 1] ? max : src[i + 1][j + 1];
					dest[i/2][j/2] = max;
					j += 2;
				}
				i += 2;
			}
			
			return dest;
		}

		public static function get_height_mip_maps( originHeightMap:Array, origSize:uint, noiseType:int ):Vector.<Array>
		{
			var numLevels	:int 			= 1;
			var level		:int 			= origSize;
			while ( level > 2 )
			{
				numLevels++;
				level /= 2;
			}

			var mips		:Vector.<Array> = new Vector.<Array>( numLevels + 1, true );
			var size		:int 			= origSize;
			var currentLevel:int			= 0;

			mips[currentLevel] = originHeightMap;
			
			while ( currentLevel < numLevels )
			{
				var new_sample:Array;
				if ( NOISE_MIN == noiseType )
					new_sample = generate_subsample_min( mips[currentLevel], size, size / 2 );
				else
					new_sample = generate_subsample_max( mips[currentLevel], size, size / 2 );
				currentLevel++;
				size /= 2;
				mips[currentLevel] = new_sample;
			}

			return mips;
		}
		
		
		public static function perlinNoiseBitmap( size:uint, octaves:uint = 6, seed:uint = 0, stitch:Boolean = true, fractalNoise:Boolean = false ):BitmapData {
			var pmap:BitmapData = new BitmapData( size, size, false, 0x00CCCCCC);
			
			if ( seed )
				Globals.seedSet( seed );
			else if ( 0 == Globals.seed() )
				Globals.seedSet( Math.floor(Math.random() * 10000) );
				
			trace( "NoiseGenerator.perlinNoiseBitmap - seed: " + Globals.seed() );	
			trace( "NoiseGenerator.perlinNoiseBitmap - octaves: " + octaves );	
			
			pmap.perlinNoise( size // baseX		Frequency to use in the x direction
			                , size // baseY		Frequency to use in the y direction
							, octaves				// numOctaves	Number of octaves or individual noise functions to combine to create this noise.
							, Globals.seed()        // Seed number to use.
							, stitch				// stitch		A Boolean value. - If the value is true, the method attempts to smooth the transition edges
							, fractalNoise			// fractalNoise	A Boolean value. If the value is true, the method generates fractal noise; otherwise, it generates turbulence.
							, 1						// channelOptions	A number that can be a combination of any of
							, true					// grayScale	A Boolean value.
							// offsets:Array=null	// offsets	An array of points that correspond to x and y offsets for each octave.
							);
			return pmap;
		}
		
		public static function normalize_height_map_for_oxel( map:Array, masterMapSize:uint, range:int, offset:int ):Array
		{
			for (var i:int = 0; i < masterMapSize; i++ ) 
				for ( var j:int = 0; j < masterMapSize; j++ ) 
					map[i][j] = map[i][j] * range + offset ;

			return map;		
		}
		
		
		// TODO pass in profile to use in PerlinNoise object, also pass in seed number
		//public static function generate_height_map( size:uint, octaves:uint = 6, seed:uint = 0, stitch:Boolean = true, fractalNoise:Boolean = false ):Array 
		public static function generate_height_map( size:uint, octaves:uint = 6, seed:uint = 0, stitch:Boolean = true, fractalNoise:Boolean = false ):Array 
		{
			var pmap:BitmapData = perlinNoiseBitmap( size, octaves, seed, stitch, fractalNoise );
			
			// Set the grid size
			// if you dont use + 1, the edges of the map are always 0
			var grid_width:uint = new uint(size+1);
			
			// Initialize the heightmap
			var heightmap:Array = new Array();
		
			for (var i:uint=0; i < grid_width; i++) {  
				heightmap[i] = new Array();
				for (var j:uint=0; j < grid_width; j++) {
					heightmap[i][j] = new uint();
				}
			}
		
			var pixelPoint:Point = new Point();
			var darkest_pixel:Number = 1;
		
			//Divide the map in to a X x Y grid and take data at each interval
			for (i=0; i < grid_width; i++) {  
				for (j=0; j < grid_width; j++) {
					pixelPoint.x = Math.round((i/grid_width) * pmap.width)+1;
					pixelPoint.y = Math.round((j/grid_width) * pmap.height)+1;
					heightmap[i][j] = pmap.getPixel(pixelPoint.x, pixelPoint.y);
					heightmap[i][j] /= 0xffffff;
		
					if (heightmap[i][j] < darkest_pixel) {
						darkest_pixel = heightmap[i][j];
					}
				}
			}
			
			var brightest_pixel:Number = 0;
			//Adjust values to a min of 0
			for (i=0; i < grid_width; i++) {
				for (j=0; j < grid_width; j++) {
				heightmap[i][j] -= darkest_pixel;
					if (heightmap[i][j] > brightest_pixel) {
						brightest_pixel = heightmap[i][j];
					}
				}
			}
		
			//Adjust values to highest value of 1
			for (i=0; i < grid_width; i++) {
				for (j=0; j < grid_width; j++) {
						heightmap[i][j] /= brightest_pixel;
					}
			}	
			
			// cut off the extra pixel generated from the size+1
			heightmap = heightmap.slice( 0, size );
			
			return heightmap;
		}
		
	}
}