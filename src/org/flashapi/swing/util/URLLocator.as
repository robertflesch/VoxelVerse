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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// URLLocator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/06/2009 15:14
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>URLLocator</code> class is a utility class that defines all-static
	 * 	methods for retrieving the URI of specified <code>DisplayObject</code>
	 * 	instances which have been loaded within a SPAS 3.0 application.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class URLLocator {
		
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
		 * 				URLLocator instance.
		 */
		public function URLLocator() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Retrieves and returns the URL of the specified <code>DisplayObject</code>
		 * 	instance, which has been loaded within the SPAS 3.0 application.
		 * 
		 * 	@param	target	The <code>DisplayObject</code> instance for which to
		 * 					retrieve the URL.
		 * 
		 * 	@return	The URI of the loaded <code>DisplayObject</code> instance.
		 */
		public static function getLocation(target:DisplayObject):String {
			var url:String = target.loaderInfo.url;
			return url.substring(0, url.lastIndexOf("/")) + "/";
		}
	}
}