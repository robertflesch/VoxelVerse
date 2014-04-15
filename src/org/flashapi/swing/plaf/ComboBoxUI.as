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
	// ComboBoxUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/07/2008 11:08
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>ComboBoxUI</code> interface defines the interface required to
	 * 	create <code>ComboBox</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.ComboBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ComboBoxUI extends DropDownMenuUI {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the combobox text input. This class must implement the
		 * 	<code>TextInputUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the combobox text input.
		 * 
		 * 	@see org.flashapi.swing.plaf.UITextFormat
		 */
		function getTextInputLaf():Class;
		
		/**
		 * 	Returns a reference to the <code>UITextFormat</code> used by the look and feel.
		 * 
		 * 	@return	The <code>UITextFormat</code> used by the look and feel
		 * 
		 * 	@see org.flashapi.swing.text.UITextFormat
		 */
		function getTextFormat():UITextFormat;
		
		/**
		 * 	Returns an integer that represents the grey tint color applied to 
		 * 	the combobox text when the <code>ComboBox.greyTint</code> property
		 * 	is set to <code>true</code>.
		 * 	
		 * 	@return  The value for the button grey tint color.
		 */
		function getGrayTintColor():uint;
		
		/**
		 * 	Returns a number that represents the gap between the button and the
		 * 	text displayed on the face of the combobox.
		 * 
		 *	@return the gap between the button and the text displayed on the face of the combobox.
		 */
		function getButtonDelay():Number;
		
		/**
		 * 	Returns a number that represents the padding of the combobox label.
		 * 	It can be the left padding when the <code>Combobox.buttonPosition</code>
		 * 	is set to <code>DropButtonPosition.LEFT</code>, or the right padding when the
		 * 	<code>Combobox.buttonPosition</code> is set to <code>DropButtonPosition.RIGHT</code>.
		 * 
		 * 	@return The padding of the combobox label.
		 */
		function getTextPadding():Number;
		
		/**
		 * 	Returns the postition correponding to this look and feel for the combobox button .
		 * 
		 * 	@return A <code>Point</code> object that indicates the buttons position
		 * 			correponding to this look and feel.
		 */
		function getButtonPosition():Point;
		
		/**
		 * 	This method is used by the look and feel to draw the combobox face
		 * 	when the mouse is not over it.
		 */
		function drawOutState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the combobox face
		 * 	when the mouse is over it.
		 */
		function drawOverState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the combobox face
		 * 	when the mouse is over it and the mouse left button is clicked.
		 */
		function drawPressedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the combobox face
		 * 	when the <code>Comboboxutton.selected</code> property is set to true.
		 */
		//function drawSelectedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the combobox face
		 * 	when the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		function drawInactiveState():void;
	}
}