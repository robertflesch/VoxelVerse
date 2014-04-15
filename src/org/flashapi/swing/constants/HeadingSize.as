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
	 * 	The <code>HeadingSize</code> class is an enumeration of constant values that
	 * 	are used by SPAS 3.0 to set the default size of <code>Heading</code>
	 * 	instances, according the their specified levels.
	 * 
	 * 	@see org.flashapi.swing.Heading
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class HeadingSize {
		
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
		 * 				HeadingSize instance.
		 */
		public function HeadingSize() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies the size, in pixels, of first-level headings.
		 */
		public static const H1Size:uint = 24;
		
		/**
		 * 	Specifies the size, in pixels, of secong-level headings.
		 */
		public static const H2Size:uint = 18;
		
		/**
		 * 	Specifies the size, in pixels, of third-level headings.
		 */
		public static const H3Size:uint = 14;
		
		/**
		 * 	Specifies the size, in pixels, of fourth-level headings.
		 */
		public static const H4Size:uint = 12;
		
		/**
		 * 	Specifies the size, in pixels, of fifth-level headings.
		 */
		public static const H5Size:uint = 10;
		
		/**
		 * 	Specifies the size, in pixels, of sixth-level headings.
		 */
		public static const H6Size:uint = 8;
	}
}