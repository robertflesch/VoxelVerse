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
	// Listable.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/09/2007 00:12
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.databinding.DataProviderObject;
	import org.flashapi.swing.databinding.XMLQueryObject;
	import org.flashapi.swing.list.ListItem;
	
	/**
	 * 	A simple linked-listed inteface. The <code>Listable</code> interface provides
	 * 	access to the list data for <code>Listable</code> objects, such as <code>ButtonBar</code>,
	 * 	<code>ListBox</code>, <code>ScrollGallery</code>..
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Listable {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Returns the current <code>ListItem</code> object selected within this
		 * 	<code>Listable</code> instance.
		 */
		function get listItem():ListItem;
		
		/**
		 * 	Returns the number of <code>ListItem</code> objects registred within this
		 * 	<code>Listable</code> instance.
		 */
		function get length():int;
		
		/**
		 * 	Specifies whether this <code>Listable</code> instance enables
		 * 	selection of multiple <code>ListItem</code> objects at the same time
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 *  @default false
		 * 
		 *  @see #itemsCollection
		 */
		function get multiple():Boolean;
		function set multiple(value:Boolean):void;
		
		/**
		 * 	Returns the collection of selected items when the <code>multiple</code> is
		 * 	<code>true</code> and the user hase selected items whithin this datagrid.
		 * 	Returns <code>null</code> the <code>multiple</code> is <code>false</code>.
		 * 
		 *  @default null
		 * 
		 *  @see #multiple
		 */
		function get itemsCollection():Array;
		
		/**
		 * 	Specifes how data is processed when a new <code>DataProvider</code>,
		 * 	or <code>XMLQuery</code>, object is added to this <code>Listable</code>
		 * 	objects. Possible values are <code>DataBindingMode</code> class
		 * 	constants:
		 * 
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Mode</th>
		 * 			<th>Description</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td><code>DataBindingMode.INCREMENT</code></td>
		 * 			<td>Adds the new <code>ListItem</code> objects at the end
		 * 			of the <code>Listable</code> instance.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>DataBindingMode.UPDATE</code></td>
		 * 			<td>Updates all <code>ListItem</code> objects in the
		 * 			<code>Listable</code> instance. If the new data value is
		 * 			<code>null</code>, the <code>data</code> property of the
		 * 			updated <code>ListItem</code> object is set to <code>null</code>.
		 * 			</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>DataBindingMode.MERGE</code></td>
		 * 			<td>Merges all <code>ListItem</code> objects in the
		 * 			<code>Listable</code> instance. If the new data value is
		 * 			<code>null</code>, the <code>data</code> property of the
		 * 			updated <code>ListItem</code> object is not changed. Use
		 * 			the <code>MERGE</code> constant as data biding mode to
		 * 			create multi-language applications.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>DataBindingMode.RESET</code></td>
		 * 			<td>Removes all existing <code>ListItem</code> objects
		 * 			from the <code>Listable</code> 	instance before adding
		 * 			new ones.</td>
		 * 		</tr>
		 * 	</table>
		 * 
		 *  @default DataBindingMode.INCREMENT
		 * 
		 * 	@see #xmlQuery
		 * 	@see #dataProvider
		 */
		function get dataBindingMode():String;
		function set dataBindingMode(value:String):void;
		
		/**
		 * 	Associates a <code>DataProvider</code> object to this <code>Listable</code>
		 * 	instance, or returns the <code>DataProvider</code> object if it exists;
		 * 	returns <code>null</code> otherwise.
		 * 
		 *  @default null
		 * 
		 * 	@see #xmlQuery
		 */
		function get dataProvider():DataProviderObject;
		function set dataProvider(value:DataProviderObject):void;
		
		/**
		 * 	Associates a <code>XMLQuery</code> object to this <code>Listable</code>
		 * 	instance, or returns the <code>XMLQuery</code> object if it exists;
		 * 	returns <code>null</code> otherwise.
		 * 
		 *  @default null
		 * 
		 * 	@see #dataProvider
		 */
		function get xmlQuery():XMLQueryObject;
		function set xmlQuery(value:XMLQueryObject):void;
		
		/**
		 * 	The zero-based index of the item currently selected within this 
		 * 	<code>Listable</code> object. List indexes are in the range <code>0</code>,
		 * 	<code>1</code>, <code>2</code>, ... , <code>n - 1</code>, where <code>n</code>
		 * 	is the number of items. Default value is <code>0</code>, corresponding to
		 * 	the first item od the <code>Listable</code> object. If there are no items
		 * 	selected in the list, this property returns <code>-1</code>.
		 * 	
		 * 	@default -1
		 */
		function get selectedIndex():int;
		function set selectedIndex(value:int):void;
		
		/**
		 * 	Sets or gets the path which represents a global URI taht can be used
		 * 	by all <code>ListItem</code> object registred within this <code>Listable</code>
		 * 	instance.
		 * 
		 * 	@default ""
		 */
		function get urlPath():String;
		function set urlPath(value:String):void;
		
		/**
		 * 	Returns the binded data of the current selected <code>ListItem</code>    
		 * 	object within this <code>Listable</code> instance.
		 * 
		 * 	@see	org.flashapi.swing.list.ListItem
		 */
		function get data():*;
		
		/**
		 * 	Returns the binded value of the current selected <code>ListItem</code>    
		 * 	object within this <code>Listable</code> instance. 
		 * 
		 * 	@see	org.flashapi.swing.list.ListItem
		 */
		function get value():*;
		
		/**
		 * 	<code>ListItem</code> objects enable access to their label property,
		 * 	which is often the label text of <code>UIObject</code> they refer to.
		 * 	So, the <code>label</code> property sets or gets the label text of
		 * 	the <code>Listable</code> instance when enabled.
		 * 
		 *  @default null
		 * 
		 * 	@see	org.flashapi.swing.list.ListItem
		 */
		function get label():String;
		function set label(value:String):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns an <code>Array</code> that contains all item properties registred
		 * 	within this <code>Listable</code> object.
		 * 
		 * 	@param	onlyListItems	Specifies whether objects into the array are
		 * 	<code>ListItem</code> (<code>true</code>), or not(<code>false</code>).
		 * 	If <code>false</code>, objects in the array are <code>Objects</code> instances
		 * 	with the following properties:
		 * 	<ul>
		 * 		<li><code>item</code>: one of the items within the list,</li>
		 * 		<li><code>index</code>: the index for this item,</li>
		 * 		<li><code>value</code>: the value for this item,</li>
		 * 		<li><code>data</code>: the data for this item.</li>
		 * 	</ul>
		 * 
		 * 	@return An <code>Array</code> that contains all item properties registred
		 * 	within this <code>Listable</code> object.
		 * 
		 * 	@see	org.flashapi.swing.list.ListItem
		 */
		function getAllProperties(onlyListItems:Boolean = false):Array;
		
		/**
		 * 	Adds the specified item and binded data to the end of this <code>Listable</code>
		 * 	object stack. Equivalent to <code>addItemAt(length, item, data)</code>. 
		 * 
		 * 	@param	value	A string or an object that describes the new properties
		 * 					for the added item.
		 * 	@param	data	The binded data for this item. Default value is <code>null</code>.
		 * 
		 * 	@return		A reference to the created <code>ListItem</code> object.
		 * 
		 * 	@see #addItemAt()
		 */
		function addItem(value:*, data:* = null):ListItem;
		
		/**
		 * 	Adds the item at the specified index. Any item that was after this index
		 * 	is moved out by one. 
		 * 
		 * 	@param	index	The index at which to place the item. 
		 * 	@param	value	A string or an object that describes the properties for
		 * 					the added item.
		 * 	@param	data	The binded data for this item. Default value is <code>null</code>.
		 * 
		 * 	@return		A reference to the created <code>ListItem</code> object.
		 * 
		 * 	@see #addItem()
		 */
		function addItemAt(index:int, value:*, data:* = null):ListItem;
		
		/**
		 *  Returns the <code>ListItem</code> object at the specified index.
		 * 
		 * 	@param	The index at which to get the item. 
		 * 
		 * 	@return	The <code>ListItem</code> object at the specified index, if exists.
		 */
		function getItemAt(index:int):ListItem;
		
		/**
		 * 	Removes all registred items from the <code>Listable</code> object stack.
		 */
		function removeAll():void;
		
		/**
		 * 	Removes the <code>ListItem</code> object, specified by the <code>item</code>
		 * 	parameter, from <code>Listable</code> object stack.
		 * 
		 * 	@param	item The <code>ListItem</code> object to remove.
		 */
		function removeItem(item:ListItem):void;
		
		/**
		 * 	Removes the item, at the specified index, from the <code>Listable</code>
		 * 	object stack.
		 * 
		 * 	@param The index at which to remove the item. 
		 */
		function removeItemAt(index:int):void;
		
		/**
		 * 	Changes the properties of the item at the specified index.
		 * 
		 * 	@param	index	The index at which to change the item properties.
		 * 	@param	value	A string or an object that describes the new properties
		 * 					for this item.
		 * 	@param	data	The new binded data for this item. Default value is <code>null</code>.
		 * 
		 * 	@return A reference to the modified <code>ListItem</code> object.
		 */
		function updateItemAt(index:int, value:*, data:* = null):ListItem;
	}
}