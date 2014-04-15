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

package org.flashapi.swing.plaf.wireframe {
	
	// -----------------------------------------------------------
	// WFDatePickerUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 00:37
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFormat;
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.icons.LeftIcon;
	import org.flashapi.swing.icons.RightIcon;
	import org.flashapi.swing.plaf.DatePickerUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>WFDatePickerUI</code> class is the SPAS 3.0 wireframe-like  look and feel
	 * 	for <code>DatePicker</code> instances.
	 * 
	 * 	@see org.flashapi.swing.DatePicker
	 * 	@see org.flashapi.swing.plaf.DatePickerUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFDatePickerUI extends WFUI implements DatePickerUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFDatePickerUI(dto:LafDTO) {
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
				lineStyle(1, DEFAULT_BORDER_COLOR, .15, true);
				moveTo(2, h);
				lineTo(dto.width-2, h);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBackground():void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			with(dto.background.graphics) {
				clear();
				beginFill(DEFAULT_BACKGROUND_COLOR);
				lineStyle(1, DEFAULT_BORDER_COLOR, 1, true);
				drawRect(0, 0, w, h);
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
			drawButtonShape(0xEAEAEA, 1);
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
			return DEFAULT_BACKGROUND_COLOR;
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
			return WFButtonUI;
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
			new TextFormat(DEFAULT_FONT_FACE, 11, DEFAULT_FONT_COLOR, true, null, null, null, null, TextAlign.CENTER);
		private var _weekTextFormat:TextFormat =
			new TextFormat(DEFAULT_FONT_FACE, 12, DEFAULT_FONT_COLOR, true, null, null, null, null, TextAlign.CENTER);
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
			with(dto.currentTarget.graphics) {
				clear();
				beginFill(color, alpha);
				drawRect(0, 0, DAY_BUTTON_SIZE, DAY_BUTTON_SIZE);
				endFill();
			}
		}
		
		private function drawYearButtonShape(direction:String):void {
			with(Figure.setFigure(dto.currentTarget)) {
				clear();
				beginFill(0xffffff, 0);
				drawRectangle(0, 0, YEAR_BUTTON_SIZE, YEAR_BUTTON_SIZE);
				beginFill(0);
				switch(direction) {
					case Direction.UP :
						drawTriangle(YEAR_BUTTON_SIZE / 2, 2, YEAR_BUTTON_SIZE-2, YEAR_BUTTON_SIZE-1, 2, YEAR_BUTTON_SIZE-1);
						break;
					case Direction.DOWN :
						drawTriangle(2, 1, YEAR_BUTTON_SIZE-2, 1, YEAR_BUTTON_SIZE / 2, YEAR_BUTTON_SIZE-2);
						break;
				}
				endFill();
			}
		}
	}
}