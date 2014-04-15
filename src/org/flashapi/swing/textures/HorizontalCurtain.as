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
	// HorizontalCurtain.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version beta 0.1, 26/05/2008 17:22
	* @see http://www.flashapi.org/
	*/
	
	// -----------------------------------------------------------
	// Based uppon "AS3 Perlin Noise Ripples" by Mike T. Henderson
	// http://mikethenderson.com/
	// -----------------------------------------------------------
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * 	The <code>HorizontalCurtain</code> class creates a programmatic <code>Texture</code>
	 * 	object which renders a theater curtain appearance.
	 * 	
	 *  @includeExample HorizontalCurtainExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class HorizontalCurtain implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>HorizontalCurtain</code> instance.
		 */
		public function HorizontalCurtain() {
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
			return "Horizontal Curtain";
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
			var bmp:BitmapData = new BitmapData(width, height, false, 0xff000000);
			render(bmp);
			return bmp;
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
			var s:Number = Math.floor(Math.random() * _seed);
			bmp.perlinNoise(_baseX, _baseY, _octaves, s, _stitch, _fractal, _channels, _grayScale, _offset);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _baseX:int = 200;
		private var _baseY:int = 50;
		private var _octaves:int = 2;
		private var _seed:int = 10
		private var _stitch:Boolean = false;
		private var _fractal:Boolean = true;
		private var _grayScale:Boolean = false;
		private var _channels:int = 1;
		private var _xSpeed:int = 2;
		private var _ySpeed:int = 5;
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