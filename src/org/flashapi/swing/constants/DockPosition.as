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
	// DockPosition.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/01/2011 17:11
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>AlertMode</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>dockPosition</code> property of the
	 * 	<code>Dock</code> class.
	 * 
	 * 	@see org.flashapi.swing.Dock#dockPosition
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DockPosition {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new DockPosition
		 * 				instance.
		 */
		public function DockPosition() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that the <code>Dock</code> object is displayed to the left-side
		 * 	of the application.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Specifies that the <code>Dock</code> object is displayed to the right-side
		 * 	of the application.
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * 	Specifies that the <code>Dock</code> object is displayed on the top
		 * 	of the application.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Specifies that the <code>Dock</code> object is displayed at the bottom
		 * 	of the application.
		 */
		public static const BOTTOM:String = "bottom";
	}
}