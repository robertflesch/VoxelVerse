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

package org.flashapi.swing.localization.pagenav {
	
	// -----------------------------------------------------------
	// PageNavLocaleFr.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/02/2011 23:48
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>PageNavLocaleFr</code> class is an enumeration of constant values
	 * 	that contains French labels to be used with the <code>PageNavigator</code>
	 * 	class.
	 * 
	 * 	<p>The <code>PageNavLocaleUs</code> class is the default class for labels
	 * 	to be used with the <code>PageNavigator</code> class.</p>
	 * 
	 * 	@see org.flashapi.swing.PageNavigator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PageNavLocaleFr {
		
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
		 * 				PageNavLocaleFr instance.
		 */
		public function PageNavLocaleFr() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The 
		 */
		public static const FIRST_LABEL:String = "Premier";
		
		/**
		 * 	The 
		 */
		public static const PREV_LABEL:String = "<";
		
		/**
		 * 	The 
		 */
		public static const LAST_LABEL:String = "Dernier";
		
		/**
		 * 	The 
		 */
		public static const NEXT_LABEL:String = ">";
	}
}