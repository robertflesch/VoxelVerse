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
	// FormRadioGroupUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/01/2009 00:36
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.RadioButtonGroup;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.form.FormItemContainer;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.Spacer;

	use namespace spas_internal;

	/**
	 * 	The <code>FormRadioGroupUtil</code> class is a fabric object that is used by
	 * 	SPAS 3.0 forms to create radion button group items within a 
	 * 	<code>FormItemContainer</code> instance.
	 * 
	 * 	@see org.flashapi.swing.form.FormItemContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormRadioGroupUtil extends FormUtilBase implements FormUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>FormRadioGroupUtil</code> object for the
		 * 				specified <code>FormItemContainer</code>.
		 *
		 * 	@param	fic	The <code>FormItemContainer</code> used to hold the radion button
		 * 				group item.
		 */
		public function FormRadioGroupUtil(fic:FormItemContainer) {
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
			var c:Canvas = new Canvas();
			c.autoSize = true;
			var lab:Label;
			var spc:Spacer;
			var absFic:* = $fic;
			c.layout.orientation = !isNull(obj.orientation) ? obj.orientation : LayoutOrientation.VERTICAL;
			var item:RadioButtonGroup = new RadioButtonGroup(c);
			absFic.eventCollector.addEvent(item, DataBindingEvent.DATA_PROVIDER_FINISHED,
				absFic.spas_internal::redrawForm);
			setItemProperties(obj, item);
			if(!isNull(obj.label)) {
				lab = new Label(obj.label);
				lab.spas_internal::setSelector(Selectors.FORM_LABEL);
				absFic.spas_internal::setLabelItem(lab);
				spc = new Spacer(($fic.form as IUIObject).horizontalGap, 5);
			}
			if(!isNull(lab)) absFic.addGraphicElements(lab, spc, c);
			else absFic.addElement(c);
			absFic.spas_internal::setFormItem(item);
			if (obj.dataProvider) item.dataProvider = obj.dataProvider;
		}
	}
}