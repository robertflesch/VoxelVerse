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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// Table.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 23/02/2010 14:48
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.CellType;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.TableFillType;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.TableEvent;
	import org.flashapi.swing.layout.TableLayout;
	import org.flashapi.swing.table.Cell;
	import org.flashapi.swing.table.TableCell;
	import org.flashapi.swing.table.TableHeader;
	import org.flashapi.swing.table.TableRow;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Table.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the user clicks on the <code>Table</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.TableEvent.CELL_CLICKED
	 */
	[Event(name = "cellClicked", type = "org.flashapi.swing.event.TableEvent")]
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	<img src="Table.png" alt="Table" width="18" height="18"/>
	 * 
	 * 	The <code>Table</code> class is used to create, display and edit regular
	 * 	two-dimensional tables of cells. To populate a <code>Table</code> object
	 * 	you must use a <code>XML</code> map and pass it as parameter of the <code>map</code>
	 * 	property. The <code>XML</code> map contains the table definition as for HTML 
	 * 	table elements: &lt;table&gt;, &lt;tr&gt; and &lt;td&gt;. The following code
	 * 	shows the base structure of a <code>XML</code> map object:
	 * 
	 * <listing version="3.0">
	 * &lt;table&gt;
	 * 	&lt;tr&gt;
	 * 			 &lt;td&gt;foo 1&lt;/td&gt;
	 * 			 &lt;td&gt;bar 1&lt;/td&gt;
	 * 	&lt;/tr&gt;
	 * 	&lt;tr&gt;
	 * 			 &lt;td&gt;foo 2&lt;/td&gt;
	 * 			 &lt;td&gt;bar 2&lt;/td&gt;
	 * 	&lt;/tr&gt;
	 * 	&lt;tr&gt;
	 * 			 &lt;td&gt;foo 3&lt;/td&gt;
	 * 			 &lt;td&gt;bar 3&lt;/td&gt;
	 * 	&lt;/tr&gt;
	 * &lt;/table&gt;
	 * </listing>
	 * 
	 * 	<p>The <code>Table</code> class does not provide a sorting API, it is just
	 * 	a convenient class for laying out collections of data like HTML tables.
	 * 	To sort, or interract with, a collection of data use the <code>DataGrid</code>
	 * 	class instead.</p>
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 *  @includeExample TableExample.as
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Table extends Box implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Table</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>Table</code> instance, in pixels.
		 * 	@param	height	The height of the <code>Table</code> instance, in pixels.
		 */
		public function Table(width:Number = 200, height:Number = 200) {
			super(width,  height);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _map:XML = null;
		/**
		 * 	Sets or gets the <code>XML</code> map object used to populate the
		 * 	<code>Table</code> instance. When setting a new  <code>XML</code> map object
		 * 	all previous existing cells in the <code>Table</code> instance are deleted.
		 * 	If <code>null</code>, the <code>Table</code> instance is reseted.
		 * 
		 * 	@default null
		 */
		public function get map():XML {
			return _map;
		}
		public function set map(value:XML):void {
			_map = value.copy();
			//_displayed ? parseXmlData() : _isMapRendered = false;
			parseXmlData();
		}
		
		/**
		 * 	@private
		 */
		override public function set buttonMode(value:Boolean):void {
			spas_internal::uioSprite.buttonMode = value;
			var i:int = _tableRows.length - 1;
			var j:int;
			var tr:TableRow;
			for (; i >= 0; i--) {
				tr = _tableRows[i];
				j = tr.length - 1;
				for (; j >= 0; j--) tr.children[j].buttonMode = value;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns an <code>Array</code> that contains all <code>TableRow</code>
		 * 	displayed within this <code>Table</code> instance.
		 * 
		 * 	@return All <code>TableRow</code> displayed within this <code>Table</code>
		 * 			instance.
		 * 
		 * 	@see #getRowAt()
		 */
		public function getRows():Array {
			return _tableRows;
		}
		
		/**
		 * 	Returns the <code>TableRow</code> instance at the position specified by the
		 * 	the <code>index</code> parameter.
		 * 
		 * 	@param index	The position of the <code>TableRow</code> instance being
		 * 					sought.
		 * 
		 * 	@return	The <code>TableRow</code> instance at the specified position.
		 * 
		 * 	@see #getRows()
		 */
		public function getRowAt(index:int):TableRow {
			return _tableRows[index];
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			deleteTable();
			_cellEvtColl.finalize();
			_cellEvtColl = null;
			_tableRows = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		/*override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			if (!_isMapRendered) trace(_map), parseXmlData();
			_isMapRendered = true;
			super.createUIObject(x, y);
		}*/
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			spas_internal::invalidateLayoutUpdate = true;
			updateTableLayout();
			spas_internal::invalidateLayoutUpdate = false;
			$borderDecorator.drawBackground();
			$borderStyle != BorderStyle.NONE ?
				$borderDecorator.drawBorders() : $borderDecorator.clearBorders();
			drawMask();
			setEffects();
		}
		
		private function updateTableLayout():void {
			var i:int = _tableRows.length - 1;
			var j:int;
			var tr:TableRow;
			var h:Number;
			for (; i >= 0; i--) {
				tr = _tableRows[i];
				j = tr.length - 1;
				if (isNaN(tr.height)) _rows[i] = TableFillType.FILL;
				for (; j >= 0; j--) {
					tr.children[j].spas_internal::invalidateLayoutUpdate = true;
					tr.children[j].spas_internal::textObject.width = tr.children[j].width;
					h = tr.children[j].spas_internal::textObject.textField.height;
					if(isNaN(tr.height)) if (_rows[i] < h) _rows[i] = h;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _rows:Array;
		private var _cols:Array;
		private var _tableRows:Array;
		private var _cellEvtColl:EventCollector;
		//private var _isMapRendered:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initTable();
			$borderColor = $padding = $verticalGap = $padB = $padL =
			$padR = $padT = $horizontalGap = 0;
			this.layout = new TableLayout();
			spas_internal::setSelector(Selectors.TABLE);
			spas_internal::isInitialized(2);
		}
		
		/*private function createCell():Cell {
			var c:Cell = new Cell();
			return c;
		}
		
		private function deleteCell(cell:Cell):void { cell.spas_internal::finalize(); }*/
		
		private function deleteTable():void {
			_cellEvtColl.removeAllEvents();
			var item:TableRow;
			spas_internal::invalidateLayoutUpdate = true;
			for each(item in _tableRows) {
				item.spas_internal::finalize();
				item = null;
			}
			_tableRows = [];
			spas_internal::invalidateLayoutUpdate = false;
			finalizeElements();
		}
		
		private function initTable():void {
			_rows = [];
			_cols = [];
			_tableRows = [];
			_cellEvtColl = new EventCollector();
		}
		
		private function parseXmlData():void {
			//deleteTable();
			//trace(_map);
			
			_rows = [];
			_cols = [];
			
			//--> Check if target is an UIContainer class instance:
			var tgtIsDocClass:Boolean = ($target is UIContainer);
			if (tgtIsDocClass) target.spas_internal::invalidateLayoutUpdate = true;
			deleteTable();
			if (_map == null)  return;
			
			//var thL:int = _map.child("th").length();
			var trL:int = _map.child("tr").length();
			
			var borderType:String = BorderStyle.NONE;
			var borderSize:Number = 0;
			if (_map.@["border"] != undefined) {
				$borderStyle = borderType = BorderStyle.SOLID;
				$borderWidth = borderSize = Number(_map.@["border"]);
			}
			if (_map.@["cellspacing"] != undefined) $verticalGap = $horizontalGap = $padB = $padL = $padR = $padT = $padding = Number(_map.@["cellspacing"]);
			var cellPadding:Number = (_map.@["cellpadding"] != undefined) ? Number(_map.@["cellpadding"]) : 0;
			
			spas_internal::invalidateLayoutUpdate = true;
			
			var constraints:String;
			var colsLength:uint = 0;
			if (trL > 0) {
				var c:Cell;
				var list:XMLList;
				var size:Number;
				var cellType:String;
				var tr:TableRow;
				var rowHeight:Number;
				var btnMode:Boolean = spas_internal::uioSprite.buttonMode;
				var len:int;
				var i:int;
				var j:int;
				var h:Number;
				for (i = 0; i < trL; i++) {
					rowHeight = (_map.child("tr")[i].@["height"] != undefined) ? _map.child("tr")[i].@["height"] : TableFillType.FILL;
					_rows.push(rowHeight);
					tr = new TableRow(this);
					if (rowHeight != TableFillType.FILL) tr.height = rowHeight;
					_tableRows.push(tr);
					list = _map.child("tr")[i].child("*");
					len = list.length();
					if (colsLength < len) colsLength = len;
					for (j = 0; j < len; j++) {
						if (_cols.length < colsLength) {
							size = list[j].@["width"] != undefined ? list[j].@["width"] : TableFillType.FILL;
							_cols.push(size);
						}
						cellType = (list[j] != "") ? CellType.TEXT_NODE : CellType.ELEMENT_NODE;
						borderType = (list[j].@["border"] != undefined) ? BorderStyle.SOLID : BorderStyle.NONE;
						c = (list[j].name() == "td") ? new TableCell(borderType, cellType) : new TableHeader(borderType, cellType);
						c.padding = cellPadding;
						c.buttonMode = btnMode;
						if (borderSize > 0) $borderWidth = borderSize;
						constraints = String(j + 1) + "," + String(i + 1);
						if (list[j].@["bgcolor"] != undefined) c.backgroundColor = list[j].@["bgcolor"];
						if (list[j].@["id"] != undefined) c.id = list[j].@["id"];
						if (list[j].@["class"] != undefined) c.className = list[j].@["class"];
						//if (cellType == CellType.TEXT_NODE) {
							if (list[j].@["color"] != undefined) c.fontColor = list[j].@["color"];
							if (list[j].@["align"] != undefined) c.textAlign = list[j].@["align"];
							c.text = list[j];
						//}
						addElement(c, DataFormat.GRAPHIC, constraints);
						_cellEvtColl.addEvent(c, MouseEvent.CLICK, onCellClick);
						tr.spas_internal::addCell(c);
					}
					j = tr.length - 1;
					for (; j >= 0; j--) {
						tr.children[j].spas_internal::invalidateLayoutUpdate = true;
						tr.children[j].spas_internal::textObject.width = tr.children[j].width;
						h = tr.children[j].spas_internal::textObject.textField.height;
						if(isNaN(tr.height)) if (_rows[i] < h) _rows[i] = h;
					}
					//rowHeight = NaN;
				}
			}
			
			spas_internal::invalidateLayoutUpdate = false;
			if (tgtIsDocClass) target.spas_internal::invalidateLayoutUpdate = false;
			($layout as TableLayout).gridMap = new Array(_cols, _rows);
			
		}
		
		private function onCellClick(e:MouseEvent):void {
			var te:TableEvent = new TableEvent(TableEvent.CELL_CLICKED);
			te.spas_internal::cellRef = e.currentTarget as Cell;
			this.dispatchEvent(te);
		}
	}
}