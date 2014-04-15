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
	// ExtendedFormContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 21:34
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.FormItemType;
	import org.flashapi.swing.constants.FormLabelPosition;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.form.formutil.FormButtonUtil;
	import org.flashapi.swing.form.formutil.FormComboBoxUtil;
	import org.flashapi.swing.form.formutil.FormDateUtil;
	import org.flashapi.swing.form.formutil.FormDivUtil;
	import org.flashapi.swing.form.formutil.FormHiddenUtil;
	import org.flashapi.swing.form.formutil.FormInputUtil;
	import org.flashapi.swing.form.formutil.FormListBoxUtil;
	import org.flashapi.swing.form.formutil.FormRadioGroupUtil;
	import org.flashapi.swing.form.formutil.FormResetUtil;
	import org.flashapi.swing.form.formutil.FormSeparatorUtil;
	import org.flashapi.swing.form.formutil.FormSpinnerUtil;
	import org.flashapi.swing.form.formutil.FormSubmitUtil;
	import org.flashapi.swing.form.formutil.FormTextAreaUtil;
	import org.flashapi.swing.form.formutil.FormTitleUtil;
	import org.flashapi.swing.RadioButton;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;

	use namespace spas_internal;
	
	/**
	 * 	The <code>ExtendedFormContainer</code> class is the base class for creating 
	 * 	<code>FormItemContainer</code> used to manage items displayed within a
	 * 	<code>Form</code> instance.
	 * 
	 * 	@see org.flashapi.swing.Form
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ExtendedFormContainer extends AbstractFormContainer implements Observer, FormItemContainer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a <code>ExtendedFormContainer</code> object with the
		 * 	specified parameters.
		 * 
		 * @param	form	The form where item objects are created and displayed in.
		 * @param	obj		An object that contains all properties for creating item 
		 * 					objects associated displayed within the specified form. 
		 * 					This object is the <code>value</code> parameter of the
		 * 					form <code>addItem()</code> method.
		 */
		public function ExtendedFormContainer(form:FormObject, obj:Object) {
			super(form, obj);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function get value():String {
			var v:* = null;
			switch($type) {
				case FormItemType.INPUT : 
				case FormItemType.PASSWORD : 	
				case FormItemType.TEXTAREA :
					v = $item.text;
					break;
				case FormItemType.COMBOBOX :
					break;
				case FormItemType.HIDDEN :
					v = $item.value;
					break;
				case FormItemType.SPINNER : 
				case FormItemType.RADIO_GROUP :
					v = ($item.data != null) ? String($item.data) : $item.value;
					break;
			}
			return v;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function reset():void {
			switch($type) {
				case FormItemType.INPUT : 
				case FormItemType.PASSWORD :
				case FormItemType.TEXTAREA :
					$item.text = "";
					if ($storedProp.borderColor) {
						$item.borderColor = $storedProp.borderColor;
						$item.focusColor = $storedProp.focusColor;
					}
					$storedProp = { };
					break;
				case FormItemType.DATE:
				case FormItemType.RADIO_GROUP :
					$item.reset();
					break;
				case FormItemType.COMBOBOX :
					$item.reset($defaultLabel);
					break;
			}
			$isValid = true;
			getNewMetrics();
		}
		
		/**
		 *  @private
		 */
		override public function changeFormItemLookAndFeel():void {
			var fLaf:Object = ($form as UIObject).lookAndFeel;
			if ($labelItem != null) $labelItem.lockLaf(fLaf.getLabelLaf(), true);
			switch($type) {
				case FormItemType.INPUT : 
				case FormItemType.PASSWORD :
					$item.lockLaf(fLaf.getTextInputLaf(), true);
					break;
				case FormItemType.TITLE :
					$item.lockLaf(fLaf.getLabelLaf(), true);
					break;
				case FormItemType.SEPARATOR :
					$item.lockLaf(fLaf.getSeparatorLaf(), true);
					break;
				case FormItemType.TEXTAREA :
					$item.lockLaf(fLaf.getTextAreaLaf(), true);
					break;
				case FormItemType.COMBOBOX :
					$item.lockLaf(fLaf.getComboBoxLaf(), true);
					break;
				case FormItemType.LIST :
					$item.lockLaf(fLaf.getListLaf(), true);
					break;
				case FormItemType.DATE :
					$item.lockLaf(fLaf.getDateFieldLaf(), true);
					break;
				case FormItemType.RESET :
				case FormItemType.SUBMIT :	
				case FormItemType.BUTTON :
					$item.lockLaf(fLaf.getButtonLaf(), true);
					break;
				case FormItemType.RADIO_GROUP :
					var it:Iterator = $item.iterator;
					while (it.hasNext()) {
						var rb:RadioButton = it.next() as RadioButton;
						rb.lockLaf(fLaf.getRadioButtonLaf(), true);
					}
					it.reset();
					break;
			}
			getNewMetrics();
		}
		
		/**
		 *  @private
		 */
		override public function displayInvalidItem():void {
			switch($type) {
				case FormItemType.INPUT : 
				case FormItemType.PASSWORD :
				case FormItemType.TEXTAREA :
					$storedProp.borderColor =  $item.borderColor;
					$storedProp.focusColor = $item.focusColor;
					$item.borderColor = $item.focusColor = 0xFF0000;
					break;
			}
			getNewMetrics();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function createGUI(obj:Object):void {
			switch(obj.type) {
				case FormItemType.INPUT : 
				case FormItemType.PASSWORD :
					new FormInputUtil(this).createFormItem(obj);
					break;
				case FormItemType.TITLE :
					new FormTitleUtil(this).createFormItem(obj);
					break;
				case FormItemType.SEPARATOR :
					new FormSeparatorUtil(this).createFormItem(obj);
					break;
				case FormItemType.TEXTAREA :
					new FormTextAreaUtil(this).createFormItem(obj);
					break;
				case FormItemType.COMBOBOX :
					new FormComboBoxUtil(this).createFormItem(obj);
					break;
				case FormItemType.LIST :
					new FormListBoxUtil(this).createFormItem(obj);
					break;
				case FormItemType.RESET :
					new FormResetUtil(this).createFormItem(obj);
					break;
				case FormItemType.SUBMIT :
					new FormSubmitUtil(this).createFormItem(obj);
					break;
				case FormItemType.BUTTON :
					new FormButtonUtil(this).createFormItem(obj);
					break;
				case FormItemType.DIV :
					new FormDivUtil(this).createFormItem(obj);
					break;
				case FormItemType.RADIO_GROUP :
					new FormRadioGroupUtil(this).createFormItem(obj);
					break;
				case FormItemType.DATE :
					new FormDateUtil(this).createFormItem(obj);
					break;
				case FormItemType.SPINNER :
					new FormSpinnerUtil(this).createFormItem(obj);
					break;
				case FormItemType.HIDDEN :
					new FormHiddenUtil(this).createFormItem(obj);
					break;
			}
			changeFormItemLookAndFeel();
		}
		
		/**
		 * 	@private
		 */
		override protected function getNewMetrics():void {
			if ($labelPosition == FormLabelPosition.TOP) $verticalBaseLine = 0;
			else if($labelPosition == FormLabelPosition.LEFT) {
				$verticalBaseLine = $labelItem != null ?
									$labelItem.width + ($form as UIObject).horizontalGap : 0;
			}
			$height = spas_internal::uioSprite.getBounds(null).height;
		}
	}
}