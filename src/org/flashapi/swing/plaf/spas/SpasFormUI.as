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
	// SpasFormUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 15/06/2009 11:55
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.FormUI;
	
	/**
	 * 	The <code>SpasFormUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>LoggingForm</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Form
	 * 	@see org.flashapi.swing.plaf.FormUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasFormUI extends SpasSimpleFormUI implements FormUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasFormUI(dto:LafDTO) {
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
		public function getComboBoxLaf():Class {
			return SpasComboBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getListLaf():Class {
			return SpasListBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDateFieldLaf():Class {
			return SpasDateFieldUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextAreaLaf():Class {
			return SpasTextAreaUI;
		}
	}
}