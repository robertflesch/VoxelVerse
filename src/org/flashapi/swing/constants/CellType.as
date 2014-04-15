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
	// CellType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/11/2008 00:01
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>CellType</code> class provides constants used to determines the types
	 * 	of nodes used by a <code>Cell</code> object.
	 * 
	 * 	@see  org.flashapi.swing.table.Cell
	 * 	@see  org.flashapi.swing.Table
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CellType {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new CellType
		 * 				instance.
		 */
		public function CellType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Represents a string of text as a node within <code>Cell</code> object.
		 */
		public static const TEXT_NODE:String = "textNode";
		
		/**
		 * 	Represents an <code>Element</code> object as a node within <code>Cell</code>
		 * 	object.
		 * 
		 * 	@see org.flashapi.swing.core.Element
		 */
		public static const ELEMENT_NODE:String = "elementNode";
	}
}