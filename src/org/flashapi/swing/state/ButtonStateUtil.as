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

package org.flashapi.swing.state {
	
	// -----------------------------------------------------------
	// ButtonStateUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 24/02/2009 23:58
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.exceptions.DeniedConstructorAccessException;
	
	/**
	 * 	A utility class that provides a static method to easilly retreive the value
	 * 	of a property according to the specified state of a button control.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonStateUtil {
		
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
		 * 				ButtonStateUtil instance.
		 */
		public function ButtonStateUtil() {
			super();
			new DeniedConstructorAccessException(this);
		}
		
		/**
		 * 	Returns the value stored within the <code>StateObject</code> specified
		 * 	by the <code>stateObject</code> parameter, according the state defined
		 * 	by the <code>state</code> parameter.
		 * 
		 * 	@param	stateObject	A <code>StateObject</code> that contains values
		 * 						of a specific property fo each state of a <code>UIObject</code>.
		 * 	@param	state	The state for which to retreive the property value.
		 * 
		 * 	@return	The value of a <code>UIObject</code> property for the specified
		 * 			state.
		 */
		public static function getStateProperty(stateObject:StateObject, state:String = "up"):* {
			var newState:Object = StateObjectValue.NONE;
			switch(state) {
				case ButtonState.UP :
					newState = stateObject.up;
					break;
				case ButtonState.OVER :
					newState = stateObject.over;
					break;
				case ButtonState.DOWN :
					newState = stateObject.down;
					break;
				case ButtonState.DISABLED :
					newState = stateObject.disabled;
					break;
				case ButtonState.SELECTED :
					newState = stateObject.selected;
					break;
			}
			return newState;
		}
	}
}