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
	// ClosableProperties.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/11/2009 16:35
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>ClosableProperties</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>defaultCloseOperation</code> property
	 * 	of the <code>ClosableObject</code> interface.
	 * 
	 * 	@see org.flashapi.swing.core.ClosableObject#defaultCloseOperation
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ClosableProperties {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new ClosableProperties
		 * 				instance.
		 */
		public function ClosableProperties() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that the <code>ClosableObject</code> should not take any action
		 * 	when closed.
		 */
		public static const DO_NOTHING_ON_CLOSE:String = "doNothingOnClose";
		
		/**
		 * 	Indicates that the <code>ClosableObject</code> should be closed when the
		 * 	user closes it.
		 */
		public static const REMOVE_ON_CLOSE:String = "removeOnClose";
		
		/**
		 * 	Indicates that the <code>ClosableObject</code> must call the
		 * 	<code>onCloseFunction</code> when the user closes it.
		 */
		public static const CALL_CLOSE_FUNCTION:String = "callCloseFunction";
		
		/**
		 * 	Indicates that the <code>ClosableObject</code> should be disposed when the
		 * 	user closes it.
		 */
		public static const DISPOSE_ON_CLOSE:String = "disposeOnClose ";
		
		/**
		 * 	Indicates that the <code>ClosableObject</code> should not take any action
		 * 	when closed, except calling the <code>onCloseFunction</code>.
		 */
		public static const ONLY_CALL_CLOSE_FUNCTION:String = "onlyCallCloseFunction";
	}
}