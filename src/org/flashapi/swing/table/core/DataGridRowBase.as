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
	// DataGridRowBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 30/03/2010 15:46
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.DataGrid;
	import org.flashapi.swing.Element;
	import org.flashapi.swing.layout.TableRowLayout;
	import org.flashapi.swing.renderer.TextItemRenderer;
	import org.flashapi.swing.text.FontFormat;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>DataGridRowBase</code> class is the base class for all objects
	 * 	that are used by <code>DataGrid</code> instances to manage items within a
	 * 	row.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridRowBase extends Canvas {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DataGridRowBase</code> instance for the
		 * 	specified <code>DataGrid</code> object.
		 * 
		 * 	@param	datagrid	The <code>DataGrid</code> object where the
		 * 						row of items will be displayed.
		 */
		public function DataGridRowBase(datagrid:DataGrid) {
			super();
			initObj(datagrid);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns an array collection that contains all items displayed within
		 * 	this row.
		 * 
		 * 	@see #length
		 */
		public function get children():Array {
			return getElements();
		}
		
		/**
		 * 	Returns the number of items displayed within this row.
		 * 
		 * 	@see #children
		 */
		public function get length():int {
			return numElements;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selected</code> property.
		 * 
		 * 	@see #selected
		 */
		protected  var $selected:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the row is currently
		 * 	selected within the <code>DataGrid</code> object (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get selected():Boolean {
			return $selected;
		}
		public function set selected(value:Boolean):void {
			$selected = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>rowItem</code> property.
		 * 
		 * 	@see #rowItem
		 */
		protected var $rowItem:Object = null;
		/**
		 * 	Returns a reference to the <code>Object</code> used within the <code>DataGrid</code>
		 * 	instance to decribe this row.
		 * 
		 * 	@default null
		 */
		public function get rowItem():Object {
			return $rowItem;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>datagrid</code> property.
		 * 
		 * 	@see #datagrid
		 */
		protected var $datagrid:DataGrid;
		/**
		 * 	Returns a reference to the row parent <code>DataGrid</code>.
		 */
		public function get datagrid():DataGrid {
			return $datagrid;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>Element</code> object contained within this row at the 
		 * 	specified index.
		 * 
		 * 	@param	index	The index position of the element. 
		 * 
		 * 	@return The <code>Element</code> contained within this row at the 
		 * 			specified index.
		 */
		public function getItemAt(index:uint):Element {
			return getElementAt(index);
		}
		
		/**
		 * @private
		 */
		override public function finalize():void {
			spas_internal::finalizeRowElements();
			$datagrid = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function setGridMap():void {
			$width = $datagrid.spas_internal::dataWidth;
			(layout as TableRowLayout).rowMap = $datagrid.spas_internal::columnsSizes;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Currently unnused.
		 */
		spas_internal function getDataGrid():DataGrid {
			return $datagrid;
		}
		
		/**
		 * 	@private
		 */
		protected function initRendererTextFormat(item:*, fmt:FontFormat):void {
			if (item is TextItemRenderer) item.initFontFormat(fmt);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function finalizeRowElements():void {
			finalizeElements();
			$rowItem = null; 
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(datagrid:DataGrid):void {
			$autoAdjustSize = false;
			$datagrid = datagrid;
			this.layout = new TableRowLayout();
			$height = 20;
			//_width = datagrid.spas_internal::dataWidth;
		}
	}
}