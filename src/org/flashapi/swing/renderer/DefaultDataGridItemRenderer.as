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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// DefaultDataGridItemRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/06/2009 16:05
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFormat;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.text.UITextField;
	import org.flashapi.swing.util.FontFormatUtil;
	
	/**
	 * 	The <code>DefaultDataGridItemRenderer</code> class defines the default item
	 * 	renderer for a <code>DataGrid</code> object.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DefaultDataGridItemRenderer extends UITextField implements DataGridItemRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DefaultDataGridItemRenderer</code> object
		 * 	with the specified parameters.
		 * 
		 * 	@param	width	The width of the <code>DefaultDataGridItemRenderer</code>
		 * 					object, in pixels.
		 * 	@param	height	The height of the <code>DefaultDataGridItemRenderer</code>
		 * 					object, in pixels.
		 */
		public function DefaultDataGridItemRenderer(width:Number = 150, height:Number = 20) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API : public properties
		//
		//--------------------------------------------------------------------------
		
		private var _index:int;
		/**
		 * 	@inheritDoc
		 */
		public function get index():int {
			return _index;
		}
		public function set index(value:int):void {
			_index = value;
		}
		
		private var _df:String;
		/**
		 * 	@inheritDoc
		 */
		public function get dataField():String {
			return _df;
		}
		public function set dataField(value:String):void {
			_df = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get boldFace():Boolean {
			return false;
		}
		public function set boldFace(value:Boolean):void {  }
		
		/**
		 *  @inheritDoc
		 */
		public function initFontFormat(value:FontFormat):void {
			var fmt:TextFormat = new TextFormat();
			FontFormatUtil.copy(fmt, value);
			defaultTextFormat = fmt;
			text = $label;
		}
		
		private var _editable:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get editable():Boolean {
			return _editable;
		}
		public function set editable(value:Boolean):void {
			_editable = value;
		}
		
		private var _itemEditor:ItemEditor = null;
		/**
		 * 	@inheritDoc
		 */
		public function get itemEditor():ItemEditor {
			return _itemEditor;
		}
		public function set itemEditor(value:ItemEditor):void {
			_itemEditor = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API : public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function updateItem(info:Object):void {
			$label = text = info.toString();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resetItem():void {
			$label = text = "";
			$data = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function setFontColor(color:uint):void {
			this.textColor = color;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			this.resetItem();
			this.height = height;
			selectable = false;
			//spas_internal::setSelector("defaultdatagriditem");
		}
	}
}