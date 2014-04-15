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
	// PictureFlowUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/07/2008 16:59
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>PictureFlowUI</code> interface defines the interface required to
	 * 	create <code>PictureFlow</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.PictureFlow
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface PictureFlowUI extends LookAndFeel {
		
		/**
		 * 	Returns a reference to the class used as look and feel for
		 * 	the <code>PictureFlow</code> scroll bar. This class must implement the
		 * 	<code>ScrollableAreaUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>PictureFlow</code> scroll bar.
		 * 
		 * 	@see	org.flashapi.swing.plaf.ScrollableAreaUI
		 */
		function getScrollBarLaf():Class;
	}
}