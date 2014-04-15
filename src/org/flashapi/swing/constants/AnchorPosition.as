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
	// AnchorPosition.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 01/01/2011 19:21
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>AnchorPosition</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>anchorPosition</code> property of the
	 * 	<code>BubbleHelp</code> class.
	 * 
	 * 	@see org.flashapi.swing.BubbleHelp.#anchorPosition
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AnchorPosition {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new AnchorPosition
		 * 				instance.
		 */
		public function AnchorPosition() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Positions the anchor at the top of the <code>BubbleHelp</code> instance.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Positions the anchor at the left of the <code>BubbleHelp</code> instance.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Positions the anchor at the bottom of the <code>BubbleHelp</code> instance.
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * 	Positions the anchor at the right of the <code>BubbleHelp</code> instance.
		 */
		public static const RIGHT:String = "right";
	}
}