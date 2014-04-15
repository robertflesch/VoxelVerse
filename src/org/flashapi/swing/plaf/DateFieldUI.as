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
	// DateFieldUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 23/07/2008 16:39
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DateFieldUI</code> interface defines the interface required to
	 * 	create <code>DateField</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.DateField
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DateFieldUI extends LookAndFeel {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the date field text input. This class must implement the
		 * 	<code>TextInputUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the date field text input.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextInputUI
		 */
		function getTextInputLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the date field calendar. This class must implement the
		 * 	<code>DatePickerUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the date field calendar.
		 * 
		 * 	@see org.flashapi.swing.plaf.DatePickerUI
		 */
		function getDatePickerLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as default icon for
		 * 	the date field icon. This class must implement the
		 * 	<code>Brush</code> interface.
		 * 
		 * 	@return The <code>Brush</code> class used as default icon.
		 * 
		 * 	@see org.flashapi.swing.brushes.Brush
		 */
		function getUpIcon():Class;
	}
}