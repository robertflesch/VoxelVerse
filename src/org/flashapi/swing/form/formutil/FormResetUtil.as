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

package org.flashapi.swing.form.formutil {
	
	// -----------------------------------------------------------
	// FormResetUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/01/2009 01:07
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Button;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.form.FormItemContainer;
	import org.flashapi.swing.framework.locale.Locale;

	use namespace spas_internal;

	/**
	 * 	The <code>FormResetUtil</code> class is a fabric object that is used by
	 * 	SPAS 3.0 forms to create reset button items within a <code>FormItemContainer</code>
	 * 	instance.
	 * 
	 * 	@see org.flashapi.swing.form.FormItemContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormResetUtil extends FormUtilBase implements FormUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>FormResetUtil</code> object for the
		 * 				specified <code>FormItemContainer</code>.
		 *
		 * 	@param	fic	The <code>FormItemContainer</code> used to hold the reset
		 * 				button item.
		 */
		public function FormResetUtil(fic:FormItemContainer) {
			super(fic);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function createFormItem(obj:Object):void {
			var l:String = !isNull(obj.label) ? obj.label : Locale.spas_internal::LABELS.RESET_BUTTON_LABEL;;
			var item:Button = new Button(l);
			item.spas_internal::setSelector("reset");
			($fic as IUIObject).eventCollector.addEvent(item, UIMouseEvent.CLICK, resetForm);
			createItems(obj, item);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function resetForm(e:UIMouseEvent):void {
			var f:* = $fic.form;
			f.spas_internal::resetForm();
		}
	}
}