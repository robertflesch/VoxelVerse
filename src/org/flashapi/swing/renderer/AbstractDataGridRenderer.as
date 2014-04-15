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
	// AbstractDataGridRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/03/2011 15:12
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.containers.SimpleContainerBase;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.text.FontFormat;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>AbstractDataGridRenderer</code> class defines the abstract class that you
	 * 	must extend to create custom item renderers for a <code>DataGrid</code> object.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class AbstractDataGridRenderer extends SimpleContainerBase implements DataGridItemRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AbstractDataGridRenderer</code> object
		 * 	with the specified parameters.
		 * 
		 * 	@param	width	The width of the <code>AbstractDataGridRenderer</code>
		 * 					object, in pixels.
		 * 	@param	height	The height of the <code>AbstractDataGridRenderer</code>
		 * 					object, in pixels.
		 */
		public function AbstractDataGridRenderer(width:Number = 20, height:Number = 20) {
			super(width, height);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API : public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function set index(value:int):void {
			spas_internal::setIndex(value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>dataField</code> property.
		 * 
		 * 	@see #dataField
		 */
		protected var $dataField:String;
		/**
		 * 	@inheritDoc
		 */
		public function get dataField():String {
			return $dataField;
		}
		public function set dataField(value:String):void {
			$dataField = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>boldFace</code> property.
		 * 
		 * 	@see #boldFace
		 */
		protected var $boldFace:Boolean = false;
		/**
		 *  @private
		 */
		public function get boldFace():Boolean {
			return $boldFace;
		}
		public function set boldFace(value:Boolean):void {
			$boldFace = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>editable</code> property.
		 * 
		 * 	@see #editable
		 */
		protected var $editable:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get editable():Boolean {
			return $editable;
		}
		public function set editable(value:Boolean):void {
			$editable = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>itemEditor</code> property.
		 * 
		 * 	@see #itemEditor
		 */
		protected var $itemEditor:ItemEditor = null;
		/**
		 * 	@inheritDoc
		 */
		public function get itemEditor():ItemEditor {
			return $itemEditor;
		}
		public function set itemEditor(value:ItemEditor):void {
			$itemEditor = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>label</code> property.
		 * 
		 * 	@see #label
		 */
		protected var $label:String;
		/**
		 * 	@inheritDoc
		 */
		public function get label():String {
			return $label;
		}
		public function set label(value:String):void {
			$label = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function initFontFormat(value:FontFormat):void { }
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API : public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function updateItem(info:Object):void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function resetItem():void {
			this.removeElements();
			$data = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function setFontColor(color:uint):void { }
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$autoAdjustSize = false;
		}
	}
}