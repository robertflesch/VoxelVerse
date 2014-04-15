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
	// TableRow.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 04/06/2009 23:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.Table;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>TableRow</code> class represents a row of <code>TableCell</code>
	 * 	objects within a <code>Table</code> instance.
	 * 
	 * 	@see org.flashapi.swing.Table
	 * 	@see org.flashapi.swing.table.TableCell
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TableRow {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>TableRow</code> instance for the
		 * 	specified <code>Table</code> object.
		 * 
		 * 	@param	target	The <code>Table</code> object where the row of cells
		 * 					will be displayed.
		 */
		public function TableRow(target:Table) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>data</code> property lets you pass a value to the
		 * 	<code>TableRow</code> instance.
		 * 
		 * 	@default null
		 */
		public var data:* = null;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		private var _height:Number = NaN;
		/**
		 *  Sets or gets the height of the row, in pixels.
		 * 
		 *  @default NaN
		 */
		public function get height():Number {
			return _height;
		}
		public function set height(value:Number):void {
			_height = value;
		}
		
		/**
		 * 	Returns the number of cells displayed within this row.
		 * 
		 * 	@see #children
		 */
		public function get length():int {
			return _stack.length;
		}
		
		/**
		 * 	Returns an array collection that contains all cells displayed within
		 * 	this row.
		 * 
		 * 	@see #length
		 */
		public function get children():Array {
			return _stack;
		}
		
		/**
		 * 	Returns the CSS selector value of the <code>TableRow</code> instance.
		 * 
		 * 	@default Selectors.TR
		 */
		public function get selector():String {
			return Selectors.TR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>Cell</code> object contained within this row at the 
		 * 	specified index.
		 * 
		 * 	@param	index	The index position of the cell. 
		 * 
		 * 	@return The <code>Cell</code> contained within this row at the specified
		 * 			index.
		 */
		public function getCellAt(index:uint):Cell {
			return _stack[index];
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function addCell(value:Cell):void {
			_stack.push(value);
			value.spas_internal::tblRow = this;
		}
		
		/**
		 * @private
		 */
		spas_internal function removeCell(value:Cell):void {
			if(_stack.indexOf(value)==-1) return;
			else _stack.splice(_stack.indexOf(value), 1);
		}
		
		/**
		 * @private
		 */
		spas_internal function finalize():void {
			_target = null;
			var l:int = _stack.length - 1;
			for (; l >= 0; l--) {
				_stack[l].finalize();
				_stack[l] = null;
			}
			_stack = [];
			_stack = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:Array;
		private var _target:Table;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:Table):void {
			_target = target;
			_stack = [];
		}
	}
}