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

package org.flashapi.swing.form {
	
	// -----------------------------------------------------------
	// FormItemContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/11/2008 03:25
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.validators.Validator;
	
	/**
	 * 	The <code>FormItemContainer</code> interface defines the basic set of APIs
	 * 	that you must implement to create a SPAS 3.0 form container.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface FormItemContainer extends IUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the form item object itself, such as a button or an input field.
		 */
		function get formItem():*;
		
		/**
		 * 	Returns the value associated with the form item object. This is often
		 * 	the value of the form item object itself.
		 */
		function get value():String;
		
		/**
		 * 	Returns the <code>FormObject</code> which is associated with this 
		 * 	<code>FormItemContainer</code> object.
		 */
		function get form():FormObject;
		
		/**
		 * 	Returns a reference to the <code>Label</code> instance used to display the 
		 * 	label text for the form item object.
		 */
		function get labelItem():Label;
		
		/**
		 * 	Sets or gets the object that contains stored data properties used by
		 * 	the <code>FormItemContainer</code> <code>Validator</code> object.
		 * 
		 * 	@see #validator
		 */
		function get storedProp():Object;
		function set storedProp(value:Object):void;
		
		/**
		 * 	Returns the variable name of the <code>FormItemContainer</code> instance.
		 * 
		 * 	@default null
		 */
		function get variable():String;
		
		/**
		 * 	Sets or gets the <code>Validator</code> object used to check the input values
		 * 	of the item object.
		 * 
		 * 	@default null
		 * 
		 * 	@see #storedProp
		 * 	@see #isValid
		 */
		function get validator():Validator;
		function set validator(value:Validator):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>FormItemContainer</code>
		 * 	instance check, by using the associated <code>Validator</code> object, has succeded  
		 * 	(<code>true</code>), or not(<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #validator
		 */
		function get isValid():Boolean;
		function set isValid(value:Boolean):void;
		
		/**
		 * 	Sets or gets the position of text label within this <code>FormItemContainer</code>
		 * 	object.
		 * 
		 * 	@default FormLabelPosition.LEFT
		 */
		function get labelPosition():String;
		function set labelPosition(value:String):void;
		
		//--------------------------------------------------------------------------
		//
		//  public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Forces the target <code>FormObject</code> to be redrawn.
		 */
		function updateMetrics():void;
		
		/**
		 * 	Resets this <code>FormItemContainer</code> object.
		 */
		function reset():void;
		
		/**
		 * 	Changes Look and Feels for all <code>UIObjects</code> displayed within this
		 * 	<code>FormItemContainer</code> object.
		 */
		function changeFormItemLookAndFeel():void;
		
		/**
		 * 	Is used by the target <code>FormObject</code> to focus on form item containers
		 * 	for which validation tests have failed.
		 */
		function displayInvalidItem():void;
	}
}