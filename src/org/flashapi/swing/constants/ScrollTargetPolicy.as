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
	// ScrollTargetPolicy.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/06/2010 15:17
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>ScrollTargetPolicy</code> class is an enumeration of constant values 
	 * 	that you can use to set the <code>scrollTargetPolicy</code> property of the
	 * 	<code>ScrollBar</code> class.
	 * 
	 * 	@see org.flashapi.swing.ScrollBar#scrollTargetPolicy
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class ScrollTargetPolicy {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new 
		 * 				ScrollTargetPolicy instance.
		 */
		public function ScrollTargetPolicy() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>ScrollBar</code> instance remains active, event if the 
		 * 	<code>targetPath</code> parameter is <code>null</code>.
		 */
		public static const ENABLE_IF_NULL:String = "enableIfNull";
		
		/**
		 * 	The <code>ScrollBar</code> instance is not active when the <code>targetPath</code>
		 * 	parameter is <code>null</code>.
		 */
		public static const DISABLE_IF_NULL:String = "disableIfNull";
	}
}