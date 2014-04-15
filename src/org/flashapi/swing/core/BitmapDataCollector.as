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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// BitmapDataCollector.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/06/2008 09:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	
	/**
	 * 	The <code>BitmapDataCollector</code> class is a utility class that create
	 * 	objects which are able to collect and easily manage <code>BitmapData</code>
	 * 	objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BitmapDataCollector {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BitmapDataCollector</code> instance and
		 * 	adds a collection or a series of <code>BitmapData</code> objects to it. 
		 * 
		 * 	@param	... rest	A collection or a series of <code>BitmapData</code> 
		 * 						objects to add to this <code>BitmapDataCollector</code>.
		 * 						<code>BitmapData</code> objects can be added separately,
		 * 						or as an <code>Array</code> that represents a collection
		 * 						of <code>BitmapData</code> objects.
		 */
		public function BitmapDataCollector(... rest) {
			super();
			initObj(rest);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a <code>BitmapData</code> object to this <code>BitmapDataCollector</code>
		 * 	instance.
		 * 
		 * 	@param	bitmap	The <code>BitmapData</code> object to add.
		 */
		public function add(bitmap:BitmapData):void {
			_stack.push(bitmap);
		}
		
		/**
		 * 	Removes the specified <code>BitmapData</code> object from this <code>BitmapDataCollector</code>
		 * 	instance and frees memory that is used to store the removed <code>BitmapData</code>
		 * 	object.
		 * 
		 * 	@param	bitmap The <code>BitmapData</code> object to remove.
		 * 
		 * 	@see #remove()
		 */
		public function dispose(bitmap:BitmapData):void {
			deleteBitmap(bitmap).dispose();
		}
		
		/**
		 * 	Removes all <code>BitmapData</code> objects from this <code>BitmapDataCollector</code>
		 * 	instance and frees memory that is used to store all removed <code>BitmapData</code>
		 * 	objects.
		 * 
		 * 	@see #removeAll()
		 */
		public function disposeAll():void {
			var i:int = _stack.length - 1;
			for (; i >= 0; i--) {
				_stack[i].dispose();
				_stack.pop();
			}
		}
		
		/**
		 * 	Removes the specified <code>BitmapData</code> object from this
		 * 	<code>BitmapDataCollector</code>. This method does not free memory that
		 * 	is used to store the removed <code>BitmapData</code> object.
		 * 
		 * 	@param	bitmap	The <code>BitmapData</code> object to remove.
		 * 
		 * 	@see #dispose()
		 */
		public function remove(bitmap:BitmapData):void {
			deleteBitmap(bitmap);
		}
		
		/**
		 * 	Removes all <code>BitmapData</code> objects from this <code>BitmapDataCollector</code>.
		 * 	This method does not free memory that is used to store removed
		 * 	<code>BitmapData</code> objects.
		 * 
		 * 	@see #disposeAll()
		 */
		public function removeAll():void {
			_stack = [];
		}
		
		/**
		 * 	@copy org.flashapi.swing.core.Finalizable#finalize()
		 */
		public function finalize():void {
			this.disposeAll();
			_stack = [];
			_stack = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:Array = [];
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(rest:Array):void {
			var l:uint = rest.length;
			var i:uint = 0;
			if (l == 1 && rest[0] is Array) {
				l = rest[0].length;
				for (; i < l; ++i) add(rest[0][i]);
			} else {
				for (; i < l; ++i) add(rest[i]);
			}
		}
		
		private function deleteBitmap(bitmap:BitmapData):BitmapData {
			var i:int = _stack.length - 1;
			for (; i >= 0; --i) {
				if (_stack[i] == bitmap) return _stack.splice(i, 1);
			}
			return null;
		}
	}
}