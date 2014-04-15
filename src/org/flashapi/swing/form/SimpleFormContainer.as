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
	// SimpleFormContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 18/10/2010 16:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.FormItemType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.form.formutil.FormButtonUtil;
	import org.flashapi.swing.form.formutil.FormDivUtil;
	import org.flashapi.swing.form.formutil.FormHiddenUtil;
	import org.flashapi.swing.form.formutil.FormInputUtil;
	import org.flashapi.swing.form.formutil.FormResetUtil;
	import org.flashapi.swing.form.formutil.FormSeparatorUtil;
	import org.flashapi.swing.form.formutil.FormSubmitUtil;
	import org.flashapi.swing.form.formutil.FormTextAreaUtil;
	import org.flashapi.swing.form.formutil.FormTitleUtil;
	import org.flashapi.swing.util.Observer;

	use namespace spas_internal;
	
	/**
	 * 	The <code>SimpleFormContainer</code> class is the base class for creating 
	 * 	<code>FormItemContainer</code> used to manage items displayed within a
	 * 	<code>SimpleForm</code> instance.
	 * 
	 * 	@see org.flashapi.swing.SimpleForm
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleFormContainer extends AbstractFormContainer implements Observer, FormItemContainer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a <code>SimpleFormContainer</code> object with the
		 * 	specified parameters.
		 * 
		 * @param	form	The form where item objects are created and displayed in.
		 * @param	obj		An object that contains all properties for creating item 
		 * 					objects associated displayed within the specified form. 
		 * 					This object is the <code>value</code> parameter of the
		 * 					form <code>addItem()</code> method.
		 */
		public function SimpleFormContainer(form:FormObject, obj:Object) {
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
				case FormItemType.HIDDEN :
					v = $item.value;
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
					break;
				case FormItemType.RESET :
				case FormItemType.SUBMIT :	
				case FormItemType.BUTTON :
					$item.lockLaf(fLaf.getButtonLaf(), true);
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
			$verticalBaseLine = $labelItem != null ? $labelItem.width + ($form as UIObject).horizontalGap : 0;
			$height = spas_internal::uioSprite.getBounds(null).height;
		}
	}
}