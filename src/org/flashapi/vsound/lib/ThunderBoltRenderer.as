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
	// ThunderBoltRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/11/2010 16:42
	* @see http://www.flashapi.org/
	* 
	* @author original implementation by: Stephen BARRANTE
	* @see http://nextframe.wordpress.com/2008/09/05/soundmixer-sound-visualization-in-actionscript-30/
	*/
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import org.flashapi.vsound.util.Geom;
	
	/**
	 * 	The <code>ThunderBoltRenderer</code> class displays an horizontal thunderbolt
	 * 	light effect.
	 * 	<p>The original implementation of the <code>ThunderBoltRenderer</code> effect 
	 * 	has been developed by <a href="http://nextframe.wordpress.com/" title="Stephen BARRANTE">Stephen BARRANTE</a>
	 * 	and is available on this page: <a href="http://nextframe.wordpress.com/2008/09/05/soundmixer-sound-visualization-in-actionscript-30/"
	 * 	title="soundmixer – sound visualization in actionscript 3.0">
	 * 	soundmixer – sound visualization in actionscript 3.0</a>.</p>
	 * 	
	 * 	<p><img src = "../../../../vsound-images/thunderbolt_renderer.jpg" alt="ThunderBoltRenderer effect." /></p>
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class ThunderBoltRenderer implements SpectrumRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ThunderBoltRenderer</code> instance.
		 */
		public function ThunderBoltRenderer() {
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
			_rect = new Rectangle();
			_ba = new ByteArray();
			_shape = new Shape;
			_canvas = _shape.graphics;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(buffer:BitmapData):void {
			updateGraphics();
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, COLOR_MATRIX);
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, BLUR);
			buffer.scroll(2, 0);
			buffer.draw(_shape, null, null, null);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			_ba = null;
			_canvas = null;
			_shape = null;
			_rect = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_posY = height / 2;
			_rect.width = width;
			_rect.height = height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const BLUR:BlurFilter = new BlurFilter(8, 8, BitmapFilterQuality.LOW);
		private static const COLOR_MATRIX:ColorMatrixFilter =
			new ColorMatrixFilter([.96,0,0,0,0,0,.97,0,0,0,0,0,.98,0,0,0,0,0,.98,0]);
		private var _ba:ByteArray;
		private var _rect:Rectangle;
		private var _shape:Shape;
		private var _canvas:Graphics;
		private var _posY:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function updateGraphics():void {
			SoundMixer.computeSpectrum(_ba);
			var lev:Number;
			var i:uint = 0;
			_canvas.clear();
			_canvas.lineStyle(2, 0xFFFFFF);
			_canvas.moveTo(0, 300);
			for (; i < 256; ++i) {
				lev = _ba.readFloat();
				_canvas.lineTo(i * 4, lev * 200 + _posY);
			}
			_canvas.endFill();
		}
	}
}