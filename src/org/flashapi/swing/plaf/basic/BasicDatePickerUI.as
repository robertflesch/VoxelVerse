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
	// BasicDatePickerUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 20/01/2009 15:21
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.icons.LeftIcon;
	import org.flashapi.swing.icons.RightIcon;
	import org.flashapi.swing.plaf.DatePickerUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicDatePickerUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>DatePicker</code> instances.
	 * 
	 * 	@see org.flashapi.swing.DatePicker
	 * 	@see org.flashapi.swing.plaf.DatePickerUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicDatePickerUI extends BasicUI implements DatePickerUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicDatePickerUI(dto:LafDTO) {
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
		public function drawTitleBar():void {
			var w:Number = dto.width;
			var h:Number = TITLE_BAR_HEIGHT;
			var color1:uint = isNaN(dto.color) ? 0xE1E5EB : dto.color;
			var color2:uint = isNaN(dto.backgroundColor) ? 0xFFFFFF : dto.backgroundColor;
			var cd:Number = isNaN(dto.cornerRadius) ? CURVE_DELAY : dto.cornerRadius;
			var a:Number = dto.backgroundAlpha;
			var m:Matrix = MatrixUtil.getMatrix(w, h * 1.5);
			with(dto.titleBar.graphics) {
				clear();
				lineStyle(1, 0xB7BABC, 1, true);
				beginGradientFill(GradientType.LINEAR, [color1, color2], [a, a], [0, 250], m, SpreadMethod.PAD);
				moveTo(cd, 0);
				lineTo(w-cd, 0);
				curveTo(w, 0, w, cd);
				lineTo(w, h);
				lineTo(0, h);
				lineTo(0, cd);
				curveTo(0, 0, cd, 0);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBackground():void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var cd:Number = isNaN(dto.cornerRadius) ? CURVE_DELAY : dto.cornerRadius;
			var color:uint = isNaN(dto.backgroundColor) ? 0xFFFFFF : dto.backgroundColor;
			with(dto.background.graphics) {
				clear();
				beginFill(color, dto.backgroundAlpha);
				moveTo(0, TITLE_BAR_HEIGHT);
				lineTo(w, TITLE_BAR_HEIGHT);
				lineStyle(1, 0xB7BABC, 1, true);
				lineTo(w, h-cd);
				curveTo(w, h, w-cd, h);
				lineTo(cd, h);
				curveTo(0, h, 0, h-cd);
				lineTo(0, TITLE_BAR_HEIGHT);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			drawButtonShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			drawButtonShape(0xB2E1FF, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			drawButtonShape(0x7FCEFF, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			drawOutState();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTodayOutState():void {
			drawButtonShape(0x818181, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTodayOverState():void {
			drawButtonShape(0x95A8B4, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTodaySelectedState():void {
			drawButtonShape(0x95A8B4, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawNextYearOutState():void {
			drawYearButtonShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPreviousYearOutState():void {
			drawYearButtonShape("down");
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarColor():uint {
			return 0xE1E5EB;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarHeight():Number {
			return TITLE_BAR_HEIGHT;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRowPadding():Number {
			return 4;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getLinePadding():Number {
			return 4;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarPadding():Number {
			return 6;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonLaf():Class {
			return BasicButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getNextButtonBrush():Class {
			return RightIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPreviousButtonBrush():Class {
			return LeftIcon;
		}
		
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonSize():Number {
			return 20;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDayButtonSize():Number {
			return DAY_BUTTON_SIZE;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getYearButtonSize():Number {
			return YEAR_BUTTON_SIZE;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleTextFormat():TextFormat {
			return _titleTextFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getWeekTextFormat():TextFormat {
			return _weekTextFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDayTextFormat():TextFormat {
			return _dayTextFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDisabledDayTextFormat():TextFormat {
			return _disabledTextFormat;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const TITLE_BAR_HEIGHT:Number = 32;
		private static const CURVE_DELAY:Number = 6;
		private static const DAY_BUTTON_SIZE:Number = 18;
		private static const YEAR_BUTTON_SIZE:Number = 9;
		private var _titleTextFormat:TextFormat = 
			new TextFormat(WebFonts.VERDANA, 11, 0x000000, true, null, null, null, null, TextAlign.CENTER);
		private var _weekTextFormat:TextFormat =
			new TextFormat(WebFonts.VERDANA, 12, 0x000000, true, null, null, null, null, TextAlign.CENTER);
		private var _dayTextFormat:TextFormat =
			new TextFormat(WebFonts.VERDANA, 12, 0x666666, false, null, null, null, null, TextAlign.CENTER);
		private var _disabledTextFormat:TextFormat =
			new TextFormat(WebFonts.VERDANA, 12, 0XAEAEAE, false, null, null, null, null, TextAlign.CENTER);
			
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(color:uint =0xFFFFFF, alpha:Number = 0):void {
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			f.beginFill(color, alpha);
			f.drawRectangle(0, 0, DAY_BUTTON_SIZE, DAY_BUTTON_SIZE);
			f.endFill();
		}
		
		private function drawYearButtonShape(direction:String = "up", color:uint =0x000000, alpha:Number = 1):void {
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			f.beginFill(color, 0);
			f.drawRectangle(0, 0, YEAR_BUTTON_SIZE, YEAR_BUTTON_SIZE);
			f.beginFill(color, alpha);
			switch(direction) {
				case "up" :
					f.drawTriangle(YEAR_BUTTON_SIZE / 2, 2, YEAR_BUTTON_SIZE-2, YEAR_BUTTON_SIZE-1, 2, YEAR_BUTTON_SIZE-1);
					break;
				case "down" :
					f.drawTriangle(2, 1, YEAR_BUTTON_SIZE-2, 1, YEAR_BUTTON_SIZE / 2, YEAR_BUTTON_SIZE-2);
					break;
			}
			f.endFill();
		}
	}
}