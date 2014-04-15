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
	// WFWindowUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/03/2010 22:54
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.constants.WindowState;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.icons.CloseIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.WindowUI;
	import org.flashapi.swing.plaf.wireframe.brushes.WFMaximizeIcon;
	import org.flashapi.swing.plaf.wireframe.brushes.WFMinimizeIcon;
	import org.flashapi.swing.plaf.wireframe.brushes.WFRestoreIcon;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.wtk.WTKButton;
	
	/**
	 * 	The <code>WFWindowUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>Window</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Window
	 * 	@see org.flashapi.swing.plaf.WindowUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFWindowUI extends WFUI implements WindowUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFWindowUI(dto:LafDTO) {
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
		public function drawWindow():void {
			drawWindowShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawWindowArea():void {
			var r:Rectangle = dto.windowBounds;
			var w:Number = r.width - 1.5;
			var f:Figure = Figure.setFigure(dto.windowArea);
			f.clear();
			f.lineStyle(3, DEFAULT_BORDER_COLOR);
			(dto.state == WindowState.MINIMIZED) ?
				f.drawRectangle(r.x, r.y, w, TITLEBAR_HEIGHT - 1.5) :
				f.drawRectangle(r.x, r.y, w, r.height - 1.5);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawMinimizedWindow():void {
			with (dto.chrome.graphics) {
				clear();
				beginFill(DEFAULT_BACKGROUND_COLOR);
				lineStyle(1, DEFAULT_BORDER_COLOR);
				drawRect(0, 0, dto.outerWidth, TITLEBAR_HEIGHT);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInnerPanel():void {
			with(Figure.setFigure(dto.innerPanelContainer)) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR);
				beginFill(DEFAULT_BACKGROUND_COLOR);
				drawRectangle(0, 0, dto.width, dto.height);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTitleBar():void {
			dto.titleBar.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function setTextEffect():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function setCloseButtonPosition():void {
			var cls:WTKButton = dto.closeButton;
			cls.x = dto.outerWidth - BTN_SIZE-10;
			cls.y = 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function setButtonsPosition():void {
			var cls:WTKButton = dto.closeButton;
			var max:WTKButton = dto.maximizeButton;
			var min:WTKButton = dto.minimizeButton;
			max.x = cls.x - cls.width - 2;
			min.x = max.x - max.width - 2;
			max.y =	min.y = 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawHeaderTray():void {}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawFooterTray():void {}
		
		/**
		 * 	@private
		 */
		override public function drawBackFace():void {
			drawWindowShape();
		}
		
		/**
		 * 	@private
		 */
		override public function onChange():void {
			var bs:Array = [];
			bs.pop();
			dto.innerPanelContainer.filters = bs;
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
		public function getBackgroundColor():uint {
			return DEFAULT_BACKGROUND_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderAlpha():Number {
			return 1;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarHeight():Number {
			return TITLEBAR_HEIGHT;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonSize():Number {
			return BTN_SIZE;
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
		public function getScrollBarLaf():Class {
			return WFScrollableAreaUI;
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
		public function getIconDelay():Number {
			return 4;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTopOffset():Number {
			return 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getLeftOffset():Number {
			return 10;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRightOffset():Number {
			return 10;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBottomOffset():Number {
			return 12;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarTopOffset():Number {
			return 4;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTitleBarLeftOffset():Number {
			return 10;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getInnerPanelOffset():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getCloseButtonBrush():Class {
			return CloseIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMinimizeButtonBrush():Class {
			return WFMinimizeIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMaximizeButtonBrush():Class {
			return WFMaximizeIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRestoreButtonBrush():Class {
			return WFRestoreIcon;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const TITLEBAR_HEIGHT:uint = 28;
		private const BTN_SIZE:Number = 18;
		private var _textFormat:UITextFormat =
			new UITextFormat(WebFonts.VERDANA, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawWindowShape():void {
			with (dto.chrome.graphics) {
				clear();
				beginFill(DEFAULT_COLOR);
				lineStyle(1, DEFAULT_BORDER_COLOR);
				drawRect(0, 0, dto.outerWidth, dto.outerHeight);
				endFill();
			}
		}
	}
}