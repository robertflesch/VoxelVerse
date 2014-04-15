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
	// MenuItemType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/02/2011 17:37
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>MenuItemType</code> class is an enumeration of constant values that
	 * 	are internally used by the <code>Menu</code> class to identify the type
	 * 	of items passed to the <code>Menu.addItem()</code> method.
	 * 
	 * 	@see org.flashapi.swing.Menu#addItem()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class MenuItemType {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				MenuItemType instance.
		 */
		public function MenuItemType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Represents the default item, a <code>SelectableItem</code> instance.
		 */
		public static const DEFAULT:String = "";
		
		/**
		 * 	Represents the value for a <code>Separator</code> item.
		 */
		public static const SEPARATOR:String = "separator";
		
		/**
		 * 	Represents the value for a <code>RadioButton</code> item.
		 */
		public static const RADIO:String = "radio";
		
		/**
		 * 	Represents the value for a <code>CheckBox</code> item.
		 */
		public static const CHECK:String = "check";
	}
}