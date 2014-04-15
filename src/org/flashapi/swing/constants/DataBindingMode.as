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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// DataBindingMode.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 28/05/2009 01:08
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DataBindingMode</code> class is an enumeration of constant values
	 * 	that specify the way data is treated by <code>Listable</code> objects.
	 * 
	 * 	@see org.flashapi.swing.list.Listable#dataBindingMode
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataBindingMode {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new DataBindingMode
		 * 				instance.
		 */
		public function DataBindingMode() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds the new <code>ListItem</code> objects at the end of the <code>Listable</code>
		 * 	instance.
		 */
		public static const INCREMENT:String = "increment";
		
		/**
		 * 	Updates all <code>ListItem</code> objects in the <code>Listable</code>
		 * 	instance. If the new data value is <code>null</code>, the <code>data</code>
		 * 	property of the updated <code>ListItem</code> object is set to <code>null</code>.
		 */
		public static const UPDATE:String = "update";
		
		/**
		 * 	Merges all <code>ListItem</code> objects in the <code>Listable</code>
		 * 	instance. If the new data value is <code>null</code>, the <code>data</code>
		 * 	property of the updated <code>ListItem</code> object is not changed. Use
		 * 	the <code>MERGE</code> constant as data biding mode to create multi-language
		 * 	applications.
		 */
		public static const MERGE:String = "merge";
		
		/**
		 * 	Removes all existing <code>ListItem</code> objects from the <code>Listable</code>
		 * 	instance before adding new ones.
		 */
		public static const RESET:String = "reset";
	}
}