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
	// DataGridRow.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 30/03/2010 15:45
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.DataGrid;
	import org.flashapi.swing.event.DataGridEvent;
	import org.flashapi.swing.renderer.DataGridItemRenderer;
	import org.flashapi.swing.renderer.ItemRenderer;
	import org.flashapi.swing.table.core.DataGridRowBase;
	import org.flashapi.swing.text.FontFormat;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DataGridRow</code> class represents a row of <code>ItemRenderer</code>
	 * 	objects within a <code>DataGrid</code> instance.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 	@see org.flashapi.swing.renderer.ItemRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridRow extends DataGridRowBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DataGridRow</code> instance for the
		 * 	specified <code>DataGrid</code> object.
		 * 
		 * 	@param	datagrid	The <code>DataGrid</code> object where the
		 * 						row of items will be displayed.
		 */
		public function DataGridRow(datagrid:DataGrid) {
			super(datagrid);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set selected(value:Boolean):void {
			$selected = value;
			if ($selected) {
				drawRowBackground($datagrid.rowSelectedColor);
				changeFontColor($datagrid.spas_internal::selectedFontColor);
			} else {
				clearRowBackground();
				changeFontColor($datagrid.spas_internal::upFontColor);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Updates the text format of all <code>TextItemRenderer</code> objects
		 * 	displayed within this <code>DataGridRow</code> instance. This method
		 * 	is invocated each time the <code>defaultItemRendererFontFormat</code>
		 * 	property of the <code>DataGrid</code> changes.
		 */
		public function updateTextFormat():void {
			var fmt:FontFormat = $datagrid.spas_internal::itemFontFormat;
			var l:int = _itemLength - 1;
			for (; l >= 0; l--) initRendererTextFormat(this.getObjectAt(l), fmt);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function updateItemRenderer(index:int, itemRendererRef:Class, data:Object, dataField:String):void {
			var elm:* = this.getObjectAt(index);
			if (elm is itemRendererRef) return;
			else {
				//--> TODO: implement the UIContainer.removeElementAt method when it works.
				var column:DataGridColumn = $datagrid.spas_internal::columns[index];
				this.removeElement(elm);
				elm.finalize();
				column.remove(elm);
				var elments:Array = getElements();
				this.removeElements();
				var item:DataGridItemRenderer;
				item = new itemRendererRef();
				if(data != null) item.updateItem(data);
				initRendererTextFormat(item, $datagrid.spas_internal::itemFontFormat);
				item.index = index;
				item.dataField = dataField;
				item.editable = column.editable;
				column.add(item);
				elm = null;
				elments.splice(index, 0, item);
				this.addGraphicElements(elments);
				elments = null;
			}
			redrawHitArea();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function updateRow(rowItem:Object):void {
			$rowItem = rowItem;
			spas_internal::invalidateLayoutUpdate = true;
			var i:int = 0;
			var item:DataGridItemRenderer;
			
			var l:int = _itemLength - 1;
			
			var itemList:Array = getElements();
			var il:int;
			var column:DataGridColumn;
			var df:String;
			var edit:Boolean;
			
			this.data = $rowItem.data;
			
			for (; l >= 0; l--) {
				column = _dgc[l];
				i = column.index;
				df = column.dataField;
				
				il = itemList.length - 1;
				edit = column.editable;
				for (; il >= 0; il--) {
					item = itemList[il] as DataGridItemRenderer;
					if (item.dataField == df) {
						item.updateItem($rowItem[df]);
						item.index = i;
						item.editable = edit;
						break;
					}
				}
			}
			this.selected = $rowItem.selected;
			spas_internal::invalidateLayoutUpdate = false;
			spas_internal::updateLayout();
			redrawHitArea();
		}
		
		
		/**
		 * 
		 * @private
		 */
		spas_internal function initRow(rowItem:Object):void {
			$rowItem = rowItem;
			spas_internal::invalidateLayoutUpdate = true;
			var i:int = 0;//--> Represents the index of the column.
			var item:DataGridItemRenderer;
			var Renderer:Class;
			setGridMap();
			spas_internal::dragEnbd = $datagrid.spas_internal::enableRowsDrag;
			_dgc = $datagrid.spas_internal::columns;
			_itemLength = _dgc.length;
			var l:int = _itemLength - 1;
			var coll:Array = [];
			var column:DataGridColumn;
			var df:String;
			var fmt:FontFormat = $datagrid.spas_internal::itemFontFormat;
			for (; l >= 0; l--) {
				column = _dgc[l];
				i = column.index;
				df = column.dataField;
				Renderer = $datagrid.spas_internal::rendererCollection[df] ?
					$datagrid.spas_internal::rendererCollection[df] : $datagrid.defaultItemRenderer;
				item = new Renderer();
				if($rowItem != null) item.updateItem($rowItem[df]);
				initRendererTextFormat(item, fmt);
				item.index = i;
				item.dataField = df;
				item.editable = column.editable;
				coll[i] = item;
				_dgc[i].add(item);
			}
			addGraphicElements(coll);
			coll = null;
			spas_internal::invalidateLayoutUpdate = false;
			spas_internal::updateLayout();
			redrawHitArea();
		}
		
		/**
		 * @private
		 */
		spas_internal function updateDragEnabled(enableRowsDrag:Boolean):void {
			spas_internal::dragEnbd = enableRowsDrag;
		}
		
		/**
		 * @private
		 */
		spas_internal function resetRow():void {
			$rowItem = null;
			this.data = null;
			//spas_internal::invalidateLayoutUpdate = true;
			var l:int = this.numElements - 1;
			
			for (; l >= 0; l--) this.getObjectAt(l).resetItem();
			//spas_internal::invalidateLayoutUpdate = false;
			//spas_internal::updateLayout();
			redrawHitArea();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			redrawHitArea();
			setEffects();
		}
		
		/**
		 * @private
		 */
		spas_internal function refreshHitArea():void {
			redrawHitArea();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _dgc:Array;
		private var _itemLength:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createHitArea();
			spas_internal::uioSprite.addChild($hitArea);
			$hitArea.doubleClickEnabled = true;
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_OVER, rollOverHandler);
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_OUT, rollOutHandler);
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_DOWN, pressHandler);
			$evtColl.addEvent($hitArea, MouseEvent.CLICK, clickHandler);
			$evtColl.addEvent($hitArea, MouseEvent.DOUBLE_CLICK, dbleClickHandler);
			spas_internal::setSelector("datagridrow");
		}
		
		private function redrawHitArea():void {
			with ($hitArea.graphics) {
				clear();
				beginFill(0xff0000, 0);
				drawRect(0, 0, $width, $height);
				endFill();
			}
		}
		
		/*private function checkHeaders(name:String):void {
			//trace(header == name);
		}*/
		
		private function rollOverHandler(e:MouseEvent):void {
			if ($rowItem == null) return;
			if ($selected) return;
			changeFontColor($datagrid.spas_internal::overFontColor);
			drawRowBackground($datagrid.rowOverColor);
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			if ($rowItem == null) return;
			if ($selected) return;
			clearRowBackground();
			changeFontColor($datagrid.spas_internal::upFontColor);
		}
		
		private function drawRowBackground(color:uint):void {
			with (spas_internal::uioSprite.graphics) {
				clear();
				beginFill(color);
				drawRect(0, 0, $width, $height);
				endFill();
			}
		}
		
		private function clearRowBackground():void {
			spas_internal::uioSprite.graphics.clear();
		}
		
		private function pressHandler(e:MouseEvent):void {
			if ($rowItem == null) return;
			var dge:DataGridEvent = new DataGridEvent(DataGridEvent.ROW_PRESSED);
			dge.spas_internal::currentRow = this;
			$datagrid.dispatchEvent(dge);
			if (!$selected) changeFontColor($datagrid.spas_internal::downFontColor);
		}
		
		private function clickHandler(e:MouseEvent):void {
			if ($rowItem == null) return;
			e.stopImmediatePropagation();
			$datagrid.spas_internal::currentRowChanged(this);
		}
		
		private function dbleClickHandler(e:MouseEvent):void {
			if ($rowItem == null) return;
			e.stopImmediatePropagation();
			this.selected = true;
			$datagrid.spas_internal::currentRowChanged(this);
			var a:Array = $stage.getObjectsUnderPoint(new Point(e.stageX, e.stageY));
			var l:int = a.length - 1;
			var obj:*;
			for (; l >= 0; l--) {
				obj = a[l];
				if (obj is ItemRenderer) {
					if (obj.editable) {
						var df:String = $datagrid.spas_internal::columns[obj.index];
						$datagrid.spas_internal::startItemRendererEdition(obj, df);
					} else $datagrid.spas_internal::dispatchDoubleClickEvent(this);
					break;
				}
			}
		}
		
		private function changeFontColor(fontColor:uint):void {
			var l:int = _itemLength - 1;
			//var item:*;
			for (; l >= 0; l--) {
				this.getObjectAt(l).setFontColor(fontColor);
			}
		}
	}
}