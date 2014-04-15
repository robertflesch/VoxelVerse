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

package org.flashapi.swing.databinding {
	
	// -----------------------------------------------------------
	//  DataProvider.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.2, 05/06/2009 15:58
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import org.flashapi.swing.util.ArrayList;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 	The <code>DataProvider</code> class help developers to simplify data management
	 * 	for <code>Listable</code> objects, by creating <code>Collection</code> of objects
	 * 	that are internally treated by <code>Listable</code> instances.
	 * 
	 * 	@see org.flashapi.swing.list.Listable
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataProvider extends EventDispatcher implements DataProviderObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DataProvider</code> instance.
		 */
		public function DataProvider() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get iterator():Iterator {
			return _stack.iterator;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get length():int {
			return _stack.size;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function add(value:Object):void {
			_stack.add(value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addAll(... rest):void{
			for(var i:int = 0; i < rest.length; i++) _stack.add(rest[i]);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addCommonProperty(property:String, value:*):void {
			_commonProp[property] = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function applyCommonProperties(obj:*):void {
			var key:Object;
			for(key in _commonProp) obj[key] = _commonProp[key];
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function toArray():Array {
			return _stack.toArray();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function remove(value:Object):void {
			_stack.remove(value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function removeAll(... rest):void { }
		
		/**
		 * 	@inheritDoc
		 */
		public function reset():void {
			deleteDictObj();
			_stack.clear();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_stack.finalize();
			_stack = null;
			deleteDictObj();
			_commonProp = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function cloneArrayList():ArrayList {
			return new ArrayList(_stack);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:ArrayList;
		private var _commonProp:Dictionary;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_stack = new ArrayList();
			_commonProp = new Dictionary();
		}
		
		private function deleteDictObj():void {
			var key:Object;
			for (key in _commonProp) {
				_commonProp[key] = null;
				delete _commonProp[key];
			}
		}
	}
}