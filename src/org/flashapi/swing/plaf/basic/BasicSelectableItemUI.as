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
	// BasicSelectableItemUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 28/12/2008 13:57
	* @see http://www.flashapi.org/
	*/

	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SelectableItemUI;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>BasicSelectableItemUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>SelectableItem</code> instances.
	 * 
	 * 	@see org.flashapi.swing.button.SelectableItem
	 * 	@see org.flashapi.swing.plaf.SelectableItemUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicSelectableItemUI extends BasicRadioIconColorsUI implements SelectableItemUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicSelectableItemUI(dto:LafDTO) {
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
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0x666666;
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
				0xb2e1ff : ColorUtil.getColor(dto.colors.over);
			drawItemShape(c);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:uint = dto.colors.down == StateObjectValue.NONE ?
				0x7FCEFF : ColorUtil.getColor(dto.colors.down);
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
			/*_dashedLine = new DashedLine(uio.container, 1, 2);
			var c:uint = (uio.isPressed || uio.isSelected) ? 0x067CD2 : 0x777777;
			_dashedLine.lineStyle(0, c, 1, true);
			_dashedLine.drawRectangle(new Point(2, 1), new Point(uio.width-2, uio.height-2));
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
		
		private var _fontFormat:FontFormat = new FontFormat(WebFonts.VERDANA, 12, 0x0B333C);
		//private var _dashedLine:DashedLine;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawItemShape(color:uint):void {
			var f:Figure = Figure.setFigure(dto.container);
			f.clear();
			f.beginFill(color, 1);
			f.drawRectangle(0, 0, dto.width, dto.height);
			f.endFill();
		}
	}
}