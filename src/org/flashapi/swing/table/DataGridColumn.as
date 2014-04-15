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

package org.flashapi.swing.table {
	
	// -----------------------------------------------------------
	// DataGridColumn.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 30/03/2010 16:14
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.DataGrid;
	import org.flashapi.swing.renderer.ItemRenderer;
	import org.flashapi.swing.util.ArrayList;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DataGridColumn</code> class represents a collection of the columns
	 * 	displayed within a <code>DataGrid</code> object. <code>DataGridColumn</code>
	 * 	instances provide the API for manipulating each column of the <code>DataGrid</code>.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridColumn extends ArrayList {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DataGridColumn</code> object with the 
		 * 	specified parameter.
		 * 
		 * 	@param	datagrid 	The parent <code>DataGrid</code> instance for this
		 * 						<code>DataGridColumn</code> object.
		 */
		public function DataGridColumn(datagrid:DataGrid) {
			super();
			initObj(datagrid);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A constant value used within the the parent <code>DataGrid</code> object
		 * 	to indicate that the column cannot be sorted.
		 */
		public static const UNSORT:int = -1;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A constant value used within the the parent <code>DataGrid</code> object
		 * 	to indicate that data is arranged from the normal low to high sequence.
		 */
		public static const ASCENDING:uint = 0;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A constant value used within the the parent <code>DataGrid</code> object
		 * 	to indicate that data is arranged from high to low sequence.
		 */
		public static const DESCENDING:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The parent <code>DataGrid</code> instance for this <code>DataGridColumn</code>
		 * 	object.
		 */
		public var datagrid:DataGrid;
		
		/**
		 * 	Indicates whether the <code>DataGridColumn</code> object can be moved
		 * 	(<code>true</code>), or not (<code>false</code>).
		 */
		public var draggable:Boolean = true;
		
		/**
		 * 	Indicates whether the <code>DataGridColumn</code> object can be resized
		 * 	(<code>true</code>), or not (<code>false</code>).
		 */
		public var resizable:Boolean = true;
		
		/**
		 * 	Indicates whether the <code>DataGridColumn</code> object can be sorted
		 * 	(<code>true</code>), or not (<code>false</code>).
		 */
		public var sortable:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _x:Number = 0;
		/**
		 * 	Returns the value of the <code>x</code> position for this <code>DataGridColumn</code>
		 * 	object, in pixels, relative to the coordianates of the parent
		 * 	<code>DataGrid</code> instance.
		 */
		public function get x():Number {
			return _x;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns an <code>Array</code> which is the original collection of elements
		 * 	that belong to this column.
		 */
		public function get children():Array {
			return $stack;
		}
		
		private var _color:* = NaN;
		/**
		 * 	sets or gets the background color for this <code>DataGridColumn</code>
		 * 	object.
		 */
		public function get color():* {
			return _color;
		}
		public function set color(value:*):void {
			_color = isNaN(value) ? NaN : ColorUtil.getColor(value);
		}
		
		private var _dataField:String;
		/**
		 *  Sets or gets the name of the field or property in the data set, 
		 * 	associated with this <code>DataGridColumn</code> object.
		 */
		public function get dataField():String {
			return _dataField;
		}
		public function set dataField(value:String):void {
			_dataField = value;
		}
		
		private var _headerText:String = null;
		/**
		 * 	Sets or gets the text displayed by the column header. If <code>null</code>, 
		 *  the parent <code>DataGrid</code> instance uses the value of the
		 * 	<code>dataField</code> property.
		 * 
		 * 	@default null
		 */
		public function get headerText():String {
			return _headerText ? _headerText : _dataField;
		}
		public function set headerText(value:String):void {
			_headerText = value;
		}
		
		/**
		 * 	Returns the current index of this <code>DataGridColumn</code> object
		 * 	regarding other columns availaible within the parent <code>DataGrid</code>
		 * 	instance.
		 */
		public function get index():uint {
			return datagrid.spas_internal::columns.indexOf(this);
		}
		//public function set index(value:uint):void { datagrid = value; }
		
		private var _selector:String = "datagridcolumn";
		/**
		 * 	Returns the CSS selector value of the <code>DataGridColumn</code>
		 * 	object.
		 * 
		 * 	@default datagridColumn
		 */
		public function get selector():String {
			return _selector;
		}
		
		private var _width:Number = NaN;
		/**
		 * 	Sets or gets the width of the <code>DataGridColumn</code> object, in
		 * 	pixels.
		 */
		public function get width():Number {
			return _width;
		}
		public function set width(value:Number):void {
			_width = value;
		}
		
		private var _itemRenderer:ItemRenderer;
		/**
		 * 	Returns a reference to the <code>ItemRenderer</code> object that will
		 * 	be used by default by elements contained within this <code>DataGridColumn</code>
		 * 	object.
		 */
		public function get itemRenderer():ItemRenderer {
			return _itemRenderer;
		}
		
		private var _editable:Boolean = false;
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>DataGridColumn</code>
		 * 	object can be edited (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get editable():Boolean {
			return _editable;
		}
		public function set editable(value:Boolean):void {
			_editable = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		override public function finalize():void {
			datagrid = null;
			var l:int = $stack.length - 1;
			for (; l >= 0; l--) $stack[l] = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		private var _currentSort:int = UNSORT;
		/**
		 * 	@private
		 */
		spas_internal function setCurrentSortType(value:int):void {
			_currentSort = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function getCurrentSortType():int {
			return _currentSort;
		}
		
		/**
		 * 	@private
		 */
		spas_internal  function setItemRenderer(value:ItemRenderer):void {
			_itemRenderer = value;
		}
		
		/**
		 * @private
		 */
		spas_internal function setX(value:Number):void {
			_x = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(datagrid:DataGrid):void {
			this.datagrid = datagrid;
		}
	}
}