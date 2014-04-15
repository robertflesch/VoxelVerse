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
	// SpasBoxHelpUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 09/11/2010 09:18
	* @see http://www.flashapi.org/
	*/

	import flash.text.TextFormat;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.BoxHelpUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>SpasBoxHelpUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>BoxHelp</code> instances.
	 * 
	 * 	@see org.flashapi.swing.BoxHelp
	 * 	@see org.flashapi.swing.plaf.BoxHelpUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasBoxHelpUI extends SpasUI implements BoxHelpUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.  A Look and Feel object must not be directly instantiated.
		 * 
		 * 	@param	dto		A reference to the <code>LafDTO</code> object that
		 * 					instantiates this look and feel.
		 */
		public function SpasBoxHelpUI(dto:LafDTO) {
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
			var cd:Number = dto.height/2;
			var lineColor:uint = dto.glow ? 0x0099CC : DEFAULT_COLOR;
			var bg:Figure = Figure.setFigure(dto.container);
			bg.clear();
			bg.lineStyle(1, lineColor, 1, true);
			bg.beginFill(dto.color, .6);
			bg.drawRoundedRectangle(0, 0, OFFSET + dto.width + OFFSET, dto.height, cd, cd);
			bg.endFill();
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
		
		private const OFFSET:Number = 6;
		private var _textFormat:TextFormat = new TextFormat(DEFAULT_FONT_FACE, 12, 0x333333, true);
	}
}