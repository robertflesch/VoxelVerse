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

package org.flashapi.swing.exceptions {
	
	// -----------------------------------------------------------
	// IllegalArgumentException.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/09/2007 18:57
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	An <code>IllegalArgumentException</code> is thrown to indicate that a method
	 * 	has been passed an illegal or inappropriate argument.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class IllegalArgumentException extends Error {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>IllegalArgumentException</code> object with
		 * 	the specified detail message.
		 * 
		 * 	@param	message	The <code>String</code> containing a detail message.
		 */
		public function IllegalArgumentException(message:String = "") {
			super("IllegalArgumentException: " + message);
		}
	}
}
