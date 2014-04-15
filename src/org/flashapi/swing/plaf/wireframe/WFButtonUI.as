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
	// WFButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2010 15:17
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.ButtonUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>WFButtonUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>Button</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 	@see org.flashapi.swing.plaf.ButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFButtonUI extends WFIconColorsUI implements ButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFButtonUI(dto:LafDTO) {
			super(dto);
			_fontFormat.letterSpacing = DEFAULT_LETTER_SPACING;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			drawButtonShape(DEFAULT_BACKGROUND_COLOR);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			drawButtonShape(0xcccccc);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			drawButtonShape(0x666666);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			drawButtonShape(0xcccccc);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			drawButtonShape(getGrayTintColor());
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
			/*if(dashedLine==null) dashedLine = new DashedLine(1, 2);
			dashedLine.lineStyle(0, 0x777777, 1, true);
			dashedLine.drawRectangle(new Point(2, 2), new Point(dto.width-2, dto.height-2));
			dashedLine.endFill();*/
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
		public function getBorderColor():uint {
			return DEFAULT_BORDER_COLOR;
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
			return _disabledFontFormat;
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
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_BUTTON_FONT_COLOR, true);
		private var _disabledFontFormat:FontFormat =
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, getGrayTintColor(), true);
		
		//private var dashedLine:DashedLine;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(buttonColor:uint):void {
			with (Figure.setFigure(dto.currentTarget)) {
				clear();
				lineStyle(dto.borderWidth, DEFAULT_BORDER_COLOR);
				beginFill(buttonColor);
				drawRectangle(0, 0, dto.width, dto.height);
				endFill();
			}
		}
	}	
}