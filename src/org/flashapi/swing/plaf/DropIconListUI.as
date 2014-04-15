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
	// DropIconListUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 11:53
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DropIconListUI</code> interface defines the interface required to
	 * 	create icons lists look and feels.
	 * 
	 * 	@see org.flashapi.swing.DropList
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DropIconListUI extends DropDownMenuUI {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the droplist button. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the droplist button.
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Specifies the default top radius for the droplist button.
		 * 
		 * 	@return	A number that represents the default top radius of the droplist button.
		 */
		function getButtonTopRadius():Number;
		
		/**
		 * 	Specifies the default bottom radius for the droplist button.
		 * 
		 * 	@return	A number that represents the default bottom radius of the droplist button.
		 */
		function getButtonBottomRadius():Number;
	}
}