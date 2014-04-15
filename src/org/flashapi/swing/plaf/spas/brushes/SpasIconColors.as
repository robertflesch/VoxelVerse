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

package org.flashapi.swing.plaf.spas.brushes {
	
	// -----------------------------------------------------------
	// SpasIconColors.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 19/01/2009 19:18
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 *  The <code>SpasIconColors</code> class provides constant values to manage colors
	 * 	of drawable icons for the SPAS 3.0 default Look and Feel.
	 * 
	 * 	<p>You cannot create a <code>SpasIconColors</code> object directly from ActionScript code.
	 * 	If you call <code>new SpasIconColors()</code>, an exception is thrown.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasIconColors {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A <code>DeniedConstructorAccess</code> if you try to create
		 * 				a new <code>SpasIconColors</code> instance;
		 */
		public function SpasIconColors() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The default LAF icon color for the "out" state.
		 */
		public static const OUT:uint = 0xFFFFFF;
		
		/**
		 * 	The default LAF icon color for the "pressed" state.
		 */
		public static const PRESSED:uint = 0x222222;
		
		/**
		 * 	The default LAF icon color for the "over" state.
		 */
		public static const OVER:uint = 0xFFFFFF;
		
		/**
		 * 	The default LAF icon's color for the "selected" state.
		 */
		public static const SELECTED:uint = 0x222222;
		
		/**
		 * 	The default LAF icon color for the "emphasized" state.
		 */
		public static const EMPHASIZED:uint = 0xFFFFFF;
		
		/**
		 * 	The default LAF icon color for the "inactive" state.
		 */
		public static const INACTIVE:uint = 0xBBBBBB;
	}
}