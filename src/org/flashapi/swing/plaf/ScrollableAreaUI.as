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
	// ScrollableAreaUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/07/2008 14:00
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ScrollableAreaUI</code> interface defines the interface
	 * 	required to create <code>ScrollableArea</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ScrollableAreaUI extends LookAndFeel {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>ScrollableArea</code> scrollbars.
		 * 
		 * 	@return the class used as look and feel for the
		 * 			<code>ScrollableArea</code> scrollbars.
		 */
		function getScrollBarLaf():Class;
		
		/**
		 * 	[Deprecated] Returns the default width of the scrollbars for the
		 * 	<code>ScrollableArea</code> look and feel.
		 * 
		 * 	@return the default width of the scrollbars for this look and feel.
		 */
		function getScrollBarWidth():Number
	}
}