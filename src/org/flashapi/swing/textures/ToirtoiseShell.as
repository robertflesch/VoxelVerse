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
	// ToirtoiseShell.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/12/2007 22:56
	* @see http://www.flashapi.org/
	*/
	
	// -----------------------------------------------------------
	// Based uppon "BioTexture" by Anton Volkov
	// http://antonvolkov.com
	// -----------------------------------------------------------
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import org.flashapi.swing.draw.Figure;
	
	/**
	 * 	The <code>ToirtoiseShell</code> class creates a programmatic <code>Texture</code>
	 * 	object which renders a toirtoise-shell-like appearance.
	 * 
	 * 	<p>The class is based on the "BioTexture effect" by Anton VOLKOV:
	 * 	<_arr href="http://antonvolkov.com/" title="BioTexture effect">
	 * 	http://antonvolkov.com/</_arr>.</p>
	 * 
	 *  @includeExample ToirtoiseShellExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ToirtoiseShell implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>ToirtoiseShell</code> instance.
		 */
		public function ToirtoiseShell() {
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
			return "Toirtoise Shell";
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
			_width = 100;
			_height = 100;
			var bioCells:BitmapData = new BitmapData(100, 100, false, 0xFFFFFFFF);
			render(bioCells);
			return bioCells;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function render(bmp:BitmapData):void {
			var brush:Shape = new Shape();
			var f:Figure = new Figure(brush);
			f.beginGradientFill(GradientType.RADIAL, [0x000000, 0xFFFFFF], [1, 1], [0, 150]);
			f.drawCircle(0, 0, 55);
			f.endFill();
			f = null;
			var m:Matrix;
			var buffer:BitmapData = new BitmapData(_width / 2, _height / 2, false, 0xFFFFFFFF);
			for(var i:uint = 0; i<600; i++) {
				var ct:ColorTransform = new ColorTransform();
				m = new Matrix(1, 0, 0, 1, Math.random()*400, Math.random()*400);
				buffer.draw(brush, m, ct, BlendMode.DARKEN);
			}
			brush = null;
			bmp.draw(buffer);
			m.createBox(-1, 1, 0, _width, 0);
			bmp.draw(buffer, m);
			m.createBox(-1, -1, 0, _width, _height);
			bmp.draw(buffer, m);
			m.createBox(1, -1, 0, 0, _height);
			bmp.draw(buffer, m);
			bmp.colorTransform(bmp.rect, new ColorTransform(2, 3, 0, 1, 0, 0, 0, 0));
			buffer.dispose();
			buffer = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// 	Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
	}
}