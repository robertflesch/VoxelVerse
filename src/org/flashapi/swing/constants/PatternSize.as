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
	// PatternSize.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/10/2011 12:39
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>PatternSize</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>patternSize</code> property of the
	 * 	<code>Checkerboard</code> class.
	 * 
	 * 	@see org.flashapi.swing.Checkerboard.#patternSize
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PatternSize {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new PatternSize
		 * 				instance.
		 */
		public function PatternSize() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The smalest pattern size for <code>Checkerboard</code> instances.
		 */
		public static const SMALL:String = "small";
		
		/**
		 * 	The medium pattern size for <code>Checkerboard</code> instances.
		 */
		public static const MEDIUM:String = "medium";
		
		/**
		 * 	The largest pattern size for <code>Checkerboard</code> instances.
		 */
		public static const LARGE:String = "large";
	}
}