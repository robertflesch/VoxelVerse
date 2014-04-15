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
	// FormUtilBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/01/2009 16:31
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.FormItemType;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.form.FormItemContainer;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.Spacer;

	use namespace spas_internal;
	
	/**
	 * 	The <code>FormUtilBase</code> class is the base class fo all
	 * 	<code>FormUtil</code> objects.
	 * 
	 * 	@see org.flashapi.swing.form.formutil.FormUtil
	 * 	@see org.flashapi.swing.form.FormItemContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormUtilBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>FormUtilBase</code> object for the
		 * 				specified <code>FormItemContainer</code>.
		 *
		 * 	@param	fic	The <code>FormItemContainer</code> used to hold a specific
		 * 				form item.
		 */
		public function FormUtilBase(fic:FormItemContainer) {
			super();
			initObj(fic);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>FormItemContainer</code> associated with this <code>FormUtilBase</code>
		 * 	object.
		 */
		protected var $fic:FormItemContainer;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function createItems(obj:Object, item:*):void {
			var lab:Label;
			var spc:Spacer;
			var absFic:* = $fic;
			setItemProperties(obj, item);
			if(!isNull(obj.label)) {
				lab = new Label(obj.label);
				lab.spas_internal::setSelector(Selectors.FORM_LABEL);
				absFic.spas_internal::setLabelItem(lab);
				spc = new Spacer(($fic.form as IUIObject).horizontalGap, 5);
			}
			absFic.spas_internal::setFormItem(item);
			if (obj.type == FormItemType.SUBMIT || obj.type == FormItemType.RESET) {
				var f:* = $fic.form;
				f.spas_internal::getButtonsContainer().addElement(item);
				return;
			}
			if(!isNull(lab)) absFic.addGraphicElements(lab, spc, item);
			else absFic.addElement(item);
		}
		
		
		/**
		 * 	@private
		 */
		protected function setItemProperties(obj:Object, item:*):void {
			var absFic:* = $fic;
			var tpe:String = obj.type;
			absFic.spas_internal::setType(tpe);
			item.spas_internal::setType(tpe);
			if (obj.name) absFic.name = obj.name;
			if (obj.validator) $fic.validator = obj.validator;
			if (obj.className) item.className = obj.className;
			if (obj.data) item.data = obj.data;
			if (!isNaN(obj.width)) item.width = obj.width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(fic:FormItemContainer):void {
			$fic = fic;
		}
	}
}