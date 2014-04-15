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
	// MenuUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/02/2008 12:17
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>MenuUI</code> interface defines the interface required to
	 * 	create <code>Menu</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Menu
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface MenuUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the default border color of the look and feel.
		 * 
		 * 	@return	The default border color of this look and feel.
		 */
		function getBorderColor():uint;
		
		/**
		 * 	Returns the a reference of the class used as start effect for
		 * 	the <code>Menu</code> instance. This class must implement the
		 * 	<code>Effect</code> interface.
		 * 
		 * 	@return The class used as start effect for the <code>Menu</code> instance.
		 * 
		 * 	@see org.falshapi.swing.effect.Effect
		 */
		function getStartEffect():Class;
		
		/**
		 * 	Returns the a reference of the class used as radio button <code>Brush</code> for
		 * 	the <code>Menu</code> selectable item buttons.
		 * 
		 * 	@return The class used as used as radio button <code>Brush</code> for the
		 * 			<code>Menu</code> selectable item buttons.
		 */
		function getRadioIconBrush():Class;
		
		/**
		 * 	Returns the a reference of the class used as check button <code>Brush</code> for
		 * 	the <code>Menu</code> selectable item buttons.
		 * 
		 * 	@return The class used as used as check button <code>Brush</code> for the
		 * 			<code>Menu</code> selectable item buttons.
		 */
		function getCheckIconBrush():Class;
		
		/**
		 * 	Returns the a reference of the class used as right direction arrow
		 * 	<code>Brush</code> for the <code>Menu</code> selectable item buttons.
		 * 
		 * 	@return The class used as used as right direction arrow <code>Brush</code>
		 * 			for the <code>Menu</code> selectable item buttons.
		 */
		function getRightArrowBrush():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>Menu</code> selectable item buttons.
		 * 	This class must implement the <code>SelectableItemUI</code> interface.
		 * 	 
		 * 
		 * 	@return The class used as look and feel for the <code>Menu</code> selectable item buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.SelectableItemUI
		 */
		function getSelectableItemLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>Menu</code> separators. This class must implement the
		 * 	<code>SeparatorUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>Menu</code> separators.
		 * 
		 * 	@see org.flashapi.swing.plaf.SeparatorUI
		 */
		function getSeparatorLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>Menu</code> box container. This class must implement the 
		 * 	<code>BoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>Menu</code> box container.
		 * 
		 * 	@see org.flashapi.swing.plaf.BoxUI
		 */
		function getBoxLaf():Class;
		
		/**
		 * 	Returns the default border style of the look and feel.
		 * 	Possible values are the constants of the <code>BorderStyle</code> class.
		 * 
		 * 	@return	The default border style of this look and feel.
		 * 
		 * 	@see org.flashapi.swing.constants.BorderStyle
		 */
		function getBorderStyle():String;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is not over the button.
		 * 
		 * 	@return	The "out" state icon color used by the look and feel
		 */
		function getOutIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the button.
		 * 
		 * 	@return	The "over" state icon color used by the look and feel
		 */
		function getOverIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the button and the mouse left button is clicked.
		 * 
		 * 	@return	The "pressed" state icon color used by the look and feel
		 */
		function getPressedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the button <code>selected</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "selected" state icon color used by the look and feel
		 */
		function getSelectedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the button <code>inactive</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "inactive" state icon color used by the look and feel
		 */
		function getInactiveIconColor():uint;
	}
}