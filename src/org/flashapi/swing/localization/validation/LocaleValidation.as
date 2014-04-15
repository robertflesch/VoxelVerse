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

package org.flashapi.swing.localization.validation {
	
	// -----------------------------------------------------------
	// LocaleValidation.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/01/2011 15:03
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>LocaleValidation</code> interface defines the basic set of APIs that 
	 * 	you must implement to create objects that add locale capabilities to SPAS 3.0
	 * 	<code>Validator</code> instances.
	 * 
	 * 	@see org.flashapi.swing.validators.Validator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface LocaleValidation {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Generates and returns an error message for the associated <code>Validator</code>
		 * 	instance in a specific language.
		 * 
		 * 	@param	obj An object that contains information to compose the message,
		 * 				when needed.
		 * 
		 * 	@return	An error message in a specific language.
		 */
		function compose(obj:Object = null):String;
	}
}