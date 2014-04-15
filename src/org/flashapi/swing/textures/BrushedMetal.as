////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing.textures {
	
	// -----------------------------------------------------------
	// BrushedMetal.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/08/2007 14:46
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 	The <code>BrushedMetal</code> class creates a programmatic <code>Texture</code>
	 * 	object which renders a brushed metal appearance.
	 * 	
	 *  @includeExample BrushedMetalExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BrushedMetal implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>BrushedMetal</code> instance.
		 */
		public function BrushedMetal() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get name():String {
			return "Brushed Metal";
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function createBitmap(width:Number, height:Number):BitmapData {
			var metal_bmp:BitmapData = new BitmapData(width, height, false, 0xFFFFFF);
			this.render(metal_bmp);
			return metal_bmp;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function render(bmp:BitmapData):void {
			var w:Number = bmp.width;
			var h:Number = bmp.height;
			var rect:Rectangle = new Rectangle(0, 0, w, h);
			var point:Point = new Point();
			var perlin1:BitmapData = new BitmapData(w, h, false, 0xFFFFFF);
			var perlin2:BitmapData = new BitmapData(w, h, false, 0xFFFFFF);
			perlin1.perlinNoise(50, 50, 1, Math.random() * 1000, true, true, 1, true);
			var bmpTemp:BitmapData = new BitmapData(w, h, false, 0xFFFFFF);
			bmpTemp.noise(1000,0,255,1|2|4,true);
			bmpTemp.applyFilter(bmpTemp, rect, point, new BlurFilter(20, 1, 5));
			perlin2.copyPixels(perlin1, rect, new Point(-1, 0));
			perlin2.copyPixels(perlin1, new Rectangle(0, 0, 1, h), new Point(w - 1, 0));
			perlin1.copyPixels(perlin2, rect, point);
			bmp.copyPixels(bmpTemp, rect, point);
			bmp.applyFilter(bmp, rect, point, new DisplacementMapFilter(perlin1, point, 1, 1, 2, 1));
		}	
	}
}