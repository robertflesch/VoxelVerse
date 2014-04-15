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
	// GridHorizontalHanchor.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/01/2011 17:47
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>GridHorizontalHanchor</code> class defines the constants for the 
	 * 	allowed values of the <code>horizontalHanchor</code> parameter of the
	 * 	<code>Grid.snapToGrid()</code> property.
	 * 
	 * 	@see org.flashapi.swing.tools.Grid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class GridHorizontalHanchor {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new 
		 * 				GridHorizontalHanchor instance.
		 */
		public function GridHorizontalHanchor() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that the anchor is placed to the left-side of the target object.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Specifies that the anchor is placed to the left-right of the target object.
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * 	Specifies that the anchor is placed to the center of the target object.
		 */
		public static const CENTER:String = "center";
	}
}