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
	// KeyboardManager.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/02/2011 16:16
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.flashapi.swing.core.KeyObserver;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 	[This class is under development.]
	 * 
	 * 	The <code>KeyboardManager</code> singleton defines the object which is responsible
	 * 	for delegation of keyboard events to <code>KeyObserver</code> objects within
	 * 	the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.UIManager#keyboardManager
	 * 	@see org.flashapi.swing.core.KeyObserver
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class KeyboardManager {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>KeyboardManager</code> instance.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException 
		 * 	 			A <code>SingletonException</code> if you try to instanciate 
		 * 				the <code>KeyboardManager</code> class.
		 */
		public function KeyboardManager() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>KeyObserver</code> object which is currently registred 
		 * 	within the <code>KeyboardManager</code> singleton. If no <code>KeyObserver</code>
		 * 	object is registred within the <code>KeyboardManager</code> singleton,
		 * 	returns <code>null</code>.
		 * 
		 * 	@return	The <code>KeyObserver</code> object which is currently registred
		 * 			within the <code>KeyboardManager</code> singleton; <code>null</code>
		 * 			otherwise.
		 * 
		 * 	@default null
		 * 
		 * 	@see #deleteKeyObserver()
		 * 	@see #setKeyObserver()
		 */
		public function getKeyObserver():KeyObserver {
			return _observer;
		}
		
		/**
		 * 	Specifies that the <code>KeyObserver</code> object passed as <code>obj</code>
		 * 	parameter becomes the new active <code>KeyObserver</code> instance. If
		 * 	<code>null</code>, the value returned by the <code>setKeyObserver()</code>
		 * 	method will be <code>null</code>.
		 * 
		 * 	@param	obj	The new<code>KeyObserver</code> object to be managed by the
		 * 				<code>KeyboardManager</code> singleton.
		 * 
		 * 	@see #deleteKeyObserver()
		 * 	@see #getKeyObserver()
		 */
		public function setKeyObserver(obj:KeyObserver):void {
			/*if (_observer != null) {
				_observer.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
			}*/
			_observer = obj;
			/*if (_observer != null) {
				_observer.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
			}*/
		}
		
		/**
		 * 	Removes the <code>KeyObserver</code> object specified by the <code>obj</code>
		 * 	parameter from the <code>KeyboardManager</code> singleton if it is
		 * 	the current <code>KeyObserver</code> object; do nothing otherwise.
		 * 
		 * 	@param	obj	The new<code>KeyObserver</code> object to be removed from the
		 * 				<code>KeyboardManager</code> singleton.
		 * 
		 * 	@see #getKeyObserver()
		 * 	@see #setKeyObserver()
		 */
		public function deleteKeyObserver(obj:KeyObserver):void {
			if (_observer == null) return;
			if (_observer == obj) _observer = null;
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the CONTROL
		 * 	key is pressed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@return	<code>true</code> if the CONTROL key is pressed; <code>false</code>
		 * 			otherwise.
		 */
		public function isControlPressed():Boolean {
			return _isCtrlPressed;
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the SHIFT
		 * 	key is pressed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@return	<code>true</code> if the SHIFT key is pressed; <code>false</code>
		 * 			otherwise.
		 */
		public function isShiftPressed():Boolean {
			return _isShiftPressed;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function getInstance():KeyboardManager {
			_constructorAccess = false;
			return new KeyboardManager();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function delegateKeyUpEvent(e:KeyboardEvent):void {
			//UIManager.print(e);
			switch(e.keyCode) {
				case Keyboard.CONTROL :
					_isCtrlPressed = false;
					break;
				case Keyboard.SHIFT :
					_isShiftPressed = false;
					break;
			}
			if (_observer != null) {
				_observer.notifyKeyUpEvent(e);
			}
		}
		
		private function delegateKeyDownEvent(e:KeyboardEvent):void {
			//UIManager.print(e);
			switch(e.keyCode) {
				case Keyboard.CONTROL :
					_isCtrlPressed = true;
					break;
				case Keyboard.SHIFT :
					_isShiftPressed = true;
					break;
			}
			if (_observer != null) {
				_observer.notifyKeyDownEvent(e);
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
		
		private var _observer:KeyObserver = null;
		private var _isCtrlPressed:Boolean = false;
		private var _isShiftPressed:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (!_instanciable) {
				throw new SingletonException(Locale.spas_internal::ERRORS.KEYBOARD_MANAGER_SINGLETON_ERROR);
			}
			_instanciable = false;
			_constructorAccess = true;
			var s:Stage = UIDescriptor.getUIManager().stage;
			s.addEventListener(KeyboardEvent.KEY_DOWN, delegateKeyDownEvent);
			s.addEventListener(KeyboardEvent.KEY_UP, delegateKeyUpEvent);
		}
	}
}