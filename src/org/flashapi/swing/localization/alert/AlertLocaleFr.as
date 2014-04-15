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

package org.flashapi.swing.localization.alert {
	
	// -----------------------------------------------------------
	// AlertLocaleFr.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/02/2011 14:46
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>AlertLocaleFr</code> class is an enumeration of constant values
	 * 	that contains French labels to be used by buttons of <code>Alert</code>
	 * 	instances.
	 * 
	 * 	<p>The default class for buttons labels of <code>Alert</code> instances
	 * 	is the <code>AlertLocaleFr</code> class.</p>
	 * 
	 * 	@see org.flashapi.swing.Alert
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AlertLocaleFr {
		
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
		 * 				AlertLocaleFr instance.
		 */
		public function AlertLocaleFr() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The label for the <code>Alert</code> action button.
		 */
		public static const ACTION:String = "Ok";
		
		/**
		 * 	The label for the <code>Alert</code> choice button.
		 */
		public static const CHOICE:String = "Non"; 
		
		/**
		 * 	The label for the <code>Alert</code> cancel button.
		 */
		public static const CANCEL:String = "Annuler";
	}
}