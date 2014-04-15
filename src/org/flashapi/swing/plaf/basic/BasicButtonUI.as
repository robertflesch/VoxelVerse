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
	// BasicButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 04/02/2010 18:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.ButtonUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.util.AltColors;
	
	/**
	 * 	The <code>BasicButtonUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Button</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 	@see org.flashapi.swing.plaf.ButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicButtonUI extends BasicIconColorsUI implements ButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicButtonUI(dto:LafDTO) {
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
			return 0XEAEAEA;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0xB6B9BB;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			var c:Object = (dto.colors.up != StateObjectValue.NONE) ?
				new AltColors(dto.colors.up, .7, .8) : { color3:0XEAEAEA, color4:0xABABAB  };
			dto.borderColors.up != StateObjectValue.NONE ?
				c.color1 = c.color2 = dto.borderColors.up : (c.color1 = 0xB6B9BB, c.color2 = 0x5F6162);
			drawButtonShape(ButtonState.UP, c.color1, c.color2, c.color3, c.color4);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawOverState():void {
			var c:Object = (dto.colors.over != StateObjectValue.NONE)
				? new AltColors(dto.colors.over, .7, .8) : {color3:0XEAEAEA, color4:0xABABAB};
			dto.borderColors.over != StateObjectValue.NONE ?
				c.color1 = c.color2 = dto.borderColors.over : (c.color1 = 0x009DFF, c.color2 = 0x0077C1);
			drawButtonShape(ButtonState.OVER, c.color1, c.color2, c.color3, c.color4);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:Object = (dto.colors.down != StateObjectValue.NONE) ?
				new AltColors(dto.colors.down, .7, .8) : {color3:0xE5F5FF, color4:0x9AD8FF};
			dto.borderColors.down != StateObjectValue.NONE ?
				c.color1 = c.color2 = dto.borderColors.down : (c.color1 = 0x009DFF, c.color2 = 0x0077C1);
			drawButtonShape(ButtonState.DOWN, c.color1, c.color2, c.color3, c.color4);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			drawPressedState();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var c:Object = (dto.colors.disabled != StateObjectValue.NONE) ?
				new AltColors(dto.colors.disabled, .7, .8) : { color3:0xA9A9A9, color4:0x979797 };
			dto.borderColors.disabled != StateObjectValue.NONE ?
				c.color1 = c.color2 = dto.borderColors.disabled : (c.color1 = 0x9C9D9D, c.color2 = 0x808080);
			drawButtonShape(ButtonState.DISABLED, c.color1, c.color2, c.color3, c.color4);
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
			var dl:DashedLine = new DashedLine(dto.currentTarget, 1, 2);
			dl.lineStyle(0, 0x777777, 1, true);
			dl.drawRectangle(new Point(2, 2), new Point(dto.width-2, dto.height-2));
			dl.endFill();
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
			return _fontFormat;
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
			return _fontFormat;
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
		
		//public function getInactiveItemColor():uint { return  0x777777; }
		
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
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fontFormat:FontFormat = new FontFormat(WebFonts.VERDANA, 12, 0x0B333C, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(state:String, lineColor1:uint, lineColor2:uint, buttonColor1:uint, buttonColor2:uint):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var bw:Number = dto.borderWidth;
			var manager:TextureManager = dto.textureManager;
			var bga:Number = dto.backgroundAlpha;
			var bdra:Number = dto.borderAlpha;
			/*if (w == 0 || h == 0) {
				manager.clear();
				return;
			}*/
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, 4);
			if(manager.texture == null) {
				manager.clear();
				var f:Figure = Figure.setFigure(dto.currentTarget);
				f.lineStyle(bw, lineColor1, bdra, true);
				f.lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [bdra, bdra], [0, 250], m);
				f.beginGradientFill(GradientType.LINEAR, [buttonColor1, buttonColor2], [bga, bga], [0, 250], m);
				f.drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
				f.endFill();
			} else {
				var ct:ColorTransform;
				switch(state) {
					case ButtonState.UP :
					break;
					case ButtonState.OVER :
						ct = new ColorTransform();
						ct.redOffset = ct.blueOffset = ct.greenOffset = 50;
						break;
					case ButtonState.DOWN :
					case ButtonState.SELECTED:
						ct = new ColorTransform()
						ct.redOffset = ct.blueOffset = ct.greenOffset = -50;
						break;
				}
				manager.colorTransform = ct;
				manager.setShape = function():void {
					with(manager.figure) {
						lineStyle(bw, lineColor1, bdra, true);
						lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [bdra, bdra], [0, 250], m);
						drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
						endFill();
					}
				}
				manager.draw(TextureType.TEXTURE);
			}
		}
	}
}