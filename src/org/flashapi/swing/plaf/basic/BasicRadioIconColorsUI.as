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
	// BasicRadioIconColorsUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/01/2009 15:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.basic.brushes.BasicIconColors;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicRadioIconColorsUI</code> interface defines the interface required to
	 * 	create buttons look and feels with colorizable icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicRadioIconColorsUI extends BasicUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicRadioIconColorsUI(dto:LafDTO) {
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
		public function getOutIconColor():uint {
			return BasicIconColors.SELECTED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOverIconColor():uint {
			return BasicIconColors.OVER;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPressedIconColor():uint {
			return BasicIconColors.PRESSED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectedIconColor():uint {
			return BasicIconColors.SELECTED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getInactiveIconColor():uint {
			return BasicIconColors.INACTIVE;
		}
	}	
}