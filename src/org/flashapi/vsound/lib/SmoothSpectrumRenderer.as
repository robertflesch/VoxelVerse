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
	// SmoothSpectrumRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/12/2010 17:34
	* @see http://www.flashapi.org/
	* 
	* @author original implementation by: Thibault IMBERT
	* @see http://www.bytearray.org/?p=9
	*/
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import org.flashapi.vsound.util.Geom;
	
	/**
	 * 	The <code>SmoothSpectrumRenderer</code> class displays multi-lines sin effect.
	 * 	<p>The original implementation of the <code>SmoothSpectrumRenderer</code> effect
	 * 
	 * 	has been developed by <a href="http://www.bytearray.org/" title="Thibault IMBERT">Thibault IMBERT</a>
	 * 	and is available on this page: <a href="http://www.bytearray.org/?p=9" title="Equalizers ">Equalizers </a>.</p>
	 * 	
	 * 	<p><img src = "../../../../vsound-images/smooth_spectrum_renderer.jpg" alt="SmoothSpectrumRenderer effect." /></p>
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class SmoothSpectrumRenderer implements SpectrumRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SmoothSpectrumRenderer</code> instance.
		 */
		public function SmoothSpectrumRenderer() {
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
			_colors = [0x990000, 0x00FF00];
			_alphas = [100, 100];
			_ratios = [80, 255];
			_matrix = new Matrix();
			_canvas = _shape.graphics;
			_ba = new ByteArray();
			_points = [];
			_midPoints = [];
			_rect = new Rectangle();
			_presetCounter = 0;
			buffer.fillRect(buffer.rect, 0);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(buffer:BitmapData):void {
			updateGraphics();
			buffer.scroll(1, 0);
			buffer.draw(_shape, null, null, BlendMode.ADD);
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, BLUR);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			_ba = null;
			_matrix = null;
			_canvas = null;
			_shape = null;
			_ratios = [];
			_ratios = null;
			_alphas = [];
			_alphas = null;
			_colors = [];
			_colors = null;
			_points = [];
			_points = null;
			_midPoints = [];
			_midPoints = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_amplitude = height / 2;
			_yOffset = 2 * height / 3;
			_matrix.createGradientBox(width, 1, 0, 0, 0);
			_rect.width = width;
			_rect.height = height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const BLUR:BlurFilter = new BlurFilter(2, 2, BitmapFilterQuality.LOW);
		private static const LENGTH:uint = 16;
		private static const CURVE_LENGTH:uint = 15;
		
		private var _ba:ByteArray;
		private var _matrix:Matrix;
		private var _ratios:Array;
		private var _alphas:Array;
		private var _colors:Array;
		private var _shape:Shape;
		private var _canvas:Graphics;
		private var _amplitude:int;
		private var _offset:Number;	
		private var _points:Array;
		private var _midPointX:Number;
		private var _midPointY:Number;
		private var _yOffset:Number;
		private var _midPoints:Array;
		private var _rect:Rectangle;
		private var _presetCounter:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function updateGraphics():void {
			SoundMixer.computeSpectrum (_ba, true);
			_canvas.clear();
			_canvas.lineStyle(0.01);
			_canvas.lineGradientStyle(GradientType.LINEAR, _colors, _alphas, _ratios,
				_matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 0.1);
			var i:int = LENGTH;
			
			while (--i > -1) {											
				_ba.position = i * 128;
				_offset = _ba.readFloat() * _amplitude;
				_points[i] = new Point(40 * i, int(_yOffset + (-_offset)));
			}
			
			i = 1;
			for (; i < LENGTH; ++i) {
				_midPointX =(_points[i].x + _points[int(i - 1)].x) / 2;
				_midPointY =(_points[i].y + _points[int(i - 1)].y) / 2;
				
				_midPoints[int(i-1)] = new Point (int(_midPointX), int(_midPointY));
			}
			
			_canvas.moveTo(_midPoints[0].x, _midPoints[0].y);
			i = 1;
			for (; i< CURVE_LENGTH; ++i)
				_canvas.curveTo (_points[i].x, _points[i].y, _midPoints[i].x, _midPoints[i].y);
			
			if (++_presetCounter == 300) changePresets();
		}
		
		private function changePresets():void {
			_presetCounter = 0;
			_colors = [Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF];
		}
	}
}