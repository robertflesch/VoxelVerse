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

package org.flashapi.swing.table.core {
	
	// -----------------------------------------------------------
	//  DataGridSeparatorButton.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 16/06/2009 22:59
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.CursorType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.cursor.Cursor;
	import org.flashapi.swing.DataGrid;
	import org.flashapi.swing.table.DataGridColumn;

	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>DataGridSeparatorButton</code> class creates reactive areas that
	 * 	provide to <code>DataGrid</code> objects a convenient system to manage the
	 * 	resizing of columns.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridSeparatorButton extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DataGridSeparatorButton</code> instance
		 * 	with the specified parameters.
		 * 
		 * 	@param	target	The <code>DataGrid</code> object that instanciates this
		 * 					<code>DataGridSeparatorButton</code>.
		 * 	@param	firstCol	The first column to be managed by this
		 * 						<code>DataGridSeparatorButton</code> instance.
		 * 	@param	secondCol	The second column to be managed by this
		 * 						<code>DataGridSeparatorButton</code> instance.
		 */
		public function DataGridSeparatorButton(target:DataGrid, firstCol:DataGridColumn, secondCol:DataGridColumn) {
			super();
			initObj(target, firstCol, secondCol);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _handleWidth:Number = 6
		/**
		 * 	Returns a number which is the width of the <code>DataGridSeparatorButton</code>
		 * 	object.
		 */
		public function get handleWidth():Number {
			return _handleWidth;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Changes the reference to the columns managed by this <code>DataGridSeparatorButton</code>
		 * 	instance. This method is called each time the oder of the columns within a
		 * 	<code>DataGrid</code> object is changed due to a user action.
		 * 
		 * 	@param	firstCol	The first column to be managed by this
		 * 						<code>DataGridSeparatorButton</code> instance.
		 * 	@param	secondCol	The secong column to be managed by this
		 * 						<code>DataGridSeparatorButton</code> instance.
		 */
		public function setColumns(firstCol:DataGridColumn, secondCol:DataGridColumn):void {
			_col1 = firstCol;
			_col2 = secondCol;
		}
		
		/**
		 * 	Method used within the <code>DataGrid</code> object to finalize this
		 * 	<code>DataGridSeparatorButton</code> instance.
		 */
		public function finalize():void {
			_evtColl.finalize();
			_evtColl = null;
			_col1 = null;
			_col2 = null;
			_datagrid = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _evtColl:EventCollector;
		private var _col1:DataGridColumn;
		private var _col2:DataGridColumn;
		private var _datagrid:DataGrid;
		private var _dragging:Boolean;
		private var _origin:Number;
		private var _storedCursorType:String;
		private var _uiManager:*;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:DataGrid, firstCol:DataGridColumn, secondCol:DataGridColumn):void {
			_evtColl = new EventCollector();
			_dragging = false;
			//_storedCursorType = null;
			_uiManager = UIDescriptor.getUIManager();
			setColumns(firstCol, secondCol);
			this.cacheAsBitmap = true;
			_datagrid = target;
			drawHandle(_datagrid.headerHeight);
			createEvents();
		}
		
		private function createEvents():void {
			_evtColl.addEvent(this, MouseEvent.ROLL_OVER, rollOverHandler);
			_evtColl.addEvent(this, MouseEvent.ROLL_OUT, rollOutHandler);
			_evtColl.addEvent(this, MouseEvent.MOUSE_DOWN, onPressHandler);
		}
		
		private function rollOverHandler(e:MouseEvent):void {
			if (!isResizable()) return;
			if (!_dragging) {
				var c:Cursor = _uiManager.cursor;
				if(!c.displayed) drawHandle(_datagrid.headerHeight, 0x666666, .6);
				else {
					_storedCursorType = c.type;
					c.type = CursorType.H_DIVIDER_CURSOR;
				}
			}
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			if (!_dragging) restoreCursor();
		}
		
		private function restoreCursor():void {
			if (_storedCursorType) {
				_uiManager.cursor.type = _storedCursorType;
				_storedCursorType = null;
			} else drawHandle(_datagrid.headerHeight);
		}
		
		private function isResizable():Boolean {
			return (_col1.resizable && _col2.resizable);
		}
		
		private function onPressHandler(e:MouseEvent):void {
			if (!isResizable()) return;
			_evtColl.addEvent(this.stage, MouseEvent.MOUSE_UP, onReleaseHandler);
			_dragging = true;
			drawHandle(_datagrid.height, 0x666666, 1);
			var mw:Number = _datagrid.minColumnWidth;
			var c1w:Number = _col1.width;
			_origin = this.x;
			var r:Rectangle = new Rectangle(_origin - c1w + mw, 0, _col2.width + c1w - 2 * mw, 0);
			this.startDrag(false, r);
		}
		
		private function onReleaseHandler(e:MouseEvent):void {
			stopDrag();
			_evtColl.removeEvent(this.stage, MouseEvent.MOUSE_UP, onReleaseHandler);
			_dragging = false;
			restoreCursor();
			var hrs:Array = _datagrid.spas_internal::headers.spas_internal::colsSizes;
			var cols:Array = _datagrid.spas_internal::columns;
			var w:Number = _origin - this.x;
			var id:int = cols.indexOf(_col1);
			hrs[id] = _col1.width - w;
			_col1.width = hrs[id];
			hrs[id + 1] = _col2.width + w;
			_col2.width = hrs[id + 1];
			_datagrid.spas_internal::resizeColumns();
		}
		
		private function drawHandle(height:Number, color:uint = 0, alpha:Number = 0):void {
			var w:Number = _handleWidth;
			with (graphics) {
				clear();
				graphics.beginFill(color, alpha);
				drawRect( -w / 2, 0, w, height);
				endFill();
			}
		}
	}
}