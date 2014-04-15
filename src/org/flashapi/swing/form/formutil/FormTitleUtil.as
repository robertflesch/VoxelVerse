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
	// FormTitleUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/01/2009 19:00
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.form.FormItemContainer;
	import org.flashapi.swing.Label;

	/**
	 * 	The <code>FormTitleUtil</code> class is a fabric object that is used by
	 * 	SPAS 3.0 forms to create title form items within a <code>FormItemContainer</code>
	 * 	instance.
	 * 
	 * 	@see org.flashapi.swing.form.FormItemContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FormTitleUtil extends FormUtilBase implements FormUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>FormTitleUtil</code> object for the
		 * 				specified <code>FormItemContainer</code>.
		 *
		 * 	@param	fic	The <code>FormItemContainer</code> used to hold the title
		 * 				form item.
		 */
		public function FormTitleUtil(fic:FormItemContainer) {
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
			var l:String = !isNull(obj.label) ? obj.label : "";
			var item:Label = new Label(l);
			obj.label = null;
			item.boldFace = true;
			createItems(obj, item);
		}
	}
}