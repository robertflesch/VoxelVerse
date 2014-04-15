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

package org.flashapi.vsound.lib {
	
	// -----------------------------------------------------------
	// StarRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/11/2010 10:17
	* @see http://www.flashapi.org/
	* 
	* @author original implementation by: Matt ELEY
	* @see http://matteley.wordpress.com/2009/08/31/music-visualizers-in-flash-using-as3-and-computespectrum/
	*/
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import org.flashapi.vsound.util.Geom;
	
	/**
	 * 	The <code>StarRenderer</code> class displays an exploding bright star effect.
	 * 	<p>The original implementation of the <code>StarRenderer</code> effect has been
	 * 	developed by <a href="http://matteley.wordpress.com/" title="Matt ELEY">Matt ELEY</a>
	 * 	and is available on this page: <a href="http://matteley.wordpress.com/2009/08/31/music-visualizers-in-flash-using-as3-and-computespectrum/"
	 * 	title="Music visualizers in Flash using AS3 and computeSpectrum">
	 * 	Music visualizers in Flash using AS3 and computeSpectrum</a>.</p>
	 * 	
	 * 	<p><img src = "../../../../vsound-images/star_renderer.jpg" alt="StarRenderer effect." /></p>
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class StarRenderer implements SpectrumRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>StarRenderer</code> instance.
		 */
		public function StarRenderer() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function init(buffer:BitmapData):void {
			_shape = new Shape();
			_shape.visible = false;
			_shape.filters = [	new GradientGlowFilter(0, 0, WAVE_COLORS, [0, 1],
								[0, 200, 255], 16, 16, 1, BitmapFilterQuality.LOW,
								BitmapFilterType.FULL)];
			_canvas = _shape.graphics;
			_matrix = new Matrix();
			_matrix.scale(5, 5);
			_rect = new Rectangle();
			_ba = new ByteArray();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(buffer:BitmapData):void {
			updateGraphics();
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, BLUR);
			buffer.colorTransform(_rect, COLORS);
			buffer.draw(_shape, _matrix, null, BlendMode.ADD);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			_shape = null;
			_canvas = null;
			_matrix = null;
			_rect = null;
			_ba = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			var w:Number = width / 2;
			var h:Number = height / 2;
			_matrix.translate(w, h);
			_shape.x = w;
			_shape.y = h;
			_rect.width = width;
			_rect.height = height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const WAVE_RADIUS:uint = 100;
		private static const WAVE_COLORS:Array = [0x0054DF, 0xBFE8FF, 0x6100D7];
		private static const BLUR:BlurFilter = new BlurFilter(16, 16, BitmapFilterQuality.LOW)
		private static const COLORS:ColorTransform = new ColorTransform(1, 1, 1, 0.90);
		
		private var _matrix:Matrix;
		private var _shape:Shape;
		private var _rect:Rectangle;
		private var _ba:ByteArray;
		private var _canvas:Graphics;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function updateGraphics():void {
			SoundMixer.computeSpectrum(_ba);
			var x:Number;
			var y:Number;
			/*var startX:Number;
			var startY:Number;*/
			var value:Number;
			var angle:Number;
			var i:int = 512;
			_canvas.clear();
			_canvas.beginFill(0xffffff, 0.7);
			_canvas.moveTo(0, 0);
			while (i--) {
				value = WAVE_RADIUS * _ba.readFloat();
				angle = i / 512 * Math.PI * 2;
				x = Math.cos(angle) * value;
				y = Math.sin(angle) * value;
				_canvas.lineTo(x, y);
				i--;
			}
			_canvas.endFill();
		}
	}
}