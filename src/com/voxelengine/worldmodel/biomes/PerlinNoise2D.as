/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.biomes
{
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;


	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class  PerlinNoise2D
	{
		public var noiseValues:Array = new Array();
        private var _amplitude:Number = 1;    // Max amplitude of the function
        private var _frequency:int  = 1;      // Frequency of the function

        public function get amplitude():Number { return _amplitude; }
        public function get frequency():int { return _frequency; }

        public function PerlinNoise2D( freq:int,  amp:Number )
        {
            _amplitude = amp;
            _frequency = freq;
			
			for (var i:uint=0; i < freq; i++) {  
				noiseValues[i] = new Array;
				for (var j:int = 0; j < freq; j++) {
					noiseValues[i][j] = new Number(Math.random());
				}
			}
		}
			
        // Get the interpolated point from the noise graph using cosine interpolation
        public function getInterpolatedPoint( _xa:int, _xb:int, _ya:int, _yb:int, x:Number, y:Number):Number
        {
            var i1:Number = interpolate(
                noiseValues[_xa % frequency][_ya % frequency],
                noiseValues[_xb % frequency][_ya % frequency]
                , x);

            var i2:Number = interpolate(
                noiseValues[_xa % frequency][ _yb % frequency],
                noiseValues[_xb % frequency][ _yb % frequency]
                , x);

            return interpolate(i1, i2, y);
        }

        // Get the interpolated point from the noise graph using cosine interpolation
        private function interpolate( a:Number, b:Number, x:Number):Number
        {
            var ft:Number = x * Math.PI;
            var f:Number = (1 - Math.cos(ft)) * .5;

            // Returns a Y value between 0 and 1
            return a * (1 - f) + b * f;
        }
		
        public function SumNoiseFunctions( width:Number, height:Number, noiseFunctions:Vector.<PerlinNoise2D> ):Array
        {
			var summedValues:Array = new Array();

            for (var ix:int = 0; ix < width; ix++)
			{
				summedValues[ix] = new Array();
				for (var iy:int = 0; iy < height; iy++)
				{
					summedValues[ix][iy] = 0;
				}
			}

            // Sum each of the noise functions
            for ( var i:int = 0; i < noiseFunctions.length; i++)
            {
				
                var x_step:Number = width / noiseFunctions[i].frequency;
                var y_step:Number = height / noiseFunctions[i].frequency;

                for (var x:int = 0; x < width; x++)
                {
                    for (var y:int = 0; y < height; y++)
                    {
                        var a:int = (int)(x / x_step);
                        var b:int = a + 1;
                        var c:int = (int)(y / y_step);
                        var d:int = c + 1;

                        var intpl_val:Number = noiseFunctions[i].getInterpolatedPoint(a, b, c, d, (x / x_step) - a, (y / y_step) - c);
						summedValues[x][y] += intpl_val * noiseFunctions[i].amplitude;
                    }
                }
            }
			
			var darkest_pixel:Number = 10000;
            for (x = 0; x < width; x++) {
				for (y = 0; y < height; y++) {
					if (summedValues[x][y] < darkest_pixel) {
						darkest_pixel = summedValues[x][y];
					}
				}
			}

			var brightest_pixel:Number = 0;
            for (x = 0; x < width; x++) {
				for ( y = 0; y < height; y++) {
					summedValues[x][y] -= darkest_pixel;
					if (summedValues[x][y] > brightest_pixel) {
						brightest_pixel = summedValues[x][y];
					}
				}
			}
		
			//Adjust values to highest value of 1
            for (x = 0; x < width; x++) {
				for ( y = 0; y < height; y++) {
					summedValues[x][y] /= brightest_pixel;
				}
			}	
			
            return summedValues;
        }
	}
}