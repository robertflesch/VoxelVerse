﻿////////////////////////////////////////////////////////////////////////////////
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
	// LabelTextAreaUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/12/2010 22:27
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>LabelTextAreaUI</code> interface defines the interface required to
	 * 	create <code>LabelTextArea</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.LabelTextArea
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface LabelTextAreaUI extends LookAndFeel {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>LabelTextAreaUI</code> text. This class must implement the
		 * 	<code>LabelUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>LabelTextAreaUI</code> text.
		 * 
		 * 	@see org.flashapi.swing.plaf.LabelUI
		 */
		function getTextLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>LabelTextAreaUI</code> text input. This class must implement the
		 * 	<code>TextAreaUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>LabelTextAreaUI</code> text area.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextAreaUI
		 */
		function getTextAreaLaf():Class;
		
	}
}