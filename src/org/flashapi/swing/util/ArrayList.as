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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// ArrayList.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.6, 21/11/2010 19:20
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ArrayList</code> class is a resizable-array implementation of the
	 * 	<code>List</code> interface. It implements all optional list operations,
	 * 	and permits all elements<span class="hide">, including <code>null</code></span>.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ArrayList extends EventDispatcher implements List, Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ArrayList</code> instance with the
		 * 	specified parameter.
		 * 
		 * 	@param	list
		 */
		public function ArrayList(list:List = null) {
			super();
			initObj(list);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get size():int {
			return $stack.length;
		}
		
		private var _iterator:ListIterator;
		/**
		 * 	@inheritDoc
		 */
		public function get iterator():Iterator {
			return _iterator;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function addAll(c:Collection):int  {
			$stack = $stack.concat(c.toArray());
			return $stack.length;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function containsAll(c:Collection):Boolean {
			var arr:Array = c.toArray();
			var l:int = arr.length - 1;
			for (; l >= 0; l--) {
				if ($stack.indexOf(arr[l]) == -1) return false;
			}
			return true;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function subList(fromIndex:int, toIndex:int):List {
			var list:ArrayList = new ArrayList();
			for (; fromIndex <= toIndex-1; ++fromIndex) {
				list.add($stack[fromIndex]);
			}
			return list as List;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function contains(obj:Object):Boolean { 
			return $stack.indexOf(obj)==-1 ? false : true;
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 	//@inheritDoc
		 */
		public function retainAll(c:Collection):Boolean {
			return false;
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 	//@inheritDoc
		 */
		public function removeAll(c:Collection):Boolean {
			return false;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function add(obj:Object):int  {
			return $stack.push(obj);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addAt(obj:Object, index:int):void {
      		RangeChecker.check(index, $stack.length);
      		$stack.splice(index, 0, obj);
		}
		
		/*public function lastIndexOf(obj:Object):int {
			return $stack.lastIndexOf(obj);
		}*/
		
		/**
		 * 	@inheritDoc
		 */
		public function isEmpty():Boolean {
			return $stack.length > 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get(index:uint):Object {
			RangeChecker.check(index, $stack.length);
			return $stack[index];
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function indexOf(obj:Object):int {
			return $stack.indexOf(obj);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function clear():void {
			$evtColl.removeAllEvents();
			$stack = [];
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			if(_iterator != null) {
				_iterator.finalize();
				_iterator = null;
			}
			$evtColl.finalize();
			$stack = [];
			$evtColl = null;
		}
		
		/**
		 * 	Finalizes all objects contained within this <code>ArrayList</code>.
		 * 	You must set all finalized element to <code>null</code> to make them
		 * 	eligible for garbage collection.
		 * 
		 * 	@see #finalize()
		 */
		public function finalizeAll():void {
			var l:int = $stack.length - 1;
			$evtColl.removeAllEvents();
			for (; l >= 0; l--) {
				if ($stack[l] is Finalizable) $stack[l].finalize();
				$stack[l] = null;
			}
			clear();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function remove(obj:Object):Boolean {
			var id:int = indexOf(obj);
			if (id == -1) return false;
			else {
				if ($evtColl.objectIsRegistered(obj)) $evtColl.removeObjectEvents(obj);
				$stack.splice(id, 1);
			}
			return true;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function swap(index1:int, index2:int):void {
			ArrayUtil.swapValuesAt($stack, index1, index2);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function removeAt(index:uint):Object {
			RangeChecker.check(index, $stack.length);
			var obj:Object = $stack[index];
			if ($evtColl.objectIsRegistered(obj)) $evtColl.removeObjectEvents(obj);
			$stack.splice(index, 1);
			return obj;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set(obj:Object, index:uint):Object {
			RangeChecker.check(index, $stack.length);
			var old:Object = $stack[index];
			$stack[index] = obj;
			return old;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function toArray():Array {
			return $stack.slice();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>EventCollector</code> instance
		 * 	for this <code>ArrayList</code> object.
		 */
		protected var $evtColl:EventCollector;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The internal <code>Array</code> instance that contains the collection of
		 * 	items stored within for this <code>ArrayList</code> instance.
		 */
		protected var $stack:Array;
		
		/**
		 * 	@private
		 */
		spas_internal function getStack():Array {
			return $stack;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function setStack(stack:Array):void {
			$stack = stack;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private function initObj(list:List):void {
			$evtColl = new EventCollector();
			$stack = [];
			if(list != null) $stack = list.toArray().slice();
			_iterator = new ListIterator(this);
		}
	}
}