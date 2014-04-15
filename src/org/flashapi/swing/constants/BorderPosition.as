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
	// BorderPosition.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/12/2008 13:06
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>BorderPosition</code> class is an enumeration of constant values
	 * 	that specify the vertical positions of the title label used with
	 * 	<code>TitleBorder</code> objects.
	 * 
	 * 	@see org.flashapi.swing.border.TitleBorder#titlePosition
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BorderPosition {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new BorderPosition
		 * 				instance.
		 */
		public function BorderPosition() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Position the title above the border top line.
		 */
		public static const ABOVE_TOP:String = "aboveTop";
		
		/**
		 * 	Position the title in the middle of the border top line.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Position the title below the border top line.
		 */
		public static const BELOW_TOP:String = "belowTop";
		
		/**
		 * 	Position the title above the border bottom line.
		 */
		public static const ABOVE_BOTTOM:String = "aboveBottom";
		
		/**
		 * 	Position the title in the middle of the border bottom line.
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * 	Position the title below the border bottom line.
		 */
		public static const BELOW_BOTTOM:String = "belowBottom";
	}
}