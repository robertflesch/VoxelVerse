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
	// AbstractFormContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 02/12/2008 01:53
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.FormLabelPosition;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.validators.Validator;

	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>AbstractFormContainer</code> class is the base class for all form
	 * 	item containers.
	 * 
	 * 	<p><code>FormItemContainer</code> objects implement template method patterns 
	 * 	that create and manage a specific type of form item, such as input or listbox..., 
	 * 	within a <code>FormObject</code> instance.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractFormContainer extends Canvas implements FormItemContainer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor.	Creates a new <code>AbstractFormContainer</code> object
		 * 					with the specified parameters.
		 * 
		 * @param	form	The form where item objects are created and displayed in.
		 * @param	obj		An object that contains all properties for creating item 
		 * 					objects associated displayed within the specified form. 
		 * 					This object is the <code>value</code> parameter of the
		 * 					form <code>addItem()</code> method.
		 */
		public function AbstractFormContainer(form:FormObject, obj:Object) {
			super(0, 0);
			initObj(form, obj);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function get data():* {
			return $item.data;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>form</code> property.
		 * 
		 * 	@see #form
		 */
		protected var $form:FormObject;
		/**
		 * 	@inheritDoc
		 */
		public function get form():FormObject {
			return $form;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>formItem</code> property.
		 * 
		 * 	@see #formItem
		 */
		protected var $item:*;
		/**
		 *  @inheritDoc
		 */
		public function get formItem():* {
			return $item;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>labelItem</code> property.
		 * 
		 * 	@see #labelItem
		 */
		protected var $labelItem:Label;
		/**
		 *  @inheritDoc
		 */
		public function get labelItem():Label {
			return $labelItem;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>storedProp</code> property.
		 * 
		 * 	@see #storedProp
		 */
		protected var $storedProp:Object;
		/**
		 *  @inheritDoc
		 */
		public function  get storedProp():Object {
			return $storedProp;
		}
		public function  set storedProp(value:Object):void {
			$storedProp = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>variable</code> property.
		 * 
		 * 	@see #variable
		 */
		protected var $variable:String = null;
		/**
		 *  @inheritDoc
		 */
		public function get variable():String {
			return $variable;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>validator</code> property.
		 * 
		 * 	@see #validator
		 */
		protected var $validator:Validator = null;
		/**
		 *  @inheritDoc
		 */
		public function get validator():Validator {
			return $validator;
		}
		public function set validator(value:Validator):void {
			$validator = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>isValid</code> property.
		 * 
		 * 	@see #isValid
		 */
		protected var $isValid:Boolean = true;
		/**
		 *  @inheritDoc
		 */
		public function get isValid():Boolean {
			return $isValid;
		}
		public function set isValid(value:Boolean):void {
			$isValid = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>labelPosition</code> property.
		 * 
		 * 	@see #labelPosition
		 */
		protected var $labelPosition:String = FormLabelPosition.LEFT;
		/**
		 *  @inheritDoc
		 */
		public function get labelPosition():String {
			return $labelPosition;
		}
		public function set labelPosition(value:String):void {
			$labelPosition = value;
			switch($labelPosition) {
				case FormLabelPosition.LEFT : 
					this.layout.orientation = LayoutOrientation.HORIZONTAL;
					break;
				case FormLabelPosition.TOP : 
					this.layout.orientation = LayoutOrientation.VERTICAL;
					break;
			}
			getNewMetrics();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get value():String {
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function updateMetrics():void {
			this.redrawForm();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function reset():void {}
		
		/**
		 *  @inheritDoc
		 */
		public function changeFormItemLookAndFeel():void {}
		
		/**
		 *  @inheritDoc
		 */
		public function displayInvalidItem():void {}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal function setFormItem(value:*):void {
			$item = value;
		}
		
		/**
		 *  @private
		 */
		spas_internal function setLabelItem(value:Label):void {
			$labelItem = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The default text label for this <code>FormItemContainer</code> object.
		 */
		protected var $defaultLabel:String;
		/**
		 *  @private
		 */
		spas_internal function setDefaultLabel(value:String):void {
			$defaultLabel = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function redrawForm(e:DataBindingEvent = null):void {
			getNewMetrics(); 
			($form as AFM).spas_internal::refreshItemList();
		}
		
		/**
		 * 	@private
		 */
		protected function resetForm(e:UIMouseEvent):void {
			($form as AFM).spas_internal::resetForm();
		}
		
		/**
		 * 	@private
		 */
		protected function createGUI(obj:Object):void { }
		
		/**
		 * 	@private
		 */
		protected function getNewMetrics():void { }
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(form:FormObject, obj:Object):void {
			$form = form;
			$storedProp = {};
			if(obj.variable) $variable = obj.variable;
			createGUI(obj);
		}
	}
}