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
	// PurpleClouds.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version beta 0.1, 05/06/2008 16:25
	* @see http://www.flashapi.org/
	*/
	
	// -----------------------------------------------------------
	// Based uppon "Perlin Noise in Flash" by Rich Hauck
	// http://www.mandalatv.net/itp/drivebys/flash-motion/index.php
	// -----------------------------------------------------------
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * 	The <code>PurpleClouds</code> class creates a programmatic <code>Texture</code>
	 * 	object which renders a cloudy purple sky appearance.
	 * 
	 * 	<p>The class is based on the "Perlin Noise in Flash" works by Rich HAUCK:
	 * 	<a href="http://www.mandalatv.net/itp/drivebys/flash-motion/index.php"
	 * 	title="Perlin Noise in Flash">
	 * 	http://www.mandalatv.net/itp/drivebys/flash-motion/index.php</a>.</p>
	 * 	
	 *  @includeExample PurpleCloudsExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PurpleClouds implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>PurpleClouds</code> instance.
		 */
		public function PurpleClouds() {
			super();
			initObj();
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
			return "Purple Clouds";
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function createBitmap(width:Number, height:Number):BitmapData {
			var bitmap:BitmapData = new BitmapData(width, height, false, 0x00FF0000);
			_randomNum = Math.floor(Math.random() * 10);
			render(bitmap);
			return bitmap;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_offset = [];
			_offset = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function render(bmp:BitmapData):void {
			_offset[0].x += _xSpeed;
			_offset[1].y += _ySpeed;
			bmp.perlinNoise(bmp.width, bmp.height, 20, _randomNum, false, true, 5, false, _offset);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _randomNum:Number
		private var _xSpeed:int = 10;
		private var _ySpeed:int = 10;
		private var _offset:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_offset = [new Point(), new Point()];
		}
	}
}