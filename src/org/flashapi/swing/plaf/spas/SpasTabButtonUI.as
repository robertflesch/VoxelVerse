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
	// SpasTabButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 28/12/2008 14:58
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.plaf.TabButtonUI;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>SpasTabButtonUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>TabButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.button.TabButton
	 * 	@see org.flashapi.swing.plaf.TabButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasTabButtonUI extends SpasIconColorsUI implements TabButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasTabButtonUI(dto:LafDTO) {
			super(dto);
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
		public function getBorderColor():uint {
			return DEFAULT_BORDER_COLOR;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function drawOutState():void {
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ?
				dto.colors.up : dto.color;
			var lineColor1:uint = 0x888888;//0x969696
			var lineColor2:int = 0x505050;//0x505050
			if (dto.fontColors.up != StateObjectValue.NONE) {
				lineColor1 = dto.fontColors.up;
				lineColor2 = -1;
			}
			drawButtonShape(bntColor, lineColor1, lineColor2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ?
				dto.colors.over : new RGB(dto.color).brighter();
			var lineColor:uint = (dto.fontColors.over != StateObjectValue.NONE) ?
				dto.fontColors.over : 0x505050;
			drawButtonShape(bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ?
				dto.colors.down : new RGB(dto.color).darker();
			var lineColor:uint = (dto.fontColors.down != StateObjectValue.NONE) ?
				dto.fontColors.down : 0x505050;
			drawButtonShape(bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			var bntColor:uint = (dto.colors.selected != StateObjectValue.NONE) ?
				dto.colors.selected : 0xFFFFFF;
			//var c:RGB = new RGB(bntColor);
			var lineColor:uint = (dto.fontColors.selected != StateObjectValue.NONE) ?
				dto.fontColors.selected : DEFAULT_FONT_COLOR;
			drawButtonShape(bntColor, lineColor, -1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ?
				dto.colors.disabled : 0x999999;
			var lineColor:uint = (dto.fontColors.disabled != StateObjectValue.NONE) ?
				dto.fontColors.disabled : 0xcccccc;
			drawButtonShape(lineColor, bntColor, bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveIcon():void {
			var it:Transform = dto.icon.transform;
            it.colorTransform = new ColorTransform(.2, .2, .2, .2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawActiveIcon():void {
			var it:Transform = dto.icon.transform;
            it.colorTransform = new ColorTransform(1, 1, 1, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawDottedLine():void {
			var dashedLine:DashedLine = new DashedLine(dto.container, 1, 2);
			dashedLine.lineStyle(0, 0x777777, 1, true);
			dashedLine.drawRectangle(new Point(2, 2), new Point(dto.width-2, dto.height-2));
			dashedLine.endFill();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getUpFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOverFontFormat():FontFormat {
			return _selectedFontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDownFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectedFontFormat():FontFormat {
			return _selectedFontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDisabledFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getGrayTintColor():uint {
			return 0xACA899;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getIconDelay():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTopOffset():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getLeftOffset():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRightOffset():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBottomOffset():Number {
			return 2;
		}
		
		/**
		 * 	@private
		 */
		override public function drawBackFace():void {
			drawOutState();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fontFormat:FontFormat =
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_BUTTON_FONT_COLOR, true);
		private var _selectedFontFormat:FontFormat =
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR, true);
		//private var dashedLine:DashedLine;
		private const _BUTTON_CURVE_HEIGHT:Number = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(buttonColor:uint, lineColor1:uint, lineColor2:int = -1):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var tgt:Sprite = dto.currentTarget;
			var bch:Number = _BUTTON_CURVE_HEIGHT;
			var f:Figure = Figure.setFigure(tgt);
			var middle:Number = h/2;
			var color2:RGB = new RGB(buttonColor);
			f.clear();
			var bw:Number = dto.borderWidth;
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			if (lineColor2 == -1) f.lineStyle(bw, lineColor1, 1, true);
			else {
				f.lineStyle(bw, lineColor1, 1, true);
				f.lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
			}
			var state:String = dto.state;
			var c2:uint = state == ButtonState.SELECTED ? 0xCCCCCC : color2.darker();
			f.beginGradientFill("linear", [c2, buttonColor], [1, 1], [0, 250], m);
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, 6);
			f.drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
			f.endFill();
			with (tgt.graphics) {
				if (state == ButtonState.SELECTED) {
					lineStyle(1, buttonColor, 1, true);
					moveTo(0, h);
					lineTo(w, h);
				} else {
					moveTo(cu.topLeft, 0);
					lineStyle(0, lineColor1, 0);
					beginFill(0xFFFFFF, .2);
					lineTo(w-cu.topRight, 0);
					curveTo(w, 0, w, cu.topRight);
					lineTo(w, middle);
					curveTo(3*w/4, middle+bch, w/2, middle);
					curveTo(w/4, middle-bch, 0, middle);
					lineTo(0, cu.topLeft);
					curveTo(0, 0, cu.topLeft, 0);
				}
				endFill();
			}
		}
	}
}