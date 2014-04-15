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
	// SpasIconColorsUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/01/2009 17:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.spas.brushes.SpasIconColors;
	
	/**
	 * 	The <code>SpasIconColorsUI</code> class is the SPAS 3.0 base class 
	 * 	for look and feel that implement  colorizable icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasIconColorsUI extends SpasUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasIconColorsUI(dto:LafDTO) {
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
			return SpasIconColors.OUT;
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