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
	// ROD.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/01/2010 10:34
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>ROD</code> (Resizable Object Directions) class provides an
	 *  enumeration of constant values that are used to specify resizable directions
	 * 	within user-enabled resizable object, such as <code>Window</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Window
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public final class ROD {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new ROD
		 * 				instance.
		 */
		public function ROD() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Represents the "top" direction.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Represents the "top-right" direction.
		 */
		public static const TOP_RIGHT:String = "topRight";
		
		/**
		 * 	Represents the "right" direction.
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * 	Represents the "bottom-right" direction.
		 */
		public static const BOTTOM_RIGHT:String = "bottomRight";
		
		/**
		 * 	Represents the "bottom" direction.
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * 	Represents the "bottom-left" direction.
		 */
		public static const BOTTOM_LEFT:String = "bottomLeft";
		
		/**
		 * 	Represents the "left" direction.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Represents the "top-left" direction.
		 */
		public static const TOP_LEFT:String = "topLeft";
	}
}