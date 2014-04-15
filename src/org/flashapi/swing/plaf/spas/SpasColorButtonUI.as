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

package org.flashapi.swing.plaf.spas {
	
	// -----------------------------------------------------------
	// SpasColorButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 15/06/2010 14:07
	* @see http://www.flashapi.org/
	*/

	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import flash.geom.Matrix;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.ColorButtonUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>SpasColorButtonUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>ColorButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ColorButton
	 * 	@see org.flashapi.swing.plaf.ColorButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasColorButtonUI extends SpasUI implements ColorButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasColorButtonUI(dto:LafDTO) { 
			super(dto);
			init();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ? dto.colors.up : dto.color;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ? dto.colors.over : dto.color;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ? 
				dto.colors.down : new RGB(dto.color).darker();
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			var bntColor:uint = (dto.colors.selected != StateObjectValue.NONE) ?
				dto.colors.selected : new RGB(dto.color).darker();
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ?
				dto.colors.disabled : new RGB(dto.color).brighter();
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @private
		 */
		override public function drawBackFace():void {
			drawOutState();
		}
		
		/**
		 *  @private
		 */
		override public function onChange():void {
			if (dto.container.contains(_shape)) dto.container.removeChild(_shape);
			_shape = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _rgb:RGB;
		private var _shape:Shape;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(buttonColor:uint):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			_rgb = new RGB(buttonColor);
			var c1:uint = _rgb.brighter(.8);
			var c2:uint = _rgb.darker(.8);
			var m:Matrix = new Matrix();
			m.createGradientBox(w, h, Math.PI / 2, 0, 0);
			var f:Figure = new Figure(_shape);
			f.clear();
			f.lineStyle(4, buttonColor);
			f.lineGradientStyle(GradientType.LINEAR, [c1, c2], [1, 1], [0, 250], m);
			f.drawRoundedRectangle(2, 2, w-2, h-2, 3, 3);
			f.endFill();
			f.lineStyle(0, buttonColor);
			f.beginFill(buttonColor, 1);
			f.drawRectangle(w - 10, h - 10, w-4, h-4);
			f.endFill();
			f.lineStyle(0, 0xFFFFFF);
			f.beginFill(0xFFFFFF, 1);
			f.drawTriangle(w - 8, h - 8, w - 4, h - 8, w - 6, h - 4);
			f.endFill();
			with (dto.container.graphics) {
				beginFill(dto.selectedColor, 1);
				drawRect(3, 3, w-6, h-6);
				endFill();
			}
		}
		
		private function init():void {
			_shape = new Shape();
			dto.container.addChild(_shape);
			var bf:BevelFilter = new BevelFilter(1);
			bf.type = BitmapFilterType.OUTER;
			bf.blurX = bf.blurY = 0;
			bf.highlightAlpha = .5;
			bf.shadowAlpha = .5;
			bf.quality = 7;
			_shape.filters = [bf];
		}
	}
}