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
	// SpasComboBoxUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.2.0, 10/11/2010 09:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.icons.UpDownIcon;
	import org.flashapi.swing.plaf.ComboBoxUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>SpasComboBoxUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>ComboBox</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ComboBox
	 * 	@see org.flashapi.swing.plaf.ComboBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasComboBoxUI extends SpasIconColorsUI implements ComboBoxUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasComboBoxUI(dto:LafDTO) {
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
		public function getIcon():Class {
			return UpDownIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonPosition():Point {
			var x:Number = dto.buttonPosition == DropButtonPosition.RIGHT ? dto.width - 22 : 0;
			return new Point(x, 0);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			var c:uint = (dto.colors.up != StateObjectValue.NONE) ? dto.colors.up : dto.color;
			var lineColor1:uint = 0x969696;
			var lineColor2:int = 0x505050;
			//if(dto.fontColors.up != StateObjectValue.NONE) lineColor1 = dto.fontColors.up, lineColor2 = -1;
			drawComboBoxShape(c, lineColor1, lineColor2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var c:uint = (dto.colors.over != StateObjectValue.NONE) ? dto.colors.over : dto.color;
			var lineColor:uint = (dto.fontColors.over!=StateObjectValue.NONE) ? dto.fontColors.over : 0xFFFFFF;
			drawComboBoxShape(c, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:uint = (dto.colors.selected != StateObjectValue.NONE) ?
				dto.colors.selected : new RGB(dto.color).darker();
			var lineColor:uint = (dto.fontColors.selected != StateObjectValue.NONE) ?
				dto.fontColors.selected : 0x505050;
			drawComboBoxShape(c, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getListLaf():Class {
			return SpasListBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public  function getTextInputLaf():Class {
			return SpasTextInputUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextFormat():UITextFormat {
			return _textFormat;
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
		public function getButtonDelay():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextPadding():Number {
			return 4;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/*private var _buttonLength:Number = 18;
		private var _defaultHeight:Number = 24;*/
		private var _textFormat:UITextFormat =
			new UITextFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_BUTTON_FONT_COLOR, true);
		private const BUTTON_CURVE_HEIGHT:Number = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawComboBoxShape(comboboxColor:uint, lineColor1:uint, lineColor2:int = -1):void {
			var tgt:Sprite = dto.currentTarget;
			var w:Number = dto.width;
			var h:Number = dto.height;
			var bch:Number = BUTTON_CURVE_HEIGHT;
			var f:Figure = Figure.setFigure(tgt);
			var middle:Number = h/2;
			var color2:RGB = new RGB(comboboxColor);
			f.clear();
			var m:Matrix = new Matrix();
			m.createGradientBox(w, h, Math.PI/2, 0, 0);
			if (lineColor2 == -1) f.lineStyle(1, lineColor1, 1, true);
			else {
				f.lineStyle(1, lineColor1, .5, true);
				f.lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
			}
			f.beginGradientFill(GradientType.LINEAR, [color2.darker(), comboboxColor], [1, 1], [0, 250], m);
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, 6);
			f.drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
			f.endFill();
			with(tgt.graphics) {
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
				endFill();
			}
		}
	}
}