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
	// BasicSimpleFormUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/01/2009 08:57
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SimpleFormUI;
	
	/**
	 * 	The <code>BasicSimpleFormUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>SimpleForm</code> instances.
	 * 
	 * 	@see org.flashapi.swing.SimpleForm
	 * 	@see org.flashapi.swing.plaf.SimpleFormUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicSimpleFormUI extends BasicLoggingFormUI implements SimpleFormUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicSimpleFormUI(dto:LafDTO) {
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
		public function getSeparatorLaf():Class {
			return BasicSeparatorUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSpinnerLaf():Class {
			return BasicSpinnerUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRadioButtonLaf():Class {
			return BasicRadioButtonUI;
		}
	}
}