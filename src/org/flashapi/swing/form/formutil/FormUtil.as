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
	// FormUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/01/2009 16:25
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	Tipically the <code>FormUtil</code> interface is implemented by fabric 
	 * 	objects that create form item objects for a specified <code>FormItemContainer</code>
	 * 	instance.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface FormUtil {
		
		/**
		 * 	The <code>FormUtil</code> method is used by the <code>FormUtil</code>
		 * 	instance to create a specific form item. The newly created item
		 * 	is defined by using propeties passed in the <code>obj</code>
		 * 	parameter.
		 * 
		 * 	@param	obj	An object that contains the properties used to
		 * 				define and create a new form item.
		 */
		function createFormItem(obj:Object):void;
	}
}