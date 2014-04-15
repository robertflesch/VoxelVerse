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

package org.flashapi.swing.layout {
	
	// -----------------------------------------------------------
	// TableLayout.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 08/02/2009 23:20
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.LayoutHorizontalDirection;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.util.ArrayUtil;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------

	/**
	 *  The "finished" <code>LayoutEvent</code> occurs after child elements are added
	 * 	or removed, bounds of the <code>UIContainer</code> object change and after 
	 * 	all other changes that could affect the layout have been performed.
	 *
	 *  @eventType org.flashapi.swing.event.LayoutEvent.FINISHED
	 */
	[Event(name="finished", type="org.flashapi.swing.event.LayoutEvent")]
	
	/**
	 * 	The <code>TableLayout</code> class is a flexible layout manager that aligns
	 * 	elements vertically and horizontally, into a dynamic, rectangular grid of
	 * 	cells, with each element occupying one or more cells.
	 * 
	 * 	<p>
	 * 	[TODO: translate the whitepaper "Travailler avec les layouts".]
	 * 	</p>
	 * 
	 *  @includeExample TableLayoutExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TableLayout extends AbstractLayout implements Layout {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates an new <code>TableLayout</code> instance from the
		 * 	specified grid map, if not <code>null</code>.
		 * 
		 * 	@param	gridMap	An associative <code>Array</code> object that represents
		 * 					the grid map for this table layout.
		 */
		public function TableLayout(gridMap:Array = null) {
			super();
			initObj(gridMap);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _minWidth:Number = 25;
		/**
		 * 	Sets or gets the minimum witdh for all cells within the table, in pixels.
		 * 
		 * 	@default 25
		 * 
		 * 	@see #minHeigh
		 */
		public function get minWidth():Number {
			return _minWidth;
		}
		public function set minWidth(value:Number):void {
			_minWidth = value;
		}
		
		private var _minHeight:Number = 25;
		/**
		 * 	Sets or gets the minimum height for all cells within the table, in pixels.
		 * 
		 * 	@default 25
		 * 
		 * 	@see #minWidth
		 */
		public function get minHeigh():Number {
			return _minHeight;
		}
		public function set minHeigh(value:Number):void {
			_minHeight = value;
		}
		
		private var _gridMap:Array;
		/**
		 * 	Sets or gets the map of the grid used to compute this table layout.
		 */
		public function get gridMap():Array {
			return _gridMap;
		}
		public function set gridMap(value:Array):void {
			_gridMap = value;
			checkGridMap();
			$target.spas_internal::updateLayout();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the original array that contains all column properties for this
		 * 	table layout.
		 * 
		 * 	@see #rows
		 */
		public function get columns():Array {
			return _cols;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the original array that contains all row properties for this
		 * 	table layout.
		 * 
		 * 	@see #columns
		 */
		public function get rows():Array {
			return _rows;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		public function moveObjects(bounds:Rectangle, caller:* = null):void {
			if (_gridMap == null) return;
			//throw new NullPointerException(this + ": grid map must not be null");
			var flag:Boolean = hasBoundsChanged(bounds);
			
			if (flag) getCellsSizes();
			//if (_hasListChanged || flag) {
			if ($elementsList.length > 0) {
				var i:int;
				var s:uint = $elementsList.length;
				if ($horizontalOrientation == LayoutHorizontalDirection.LEFT_TO_RIGHT)
					for(i = 0; i < s; i++) applyLayout(i);
				else if ($horizontalOrientation == LayoutHorizontalDirection.RIGHT_TO_LEFT)
					for(i = s-1; i >= 0; i--) applyLayout(i);
				_obj = null;
				//_hasListChanged = false;
			}
			if ($target.autoWidth) $target.width -= _fixW;
			if ($target.autoHeight) $target.height -= _fixH;
			dispatchFinishedEvent();
		}
		
		/**
		 * @private
		 */
		override public function setTarget(target:UIContainer):void {
			$target = target;
			spas_internal::bounds = $target.spas_internal::getLayoutBounds();
			if(_gridMap != null) checkGridMap();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fixW:Number;
		private var _fixH:Number;
		private var _cols:Array;
		private var _rows:Array;
		private var _obj:* = null;
		private var _hGap:Number;
		private var _vGap:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(gridMap:Array):void {
			_gridMap = gridMap;
		}
		
		private function checkGridMap():void {
			if (_gridMap[0] == null || _gridMap[0].length == 0) {
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.COLUMN_NUMBER_ERROR);
			}
			else if (_gridMap[1] == null || _gridMap[1].length == 0) {
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.ROW_NUMBER_ERROR);
			}
			getCellsSizes();
		}
		
		private function getCellsSizes():void {
			
			_cols = ArrayUtil.clone(_gridMap[0]);
			_rows = ArrayUtil.clone(_gridMap[1]);
			
			var colsL:Number = _cols.length;
			var rowsL:Number = _rows.length;
			
			_hGap = $target.horizontalGap;
			_vGap = $target.verticalGap;
			
			var n:Number;
			var i:int;
			var cellL:int;
			var size:Number;
			
			_fixW = spas_internal::bounds.width;
			
			var fillCells:Array = [];
			for (i = colsL - 1; i >= 0; i--) {
				n = _cols[i];
				
				if (n >= 1 || n == 0)  _fixW -= n + _hGap;
				else if (n == -1) {
					fillCells.push(i);
					_fixW -= _hGap;
				} else if (n > 0 && n < 1) {
					_cols[i] = n * spas_internal::bounds.width / 100;
					_fixW -= _cols[i] + _hGap;
				} else {
					throw new InvalidArgumentException(Locale.spas_internal::ERRORS.COLUMN_SIZE_ERROR);
				}
			}
			var hasOnlyFillCells:Boolean = (_fixW == spas_internal::bounds.width - colsL * _hGap);
			if (hasOnlyFillCells) _fixW += _hGap;
			cellL = fillCells.length;
			//trace(cellL)
			if (cellL > 0) {
				for (i = cellL - 1; i >= 0; i--) {
					if ($target.autoWidth) _cols[fillCells[i]] = { length:_minWidth };
					else _cols[fillCells[i]] = { length: _fixW < 0 ? 0 : _fixW / cellL };
				}
			}
			//trace(_fixW / cellL);
			if (!hasOnlyFillCells) _fixW = spas_internal::bounds.width / (spas_internal::bounds.width - (_fixW + _hGap));
			n = spas_internal::bounds.width;
			for (i = _cols.length - 1; i >= 0; i--) {
				if ($target.autoWidth) {
					size = (_cols[i].hasOwnProperty("length")) ?_cols[i].length : _cols[i];
				} else if(cellL > 0){
					size = (_cols[i].hasOwnProperty("length")) ? _cols[i].length : (_fixW > 0 || hasOnlyFillCells ? _cols[i] : _cols[i] * _fixW);
				} else size = _cols[i] * _fixW;
				n -= Math.floor(size);
				_cols[i] = { origin:n, length:Math.floor(size) };
				n -= _hGap;
			}
			if ($target.autoWidth) {
				_fixW = n;
			} else {
				_fixW = 0;
				if (n != 0 && (hasOnlyFillCells || cellL == 0)) _cols[0].length += n;
				
			}
			_cols[0].origin = spas_internal::bounds.x + _fixW;
			
			_fixH = spas_internal::bounds.height;
			fillCells = [];
			for (i = rowsL - 1; i >= 0; i--) {
				n = _rows[i];
				if (n >= 1 || n == 0)  _fixH -= n + _vGap;
				else if (n == -1) {
					fillCells.push(i);
					_fixH -= _vGap;
				} else if (n > 0 && n < 1) {
					_rows[i] = n * spas_internal::bounds.height / 100;
					_fixH -= _rows[i] + _vGap;
				} else {
					throw new InvalidArgumentException(Locale.spas_internal::ERRORS.ROW_SIZE_ERROR);
				}
			}
			hasOnlyFillCells = (_fixH == spas_internal::bounds.height - rowsL * _vGap);
			
			if (hasOnlyFillCells) _fixH += _vGap;
			cellL = fillCells.length;
			if (cellL > 0) {
				for (i = cellL - 1; i >= 0; i--) {
					if ($target.autoHeight) _rows[fillCells[i]] = _minHeight;
					else  _rows[fillCells[i]] = { length: _fixH <0 ? 0 : _fixH / cellL };
				}
			}
			if (!hasOnlyFillCells) _fixH = spas_internal::bounds.height / (spas_internal::bounds.height - (_fixH + _vGap));
			n = spas_internal::bounds.height;
			for (i = _rows.length - 1; i >= 0; i--) {
				if ($target.autoHeight) {
					size = (_rows[i].hasOwnProperty("length")) ?_rows[i].length : _rows[i];
				} else if(cellL > 0){
					size = (_rows[i].hasOwnProperty("length")) ? _rows[i].length : (_fixH > 0 || hasOnlyFillCells ? _rows[i] : _rows[i] * _fixH);
				} else size = _rows[i] * _fixH;
				n -= Math.floor(size); 
				_rows[i] = { origin:n, length:Math.floor(size) };
				n -= _vGap;
			}
			if ($target.autoHeight) {
				_fixH = n;
			} else {
				_fixH = 0;
				if (n != 0 && (hasOnlyFillCells || cellL == 0)) _rows[0].length += n;
			}
			_rows[0].origin = spas_internal::bounds.y + _fixH;
			
			
			
			//fillCells = null;
		}
		
		private function applyLayout(cursor:int):void {
			_obj = $elementsList[cursor];
			invalidateEvent(_obj, true);
			if(_obj.constraints != null) {
				var a:Array = _obj.constraints.split(",");
				switch(a.length) {
					case 2 :
						setOneCellPosition(uint(a[0]) - 1, uint(a[1]) - 1);
						break;
					case 4 :
						setTwoCellsPosition(uint(a[0]) - 1, uint(a[1]) - 1, uint(a[2]) - 1, uint(a[3]) - 1);
						break;
				}
			} else {
				//setOneCellPosition(uint(a[0]) - 1, uint(a[1]) - 1);
			}
			invalidateEvent(_obj, false);
		}
		
		private var _oh:Object;
		private var _ov:Object;
		private var _r1:Rectangle;
		private var _r2:Rectangle;
		
		private function setOneCellPosition(colId:uint, rowId:uint):void {
			_oh = _cols[colId];
			_ov = _rows[rowId];
			var rh:Number = getHRatio() / 2;
			var rv:Number = getVRatio() / 2;
			_obj.x = _oh.origin + rv -_fixW; _obj.y = _ov.origin + rh - _fixH;
			_obj.width = _oh.length - rv; _obj.height = _ov.length - rh;
			//trace(_obj.y, _obj.height)
		}
		
		private function setTwoCellsPosition(col1Id:uint, row1Id:uint, col2Id:uint, row2Id:uint):void {
			_oh = _cols[col1Id];
			_ov = _rows[row1Id];
			_r1 = new Rectangle(_oh.origin, _ov.origin, _oh.length, _ov.length);
			_oh = _cols[col2Id];
			_ov = _rows[row2Id];
			_r2 = new Rectangle(_oh.origin, _ov.origin, _oh.length, _ov.length);
			var r:Rectangle = _r1.union(_r2);
			var rh:Number = getHRatio() / 2;
			var rv:Number = getVRatio() / 2;
			_obj.x = r.x + rv - _fixW; _obj.y = r.y + rh - _fixH;
			_obj.width = r.width - rv; _obj.height = r.height - rh;
		}
		
		private function invalidateEvent(element:*, value:Boolean):void { 
			if (element is UIObject)
				element.spas_internal::invalidateChangeEvent =
				element.spas_internal::deactivateMetricsChanges = value;
			if (element is UIContainer) element.spas_internal::invalidateLayoutUpdate = value;
		}
		
		private function getVRatio():Number {
			var r:Rectangle = _obj.getBounds(null);
			var fixedSize:Number = isNaN(_obj.width) ? 0 : _obj.width;
			return r.width + Math.abs(r.x) - fixedSize;
		}
		
		private function getHRatio():Number {
			var r:Rectangle = _obj.getBounds(null);
			var fixedSize:Number = isNaN(_obj.height) ? 0 : _obj.height;
			return r.height + Math.abs(r.y) - fixedSize;
		}
	}
}