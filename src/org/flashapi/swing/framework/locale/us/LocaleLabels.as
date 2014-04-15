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

package org.flashapi.swing.framework.locale.us {
	
	// -----------------------------------------------------------
	// LocaleLabels.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/01/2011 00:00
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>LocaleLabels</code> class is an enumeration of constant values that
	 * 	are internally used by the SPAS 3.0 localization API to set the language of
	 * 	default label texts used by the SPAS 3.0 core API for some controls, such as
	 * 	buttons or listboxes.
	 * 
	 * 	<p><strong>Classes contained within the <code>org.flashapi.swing.framework.locale.us</code>
	 * 	package define SPAS 3.0 core localization for the English US language.</strong>
	 * 	</p>
	 * 
	 * 	@see org.flashapi.swing.framework.locale.Locale
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class LocaleLabels extends LocaleLang {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				LocaleLabels instance.
		 */
		public function LocaleLabels() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The title text label for the debug panel component.
		 * 
		 * 	@see org.flashapi.swing.framework.DebugPanel
		 */
		public static const DEBUG_PANEL_TITLE:String = "SPAS 3.0 Debug Panel";
		
		/**
		 * 	The title text label for the monitor panel component.
		 * 
		 * 	@see org.flashapi.swing.framework.MonitorPanel
		 */
		public static const MONITOR_PANEL_TITLE:String = "SPAS 3.0 Monitor Panel";
		
		/**
		 * 	The text label for the clear option of the debug panel component.
		 * 
		 * 	@see org.flashapi.swing.framework.DebugPanel
		 */
		public static const CLEAR_DEBUG_PANEL:String = "Clear panel";
		
		/**
		 * 	The default text label for the <code>AccordionHeader</code> class.
		 * 
		 * 	@see org.flashapi.swing.button.AccordionHeader
		 */
		public static const ACCORDION_HEADER_LABEL:String = "Label";
		
		/**
		 * 	The default text label for the <code>MenuButton</code> class.
		 * 
		 * 	@see org.flashapi.swing.button.MenuButton
		 */
		public static const MENU_BUTTON_LABEL:String = "Button";
		
		/**
		 * 	The default text label for the <code>SelectableItem</code> class.
		 * 
		 * 	@see org.flashapi.swing.button.SelectableItem
		 */
		public static const SELECTABLE_ITEM_LABEL:String = "Selectable Item";
		
		/**
		 * 	The default text label for the <code>TabButton</code> class.
		 * 
		 * 	@see org.flashapi.swing.button.TabButton
		 */
		public static const TAB_BUTTON_LABEL:String = "Tab";
		
		/**
		 * 	The text label for the submit component of a form object.
		 * 
		 * 	@see org.flashapi.swing.form.formutil.FormSubmitUtil
		 */
		public static const SUBMIT_BUTTON_LABEL:String = "Submit";
		
		/**
		 * 	The text label for the reset component of a form object.
		 * 
		 * 	@see org.flashapi.swing.form.formutil.FormResetUtil
		 */
		public static const RESET_BUTTON_LABEL:String = "Reset";
		
		/**
		 * 	The text label for the red component of a RGB color.
		 * 
		 * 	@see org.flashapi.swing.color.RGB
		 */
		public static const RED_LABEL:String = "Red";
		
		/**
		 * 	The text label for the blue component of a RGB color.
		 * 
		 * 	@see org.flashapi.swing.color.RGB
		 */
		public static const BLUE_LABEL:String = "Blue";
		
		/**
		 * 	The text label for the green component of a RGB color.
		 * 
		 * 	@see org.flashapi.swing.color.RGB
		 */
		public static const GREEN_LABEL:String = "Green";
		
		/**
		 * 	The text label for the alpha component of a ARGB color.
		 * 
		 * 	@see org.flashapi.swing.color.RGB
		 */
		public static const ALPHA_LABEL:String = "Alpha";
		
		/**
		 * 	The default text label for the <code>Button</code> class.
		 * 
		 * 	@see org.flashapi.swing.Button
		 */
		public static const BUTTON_LABEL:String = "Label";
		
		/**
		 * 	The default text label for the <code>CheckBox</code> class.
		 * 
		 * 	@see org.flashapi.swing.CheckBox
		 */
		public static const CHECKBOX_LABEL:String = "Checkbox";
		
		/**
		 * 	The default text label for the <code>LinkButton</code> class.
		 * 
		 * 	@see org.flashapi.swing.LinkButton
		 */
		public static const LINK_BUTTON_LABEL:String = "LinkButton";
		
		/**
		 * 	The default text label for the <code>RadioButton</code> class.
		 * 
		 * 	@see org.flashapi.swing.RadioButton
		 */
		public static const RADIO_BUTTON_LABEL:String = "Radio button";
	}
}