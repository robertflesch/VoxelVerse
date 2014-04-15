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
	// Library.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/05/2009 14:41
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Loader;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.exceptions.NullPointerException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>This class is experimental.</strong>
	 * 
	 * 	The <code>Library</code> class is used to create wrapper objects that enable
	 * 	easy access to assets or data contained within a Runtime Shared Library
	 * 	object (RSL).
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Library {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Library</code> instance.
		 * 
		 * 	@param	src	A <code>Loader</code> object; the source for the <code>Library</code>
		 * 				instance.
		 */
		public function Library(src:Loader = null) {
			super();
			initObj(src);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _src:Loader;
		/**
		 * 	Returns the <code>Loader</code> object used as RSL for this <code>Library</code>.
		 * 	If no <code>Loader</code> object is defined, returns <code>null</code>.
		 */
		public function get library():Loader {
			return _src;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a reference to the <code>Class</code> object of the class specified
		 * 	by the <code>name</code> parameter, if contained within this <code>Library</code>
		 * 	instance. Throws an <code>InvalidArgumentException</code> exception otherwise.
		 * 
		 * 	@param	name The name of a class.
		 * 
		 * 	@return	A reference to the <code>Class</code> object of the class specified
		 * 	by the <code>name</code> parameter.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.InvalidArgumentException
		 * 				An <code>InvalidArgumentException</code> if no public definition
		 * 				exists with the specified name for this <code>Library</code>
		 * 				instance.
		 *  @throws 	org.flashapi.swing.exceptions.NullPointerException
		 * 				A <code>NullPointerException</code> if the RSL for this <code>Library</code>
		 * 				instance is <code>null</code>.
		 */
		public function getClassByDefinition(name:String):Class {
			if (_src == null) throw new NullPointerException();
			try {
				return _src.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
			} catch (e:Error) {
				throw new InvalidArgumentException(Locale.spas_internal::ERRORS.LIBRARY_ERROR + name);
			}
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function setLibrary(value:Loader):void {
			_src = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(src:Loader):void {
			_src = src;
		}
	}
}