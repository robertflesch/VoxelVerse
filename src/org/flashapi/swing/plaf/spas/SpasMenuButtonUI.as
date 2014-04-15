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
	// SpasMenuButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 10/11/2010 14:19
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.MenuButtonUI;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.util.AltColors;
	
	/**
	 * 	The <code>SpasMenuButtonUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>MenuButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.button.MenuButton
	 * 	@see org.flashapi.swing.plaf.MenuButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasMenuButtonUI extends SpasIconColorsUI implements MenuButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasMenuButtonUI(dto:LafDTO) {
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
			drawButtonShape();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawOverState():void {
			var c:Object = (dto.colors.over != StateObjectValue.NONE) ?
				new AltColors(dto.colors.over) : {color1:0XFFFFFF, color2:0XFFFFFF};
			drawButtonShape(true, c.color1, c.color2);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawPressedState():void {
			var c:Object = (dto.colors.down != StateObjectValue.NONE) ?
				new AltColors(dto.colors.down) : {color1:0xFFFFFF, color2:0x9AD8FF}; //0xE5F5FF
			drawButtonShape(true, c.color1, c.color2);
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
				new AltColors(dto.colors.disabled) : {color1:0xA9A9A9, color2:0x979797};
			drawButtonShape(true, c.color1, c.color2);
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
		
		/**
		 * 	@private
		 */
		override public function drawBackFace():void {
			drawOutState();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fontFormat:FontFormat =
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(show:Boolean = false, buttonColor1:uint = 0XFFFFFF, buttonColor2:uint = 0XFFFFFF):void {
			var f:Figure = Figure.setFigure(dto.container);
			var w:Number = dto.width;
			var h:Number = dto.height;
			f.clear();
			if (show) {
				f.beginGradientFill(GradientType.LINEAR, [buttonColor1, buttonColor2], [1, 1], [0, 250], MatrixUtil.getMatrix(w, h));
				f.drawRectangle(0, 0, w, h);
			}
			f.endFill();
		}
	}
}