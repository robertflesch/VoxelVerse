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
	// DropDownMenuUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/09/2009 16:05
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DropDownMenuUI</code> interface defines the interface required to
	 * 	create list objects look and feels.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DropDownMenuUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>DropList</code> list box. This class must implement the
		 * 	<code>ListBoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>DropList</code> list box.
		 * 
		 * 	@see org.flashapi.swing.plaf.ListBoxUI
		 */
		function getListLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as arrow icon.
		 * 	This class must implement the <code>StateBrush</code> interface.
		 * 	
		 * 	@return	The class used as arrow icon.
		 * 
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		function getIcon():Class;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is not over the reactive area of the drop-down menu.
		 * 
		 * 	@return	The "out" state icon color used by the look and feel
		 */
		function getOutIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the area of the drop-down menu.
		 * 
		 * 	@return	The "over" state icon color used by the look and feel
		 */
		function getOverIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the area of the drop-down menu and the mouse
		 * 	left button is clicked.
		 * 
		 * 	@return	The "pressed" state icon color used by the look and feel
		 */
		function getPressedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the drop-down menu <code>selected</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "selected" state icon color used by the look and feel
		 */
		function getSelectedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the drop-down menu <code>inactive</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "inactive" state icon color used by the look and feel
		 */
		function getInactiveIconColor():uint;
	}
}