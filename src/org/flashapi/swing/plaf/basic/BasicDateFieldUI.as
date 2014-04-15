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
	// BasicDateFieldUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 23/07/2008 16:40
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.icons.CalendarIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.DateFieldUI;
	
	/**
	 * 	The <code>BasicDateFieldUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>DateField</code> instances.
	 * 
	 * 	@see org.flashapi.swing.DateField
	 * 	@see org.flashapi.swing.plaf.DateFieldUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicDateFieldUI extends BasicUI implements DateFieldUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicDateFieldUI(dto:LafDTO) {
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
		public function getDatePickerLaf():Class {
			return BasicDatePickerUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextInputLaf():Class {
			return BasicTextInputUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getUpIcon():Class {
			return CalendarIcon;
		}
	}
}