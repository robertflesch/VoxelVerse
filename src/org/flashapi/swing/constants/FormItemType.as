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
	// FormItemType.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/01/2008 16:45
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>FormItemType</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>type</code> property of the
	 * 	descriptor object you use to add new items into SPAS 3.0 form objects.
	 * 
	 * 	@see org.flashapi.swing.Form
	 * 	@see org.flashapi.swing.SimpleForm
	 * 	@see org.flashapi.swing.Loggingorm
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormItemType {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new FormItemType
		 * 				instance.
		 */
		public function FormItemType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that the form item is a <code>Button</code> instance.
		 */
		public static const BUTTON:String = "button";
		
		/**
		 * 	Specifies that the form item is a <code>Checkbox</code> instance.
		 */
		public static const CHECKBOX:String = "checkbox";
		
		/**
		 * 	Specifies that the form item is a <code>Combobox</code> instance.
		 */
		public static const COMBOBOX:String = "combobox";
		
		/**
		 * 	Specifies that the form item is a <code>DateField</code> instance.
		 */
		public static const DATE:String = "date";
		
		/**
		 * 	Specifies that the form item is a <code>Canvas</code> instance.
		 */
		public static const DIV:String = "div";
		
		/**
		 * 	Specifies that the form item is an <code>Object</code> instance.
		 */
		public static const HIDDEN:String = "hidden";
		
		/**
		 * 	Specifies that the form item is a <code>TextInput</code> instance.
		 */
		public static const INPUT:String = "input";
		
		/**
		 * 	Specifies that the form item is a <code>ListBox</code> instance.
		 */
		public static const LIST:String = "list";
		
		/**
		 * 	Specifies that the form item is a <code>TextInput</code> instance
		 * 	That only displays passwords.
		 */
		public static const PASSWORD:String = "password";
		
		/**
		 * 	Specifies that the form item is a <code>RadioButtonGroup</code> instance.
		 */
		public static const RADIO_GROUP:String = "radioGroup";
		
		/**
		 * 	Specifies that the form item is a "reset" <code>Button</code> instance.
		 */
		public static const RESET:String = "reset";
		
		/**
		 * 	Specifies that the form item is a <code>Separator</code> instance.
		 */
		public static const SEPARATOR:String = "separator";
		
		/**
		 * 	Not implemented yet.
		 */
		public static const SELECT:String = "select";
		
		/**
		 * 	Specifies that the form item is a "submit" <code>Button</code> instance.
		 */
		public static const SUBMIT:String = "submit";
		
		/**
		 * 	Specifies that the form item is a <code>Spinner</code> instance.
		 */
		public static const SPINNER:String = "spinner";
		
		/**
		 * 	Specifies that the form item is a <code>NumericStepper</code> instance.
		 */
		public static const NUMERIC_STEPPER:String = "numericStepper";
		
		/**
		 * 	Specifies that the form item is a <code>Text</code> instance.
		 */
		public static const TEXT:String = "text";
		
		/**
		 * 	Specifies that the form item is a <code>Textarea</code> instance.
		 */
		public static const TEXTAREA:String = "textarea";
		
		/**
		 * 	Specifies that the form item is a "title" <code>Label</code> instance.
		 */
		public static const TITLE:String = "title";
	}
}