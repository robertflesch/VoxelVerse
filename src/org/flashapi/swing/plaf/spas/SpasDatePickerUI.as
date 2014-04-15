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
	// SpasDatePickerUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 15/01/2009 22:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.icons.LeftIcon;
	import org.flashapi.swing.icons.RightIcon;
	import org.flashapi.swing.plaf.DatePickerUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>SpasDatePickerUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>DatePicker</code> instances.
	 * 
	 * 	@see org.flashapi.swing.DatePicker
	 * 	@see org.flashapi.swing.plaf.DatePickerUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasDatePickerUI extends SpasUI implements DatePickerUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasDatePickerUI(dto:LafDTO) {
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
			var h:Number = TITLE_BAR_HEIGHT;
			with(dto.titleBar.graphics) {
				clear();
				lineStyle(1, 0xFFFFFF, .15, true);
				moveTo(2, h);
				lineTo(dto.width-2, h);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBackground():void {
			var cd:Number = isNaN(dto.cornerRadius) ? CURVE_DELAY : dto.cornerRadius;
			var w:Number = dto.width;
			var h:Number = dto.height;
			var ch:Number = 2;//CURVE_HEIGHT;
			var color1:uint = isNaN(dto.backgroundColor) ? 0xFFFFFF : dto.backgroundColor;
			var color2:RGB = new RGB(color1);
			var bg:Sprite = dto.background;
			var p:Figure = Figure.setFigure(bg);
			var curveMiddle:Number = h/2;
			p.clear();
			p.beginGradientFill(GradientType.LINEAR, [color2.darker(), color1],
				[1, 1], [0, 250], MatrixUtil.getMatrix(w, h));
			p.lineStyle(dto.borderWidth, 0x969696, .5, true);
			p.lineGradientStyle(GradientType.LINEAR, [0x969696, 0x505050], [1, 1],
				[0, 250], MatrixUtil.getMatrix(w, h));
			p.drawRoundedRectangle(0, 0, w, h, cd, cd);
			with(bg.graphics) {
				moveTo(cd, 0);
				lineStyle(0, 0x969696, 0);
				beginFill(0xFFFFFF, .1);
				lineTo(w-cd, 0);
				curveTo(w, 0, w, cd);
				lineTo(w, curveMiddle-ch);
				curveTo(3*w/4, curveMiddle+ch, w/2, curveMiddle);
				curveTo(w/4, curveMiddle-ch, 0, curveMiddle+ch);
				lineTo(0, cd);
				curveTo(0, 0, cd, 0);
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
			drawYearButtonShape(Direction.UP);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPreviousYearOutState():void {
			drawYearButtonShape(Direction.DOWN);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarColor():uint {
			return DEFAULT_COLOR;
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
			return SpasButtonUI;
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
			new TextFormat(DEFAULT_FONT_FACE, 11, 0xFFFFFF, true, null, null, null, null, TextAlign.CENTER);
		private var _weekTextFormat:TextFormat =
			new TextFormat(DEFAULT_FONT_FACE, 12, 0xFFFFFF, true, null, null, null, null, TextAlign.CENTER);
		private var _dayTextFormat:TextFormat =
			new TextFormat(DEFAULT_FONT_FACE, 12, DEFAULT_FONT_COLOR, false, null, null, null, null, TextAlign.CENTER);
		private var _disabledTextFormat:TextFormat =
			new TextFormat(DEFAULT_FONT_FACE, 12, 0XAEAEAE, false, null, null, null, null, TextAlign.CENTER);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(color:uint = 0xFFFFFF, alpha:Number = 0):void {
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			f.beginFill(color, alpha);
			f.drawRectangle(0, 0, DAY_BUTTON_SIZE, DAY_BUTTON_SIZE);
			f.endFill();
		}
		
		private function drawYearButtonShape(direction:String, color:uint =0xFFFFFF, alpha:Number = 1):void {
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			f.beginFill(color, 0);
			f.drawRectangle(0, 0, YEAR_BUTTON_SIZE, YEAR_BUTTON_SIZE);
			f.beginFill(color, alpha);
			switch(direction) {
				case Direction.UP :
					f.drawTriangle(YEAR_BUTTON_SIZE / 2, 2, YEAR_BUTTON_SIZE-2, YEAR_BUTTON_SIZE-1, 2, YEAR_BUTTON_SIZE-1);
					break;
				case Direction.DOWN :
					f.drawTriangle(2, 1, YEAR_BUTTON_SIZE-2, 1, YEAR_BUTTON_SIZE / 2, YEAR_BUTTON_SIZE-2);
					break;
			}
			f.endFill();
		}
	}
}