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
	// BasicWindowUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 28/06/2009 14:37
	* @see http://www.flashapi.org/
	*/

	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.constants.WindowState;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.icons.CloseIcon;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.basic.brushes.BasicMaximizeIcon;
	import org.flashapi.swing.plaf.basic.brushes.BasicMinimizeIcon;
	import org.flashapi.swing.plaf.basic.brushes.BasicRestoreIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.WindowUI;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.wtk.WindowButton;
	
	/**
	 * 	The <code>BasicWindowUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>AWM</code> instances.
	 * 
	 * 	@see org.flashapi.swing.wtk.AWM
	 * 	@see org.flashapi.swing.plaf.WindowUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicWindowUI extends BasicUI implements WindowUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicWindowUI(dto:LafDTO) {
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
			drawWindowShape(false);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawWindowArea():void {
			var r:Rectangle = dto.windowBounds;
			var f:Figure = Figure.setFigure(dto.windowArea);
			f.clear();
			f.lineStyle(3, 0x888888);
			(dto.state == WindowState.MINIMIZED) ? 
				f.drawRectangle(r.x, r.y, r.width - 1.5, TITLEBAR_HEIGHT - 1.5) :
				f.drawRectangle(r.x, r.y, r.width - 1.5, r.height - 1.5);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawMinimizedWindow():void {
			drawWindowShape(true);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInnerPanel():void {
			var pc:Sprite = dto.innerPanelContainer;
			var c:uint = isNaN(dto.innerPanelColor) ? 0xFFFFFF : dto.innerPanelColor;
			var f:Figure = Figure.setFigure(pc);
			f.clear();
			f.beginFill(c, dto.innerPanelOpacity);
			f.drawRectangle(0, 0, dto.width, dto.height);
			f.endFill();
			var bs:Array = [];
			if((dto.shadow || dto.glow) && !dto.isFooterDisplayed()) bs.push(_backgroundShadow);
			pc.filters = bs;
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
			var cls:WindowButton = dto.closeButton;
			cls.x = dto.outerWidth-BUTTON_SIZE-10;
			cls.y = 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function setButtonsPosition():void {
			var cls:WindowButton = dto.closeButton;
			var max:WindowButton = dto.maximizeButton;
			var min:WindowButton = dto.minimizeButton;
			max.x = cls.x-cls.width-2;
			min.x = max.x-max.width-2;
			max.y =	min.y = 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawHeaderTray():void {
			var h:Number = dto.headerTrayHeight;
			var w:Number = dto.trayWidth;
			var m:Matrix = MatrixUtil.getMatrix(w, 20, Math.PI / 2, 0, h - 20);
			var c:uint = dto.color;
			var rgb:RGB = new RGB(c);
			//var bdrColor:uint = isNaN(dto.borderColor) ? 0xFFFFFF : dto.borderColor;
			var f:Figure = Figure.setFigure(dto.headerTray);
			f.clear();
			f.lineStyle(1, rgb.darker(), .3);
			f.beginGradientFill(GradientType.LINEAR, [c, rgb.darker()], [1, .8], [200, 250], m);
			f.drawRectangle(0, 0, w, h);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawFooterTray():void {
			var f:Figure = Figure.setFigure(dto.footerTray);
			f.clear();
			f.beginFill(dto.color);
			f.drawRectangle(0, 0, dto.trayWidth, dto.footerTrayHeight);
			f.endFill();
		}
		
		/**
		 * 	@private
		 */
		override public function onChange():void {
			dto.innerPanelContainer.filters = [];
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_PANEL_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBackgroundColor():uint {
			return DEFAULT_PANEL_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0x999999;
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
			return BUTTON_SIZE;
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
		public function getScrollBarLaf():Class {
			return BasicScrollableAreaUI;
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
			return BasicMinimizeIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMaximizeButtonBrush():Class {
			return BasicMaximizeIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRestoreButtonBrush():Class {
			return BasicRestoreIcon;
		}
		
		//public const ICON_MENU_LAF:Class = BasicPanelUI;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const CURVE_DELAY:Number = 7;
		private var _backgroundShadow:DropShadowFilter = new DropShadowFilter(2.5, 80, 0, .3, 4, 5);
		private const TITLEBAR_HEIGHT:uint = 28;
		private const BUTTON_SIZE:Number = 18;
		private var _textFormat:UITextFormat = new UITextFormat(WebFonts.VERDANA, 12, 0x333333, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawWindowShape(minimized:Boolean):void {
			var cd:Number = isNaN(dto.cornerRadius) ? CURVE_DELAY : dto.cornerRadius;
			var w:Number = dto.outerWidth;
			var h:Number = minimized ? TITLEBAR_HEIGHT : dto.outerHeight;
			isNaN(dto.color) ? dto.color = DEFAULT_PANEL_COLOR : NaN;
			var bdrAlpha:uint = isNaN(dto.borderAlpha) ? .5 : dto.borderAlpha;
			var bdrColor:uint = isNaN(dto.borderColor) ? 0xFFFFFF : dto.borderColor;
			if (dto.state == WindowState.MAXIMIZED) cd = 0;
			var manager:TextureManager = dto.textureManager;
			manager.setShape = function():void {
				with(manager.figure) {
					lineStyle(1, bdrColor, bdrAlpha, true);
					drawRoundedBox(0, 0, w, h, cd, cd, 0, 0);
					endFill();
				}
			}
			if(manager.texture == null) {
				manager.color = dto.color;
				manager.alpha = dto.windowOpacity;
				manager.draw();
			} else manager.draw(TextureType.PLAIN);
		}
	}
}