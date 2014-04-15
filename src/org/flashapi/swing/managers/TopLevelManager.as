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
	// TopLevelManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 30/11/2009 10:16
	* @see http://www.flashapi.org/
	*/

	import flash.events.EventDispatcher;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.util.ArrayList;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>TopLevelManager</code> class is used by the SPAS 3.0 core API
	 * 	to manage z-indexes of dynamic top-level objects, such as drop-down lists.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TopLevelManager extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>TopLevelManager</code> instance.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException 
		 * 	 			A <code>SingletonException</code> if you try to instanciate 
		 * 				the <code>TopLevelManager</code> class.
		 */
		public function TopLevelManager() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		public function finalize():void {
			_objList.finalize();
			_objList = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function getInstance():TopLevelManager {
			_constructorAccess = false;
			return new TopLevelManager();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function addObject(uio:UIObject):void {
			_objList.add(uio);
			uio.setToTopLevel();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function removeObject(uio:UIObject):void {
			_objList.remove(uio);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function setNewPosition():void {
			/*if(_objList.size > 0) {
				var mc:MainContainer = UIManager.mainContainer;
				var s:Stage =  UIManager.stage;
				var xPos:Number = s.stageWidth - mc.stageWidth;
				var yPos:Number = s.stageHeight - mc.stageHeight;
				var it:Iterator = _objList.iterator;
				while(it.hasNext()) {
					var uio:* = it.next();
					uio.x += xPos;
					uio.y += yPos;
				}
				it.reset();
			}*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _objList:ArrayList;
		
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
			_objList = new ArrayList();
			_instanciable = false;
			_constructorAccess = true;
		}
	}
}