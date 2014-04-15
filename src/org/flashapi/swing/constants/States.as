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
	// States.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 30/11/2009 15:22
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>States</code> class is an enumeration of constant values that
	 * 	you can use to determine the current state of clickable objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class States {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new States
		 * 				instance.
		 */
		public function States() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The object has its normal appearance.
		 */
		public static const UP:String = "up";
		
		/**
		 * 	The mouse leaves the object.
		 */
		public static const OUT:String = "out";
		
		/**
		 * 	The object is currently pressed.
		 */
		public static const PRESSED:String = "pressed";
		
		/**
		 * 	The mouse button is pressed over the object.
		 */
		public static const DOWN:String = "down";
		
		/**
		 * 	The mouse is over the object.
		 */
		public static const OVER:String = "over";
		
		/**
		 * 	No state is defined for this object.
		 */
		public static const NONE:String = "none";
		
		/**
		 * 	The object is selected.
		 */
		public static const SELECTED:String = "selected";
		
		/**
		 * 	The object is emphasized.
		 */
		public static const EMPHASIZED:String = "emphasized";
		
		/**
		 * 	The object is currently inactive.
		 */
		public static const INACTIVE:String = "inactive";
		
		/**
		 * 	The object is disabled.
		 */
		public static const DISABLED:String = "disabled";
	}
}