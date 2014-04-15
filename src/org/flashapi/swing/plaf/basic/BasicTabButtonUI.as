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
	* @version 1.0.1, 27/12/2008 21:26
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.plaf.TabButtonUI;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.util.AltColors;
	
	/**
	 * 	The <code>BasicTabButtonUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>TabButtonUI</code> instances.
	 * 
	 * 	@see org.flashapi.swing.button.TabButton
	 * 	@see org.flashapi.swing.plaf.TabButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicTabButtonUI extends BasicIconColorsUI implements TabButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicTabButtonUI(dto:LafDTO) {
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
				new AltColors(dto.colors.up, .7, .8) :
				{color1:0xB6B9BB, color2:0x5F6162, color3:0XEAEAEA, color4:0xABABAB };
			drawButtonShape(c.color1, c.color2, c.color3, c.color4, States.OUT);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var c:Object = (dto.colors.over != StateObjectValue.NONE) ?
				new AltColors(dto.colors.over, .7, .8) :
				{color1:0x009DFF, color2:0x0077C1, color3:0XEAEAEA, color4:0xABABAB };
			drawButtonShape(c.color1, c.color2, c.color3, c.color4, States.OVER);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:Object = (dto.colors.down != StateObjectValue.NONE) ?
				new AltColors(dto.colors.down, .7, .8) :
				{color1:0x009DFF, color2:0x0077C1, color3:0xFFFFFF, color4:0xFFFFFF };
			drawButtonShape(c.color1, c.color2, c.color3, c.color4, States.SELECTED);
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
				new AltColors(dto.colors.disabled, .7, .8) :
				{color1:0x9C9D9D, color2:0x808080, color3:0xA9A9A9, color4:0x979797 };
			drawButtonShape(c.color1, c.color2, c.color3, c.color4, States.INACTIVE);
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
		
		private function drawButtonShape(lineColor1:uint, lineColor2:uint, buttonColor1:uint, buttonColor2:uint, state:String):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			var tgt:Sprite = dto.container;
			var f:Figure = Figure.setFigure(tgt);
			f.clear();
			f.lineStyle(1, lineColor1, 1, true);
			f.lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
			f.beginGradientFill(GradientType.LINEAR, [buttonColor1, buttonColor2], [1, 1], [0, 250], m);
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, 4);
			f.drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
			if (state == States.SELECTED) {
				with(tgt.graphics) {
					lineStyle(1, buttonColor2, 1, true);
					moveTo(0, h);
					lineTo(w, h);
				}
			}
			f.endFill();
		}
	}
}