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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// FocusManager.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/01/2010 21:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.FocusEvent;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	The <code>FocusManager</code> singleton defines the object which is responsible
	 * 	for focusing on <code>UIObjects</code> within the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.UIManager#focusManager
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FocusManager {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>FocusManager</code> instance.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException 
		 * 	 			A <code>SingletonException</code> if you try to instanciate 
		 * 				the <code>FocusManager</code> class.
		 */
		public function FocusManager() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>UIObject</code> which currently get the focus within
		 * 	a SPAS 3.0 application. If no <code>UIObject</code> has the focus when
		 * 	called, returns <code>null</code>.
		 * 
		 * 	@return	The <code>UIObject</code> which currently get the focus;
		 * 			<code>null</code> if no <code>UIObject</code> has the focus.
		 * 
		 * 	@default null
		 */
		public function getFocus():UIObject {
			return _focused;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function getInstance():FocusManager {
			_constructorAccess = false;
			return new FocusManager();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function setFocus(uio:UIObject):void {
			if (_focused != null) {
				_focused.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
			}
			_focused = uio;
			if (_focused != null) {
				_focused.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//---> Singleton management:
		private static var _instanciable:Boolean = true;
		private static var _constructorAccess:Boolean = true;
		
		private var _focused:UIObject = null;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (!_instanciable) {
				throw new SingletonException(Locale.spas_internal::ERRORS.FOCUS_MANAGER_SINGLETON_ERROR);
			}
			_instanciable = false;
			_constructorAccess = true;
		}
	}
}