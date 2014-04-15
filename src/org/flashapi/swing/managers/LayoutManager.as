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
	// LayoutManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 22/02/2010 23:29
	* @see http://www.flashapi.org/
	*/
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	import flash.events.EventDispatcher;
	import org.flashapi.swing.containers.IMainContainer;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.event.ContainerEvent;
	import org.flashapi.swing.event.LayoutEvent;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.swing.util.ArrayList;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>LayoutManager</code> singleton defines the object which is responsible
	 * 	for laying out all <code>UIObjects</code> within the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.UIManager#layoutManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LayoutManager extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>LayoutManager</code> instance.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException
		 * 	A <code>SingletonException</code> if you try create a new
		 * 	<code>LayoutManager</code> object.
		 */
		public function LayoutManager() { 
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _updateInProgress:Boolean = false;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether a layout operation
		 * 	is performing (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get updateInProgress():Boolean {
			return _updateInProgress;
		}
		
		private var _currentUIC:UIContainer = null;
		/**
		 * 	Returns the <code>UIContainer</code> that is currently laid out, while a
		 * 	layout operation is performing, <code>null</code> otherwise.
		 * 
		 * 	@default null
		 */
		public function get currentTarget():UIContainer {
			return _currentUIC;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_stack.finalize();
			_stack = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var invalidateListUpdate:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function getInstance():LayoutManager {
			_constructorAccess = false;
			return new LayoutManager();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function addToQueue(uic:UIContainer):void {
			if(uic.layout != null && !(uic.layout is AbsoluteLayout) && !_stack.contains(uic)) _stack.add(uic);
			if(!_updateInProgress && _stack.size > 0 && !invalidateListUpdate) _updateInProgress = true, updateList();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function updateList(e:LayoutEvent = null):void {
			if (_currentUIC != null && !(_currentUIC is IMainContainer)) {
				//_uiManager.print(_currentUIC);
				_currentUIC.layout.removeEventListener(LayoutEvent.LAYOUT_FINISHED, updateList);
				_currentUIC.dispatchEvent(new ContainerEvent(ContainerEvent.LAYOUT_UPDATED));
				_currentUIC = null;
			}
			if(invalidateListUpdate) {
				_updateInProgress = false;
				_currentUIC = null;
				return;
			}
			if (_stack.size > 0 ) {
				_currentUIC = _stack.get(0) as UIContainer;
				if(_currentUIC is IMainContainer) {
					_stack.remove(_currentUIC);
					updateList();
				} else {
					//_uiManager.print('called');
					_currentUIC.layout.addEventListener(LayoutEvent.LAYOUT_FINISHED, updateList);
					_stack.remove(_currentUIC);
					_currentUIC.spas_internal::updateLayout();
					//trace(_currentUIC);
				}
			} else {
				//_uiManager.print("Main Container called");
				if(_uiManager.mainContainer) _uiManager.mainContainer.spas_internal::updateLayout();
				_updateInProgress = false;
				_currentUIC = null;
				this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_MANAGER_PROCESS_FINISHED));
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:ArrayList;
		private var _uiManager:*;
		
		//---> Singleton management:
		private static var _instanciable:Boolean = true;
		private static var _constructorAccess:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (!_instanciable) {
				throw new SingletonException(Locale.spas_internal::ERRORS.LAYOUT_MANAGER_SINGLETON_ERROR);
			}
			_stack = new ArrayList();
			_uiManager = UIDescriptor.getUIManager();
			_instanciable = false;
			_constructorAccess = true;
		}
	}
}