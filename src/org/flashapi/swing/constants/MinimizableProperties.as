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
	// MinimizableProperties.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/04/2009 12:55
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>MinimizableProperties</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>defaultMinimizeOperation</code>
	 * 	property of the <code>Window</code> class.
	 * 
	 * 	@see	org.flashapi.swing.Window#defaultMinimizeOperation
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MinimizableProperties {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new
		 * 				MinimizableProperties instance.
		 */
		public function MinimizableProperties() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A value for the <code>Window.defaultMinimizeOperation</code> property
		 * 	that indicates the <code>Window</code> should not take any action when
		 * 	minimized.
		 */
		public static const DO_NOTHING_ON_CALL:String = "doNothingOnCall";
		
		/**
		 * 	A value for the <code>Window.defaultMinimizeOperation</code> property
		 * 	that indicates the <code>Window</code> should be minimized when a user
		 * 	clicks the minimize button.
		 */
		public static const MINIMIZE_ON_CALL:String = "minimizeOnCall";
	}
}