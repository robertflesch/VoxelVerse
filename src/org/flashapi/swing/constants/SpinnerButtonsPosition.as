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
	// SpinnerButtonsPosition.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/01/2011 17:51
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>SpinnerButtonsPosition</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>buttonPosition</code> property of the
	 * 	<code>AbstractSpinner</code> class.
	 * 
	 * 	@see org.flashapi.swing.core.AbstractSpinner#buttonPosition
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class SpinnerButtonsPosition {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new 
		 * 				SpinnerButtonsPosition instance.
		 */
		public function SpinnerButtonsPosition() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that the button is placed to the left-side of the spinner
		 * 	object.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Indicates that the button is placed to the right-side of the spinner
		 * 	object.
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * 	Indicates that the button is placed on the top of the spinner object.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Indicates that the button is placed at the bottom of the spinner object.
		 */
		public static const BOTTOM:String = "bottom";
	}
}