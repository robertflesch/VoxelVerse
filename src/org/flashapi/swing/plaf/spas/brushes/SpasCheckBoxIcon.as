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

package org.flashapi.swing.plaf.spas.brushes {
	
	// -----------------------------------------------------------
	// SpasCheckBoxIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 10/02/2010 10:11
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.spas.SpasUI;
	import org.flashapi.swing.util.AltColors;
	
	/**
	 * 	The <code>SpasCheckBoxIcon</code> class renders icons used by <code>CheckBox</code>
	 * 	objects for the SPAS 3.0 default Look and Feel.
	 * 
	 * 	@see org.flashapi.swing.CheckBox
	 * 	@see org.flashapi.swing.plaf.CheckBoxUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasCheckBoxIcon extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function SpasCheckBoxIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function drawBrushShape(state:String):void {
			var c:Object;
			var bg:Object;
			var brightColor:uint = _rgb.brighter(.8)
			var darkColor:uint = _rgb.darker(.8);
			switch(state) {
				case States.OUT :
					c = ($dto.borderColors.up != StateObjectValue.NONE) ?
					new AltColors($dto.borderColors.up) : { color1:0xB6B9BB, color2:0x5F6162 };
					bg = ($dto.colors.up != StateObjectValue.NONE) ?
					new AltColors($dto.colors.up) : { color3:brightColor, color4:darkColor };
					break;
				case States.OVER :
					c = ($dto.borderColors.over != StateObjectValue.NONE) ?
					new AltColors($dto.borderColors.over) : { color1:0x009DFF, color2:0x0077C1 };
					bg = ($dto.colors.over != StateObjectValue.NONE) ? 
					new AltColors($dto.colors.over) : { color3:brightColor, color4:darkColor };
					break;
				case States.PRESSED :
				c = ($dto.borderColors.down != StateObjectValue.NONE) ?
					new AltColors($dto.borderColors.down) : { color1:0x009DFF, color2:0x0077C1 };
					bg = ($dto.colors.down != StateObjectValue.NONE) ?
					new AltColors($dto.colors.down) : { color3:0xE5F5FF, color4:0x9AD8FF };
					break;
				case States.SELECTED :
					c = ($dto.borderColors.selected != StateObjectValue.NONE) ? 
					new AltColors($dto.borderColors.selected) : { color1:0xB6B9BB, color2:0x5F6162 };
					bg = ($dto.colors.selected != StateObjectValue.NONE) ?
					new AltColors($dto.colors.selected) : { color3:brightColor, color4:darkColor };
					break;
				case States.INACTIVE :
					c = ($dto.borderColors.disabled != StateObjectValue.NONE) ?
					new AltColors($dto.borderColors.disabled) : { color1:0x9C9D9D, color2:0x808080 };
					bg = ($dto.colors.disabled != StateObjectValue.NONE) ?
					new AltColors($dto.colors.disabled) : { color3:0xA9A9A9, color4:0x979797 };
					break;
				case States.EMPHASIZED :
					break;
			}
			drawRadioButtonIcon(c.color1, c.color2, bg.color3, bg.color4, state);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _rgb:RGB;
		private static var _matrix:Matrix = null;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (_matrix == null) _matrix = MatrixUtil.getMatrix(18, 18);
			_rgb = new RGB(SpasUI.DEFAULT_COLOR);
		}
		
		private function drawRadioButtonIcon(lineColor1:uint, lineColor2:uint, buttonColor1:uint, buttonColor2:uint, state:String):void {
			var c:uint = ColorStateUtil.getColor(state, $colors);
			with($graphics){
				clear();
				lineStyle(1, lineColor1, 1);
				lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], _matrix);
				beginGradientFill(GradientType.LINEAR, [buttonColor1, buttonColor2], [1, 1], [0, 250], _matrix);
				drawRect(0, 0, 16, 16);
				if (state == States.OUT) {
					endFill();
					return;
				}
				lineStyle(0, c);
				beginFill(c);
				moveTo(4, 5);
				lineTo(9, 13);
				lineTo(15, 1);
				lineTo(9, 8);
				lineTo(4, 5);
				endFill();
			}
		}
	}
}