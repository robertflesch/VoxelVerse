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
	// DateOrder.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/01/2011 13:35
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DateOrder</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>order</code> property of the
	 * 	<code>DateFormatter</code> class.
	 * 
	 * 	@see org.flashapi.swing.date.DateFormatter#order
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DateOrder {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new DateOrder
		 * 				instance.
		 */
		public function DateOrder() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that the order of the date format is respectively "Month", "Day"
		 * 	and "Year". This is the typical order for US-English date style.
		 */
		public static const MDY:String = "MDY";
		
		/**
		 * 	Indicates that the order of the date format respectively "Day", "Month"
		 * 	and "Year". This is the typical order for European date style.
		 */
		public static const DMY:String = "DMY";
		
		/**
		 * 	Indicates that the order of the date format is respectively "Year", "Month"
		 * 	and "Day". This is the typical order for Japanese date style.
		 */
		public static const YMD:String = "YMD";
	}
}