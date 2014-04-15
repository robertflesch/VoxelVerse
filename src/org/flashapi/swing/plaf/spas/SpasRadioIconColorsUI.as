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
	// SpasRadioIconColorsUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 09/11/2010 17:17
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.spas.brushes.SpasIconColors;
	
	/**
	 * 	The <code>SpasRadioIconColorsUI</code> interface defines the interface required to
	 * 	create buttons look and feels with colorizable icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasRadioIconColorsUI extends SpasUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasRadioIconColorsUI(dto:LafDTO) {
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
			return SpasIconColors.SELECTED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOverIconColor():uint {
			return SpasIconColors.OVER;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPressedIconColor():uint {
			return SpasIconColors.PRESSED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectedIconColor():uint {
			return SpasIconColors.SELECTED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getInactiveIconColor():uint {
			return SpasIconColors.INACTIVE;
		}
	}	
}