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
	// HeadingLevel.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/02/2011 15:52
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>HeadingLevel</code> class is an enumeration of constant values that
	 * 	you can use to specifiy the level of <code>Heading</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Heading
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class HeadingLevel {
		
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
		 * 				HeadingLevel instance.
		 */
		public function HeadingLevel() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Creates first-level heading.
		 */
		public static const H1:String = "h1";
		
		/**
		 * 	Creates secong-level heading.
		 */
		public static const H2:String = "h2";
		
		/**
		 * 	Creates third-level heading.
		 */
		public static const H3:String = "h3";
		
		/**
		 * 	Creates fourth-level heading.
		 */
		public static const H4:String = "h4";
		
		/**
		 * 	Creates fifth-level heading.
		 */
		public static const H5:String = "h5";
		
		/**
		 * 	Creates sixth-level heading.
		 */
		public static const H6:String = "h6";
	}
}