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
	// WFSelectableItemUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 13:27
	* @see http://www.flashapi.org/
	*/

	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SelectableItemUI;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>WFSelectableItemUI</code> class is the SPAS 3.0 wireframe-like default look and feel
	 * 	for <code>SelectableItem</code> instances.
	 * 
	 * 	@see org.flashapi.swing.button.SelectableItem
	 * 	@see org.flashapi.swing.plaf.SelectableItemUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFSelectableItemUI extends WFRadioIconColorsUI implements SelectableItemUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFSelectableItemUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_BACKGROUND_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return null;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			if(dto.colors.up==StateObjectValue.NONE) dto.container.graphics.clear()
			else {
				var c:uint = ColorUtil.getColor(dto.colors.up);
				drawItemShape(c);
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var c:uint = dto.colors.over == StateObjectValue.NONE ?
				DEFAULT_COLOR : ColorUtil.getColor(dto.colors.over);
			drawItemShape(c);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:uint = dto.colors.down == StateObjectValue.NONE ?
				_pressedColor : ColorUtil.getColor(dto.colors.down);
			drawItemShape(c);
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
			dto.container.graphics.clear();
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
			/*_dashedLine = new DashedLine(dto.container, 1, 2);
			var c:uint = (isPressed || isSelected) ? 0xFFFFFF : 0x777777;
			_dashedLine.lineStyle(0, c, 1, true);
			_dashedLine.drawRectangle(new Point(2, 1), new Point(dto.width-2, dto.height-2));
			_dashedLine.endFill();*/
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
			return _downFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectedFontFormat():FontFormat {
			return _downFormat;
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
		
		private var _fontFormat:FontFormat =
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR);
		private var _downFormat:FontFormat =
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_BUTTON_FONT_COLOR);
		//private var _dashedLine:DashedLine;
		private var _pressedColor:uint = new RGB(DEFAULT_COLOR).darker(.8);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawItemShape(color:uint):void {
			with(dto.container.graphics) {
				clear();
				beginFill(color, 1);
				drawRect(0, 0, dto.width, dto.height);
				endFill();
			}
		}
	}
}