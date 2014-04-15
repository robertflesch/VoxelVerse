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
	// SpectrumRingRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/12/2010 15:58
	* @see http://www.flashapi.org/
	* 
	* @author original implementation by: Grant SKINNER
	* @see http://www.gskinner.com/blog/archives/2009/07/source_code_spe.html
	*/
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import org.flashapi.vsound.util.Geom;
	
	/**
	 * 	The <code>SpectrumRingRenderer</code> class displays lighting ring effect.
	 * 	<p>The original implementation of the <code>SpectrumRingRenderer</code> effect 
	 * 	has been developed by <a href="http://www.gskinner.com/blog" title="Grant SKINNER">Grant SKINNER</a>
	 * 	and is available on this page: <a href="http://www.gskinner.com/blog/archives/2009/07/source_code_spe.html"
	 * 	title="Source Code: Spectrum Ring Music Visualizer">Source Code: Spectrum Ring Music Visualizer</a>.</p>
	 * 	
	 * 	<p><img src = "../../../../vsound-images/spectrum_ring_renderer.jpg" alt="SpectrumRingRenderer effect." /></p>
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class SpectrumRingRenderer implements SpectrumRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SpectrumRingRenderer</code> instance.
		 */
		public function SpectrumRingRenderer() {
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
			_ba = new ByteArray();
			_bars = [];
			_holder = new Sprite();
			
			_barCount = (512 - BASS_COUNT * 2) >> 2;
			var i:uint = 0;
			var dbc:Number = _barCount * 2;
			var bar:Shape;
			for (; i<dbc; ++i) {
				bar = new Shape();
				bar.rotation = (i + 0.5) / _barCount * 180;
				_holder.addChild(bar);
				with (bar.graphics) {
					beginFill(0xFFFFFF, 1);
					drawRect( -60, 10, 1, 80);
					endFill();
				}
				_bars.push(bar);
			}
			_rect = new Rectangle();
			_matrix = new Matrix();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(buffer:BitmapData):void {
			SoundMixer.computeSpectrum(_ba, true, 1);
			
			var level:Number = 0;
			var i:uint;
			var bar:Shape;
			
			// left bass:
			var lBass:Number = 0;
			
			i = 0;
			for (; i < BASS_COUNT; ++i) lBass += _ba.readFloat();
			
			// left channels:
			i = 0;
			for (; i < _barCount; ++i) { ;
				level = (_ba.readFloat() + _ba.readFloat()) * (i + 15) / 4 + 0.02 + i / 500;
				bar = _bars[i];
				bar.scaleY += (level - bar.scaleY) / 5;
			}
			
			// right bass:
			var rBass:Number = 0;
			i = 0;
			for (; i < BASS_COUNT; ++i) lBass += _ba.readFloat();
			
			// right channels:
			i = 0;
			for (; i < _barCount; ++i) {
				level = (_ba.readFloat() + _ba.readFloat()) * (i + 15) / 4 + 0.02 + i / 500;
				bar = _bars[i+_barCount];
				bar.scaleY += (level - bar.scaleY) / 5;
			}
			buffer.colorTransform(_rect, COLOR_TRANSFORM);
			buffer.draw(_holder, _matrix, new ColorTransform(1, 1, 1, Math.min(1, 0.05 + (lBass + rBass) / 50)));
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, BLUR);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			_ba = null;
			_rect = null;
			_matrix = null;
			var bar:Shape;
			while (_bars.length) {
				bar = _bars.shift();
				_holder.removeChild(bar);
				bar = null;
			}
			_bars = null;
			_holder = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_rect.width = width;
			_rect.height = height;
			_matrix.translate(width / 2, height / 2);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _ba:ByteArray;
		private static const BASS_COUNT:uint = 24;
		private static const BLUR:BlurFilter = new BlurFilter(16, 16, 2);
		private static const COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.88, 0.93, 0.97, 1)
		private var _rect:Rectangle;
		private var _matrix:Matrix;
		private var _bars:Array;
		private var _barCount:Number;
		private var _holder:Sprite;
	}
}