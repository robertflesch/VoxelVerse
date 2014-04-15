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
	// ButtonState.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 30/11/2009 15:27
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>ButtonState</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>state</code> property of the <code>ABM</code>
	 * 	class.
	 * 
	 * 	@see org.flashapi.swing.button.core.ABM#state
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonState {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new ButtonState
		 * 				instance.
		 */
		public function ButtonState() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The button has its normal appearance.
		 */
		public static const UP:String = States.UP;
		
		/**
		 * 	The button appears pressed.
		 */
		public static const DOWN:String = States.DOWN;
		
		/**
		 * 	Basically displayed while the mouse is over the button.
		 */
		public static const OVER:String = States.OVER;
		
		/**
		 * 	The button is inactive.
		 */
		public static const DISABLED:String = States.DISABLED;
		
		/**
		 * 	The button is selected.
		 */
		public static const SELECTED:String = States.SELECTED;
	}
}