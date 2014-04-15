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

package org.flashapi.swing.plaf.basic {
	
	// -----------------------------------------------------------
	// BasicComboBoxUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 24/09/2009 15:42
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.icons.UpDownIcon;
	import org.flashapi.swing.plaf.ComboBoxUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.util.AltColors;
	
	/**
	 * 	The <code>BasicComboBoxUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>ComboBox</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ComboBox
	 * 	@see org.flashapi.swing.plaf.ComboBoxUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicComboBoxUI extends BasicIconColorsUI implements ComboBoxUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicComboBoxUI(dto:LafDTO) {
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
			var x:Number = dto.buttonPosition == DropButtonPosition.RIGHT ? dto.width - 24 : 8;
			return new Point(x, 2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			var c:Object = (dto.colors.up != StateObjectValue.NONE) ?
				new AltColors(dto.colors.up, .7, .8) :
				{color1:0xB6B9BB, color2:0x5F6162, color3:0XEAEAEA, color4:0xABABAB};
			drawComboBoxShape(c.color1, c.color2, c.color3, c.color4);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var c:Object = (dto.colors.over != StateObjectValue.NONE) ?
				new AltColors(dto.colors.over, .7, .8) :
				{color1:0x009DFF, color2:0x0077C1, color3:0XEAEAEA, color4:0xABABAB};
			drawComboBoxShape(c.color1, c.color2, c.color3, c.color4);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:Object = (dto.colors.down != StateObjectValue.NONE) ?
				new AltColors(dto.colors.down, .7, .8) :
				{color1:0x009DFF, color2:0x0077C1, color3:0xE5F5FF, color4:0x9AD8FF};
			drawComboBoxShape(c.color1, c.color2, c.color3, c.color4);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getListLaf():Class {
			return BasicListBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public  function getTextInputLaf():Class {
			return BasicTextInputUI;
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
		
		private var _buttonLength:Number = 18;
		private var _textFormat:UITextFormat = new UITextFormat(WebFonts.VERDANA, 12, 0x0B333C, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawComboBoxShape(lineColor1:uint, lineColor2:uint, buttonColor1:uint, buttonColor2:uint):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			var cd:Number = isNaN(dto.cornerRadius) ? 6 : dto.cornerRadius;
			var tgt:Sprite = dto.container;
			var f:Figure = Figure.setFigure(tgt);
			f.clear();
			f.lineStyle(1, lineColor1, 1, true);
			f.lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
			f.beginGradientFill(GradientType.LINEAR, [buttonColor1, buttonColor2], [1, 1], [0, 250], m);
			f.drawRoundedRectangle(0, 0, w, h, cd, cd);
			f.endFill();
			var x:Number = dto.buttonPosition == DropButtonPosition.RIGHT ? w-30 : 30;
			with(tgt.graphics){
				lineStyle(1, lineColor1, 1);
				moveTo(x, 5);
				lineTo(x, 19);
				lineStyle(1, 0xFFFFFF, .6);
				moveTo(x+1, 5);
				lineTo(x+1, 19);
				endFill();
			}
		}
	}
}