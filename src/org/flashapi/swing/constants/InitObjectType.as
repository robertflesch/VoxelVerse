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
	// InitObjectType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 13/08/2009 19:18
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>InitObjectType</code> class is an enumeration of constant values 
	 * 	that are used by the <code>Initializator</code> class to inticates the type
	 * 	of object that are currently initialized.
	 * 
	 * 	@see org.flashapi.swing.Initializator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class InitObjectType {
		
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
		 * 				InitObjectType instance.
		 */
		public function InitObjectType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that the current type of object to intialize is a Runtime 
		 * 	Shared Library.
		 */
		public static const RSL:uint = 0;
		
		/**
		 * 	Indicates that the current type of object to intialize is a CSS.
		 */
		public static const STYLE_SHEET:uint = 1;
		
		/**
		 * 	Indicates that the current type of object to intialize is an external
		 * 	asset.
		 */
		public static const ASSETS:uint = 2;
		
		/**
		 * 	Indicates that the current type of object to intialize is an
		 * 	<code>Object</code>.
		 */
		public static const OBJECT:uint = 3;
		
		/**
		 * 	Indicates that the current type of object to intialize is a
		 * 	<code>DataProvider</code> object.
		 */
		public static const DATA_PROVIDER:uint = 4;
		
		/**
		 * 	Indicates that the current type of object to intialize is a
		 * 	<code>XMLQuery</code> object.
		 */
		public static const XML_QUERY:uint = 5;
	}
}