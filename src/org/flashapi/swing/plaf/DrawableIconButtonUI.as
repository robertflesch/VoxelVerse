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
	// DrawableIconButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/01/2009 21:04
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DrawableIconButtonUI</code> interface defines the interface 
	 * 	required to create drawable icon buttons look and feels.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DrawableIconButtonUI extends ButtonUI {
		
		/**
		 * 	Returns the defaut brush class used to render the button icon
		 * 	with this look and feel. This class must implement the
		 * 	<code>StateBrush</code> interface.
		 * 
		 * 	@return the defaut brush class used to render the button icon.
		 * 
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		function getDefaultIcon():Class;
	}
}