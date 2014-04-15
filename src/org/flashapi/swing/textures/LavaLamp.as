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
	// LavaLamp.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version beta 0.1, 26/05/2008 14:51
	* @see http://www.flashapi.org/
	*/
	
	// -----------------------------------------------------------
	// Based uppon "lava lamp effect" by Pierluigi Pesenti
	// http://blog.oaxoa.com/
	// -----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 	The <code>LavaLamp</code> class creates _arr programmatic <code>Texture</code>
	 * 	object which renders a lava lamp effect to let you googlize your components.
	 * 
	 * 	<p>The class is based on the "lava lamp effect" by Pierluigi PESENTI:
	 * 	<a href="http://blog.oaxoa.com/" title="lava lamp effect">
	 * 	http://blog.oaxoa.com/</a>.</p>
	 * 	
	 *  @includeExample LavaLampExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LavaLamp implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>LavaLamp</code> instance.
		 */
		public function LavaLamp() {
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
			return "Lava Lamp";
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
			_rect = new Rectangle(0, 0, width, height);
			_bd = new BitmapData(width, height);
			_bd2 = new BitmapData(width, height);
			_bmp = new Bitmap(_bd2);
			_bmp.filters = [_blur, _bevel, _glow];
			_bmp.smoothing = true;
			render(_bd2);
			_bd.draw(_bmp, new Matrix());
			return _bd;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_rect = null;
			_point = null;
			_arr = [];
			_arr = null;
			_bd2.dispose();
			_bd2 = null;
			_bmp = null;
			_bd.dispose();
			_bd = null;
			_bevel = null;
			_blur = null;
			_glow = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function render(bmp:BitmapData):void {
			_bd.perlinNoise(105, 105, 2, 0, false, true, 7, true, _arr);
			_bd2.fillRect(_rect, 0x00000000);
			_bd2.threshold(_bd, _rect, _point, ">", 150 / 255 * 0xffffff, 0xffff8000, 0x00ffffff, false);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_point = new Point(0, 0);
			 _arr = [new Point(1, 1), new Point(3, 3)]
			_bevel = new BevelFilter();
			_bevel.blurX = _bevel.blurY = 20;
			_bevel.distance = 10;
			_bevel.highlightColor = 0xffffff;
			_bevel.shadowColor = 0xCC0000;
			_blur = new BlurFilter(2, 2);
			_glow = new GlowFilter(0xFFAA00, 1, 20, 20, 2, 1, false, false);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//private var _width:Number;
		//private var _height:Number;
		private var _rect:Rectangle;
		private var _point:Point;
		private var _arr:Array;
		private var _bd:BitmapData;
		private var _bd2:BitmapData;
		private var _bmp:Bitmap;
		private var _bevel:BevelFilter;
		private var _blur:BlurFilter;
		private var _glow:GlowFilter;
	}
}