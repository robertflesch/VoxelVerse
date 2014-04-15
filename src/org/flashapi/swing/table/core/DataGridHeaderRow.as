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
	// DataGridHeaderRow.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 23/02/2010 15:15
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.TableFillType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.DataGrid;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.layout.TableCellUtil;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.table.DataGridColumn;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>DataGridHeaderRow</code> class is responsible for creating and
	 * 	managing <code>DataGridHeader</code> instances within a <code>DataGrid</code>
	 * 	object.
	 * 
	 * 	@see org.flashapi.swing.table.DataGridHeader
	 * 	@see org.flashapi.swing.table.DataGridHeaderContainer
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridHeaderRow extends DataGridRowBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DataGridHeaderRow</code> instance for
		 * 	the specified <code>DataGrid</code> object.
		 * 
		 * 	@param	datagrid	The <code>DataGrid</code> object where the
		 * 						header row will be displayed.
		 */
		public function DataGridHeaderRow(datagrid:DataGrid) {
			super(datagrid);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var colsSizes:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * @private
		 */
		spas_internal function createRow(rowItem:Object):void {
			$rowItem = rowItem;
			//_datagrid.spas_internal::columns = [];
			$width = $datagrid.spas_internal::dataWidth;
			spas_internal::invalidateLayoutUpdate = true;
			var children:XMLList = rowItem.rowData.children();
			var i:int = 0;//--> Represents the index of the column.
			var ht:String;
			var df:String;
			var item:*;
			
			var Renderer:Class = $datagrid.spas_internal::headerItemRenderer;
			var RendererLaf:Class = $datagrid.lookAndFeel.getHeaderLaf();
			var wdt:Number;
			var elm:XML;
			for (; i < children.length(); i++) {
				elm = children[i];
				
				df = elm.@dataField.toXMLString();
				ht = elm.@headerText != undefined ? elm.@headerText.toXMLString() : df;
				
				/*if (elm.@width != undefined) {
					if (elm.@width == "auto") wdt = NaN;
					else wdt = Number(elm.@width);
				} else wdt = TableFillType.FILL;
				item = new Renderer(ht, wdt == TableFillType.FILL ? 100 : wdt);*/
				
				item = new Renderer(ht);
				item.lockLaf(RendererLaf, true);
				item.height = $datagrid.headerHeight;
				initRendererTextFormat(item, $datagrid.spas_internal::headerFontFormat);
				item.index = i;
				$evtColl.addEvent(item, UIMouseEvent.CLICK, sortHandler);
				$evtColl.addEvent(item, UIMouseEvent.PRESS, doDragHandler);
				
				var cs:ColorState = item.colors;
				if (elm.@upColor != undefined) cs.up = elm.@upColor;
				if (elm.@overColor != undefined) cs.over = elm.@overColor;
				if (elm.@downColor != undefined) cs.down = elm.@downColor;
				if (elm.@disabledColor != undefined) cs.disabled = elm.@disabledColor;
				
				//spas_internal::colsSizes.push(isNaN(wdt) ? item.width : wdt);
				
				wdt = (elm.@width != undefined) ? Number(elm.@width) : TableFillType.FILL;
				spas_internal::colsSizes.push(wdt);
				
				addElement(item);
				var dgc:* = new DataGridColumn($datagrid);
				item.spas_internal::setDataGridColumn(dgc);
				dgc.setItemRenderer(item);
				dgc.dataField = df;
				dgc.headerText = ht;
				$datagrid.spas_internal::columns.push(dgc);
				
				getBooleanProperty(elm, dgc, "resizable");
				getBooleanProperty(elm, dgc, "sortable");
				getBooleanProperty(elm, dgc, "draggable");
				getBooleanProperty(elm, dgc, "editable");
			}
			
			updateColumnsSizes();
			
			setGridMap();
			spas_internal::invalidateLayoutUpdate = false;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function updateColumnsSizes():void {
			var tcu:TableCellUtil = new TableCellUtil();
			tcu.rowMap = spas_internal::colsSizes;
			$datagrid.spas_internal::columnsSizes =
				tcu.spas_internal::getCellsSizes($datagrid.spas_internal::dataWidth);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _proxyImage:Bitmap;
		private var _proxyImageCont:Sprite;
		private var _hasBeenDragged:Boolean = false;
		private var _draggedItem:UIObject;
		private var _minDrag:Number;
		private var _maxDrag:Number;
		private var _dropIndex:int;
		private var _dragIndex:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::colsSizes = [];
			spas_internal::setSelector("datagridheaderrow");
		}
		
		private function sortHandler(e:UIMouseEvent):void {
			$datagrid.spas_internal::sortData(e.target.index);
		}
		
		private function doDragHandler(e:UIMouseEvent):void {
			_draggedItem = e.target as UIObject;
			_dragIndex = getElementIndex(_draggedItem);
			if (!$datagrid.spas_internal::columns[_dragIndex].draggable) return;
			$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, startMouseMove);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, stopDragHandler);
			//trace("doDragHandler");
		}
		
		private function startMouseMove(e:MouseEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, startMouseMove);
			var xPos:Number = _draggedItem.x;
			var yPos:Number = _draggedItem.y;
			var w:Number = _draggedItem.width;
			var bmpd:BitmapData = new BitmapData(w, _draggedItem.height);
			drawSelectedColumn(xPos, yPos, w, $datagrid.height);
			bmpd.draw(_draggedItem.container);
			_proxyImage = new Bitmap(bmpd);
			_proxyImageCont = new Sprite();
			_proxyImageCont.addChild(_proxyImage);
			_proxyImageCont.x = xPos;
			_proxyImageCont.y = yPos;
			_proxyImageCont.alpha = .8;
			$datagrid.spas_internal::headerContainer.container.addChild(_proxyImageCont);
			var _mousePosX:Number = _proxyImageCont.mouseX;
			var r:Rectangle = new Rectangle(-_mousePosX, 0, $width + (_proxyImage.width - _mousePosX), 0);
			_proxyImageCont.startDrag(false, r);
			$evtColl.addEvent(_proxyImageCont, MouseEvent.MOUSE_MOVE, setCurrentDropTarget);
			_hasBeenDragged = true;
		}
		
		private function stopDragHandler(e:MouseEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, stopDragHandler);
			if (!_hasBeenDragged) $evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, startMouseMove);
			else {
				clearSelectedColumn();
				$evtColl.removeEvent(_proxyImageCont, MouseEvent.MOUSE_MOVE, setCurrentDropTarget);
				_proxyImageCont.stopDrag();
				$datagrid.spas_internal::headerContainer.container.removeChild(_proxyImageCont);
				_proxyImageCont.removeChild(_proxyImage);
				_proxyImage.bitmapData.dispose();
				_proxyImage.bitmapData = null;
				_proxyImage = null;
				_proxyImageCont = null;
				_hasBeenDragged = false;
				if(_dropIndex != _dragIndex) $datagrid.spas_internal::swapColumns(_dragIndex, _dropIndex);
			}
			_draggedItem = null;
			//trace("stopDragHandler");
		}
		
		private function setCurrentDropTarget(e:MouseEvent):void {
			var xPos:Number = e.currentTarget.x + e.currentTarget.mouseX;
			if (_minDrag <= xPos && _maxDrag >= xPos) return;
			var cs:Array = $datagrid.spas_internal::columns;
			var l:int = cs.length - 1;
			var _x:Number;
			var _w:Number;
			for (; l >= 0; l--) {
				_x = cs[l].x;
				_w = cs[l].width;
				if (_x + _w >= xPos && _x <= xPos) {
					_minDrag = _x;
					_maxDrag = _x + _w;
					_dropIndex = l;
					return;
				}
			}
		}
		
		private function getBooleanProperty(elm:XML, dgc:DataGridColumn, prop:String):void {
			if (elm.@[prop] != undefined) {
				if (elm.@[prop] == "false") dgc[prop] = false;
				else if(elm.@[prop] == "true") dgc[prop] = true;
			}
		}
		
		private function drawSelectedColumn(fromX:Number, fromY:Number, width:Number, height:Number):void {
			with($datagrid.spas_internal::selectedColumnContainer.graphics) {
				clear();
				beginFill(0x666666, .5);
				drawRect(fromX, fromY, width, height);
				endFill();
			}
		}
		
		private function clearSelectedColumn():void {
			$datagrid.spas_internal::selectedColumnContainer.graphics.clear();
		}
	}
}