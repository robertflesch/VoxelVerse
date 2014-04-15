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
	// TableCellUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/02/2009 18:56
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.util.ArrayUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>TableCellUtil</code> class is a utility class used by <code>DataGrid</code>
	 * 	object to layout header rows.
	 * 
	 * 	@see org.flashapi.swing.table.core.DataGridHeaderRow
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TableCellUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>TableCellUtil</code> instance.
		 */
		public function TableCellUtil() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An array that contains the map indications to define the grid used to
		 * 	compute this layout.
		 */
		public var rowMap:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _minWidth:Number = 25;
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Sets or gets the minimum witdh for all cells, in pixels.
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
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Sets or gets the minimum height for all cells, in pixels.
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
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fixW:Number;
		private var _cols:Array;
		private var _width:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function getCellsSizes(width:Number, gap:Number = 0):Array {
			if (rowMap == null) return [];
			if (width == _width) return _cols;
			_width = width;
			_cols = ArrayUtil.clone(rowMap);
			var len:Number = _cols.length;
			var n:Number;
			var i:int;
			var cellL:int;
			var size:Number;
			_fixW = _width;
			var fillCells:Array = [];
			for (i = len - 1; i >= 0; i--) {
				n = _cols[i];
				
				if (n >= 1 || n == 0)  _fixW -= n + gap;
				else if (n == -1) {
					fillCells.push(i);
					_fixW -= gap;
				} else if (n > 0 && n < 1) {
					_cols[i] = n * _width / 100;
					_fixW -= _cols[i] + gap;
				} else {
					throw new InvalidArgumentException(
						Locale.spas_internal::ERRORS.COLUMN_SIZE_ERROR
					);
				}
			}
			var hasOnlyFillCells:Boolean = (_fixW == _width - len * gap);
			if (hasOnlyFillCells) _fixW += gap;
			cellL = fillCells.length;
			//trace(cellL)
			if (cellL > 0) {
				for (i = cellL - 1; i >= 0; i--) _cols[fillCells[i]] = _fixW < 0 ? 0 : _fixW / cellL;
			}
			if (!hasOnlyFillCells) _fixW = _width / (_width - (_fixW + gap));
			n = _width;
			for (i = _cols.length - 1; i >= 0; i--) {
				if(cellL > 0) size = (_fixW > 0 || hasOnlyFillCells) ? _cols[i] : _cols[i] * _fixW;
				else size = _cols[i] * _fixW;
				n -= Math.floor(size);
				_cols[i] = Math.floor(size);
				n -= gap;
			}
			_fixW = 0;
			if (n != 0 && (hasOnlyFillCells || cellL == 0)) _cols[0] += n;
			return _cols;
		}
	}
}