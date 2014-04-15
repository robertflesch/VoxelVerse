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
	// FormItem.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/02/2011 13:46
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.databinding.DataProvider;
	import org.flashapi.swing.validators.Validator;
	
	/**
	 * 	The <code>FormItem</code> class creates basic objects that define a rich
	 * 	field within a <code>FormObject</code> list. You typically use <code>FormItem</code>
	 * 	instances to add a field with the <code>AFM.addItem()</code> method.
	 * 
	 * 	@see org.flashapi.swing.form.AFM
	 * 	@see org.flashapi.swing.form.FormObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormItem extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>FormItem</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	label		The plain text displayed within the form field defined
		 * 						by this <code>FormItem</code> instance.
		 * 	@param	variable	The string variable associated with the form field
		 * 						defined by this <code>FormItem</code> instance.
		 * 	@param	type		A <code>FormItemType</code> constant that specifies
		 * 						the type of form field defined by this <code>FormItem</code>
		 * 						instance. Default value is <code>FormItemType.INPUT</code>.
		 * 	@param	validator	The <code>Validator</code> object associated with the
		 * 						form field defined by this <code>FormItem</code> instance.
		 */
		public function FormItem(label:String = "", variable:String = "", type:String = "input",  validator:Validator = null) {
			super();
			initObj(label, variable, type,  validator);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>FormItemType</code> constant that specifies the type of form field
		 * 	defined by this <code>FormItem</code> instance.
		 * 	
		 * 	@default FormItemType.INPUT
		 */
		public var type:String;
		
		/**
		 * 	The plain text displayed at field title within the form field defined by  
		 * 	this <code>FormItem</code> instance.
		 * 
		 * 	@default An empty string.
		 */
		public var label:String;
		
		/**
		 * 	The string variable associated with the form field defined by this 
		 * 	<code>FormItem</code> instance.
		 * 
		 * 	@default An empty string.
		 */
		public var variable:String;
		
		/**
		 * 	The plain text displayed on the face of the field control associated with
		 * 	the form field defined by this <code>FormItem</code> instance.
		 * 
		 * 	@default An empty string.
		 */
		public var itemLabel:String = "";
		
		/**
		 * 	The <code>Validator</code> object associated with the form field defined 
		 * 	by this <code>FormItem</code> instance.
		 * 
		 * 	@default null
		 */
		public var validator:Validator;
		
		/**
		 * 	Specifies the orientation of the form field defined by this 
		 * 	<code>FormItem</code> instance, when using complex elements such like
		 * 	<code>RadioGroup</code> objects. Valid values are <code>LayoutOrientation.HORIZONTAL</code>
		 * 	or <code>LayoutOrientation.VERTICAL</code>
		 * 
		 * 	@default LayoutOrientation.HORIZONTAL
		 */
		public var orientation:String = LayoutOrientation.HORIZONTAL;
		
		/**
		 * 	Specifies the <code>DataProvider</code> of the form field defined by this 
		 * 	<code>FormItem</code> instance, when using complex elements such like
		 * 	<code>RadioGroup</code> objects.
		 * 
		 * 	@default null
		 */
		public var dataProvider:DataProvider;
		
		/**
		 * 	Indicates the name if the <code>FormItemContainer</code> instance associated with the
		 * 	form field defined by this <code>FormItem</code> instance
		 * 
		 * 	@default null
		 */
		public var name:String;
		
		/**
		 * 	The CSS class name of the field control associated with the form field defined by this
		 * 	<code>FormItem</code> instance.
		 * 
		 * 	@default null
		 */
		public var className:String;
		
		/**
		 * 	The additional data value of the field control associated with the form field defined 
		 * 	by this <code>FormItem</code> instance.
		 * 
		 * 	@default null
		 */
		public var data:*;
		
		/**
		 * 	The width, in pixels, of the field control associated with the form field defined 
		 * 	by this <code>FormItem</code> instance.
		 * 
		 * 	@default NaN
		 */
		public var width:Number = NaN;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, variable:String, type:String,  validator:Validator):void {
			this.label = label;
			this.variable = variable;
			this.type = type;
			this.validator = validator;
		}
	}
}