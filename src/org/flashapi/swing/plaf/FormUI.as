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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// FormUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 10/11/2010 13:01
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>LoggingFormUI</code> interface defines the interface required to
	 * 	create complex forms look and feels.
	 * 
	 * 	@see org.flashapi.swing.Form
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface FormUI extends SimpleFormUI { 
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form comboboxes. This class must implement the
		 * 	<code>ComboBoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form comboboxes.
		 * 
		 * 	@see org.flashapi.swing.plaf.ComboBoxUI
		 */
		function getComboBoxLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form listboxes. This class must implement the
		 * 	<code>ListBoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form listboxes.
		 * 
		 * 	@see org.flashapi.swing.plaf.ListBoxUI
		 */
		function getListLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form date fields. This class must implement the
		 * 	<code>DateFieldUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form date fields.
		 * 
		 * 	@see org.flashapi.swing.plaf.DateFieldUI
		 */
		function getDateFieldLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form text areas. This class must implement the
		 * 	<code>TextAreaUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form text areas.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextAreaUI
		 */
		function getTextAreaLaf():Class;
	}
}