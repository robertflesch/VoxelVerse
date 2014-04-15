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
	// SpinButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 16:54
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SpinButtonUI</code> interface defines the interface required to
	 * 	create <code>SpinButton</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.SpinButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface SpinButtonUI extends LookAndFeel {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>SpinButton</code>. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>SpinButton</code>.
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as up direction arrow <code>Brush</code> for
		 * 	the <code>SpinButton</code> up button.
		 * 
		 * 	@return The class used as used as up direction arrow <code>Brush</code> for the
		 * 			<code>SpinButton</code> up button.
		 */
		function getUpArrowBrush():Class;
		
		/**
		 * 	Returns the a reference of the class used as down direction arrow <code>Brush</code> for
		 * 	the <code>SpinButton</code> down button.
		 * 
		 * 	@return The class used as used as down direction arrow <code>Brush</code> for the
		 * 			<code>SpinButton</code> down button.
		 */
		function getDownArrowBrush():Class;
	}
}