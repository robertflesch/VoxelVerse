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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// DeniedConstructorAccess.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/07/2007 11:24
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.exceptions.DeniedConstructorAccessException;
	import org.flashapi.swing.exceptions.NullPointerException;
	
	/**
	 * 	The <code>DeniedConstructorAccess</code> class creates objects that throws
	 * 	exceptions if you attempt to access the constructor function of the specified
	 * 	instance.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DeniedConstructorAccess {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates an new <code>DeniedConstructorAccess</code> instance.
		 * 
		 * 	@param	o	A reference to the object that you want restrict the access
		 * 				to its constructor function.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A <code>DeniedConstructorAccessException</code> if the 
		 * 				<code>o</code> parameter is not <code>null</code>.
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A <code>NullPointerException</code> if the <code>o</code>
		 * 				parameter is <code>null</code>.
		 */
		public function DeniedConstructorAccess(o:* = null) {
			super();
			initObj(o);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(o:*):void {
			if(o!=null) denyInstantiation(this);
			else throw new NullPointerException();
		}
		
		private function denyInstantiation(o:*):void {
			throw new DeniedConstructorAccessException(o);
		}
	}
}