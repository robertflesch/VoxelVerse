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
	// SpasWindowUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.2.1, 31/03/2011 18:38
	* @see http://www.flashapi.org/
	*/

	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.constants.WindowState;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.icons.CloseIcon;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.plaf.spas.brushes.SpasMaximizeIcon;
	import org.flashapi.swing.plaf.spas.brushes.SpasMinimizeIcon;
	import org.flashapi.swing.plaf.spas.brushes.SpasRestoreIcon;
	import org.flashapi.swing.plaf.WindowUI;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.wtk.WTKButton;
	
	/**
	 * 	The <code>SpasWindowUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>Window</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Window
	 * 	@see org.flashapi.swing.plaf.WindowUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasWindowUI extends SpasUI implements WindowUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasWindowUI(dto:LafDTO) {
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
			f.lineStyle(3, 0x888888);
			(dto.state == WindowState.MINIMIZED) ?
				f.drawRectangle(r.x, r.y, w, TITLEBAR_HEIGHT - 1.5) :
				f.drawRectangle(r.x, r.y, w, r.height - 1.5);
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
			var cls:WTKButton = dto.closeButton;
			cls.x = dto.outerWidth-BUTTON_SIZE-10;
			cls.y = 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function setButtonsPosition():void {
			var cls:WTKButton = dto.closeButton;
			var max:WTKButton = dto.maximizeButton;
			var min:WTKButton = dto.minimizeButton;
			max.x = cls.x-cls.width-2;
			min.x = max.x-max.width-2;
			max.y =	min.y = 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawHeaderTray():void {
			var tw:Number = dto.trayWidth;
			var th:Number = dto.getHeaderTrayHeight();
			var m:Matrix = MatrixUtil.getMatrix(tw, th);
			var c:uint = dto.headerColor;
			var rgb:RGB = new RGB(c);
			//var bdrColor:uint = isNaN(dto.borderColor) ? 0xFFFFFF : dto.borderColor;
			var f:Figure = Figure.setFigure(dto.headerTray);
			f.clear();
			f.lineStyle(1, rgb.darker(), .3);
			f.beginGradientFill(GradientType.LINEAR, [c, rgb.darker()], [1, .8], [200, 250], m);
			f.drawRectangle(0, 0, tw, th);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawFooterTray():void {
			var f:Figure = Figure.setFigure(dto.footerTray);
			f.clear();
			f.beginFill(dto.footerColor, dto.footerOpacity);
			f.drawRectangle(0, 0, dto.trayWidth, dto.getFooterTrayHeight());
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
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBackgroundColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return DEFAULT_BORDER_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderAlpha():Number {
			return .25;
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
			return SpasButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getScrollBarLaf():Class {
			return SpasScrollableAreaUI;
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
			return SpasMinimizeIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMaximizeButtonBrush():Class {
			return SpasMaximizeIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRestoreButtonBrush():Class {
			return SpasRestoreIcon;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const CURVE_DELAY:Number = 10;
		private const CURVE_HEIGHT:Number = 2;
		private var _backgroundShadow:DropShadowFilter = new DropShadowFilter(2.5, 80, 0, .3, 4, 5);
		private const TITLEBAR_HEIGHT:uint = 28;
		private const BUTTON_SIZE:Number = 18;
		private var _textFormat:UITextFormat = new UITextFormat(DEFAULT_FONT_FACE, 12, 0xFFFFFF, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawWindowShape(minimized:Boolean = false):void {
			var tgt:Sprite = dto.chrome;
			var manager:TextureManager = dto.textureManager;
			var cd:Number = isNaN(dto.cornerRadius) ? CURVE_DELAY : dto.cornerRadius;
			var w:Number = dto.outerWidth;
			var h:Number = minimized ? TITLEBAR_HEIGHT : dto.outerHeight;
			var a:Number = dto.windowOpacity;
			var curveMiddle:Number = TITLEBAR_HEIGHT / 2;
			var isMaximized:Boolean = (dto.state == WindowState.MAXIMIZED);
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, cd);
			if (manager.texture != null) {
				manager.setShape = function():void {
					with (manager.figure) {
						lineStyle(1, 0xFFFFFF, .5, true);
						isMaximized ?
							drawRoundedBox(0, 0, w, h, 0, 0, 0, 0) :
							drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
						drawSpasEffect(tgt, w, cu, curveMiddle);
					}
				}
				manager.draw(TextureType.TEXTURE);
			} else {
				var color2:RGB = new RGB(dto.color);
				var f:Figure = Figure.setFigure(tgt);
				var m:Matrix = MatrixUtil.getMatrix(w, h);
				f.clear();
				f.beginGradientFill(GradientType.LINEAR, [color2.darker(), dto.color], [a, a], [0, 250], m);
				f.lineStyle(1, 0x969696, .5, true);
				f.lineGradientStyle(GradientType.LINEAR, [0x969696, 0x505050], [1, 1], [0, 250], m);
				isMaximized ?
					f.drawRoundedBox(0, 0, w, h, 0, 0, 0, 0) :
					f.drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
				drawSpasEffect(tgt, w, cu, curveMiddle);
			}
		}
		
		private function drawSpasEffect(target:Sprite, w:Number, cu:LafDTOCornerUtil, curveMiddle:Number):void {
			with(target.graphics) {
				moveTo(cu.topLeft, 0);
				lineStyle(0, 0x969696, 0);
				beginFill(0xFFFFFF, .2);
				lineTo(w-cu.topRight, 0);
				curveTo(w, 0, w, cu.topRight);
				lineTo(w, curveMiddle-CURVE_HEIGHT);
				curveTo(3*w/4, curveMiddle+CURVE_HEIGHT, w/2, curveMiddle);
				curveTo(w/4, curveMiddle-CURVE_HEIGHT, 0, curveMiddle+CURVE_HEIGHT);
				lineTo(0, cu.topLeft);
				curveTo(0, 0, cu.topLeft, 0);
				endFill();
			}
		}
	}
}