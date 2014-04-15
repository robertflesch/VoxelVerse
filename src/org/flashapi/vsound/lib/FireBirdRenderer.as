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
	// FireBirdRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/11/2010 20:24
	* @see http://www.flashapi.org/
	* 
	* @author original implementation by: Andreas JIRENIUS
	* @see http://www.x-com.se/labs/flash/firebird-a-sound-visualization.html
	*/
	
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	/**
	 * 	The <code>FireBirdRenderer</code> class displays simulated bird-on-fire effect.
	 * 	<p>The original implementation of the <code>FireBirdRenderer</code> effect 
	 * 	has been developed by <a href="http://www.x-com.se/" title="Andreas JIRENIUS">Andreas JIRENIUS</a>
	 * 	and is available on this page: <a href="http://www.x-com.se/labs/flash/firebird-a-sound-visualization.html"
	 * 	title="Firebird – A sound visualization">Firebird – A sound visualization</a>.</p>
	 * 	
	 * 	<p><img src = "../../../../vsound-images/firebird_renderer.jpg" alt="FireBirdRenderer effect." /></p>
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class FireBirdRenderer implements SpectrumRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>FireBirdRenderer</code> instance.
		 */
		public function FireBirdRenderer() {
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
			_counter = 0;
            _colors = [0xFF0000, 0xFF2200, 0xFFFF33, 0xFFFFFF, 0xFFFF33, 0xFF2200, 0xFF0000];
			_shape = new Shape();
			_shape.visible = false;
			_shape.filters = [new GlowFilter(0xFF2211,1,20,30,3,2)];
			_ba = new ByteArray();
			_matrix = new Matrix();
			_bufferMatrix = new Matrix();
			_bufferMatrix.scale(2, 2);
			_rect = new Rectangle();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(buffer:BitmapData):void {
			updateGraphics();
			buffer.fillRect(_rect, 0);
			buffer.draw(_shape, _bufferMatrix);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			_ba = null;
			_matrix = null;
			_shape = null;
			_colors = [];
			_colors = null;
			_bufferMatrix = null;
			_rect = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_xOffset = width / 2;
			_yOffset = height / 2;
			_rect.width = width;
			_rect.height = height;
			_bufferMatrix.translate(_xOffset, _yOffset);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const BAR_WIDTH:int = 1;
		private var _ba:ByteArray;
		private var _matrix:Matrix;
		private var _shape:Shape;
		private var _counter:Number;
		private var _colors:Array;
		private var _xOffset:Number;
		private var _yOffset:uint;
		private var _bufferMatrix:Matrix;
		private var _rect:Rectangle;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function updateGraphics():void {
			var enhance:Number;
			var barHeight:Number;
			var dblBarHeight:Number;
			var posY:Number = 0;
			SoundMixer.computeSpectrum(_ba, true, 0);
			var i:int = 0;
			with(_shape.graphics) {
				clear(); 
				for (; i<200; i+=BAR_WIDTH) {
					enhance = 60-i;
					enhance = (enhance < 0) ? 0 : enhance;
					posY = -Math.sin(_counter+i * Math.PI / 360) * 100;
					barHeight = (_ba.readFloat() * (10 + enhance));
					dblBarHeight = 2 * barHeight;
					_matrix.createGradientBox(BAR_WIDTH, dblBarHeight, 1.57075, 0, -barHeight - posY * 0.5);
					beginGradientFill(GradientType.LINEAR, _colors, [0, 1, 1, 1, 1, 1, 0], [0, 50, 110, 128, 146, 205, 255], _matrix);
					drawRect(i, -barHeight - posY * 0.5, BAR_WIDTH, dblBarHeight); 
					drawRect( -i + BAR_WIDTH, -barHeight - posY * 0.5, BAR_WIDTH, dblBarHeight);
				}
			}
			_counter += .02;
		}
	}
}