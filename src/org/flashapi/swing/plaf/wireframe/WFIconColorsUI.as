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
	// WFIconColorsUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2010 15:23
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.wireframe.brushes.WFIconColors;
	
	/**
	 * 	The <code>WFIconColorsUI</code> class is the SPAS 3.0 base class 
	 * 	for wireframe-like look and feels that implement colorizable icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFIconColorsUI extends WFUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFIconColorsUI(dto:LafDTO) {
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
			return WFIconColors.OUT;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOverIconColor():uint {
			return WFIconColors.OVER;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPressedIconColor():uint {
			return WFIconColors.PRESSED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectedIconColor():uint {
			return WFIconColors.SELECTED;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getInactiveIconColor():uint {
			return WFIconColors.INACTIVE;
		}
	}	
}