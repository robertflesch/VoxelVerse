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
	// SpinnerUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 15:20
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SpinnerUI</code> interface defines the interface required to
	 * 	create <code>AbstractSpinner</code> subclasses look and feels.
	 * 
	 * 	@see org.flashapi.swing.core.AbstractSpinner
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface SpinnerUI extends LookAndFeel {
		
		/**
		 * 	Returns a number that represents the gap between the text input and the
		 * 	buttons displayed on the face of the <code>Spinner</code> object.
		 * 
		 *	@return the gap between the text input and the buttons displayed on the face
		 * 			of the <code>Spinner</code> object.
		 */
		function getButtonDelay():Number;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>Spinner</code> object buttons. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>Spinner</code> object buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>Spinner</code> object text input. This class must implement the
		 * 	<code>TextInputUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>Spinner</code> object text input.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextInputUI
		 */
		function geTextInputLaf():Class;
		
		/**
		 * 	Returns a number that represents the width of the <code>Spinner</code> object buttons.
		 * 
		 *	@return the width of the <code>Spinner</code> object buttons.
		 */
		function getButtonWidth():Number;
		
		/**
		 * 	Returns the a reference of the class used as up direction arrow <code>Brush</code>
		 * 	for the <code>Spinner</code> object up button.
		 * 
		 * 	@return The class used as used as up direction arrow <code>Brush</code> for the
		 * 	<code>Spinner</code> object up button.
		 */
		function getUpArrowBrush():Class;
		
		/**
		 * 	Returns the a reference of the class used as down direction arrow <code>Brush</code>
		 * 	for the <code>Spinner</code> object down button.
		 * 
		 * 	@return The class used as used as down direction arrow <code>Brush</code> for the
		 * 	<code>Spinner</code> object down button.
		 */
		function getDownArrowBrush():Class;
	}
}