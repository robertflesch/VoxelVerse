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

package org.flashapi.swing.math.rpn {
	
	// -----------------------------------------------------------
	// RpnConstant.as
	// -----------------------------------------------------------
	
	/**
	* @author	Pascal ECHEMANN
	* @version	1.0.0, 27/02/2011 19:15
	* @see		http://www.flashapi.org/
	*/
		
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>RpnConstant</code> class is an enumeration of constant values that
	 * 	are internally used by the <code>RpnExp</code> class to specify the type of
	 * 	item to be treated.
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class RpnConstant {
		
		// -----------------------------------------------------------
		// RpnConstant.as
		// -----------------------------------------------------------
		
		/**
		* @author	Pascal ECHEMANN
		* @version	1.0.0, 19/05/2008 16:40
		* @see		http://www.flashapi.org/
		*/
		
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
		 * 				RpnConstant instance.
		 */
		public function RpnConstant() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that the current item is a right bracket.
		 */
		public static const RIGHT_BRACKET:String = "rightBracket";
		
		/**
		 * 	Specifies that the current item is a left bracket.
		 */
		public static const LEFT_BRACKET:String = "leftBracket";
		
		/**
		 * 	Specifies that the current item is a numeric value.
		 */
		public static const VALUE:String = "value";
		
		/**
		 * 	Specifies that the current item is an operator.
		 */
		public static const OPERATOR:String = "operator";
		
		/**
		 * 	Specifies that the current item is a function.
		 */
		public static const FUNCTION:String = "function";
		
		/**
		 * 	Specifies that the current item is a separator.
		 */
		public static const SEPARATOR:String = "separator";
		
		/**
		 * 	Specifies that the current item is a variable.
		 */
		public static const VARIABLE:String = "variable";
		
		/**
		 * 	Specifies that the current item is a constant.
		 */
		public static const CONSTANT:String = "constant";
		
		/**
		 * 	Specifies that the current item is a string.
		 */
		public static const STRING:String = "string";
	}
}