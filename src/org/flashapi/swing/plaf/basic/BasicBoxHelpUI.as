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
	// BasicBoxHelpUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/08/2007 11:26
	* @see http://www.flashapi.org/
	*/

	import flash.text.TextFormat;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.BoxHelpUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicBoxHelpUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>BoxHelp</code> instances.
	 * 
	 * 	@see org.flashapi.swing.BoxHelp
	 * 	@see org.flashapi.swing.plaf.BoxHelpUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicBoxHelpUI extends BasicUI implements BoxHelpUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicBoxHelpUI(dto:LafDTO) {
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
		public function clearBoxHelp():void {
			dto.container.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBoxHelp():void {
			var lineColor:uint = dto.glow ? 0x0099CC : 0;
			var f:Figure = Figure.setFigure(dto.container);
			f.clear();
			f.lineStyle(1, lineColor, 1, true);
			f.beginFill(dto.color);
			f.drawRoundedRectangle(0, 0, OFFSET + dto.width + OFFSET, dto.height, 4, 4);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return 0xFEFFDD;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getHorizontalOffset():Number {
			return OFFSET;
		}
		
		
		/**
		 *  @inheritDoc 
		 */
		public function getVerticalOffset():Number {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getXMouseOffset():Number {
			return 10;
		}
		/**
		 *  @inheritDoc 
		 */
		public function getYMouseOffset():Number {
			return 20;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextFormat():TextFormat {
			return _textFormat;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textFormat:TextFormat = new TextFormat(WebFonts.VERDANA, 11, 0x000000);
		private const OFFSET:Number = 6;
	}
}