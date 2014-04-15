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
	// LoggingFormUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 12:57
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>LoggingFormUI</code> interface defines the interface required to
	 * 	create all forms look and feels.
	 * 
	 * 	@see org.flashapi.swing.LoggingForm
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface LoggingFormUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form buttons. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form labels. This class must implement the
		 * 	<code>LabelUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form labels.
		 * 
		 * 	@see org.flashapi.swing.plaf.LabelUI
		 */
		function getLabelLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the form text inputs. This class must implement the
		 * 	<code>TextInputUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the form text inputs.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextInputUI
		 */
		function getTextInputLaf():Class;
	}
}