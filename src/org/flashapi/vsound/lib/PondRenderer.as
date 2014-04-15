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
	// PondRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/11/2010 14:51
	* @see http://www.flashapi.org/
	* 
	* @author original implementation by: Antti KUPILA
	* @see http://www.anttikupila.com/flash/flash-spectrum-analyzer/
	*/
	
	import flash.display.BitmapData;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import org.flashapi.vsound.util.Geom;
	
	/**
	 * 	The <code>PondRenderer</code> class displays an effect taht consists in
	 * 	a succession of concentric and horizontal green circles.
	 * 	<p>The original implementation of the <code>PondRenderer</code> effect has been
	 * 	developed by <a href="http://www.anttikupila.com/" title="Antti KUPILA">Antti KUPILA</a>
	 * 	and is available on this page: <a href="http://www.anttikupila.com/flash/flash-spectrum-analyzer/"
	 * 	title="Spectrum Analizer">Spectrum Analizer</a>.</p>
	 * 	
	 * 	<p><img src = "../../../../vsound-images/pond_renderer.jpg" alt="PondRenderer effect." /></p>
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class PondRenderer implements SpectrumRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>PondRenderer</code> instance.
		 */
		public function PondRenderer() {
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
			_rect = new Rectangle();
			_z = 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(buffer:BitmapData):void {
			SoundMixer.computeSpectrum(_ba, true, 0);
			var num:Number = _ba.readFloat();
			var l:Number = Math.pow(num, 3) * _width / 3;
			var i:int = 1440;
			var v:Number;
			for (; i >= 0; --i) {
				v = i * Math.PI / 180;
				buffer.setPixel(Math.cos(v) * l + _width / 2, Math.sin(v) * l / 3 + _height / 2, i * 0xffffff / 2);
			}
			var displace:DisplacementMapFilter = new DisplacementMapFilter (buffer, Geom.ORIGIN, 2, 1, Math.sin(_z) * 3, Math.cos(_z) + 3);
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, displace);
			buffer.applyFilter(buffer, _rect, Geom.ORIGIN, BLUR);
			_z += 0.02;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			_ba = null;
			_rect = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_rect.width = _width = width;
			_rect.height = _height = height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const BLUR:BlurFilter = new BlurFilter(5, 1, BitmapFilterQuality.LOW);
		private var _ba:ByteArray;
		private var _width:Number;
		private var _height:Number;
		private var _z:Number;
		private var _rect:Rectangle;
		
	}
}