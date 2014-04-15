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
	// BasicLinkButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 28/12/2008 13:56
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.LinkButtonUI;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>BasicLinkButtonUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>LinkButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.LinkButton
	 * 	@see org.flashapi.swing.plaf.LinkButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicLinkButtonUI extends BasicIconColorsUI implements LinkButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicLinkButtonUI(dto:LafDTO) {
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
			var c:uint = (dto.colors.up!=StateObjectValue.NONE) ? dto.colors.over : 0x000000;
			var a:Number = (dto.highlightOpacity.up!=StateObjectValue.NONE) ? dto.highlightOpacity.up : 0;
			drawButtonShape(c, a);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var c:uint = (dto.colors.over!=StateObjectValue.NONE) ? dto.colors.over : 0xb2e1ff;
			var a:Number = (dto.highlightOpacity.over!=StateObjectValue.NONE) ? dto.highlightOpacity.over : .8;
			drawButtonShape(c, a);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var c:uint = (dto.colors.down!=StateObjectValue.NONE) ? dto.colors.down : 0x7fceff;
			var a:Number = (dto.highlightOpacity.down!=StateObjectValue.NONE) ? dto.highlightOpacity.down : .8;
			drawButtonShape(c, a);
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
			//var c:Object= (dto.colors.disabled!=StateObjectValue.NONE) ? new AltColors(dto.colors.over) : {color1:0x9C9D9D, color2:0x808080, color3:0xA9A9A9, color4:0x979797};
			//drawButtonShape(c.color1, c.color2, c.color3, c.color4);
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
		
		private var _fontFormat:FontFormat = new FontFormat(WebFonts.VERDANA, 12, 0x000000);
		private var _dashedLine:DashedLine;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(color:uint, alpha:Number):void {
			var cd:Number = isNaN(dto.cornerRadius) ? 8 : dto.cornerRadius;
			var f:Figure = Figure.setFigure(dto.container);
			f.clear();
			f.beginFill(color, alpha);
			f.drawRoundedRectangle(0, 0, dto.width, dto.height, cd, cd);
			f.endFill();
		}
	}
}