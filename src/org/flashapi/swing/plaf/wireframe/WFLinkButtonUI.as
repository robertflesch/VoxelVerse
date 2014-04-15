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
	// WFLinkButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/04/2011 13:28
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.LinkButtonUI;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>WFLinkButtonUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>LinkButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.LinkButton
	 * 	@see org.flashapi.swing.plaf.LinkButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class WFLinkButtonUI extends WFIconColorsUI implements LinkButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFLinkButtonUI(dto:LafDTO) {
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
		public function drawOutState():void {
			var a:Number = (dto.highlightOpacity.up != StateObjectValue.NONE) ?
				dto.highlightOpacity.up : 0;
			drawButtonShape(DEFAULT_BACKGROUND_COLOR, a);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var a:Number = (dto.highlightOpacity.over != StateObjectValue.NONE) ?
				dto.highlightOpacity.over : .5;
			drawButtonShape(0xDDDDDD, a);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var a:Number = (dto.highlightOpacity.down != StateObjectValue.NONE) ?
				dto.highlightOpacity.down : 1;
			drawButtonShape(0xDDDDDD, a);
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
			var a:Number = (dto.highlightOpacity.disabled != StateObjectValue.NONE) ?
				dto.highlightOpacity.disabled : 0;
			drawButtonShape(DEFAULT_BACKGROUND_COLOR, a);
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
			_dashedLine = new DashedLine(dto.container, 1, 2);
			_dashedLine.lineStyle(0, 0x777777, 1, true);
			_dashedLine.drawRectangle(new Point(2, 2), new Point(dto.width-2, dto.height-2));
			_dashedLine.endFill();
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
		public function getColor():uint {
			return null;
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
		public function getGrayTintColor():uint {
			return 0xACA899;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getIconDelay():Number {
			return 5;
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
		 *  @private
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
			new FontFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR);
		private var _dashedLine:DashedLine;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(color:uint, alpha:Number):void {
			with(dto.container.graphics) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR);
				beginFill(color, alpha);
				drawRect(0, 0, dto.width, dto.height);
				endFill();
			}
		}
	}
}