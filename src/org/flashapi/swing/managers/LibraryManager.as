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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// LibraryManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/01/2010 19:25
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.library.ExtLib;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>LibraryManager</code> singleton defines the object which is responsible
	 * 	for managing all external effects that implement the <code>ExtLib</code> interface
	 * 	within the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.library.ExtLib
	 * 	@see org.flashapi.swing.UIManager#libManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LibraryManager {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>LibraryManager</code> instance.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException
		 * 	A <code>SingletonException</code> if you try create a new
		 * 	<code>LibraryManager</code> object.
		 */
		public function LibraryManager() { 
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds an <code>ExtLib</code> library class reference to the 
		 * 	<code>LibraryManager</code> singleton. This library defines a new set
		 * 	of functionalities to extend capabilities of the SPAS 3.0 API.
		 * 
		 * 	@param	library	A library class reference to extend the SPAS 3.0 API
		 * 					capabilities.
		 */
		public function addLib(library:Class):void {
			var lib:ExtLib = new library();
			lib.init();
			lib = null;
		}
		
		/**
		 * 	removes the <code>ExtLib</code> library specified by the <code>library</code>
		 * 	parameter from the <code>LibraryManager</code> singleton. After removing
		 * 	the library, all the functionalities that it defines wont be accessible
		 * 	anymore.
		 * 
		 * 	@param	library	The library to remove from the <code>LibraryManager</code> 
		 * 					singleton.
		 */
		public function removeLib(library:Class):void {
			var lib:ExtLib = new library();
			lib.finalize();
			lib = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal static function getInstance():LibraryManager {
			_constructorAccess = false;
			return new LibraryManager();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//---> Singleton management:
		private static var _instanciable:Boolean = true;
		private static var _constructorAccess:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (!_instanciable) {
				throw new SingletonException(Locale.spas_internal::ERRORS.LIBRARY_MANAGER_SINGLETON_ERROR);
			}
			_instanciable = false;
			_constructorAccess = true;
		}
	}
}