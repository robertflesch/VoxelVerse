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
	// Luminance.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 01/03/2009 14:24
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>Luminance</code> class is an enumeration of constant values 
	 * 	that are internally used by the <code>ColorMatrix</code> class.
	 * 
	 * 	<p>The weights to compute true CIE luminance from linear red, green and blue
	 * 	(indicated without prime symbols), for the<code>ColorMatrix</code> class,
	 * 	are these:
	 * 	<code>Y = Luminance.RED_CGL * R + Luminance.GREEN_CGL * G + Luminance.BLUE_CGL * B</code>.
	 * 	</p>
	 * 
	 * 	@see org.flashapi.swing.filters.ColorMatrix
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class Luminance {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new Luminance
		 * 				instance.
		 */
		public function Luminance() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant value used to compute true CIE luminance from linear red,
		 * 	green and blue.
		 */
		public static const RED_CGL:Number = 0.3086;
		
		/**
		 * 	A constant value used to compute true CIE luminance from linear red,
		 * 	green and blue.
		 */
		public static const GREEN_CGL:Number = 0.6094;
		
		/**
		 * 	A constant value used to compute true CIE luminance from linear red,
		 * 	green and blue.
		 */
		public static const BLUE_CGL:Number = 0.8020;
		
		/**
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const RED_NTSCL:Number = 0.212671;
		
		/**
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const GREEN_NTSCL:Number = 0.715160;
		
		/**
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const BLUE_NTSCL:Number = 0.072169;
	}
}