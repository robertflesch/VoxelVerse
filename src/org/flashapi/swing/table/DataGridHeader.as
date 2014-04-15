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
	// DataGridHeader.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 15/03/2010 22:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.plaf.libs.DataGridHeaderUIRef;
	import org.flashapi.swing.renderer.DataGridHeaderRenderer;
	import org.flashapi.swing.renderer.ItemEditor;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.Text;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.util.FontFormatUtil;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DataGridHeader</code> class represents control objects used as
	 * 	<code>DataGridHeaderRenderer</code> within <code>DataGrid</code> instances.
	 * 
	 * 	<p>Typically, <code>DataGridHeader</code> controls allow users to interact with
	 * 	<code>DataGrid</code> objects by sorting data contained within a datagrid
	 * 	column or by moving columns to the order of data presentation.</p>
	 * 
	 * 	<p><strong><code>DataGridHeader</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-weight</code></td>
	 * 			<td>Sets the font weight of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">bold</code>.</td>
	 * 			<td><code>boldFace</code></td>
	 * 			<td><code>Properties.FONT_WEIGHT</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">icon-color</code></td>
	 * 			<td>Sets the color of the icon displayed within this object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>iconColor</code></td>
	 * 			<td><code>Properties.ICON_COLOR</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridHeader extends UIObject implements Observer, LafRenderer, DataGridHeaderRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DataGridHeader</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	label	The text displayed on the face of the <code>DataGridHeader</code>
		 * 					object.
		 * 	@param	width	The width of the <code>DataGridHeader</code> object, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>DataGridHeader</code> object, in
		 * 					pixels.
		 */
		public function DataGridHeader(label:String = "", width:Number = 150, height:Number = 22) {
			super();
			initObj(label, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _dataGridColumn:DataGridColumn;
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the <code>DataGridColumn</code> associated with this
		 * 	<code>DataGridHeader</code> object.
		 */
		public function get dataGridColumn():DataGridColumn {
			return _dataGridColumn;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set index(value:int):void {
			spas_internal::setIndex(value);
		}
		
		/**
		 *  @private
		 */
		private var _textCtrl:Text;
		/**
		 * 	A reference to the <code>Text</code> control that is used to display
		 * 	the text on the face of the <code>DataGridHeader</code> object.
		 */
		public function get textControl():Text {
			return _textCtrl;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>DataGridHeader</code>
		 * 	object can be selected (<code>true</code>), or not (<code>false</code>).
		 * 	
		 * 	@default false
		 * 
		 * 	@see #isSelected
		 */
		public function get selectable():Boolean {
			return _textCtrl.selectable;
		}
		public function set selectable(value:Boolean):void {
			_textCtrl.selectable = value;
		}
		
		/*override public function set height(value:Number):void {
			_height = _textCtrl.height = value;
		}*/
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			spas_internal::lafDTO.width = $width = value;
			fixTextWidth();
			setRefresh();
		}
		
		private var _selected:Boolean = false;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether this
		 * 	<code>DataGridHeader</code> object is currently selected (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #selectable
		 */
		public function get isSelected():Boolean {
			return _selected;
		}
		
		/**
		 *  @private
		 */
		protected var _label:String = null;
		/**
		 * 	@inheritDoc
		 */
		public function get label():String {
			return _label;
		}
		public function set label(value:String):void {
			_label = value;
			setRefresh();
		}
		
		private var _iconColor:*;
		/**
		 * 	@inheritDoc
		 */
		public function get iconColor():* {
			return _iconColor;
		}
		public function set iconColor(value:*):void {
			var val:* = value == StateObjectValue.NONE ? StateObjectValue.NONE : getColor(value);
			_iconColor = _iconColors.up = _iconColors.down = _iconColors.over =
			_iconColors.disabled = _iconColors.selected = val;
			setIconColors();
			setRefresh();
		}
		
		private var _iconColors:ColorState;
		/**
		 * 	@inheritDoc
		 */
		public function get iconColors():ColorState {
			return _iconColors;
		}
		public function set iconColors(value:ColorState):void { 
			_iconColors = value;
			setIconColors();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  TextItemRenderer API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function get boldFace():Boolean {
			return _textCtrl.boldFace;
		}
		public function set boldFace(value:Boolean):void {
			_textCtrl.boldFace = value;
		}
		
		private var _itemEditor:ItemEditor;
		/**
		 *  @inheritDoc
		 */
		public function get itemEditor():ItemEditor {
			return _itemEditor;
		}
		public function set itemEditor(value:ItemEditor):void {
			_itemEditor = value;
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
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_dataGridColumn = null;
			_textCtrl.finalize();
			_textCtrl = null;
			_icon.finalizeElements();
			_icon.clear();
			_icon.finalize();
			_icon = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API : public methods
		//
		//--------------------------------------------------------------------------
		
		private var _defaultFontFormat:FontFormat;
		/**
		 *  @inheritDoc
		 */
		public function initFontFormat(value:FontFormat):void {
			_defaultFontFormat = value;
			var fmt:TextFormat = new TextFormat();
			FontFormatUtil.copy(fmt, value);
			_textCtrl.textField.defaultTextFormat = fmt;
			_textCtrl.text = _label;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function updateItem(info:Object):void {
			_label = info.label;
			$data = info.data;
			setRefresh();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resetItem():void {
			_label = "";
			$data = null;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			fixTextWidth();
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			lookAndFeel.drawOutState();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_textCtrl.lockLaf(lookAndFeel.getTextLaf(), true);
			if (_defaultFontFormat != null) initFontFormat(_defaultFontFormat);
			
			_stateIcon =
				_icon.setBrush(lookAndFeel.getIcon(), _brushRect, _icon.spas_internal::lafDTO)
				as StateIcon;
			
			initIconColors();
			//setIconColors(true);
			
			//_ascIcon = UpIcon;
			//_dscIcon = DownIcon
		}
		
		/**
		 * @private
		 */
		protected function initIconColors():void {
			_iconColors.up = lookAndFeel.getOutIconColor();
			_iconColors.down = lookAndFeel.getPressedIconColor();
			_iconColors.over = lookAndFeel.getOverIconColor();
			_iconColors.disabled = lookAndFeel.getInactiveIconColor();
			setIconColors();
		}
		
		/**
		 * @private
		 */
		protected function setIconColors():void {
			(_icon.brush as StateBrush).colors = _iconColors;
		}
		
		/**
		 *  @private
		 */
		spas_internal function setSelected(value:Boolean, sortType:int):void {
			_selected = value;
			if (value) {
				_stateIcon.nextState = sortType;
				_stateIcon.paint();
				if (!_icon.displayed) _icon.display($width - _iconWidth - 4, ($height - _icon.height) / 2);
			} else {
				//_stateIcon.clear();
				_icon.remove();
			}
			fixTextWidth();
		}
		
		/**
		 *  @private
		 */
		spas_internal function setDataGridColumn(value:DataGridColumn):void {
			_dataGridColumn = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _iconHeight:Number = 20;
		private var _iconWidth:Number = 15;
		private var _icon:Icon;
		private var _stateIcon:StateIcon;
		//private var _ascIcon:Class;
		//private var _dscIcon:Class;
		private var _brushRect:Rectangle;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number):void {
			_label = label;
			initSize(width, height);
			spas_internal::lafDTO.currentTarget = spas_internal::uioSprite;
			createTextureManager(spas_internal::uioSprite);
			_iconColors = new ColorState(this);
			createControls();
			createColorsObj();
			initLaf(DataGridHeaderUIRef);
			createEvents();
			spas_internal::setSelector(Selectors.DATAGRID_HEADER);
			spas_internal::isInitialized(1);
		}
		
		private function createControls():void {
			_icon = new Icon();
			var w:Number = $width;
			_icon.x = w;
			_textCtrl = new Text(w, $height);
			_icon.target = _textCtrl.target = spas_internal::uioSprite;
			_textCtrl.text = _label;
			_textCtrl.selectable = false;
			
			_textCtrl.display();
			
			_brushRect = new Rectangle(0, 0, _iconHeight, _iconWidth);
		}
		
		private function createEvents():void {
			$evtColl.addEvent(this, MouseEvent.ROLL_OVER, rollOverHandler);
			$evtColl.addEvent(this, MouseEvent.ROLL_OUT, rollOutHandler);
			$evtColl.addEvent(this, MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function rollOverHandler(e:MouseEvent):void {
			if (!_dataGridColumn.sortable) return;
			lookAndFeel.drawOverState();
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			if (!_dataGridColumn.sortable) return;
			lookAndFeel.drawOutState();
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			//trace("mouseDownHandler");
			if (!_dataGridColumn.sortable) return;
			lookAndFeel.drawPressedState();
		}
		
		private function fixTextWidth():void {
			if(_icon.displayed) {
				_textCtrl.width = _icon.x = $width - _iconWidth - 4;
			} else _textCtrl.width = $width;
		}
	}
}