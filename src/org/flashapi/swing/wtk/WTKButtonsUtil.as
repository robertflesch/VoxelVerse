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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// WTKButtonsUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/11/2009 09:33
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.plaf.libs.WindowUIRef;
	
	/**
	 * 	The <code>WTKButtonsUtil</code> class is a utility class that defines all-static
	 * 	methods for adding localization support to <code>WTK</code> and <code>UIWindow</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.wtk.WTK
	 * 	@see org.flashapi.swing.wtk.UIWindow
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class WTKButtonsUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				WTKButtonsUtil instance.
		 */
		public function WTKButtonsUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>setButtonsLang</code> method allows to change alternate text 
		 * 	values for all <code>WTK</code> and <code>UIWindow</code> objects. This
		 * 	method is useful for easilly implementing localization support to SPAS 3.0
		 * 	window objects.
		 * 
		 * 	@param	close		The alternate text for all window closing buttons.
		 * 	@param	minimize	The alternate text for all window minimizing buttons.
		 * 	@param	maximize	The alternate text for all window maximizing buttons.
		 * 	@param	retore		The alternate text for all window retoring buttons.
		 */
		public static function setButtonsLang(close:String, minimize:String, maximize:String, retore:String):void {
			var buffer:Array = WindowUIRef.lafList.getObservers();
			var item:*;
			for each(item in buffer) {
				item.closeButtonAlt = close;
				if (item is UIWindow) {
					item.minimizeAlt = minimize;
					item.maximizeAlt = maximize;
					item.retoreAlt = retore;
				}
			}
			buffer = [];
			buffer = null;
		}
	}
}