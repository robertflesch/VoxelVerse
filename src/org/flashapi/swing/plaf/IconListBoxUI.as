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
	// IconListBoxUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 13:10
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>IconListBoxUI</code> interface defines the interface required to
	 * 	create <code>IconListBox</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.list.IconListBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface IconListBoxUI extends BorderUI {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>IconListBox</code> container. This class must implement the
		 * 	<code>BoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>IconListBox</code> container.
		 * 
		 * 	@see org.flashapi.swing.plaf.BoxUI
		 */
		function getBoxLaf():Class;
		
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>IconListBox</code> item buttons. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>IconListBox</code> item buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
	}
}