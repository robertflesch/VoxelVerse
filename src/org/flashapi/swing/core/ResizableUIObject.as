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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// ResizableUIObject.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/03/2011 13:18
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ResizableUIObject</code> interface defines the basic set of APIs that 
	 * 	you must implement to create SPAS 3.0 <code>UIObjects</code> that can be resized
	 * 	by users.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public interface ResizableUIObject extends IUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Deactivates a collection of handles to prevent resizing from these specified
		 * 	handles. You use the constants of the <code>ROD</code> class to define
		 * 	handle objects to deactivate.
		 * 
		 * 	@param	... rest	A collection of handle objects to deactivate, defined
		 * 						by their <code>ROD</code> names.
		 * 
		 * 	@see #activateHandles()
		 * 	@see org.flashapi.swing.constants.ROD
		 */
		function deactivateHandles(... rest):void;
		
		/**
		 * 	Activates a collection of handles to allow resizing from these specified
		 * 	handles. You use the constants of the <code>ROD</code> class to define
		 * 	handle objects to activate.
		 * 
		 * 	@param	... rest	A collection of handle objects to activate, defined
		 * 						by their <code>ROD</code> names.
		 * 
		 * 	@see #deactivateHandles()
		 * 	@see org.flashapi.swing.constants.ROD
		 */
		function activateHandles(... rest):void;
	}
}