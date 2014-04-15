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
	// ScrollPaneUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/07/2008 18:20
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ScrollPaneUI</code> interface defines the interface required to
	 * 	create <code>ScrollPane</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.ScrollPane
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ScrollPaneUI extends BorderUI {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns a reference to the class used as look and feel for
		 * 	the <code>ScrollPane</code> scroll bars. This class must implement the
		 * 	<code>ScrollableAreaUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>ScrollPane</code> scroll bars.
		 * 
		 * 	@see org.flashapi.swing.plaf.ScrollableAreaUI
		 */
		function getScrollBarLaf():Class;
		
		/**
		 * 	Draws the mask used for the <code>ScrollPane</code> content,
		 * 	whith the specified shape.
		 */
		function drawMask():void;
	}
}