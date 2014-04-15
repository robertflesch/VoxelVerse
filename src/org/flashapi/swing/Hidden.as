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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// Hidden.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/11/2008 18:29
	* @see http://www.flashapi.org/
	*/
	
	[IconFile("Hidden.png")]
	
	/**
	 * 	<img src="Hidden.png" alt="Hidden" width="18" height="18"/>
	 * 
	 * 	The <code>Hidden</code> object represents a hidden input field in an SPAS 3.0
	 * 	form. <code>Hidden</code> objects behaves exactly like HTML <code>hidden</code>
	 * 	tags. They create special objects that sends form fields to the server while
	 *  hiding them from the reader.
	 * 
	 * 	@see org.flashapi.swing.constants.FormItemType
	 * 	@see org.flashapi.swing.form.FormObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Hidden extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Hidden</code> instance.
		 */
		public function Hidden() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The string variable associated with this <code>Hidden</code> instance.
		 */
		public var variable:String;
		
		/**
		 * 	The name this <code>Hidden</code> instance.
		 */
		public var name:String;
		
		/**
		 * 	The <code>value</code> property associated with this <code>Hidden</code>
		 * 	instance.
		 */
		public var value:*;
		
		/**
		 * 	The <code>data</code> property associated with this <code>Hidden</code>
		 * 	instance.
		 */
		public var data:*;
	}
}