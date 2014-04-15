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
	// AlertMode.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 13/08/2009 19:18
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>AlertMode</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>alertMode</code> property of the
	 * 	<code>Alert</code> class.
	 * 
	 * 	@see org.flashapi.swing.Alert#alertMode
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class AlertMode {
		
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
		 * 				AlertMode instance.
		 */
		public function AlertMode() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Value that indicates that no button is displayed within the <code>Alert</code>
		 * 	instance.
		 */
		public static const NONE:String = "none";
		
		/**
		 * 	Value that enables an OK button within the <code>Alert</code> instance.
		 */
		public static const ALERT:String = "alert";
		
		/**
		 * 	Value that enables both, YES and NO buttons, within the <code>Alert</code>
		 * 	instance.
		 */
		public static const CHOICE:String = "choice";
		
		/**
		 * 	Value that enables YES, NO and Cancel buttons within the <code>Alert</code>
		 * 	instance.
		 */
		public static const CANCELABLE:String = "cancelable";
	}
}