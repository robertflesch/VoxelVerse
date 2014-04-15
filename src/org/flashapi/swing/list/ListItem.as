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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// ListItem.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 31/05/2009 18:02
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.List;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ListItem</code> class is a wrapper around an object (item) in a
	 * 	list collection. It allows users to manage item-value-data group used within 
	 * 	<code>Listable</code> objects.
	 * 
	 * 	@see org.flashapi.swing.list.Listable
	 * 	@see org.flashapi.swing.util.List
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ListItem extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ListItem</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	item The object wrapped by this <code>ListItem</code> instance.
		 * 	@param	list 	The <code>List</code> collection that stores the object
		 * 					item specified by the <code>item</code> parameter.
		 * 	@param	value 	The value associated with the <code>item</code> parameter. 
		 * 					Default value is <code>null</code>.
		 * 	@param	data 	The data binded with the <code>item</code> parameter.
		 * 					Default value is <code>null</code>.
		 * 	@param	index 	The index position at where the <code>item</code> object
		 * 					is added into the <code>List</code> collection. If index
		 * 					is <code>-1</code>, the <code>item</code> object is added 
		 * 					at the end of the list. Default value is <code>-1</code>.
		 */
		public function ListItem(item:*, list:List, value:* = null, data:* = null, index:int = -1) {
			super();
			initObj(item, list, value, data, index);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _data:*;
		/**
		 *  Sets or get the data binded to this <code>ListItem</code> object.
		 * 
		 * 	@default null
		 */
		public function get data():* {
			return _data;
		}
		public function set data(value:*):void {
			_data = value;
		}
		
		/**
		 * 	Returns the index of the item object wrapped by this <code>ListItem</code>
		 * 	object.
		 */
		public function get index():int {
			return _list.indexOf(this);
		}
		
		private var _item:*;
		/**
		 * 	Returns a reference to the item object wrapped by this <code>ListItem</code>
		 * 	object.
		 */
		public function get item():* {
			return _item;
		}
		
		private var _list:List;
		/**
		 * 	Returns a reference to the <code>List</code> collections that
		 * 	contains the item wrapped by this <code>ListItem</code> object.
		 */
		public function get list():List {
			return _list;
		}
		
		private var _value:*;
		/**
		 * 	Returns the value of the item object wrapped by this <code>ListItem</code>
		 * 	object.
		 * 
		 * 	@default null
		 */
		public function get value():* {
			return _value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all subprocess will
		 * 	be killed for that list item. After calling this function you have to set
		 * 	the list item to <code>null</code> to make it elligible for garbage
		 * 	collection.
		 */
		public function finalize():void { 
			_value = null;
			_item = null;
			_data = null;
			_list = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function setIndex(value:int):void {
			var i:int = _list.indexOf(this);
			var li:ListItem = _list.set(this, value) as ListItem;
			_list.set(li, i);
		}
		
		/**
		 * @private
		 */
		spas_internal function setValue(value:*):void {
			_value = value;
		}
		
		/**
		 * @private
		 */
		spas_internal function setItem(value:*):void {
			_item = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(item:*, list:List, value:*, data:*, index:int):void {
			_item = item;
			_list = list;
			_value = value;
			_data = data;
			index != -1 ? _list.addAt(this, index) : _list.add(this);
		}
	}
}