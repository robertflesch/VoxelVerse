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
	// FormTextUtilBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/01/2009 22:49
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.FormItemType;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.form.FormItemContainer;
	
	use namespace spas_internal;

	/**
	 * 	The <code>FormTextUtilBase</code> class is the base class fo all text form
	 * 	fabric objects.
	 * 
	 * 	@see org.flashapi.swing.form.formutil.FormUtil
	 * 	@see org.flashapi.swing.form.FormItemContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormTextUtilBase extends FormUtilBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>FormTextUtilBase</code> object for the
		 * 				specified <code>FormItemContainer</code>.
		 *
		 * 	@param	fic	The <code>FormItemContainer</code> used to hold a specific
		 * 				text form item.
		 */
		public function FormTextUtilBase(fic:FormItemContainer) {
			super(fic);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function focusOutHandler(e:TextEvent):void {
			var flag:Boolean = $fic.isValid;
			if (!flag) {
				var item:* = $fic.formItem;
				$fic.isValid = $fic.validator.validate(item.label);
				var prop:Object = $fic.storedProp;
				if (flag) {
					switch($fic.type) {
						case FormItemType.TEXTAREA :
							break;
						case FormItemType.INPUT : 
						case FormItemType.PASSWORD :
							if (prop.borderColor) {
								item.borderColor = prop.borderColor;
								item.focusColor = prop.focusColor;
							}
							$fic.storedProp = { };
							break;
					}
				}
			}
		}
		
		/**
		 * 	@private
		 */
		protected function rollOverHandler(e:UIMouseEvent):void {
			if (!$fic.isValid) {
				var f:* = $fic.form;
				f.spas_internal::displayErrorMessage($fic.validator.message, $fic as Canvas);
			}
		}
		
		/**
		 * 	@private
		 */
		protected function rollOutHandler(e:UIMouseEvent):void {
			var f:* = $fic.form;
			f.spas_internal::removeErrorMessage();
		}
		
		/**
		 * 	@private
		 */
		protected function addTextHandlers(item:IEventDispatcher):void {
			var ec:EventCollector = ($fic as IUIObject).eventCollector;
			ec.addEvent(item, UIMouseEvent.ROLL_OVER, rollOverHandler);
			ec.addEvent(item, UIMouseEvent.ROLL_OUT, rollOutHandler);
			ec.addEvent(item, UIMouseEvent.PRESS, rollOutHandler);
			ec.addEvent(item, TextEvent.TEXT_FOCUS_OUT, focusOutHandler);
		}
	}
}