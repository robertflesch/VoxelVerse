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

package org.flashapi.swing.validators {
	
	// -----------------------------------------------------------
	// Validator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/11/2008 15:11
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>Validator</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 validation services.
	 * 
	 * 	<p><code>Validator</code> objects provide the ability for a form to make a
	 * 	field required, which means that the user must enter a value in the field or
	 * 	the validation fails.</p>
	 * 
	 * 	@see org.flashapi.swing.validators.AbstractValidator
	 * 	@see org.flashapi.swing.form.FormItemContainer#validator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Validator { 
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>String</code> which contains the error message to be 
		 * 	displayed if the validation failed. This message is composed from the
		 * 	<code>LocaleValidation</code> instance specified by the <code>composerClass</code>
		 * 	property.
		 * 
		 * 	@see #composerClass
		 * 	@see org.flashapi.swing.localization.validation.LocaleValidation
		 */
		function get message():String;
		
		/**
		 * 	Sets or gets the <code>Class</code> reference that will be instantiated
		 * 	to compose the error message if the validation failed. The <code>Class</code>
		 * 	object reference must implement the <code>LocaleValidation</code> interface.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.InvalidInheritanceException
		 * 				A <code>InvalidInheritanceException</code> error if 
		 * 				<code>composerClass</code> does not implement the
		 * 				<code>LocaleValidation</code> interface.
		 * 
		 * 	@see #message
		 * 	@see org.flashapi.swing.localization.validation.LocaleValidation
		 */
		function get composerClass():Class;
		function set composerClass(value:Class):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Validates the string specified by the <code>value</code> parameter, according
		 * 	to specifications defined by this <code>Validator</code> object.
		 * 
		 * 	@param	value	The string to be validated by this <code>Validator</code>
		 * 					object.
		 * 
		 * 	@return	<code>true</code> is the <code>value</code> parameter to 
		 * 			to the <code>Validator</code> object specifications; <code>false</code>
		 * 			otherwise.
		 */
		function validate(value:String):Boolean;
	}
}