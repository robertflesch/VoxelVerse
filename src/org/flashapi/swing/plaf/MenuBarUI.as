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
	// MenuBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/07/2009 22:26
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>MenuBarUI</code> interface defines the interface required to
	 * 	create <code>MenuBar</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.MenuBar
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface MenuBarUI extends LookAndFeel {
		
		/**
		 * 	This method is used by the look and feel to draw the menu bar track (tray).
		 */
		function drawTray():void;
		
		/**
		 * 	Draws the border of the menu bar.
		 */
		function drawBorder():void
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the menu bar buttons. This class must implement the
		 * 	<code>MenuButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the menu bar buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.MenuButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the menus of the menu bar. This class must implement the
		 * 	<code>MenuUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the menus of the menu bar.
		 * 
		 * 	@see org.flashapi.swing.plaf.MenuUI
		 */
		function getMenuLaf():Class;
	}
}