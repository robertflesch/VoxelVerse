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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	//  DataGrid.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 0.9.7, 12/04/2011 03:09
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.ScrollTargetPolicy;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.KeyObserver;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.databinding.XMLSerializer;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.DataGridEvent;
	import org.flashapi.swing.event.ItemEditorEvent;
	import org.flashapi.swing.event.ItemRendererEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.layout.TableVerticalLayout;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.managers.KeyboardManager;
	import org.flashapi.swing.plaf.libs.DataGridUIRef;
	import org.flashapi.swing.renderer.DefaultDataGridItemRenderer;
	import org.flashapi.swing.renderer.DefaultItemEditor;
	import org.flashapi.swing.renderer.ItemEditor;
	import org.flashapi.swing.renderer.ItemRenderer;
	import org.flashapi.swing.scroll.ColorizableScrollbar;
	import org.flashapi.swing.scroll.Scrollable;
	import org.flashapi.swing.table.core.DataGridHeaderContainer;
	import org.flashapi.swing.table.core.DataGridHeaderRow;
	import org.flashapi.swing.table.core.DataGridSeparatorButton;
	import org.flashapi.swing.table.core.RowDTO;
	import org.flashapi.swing.table.DataGridColumn;
	import org.flashapi.swing.table.DataGridHeader;
	import org.flashapi.swing.table.DataGridRow;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.util.ArrayUtil;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DataGrid.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>DataGrid</code> changes value due to mouse or
	 * 	keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>DataGrid</code> instance has finished using
	 * 	data provided by the <code>DataProvider</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the <code>DataGrid</code> instance has finished using
	 * 	data provided by the <code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the user clicks on a row of the <code>DataGrid</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.DataGridEvent.ROW_PRESSED
	 */
	[Event(name = "rowPressed", type = "org.flashapi.swing.event.DataGridEvent")]
	
	/**
	 *  Dispatched when the user double clicks on a row of the <code>DataGrid</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.DataGridEvent.ROW_DOUBLE_CLICK
	 */
	[Event(name = "rowDoubleClick", type = "org.flashapi.swing.event.DataGridEvent")]
	
	/**
	 * 	<img src="DataGrid.png" alt="DataGrid" width="18" height="18"/>
	 * 
	 * 	[This class is under development.]
	 * 
	 *  The <code>DataGrid</code> class defines a data bound list control that
	 * 	displays the items from data source in a table.
	 * 
	 * 	<p>A <code>DataGrid</code> object allows you to select, sort, and edit these items.
	 * 	Moreover, it provides the following features:</p>
	 * 	<ul>
	 * 		<li>Columns of different widths or identical fixed widths.</li>
	 * 		<li>Columns that the user can resize at runtime.</li>
	 * 		<li>Columns that the user can reorder at runtime.</li>
	 * 		<li>Optional customizable column headers.</li>
	 * 		<li>Optional customizable column colors.</li>
	 * 		<li>Ability to use a custom item renderer for any column to display
	 * 		data other than text.</li>
	 * 		<li>Ability to use a custom background colors or textures for each row.</li>
	 * 	</ul>
	 * 
	 * 	<p>The <code>DataGrid</code> class is intended for viewing data, and not as a
	 * 	layout tool like an HTML table. The <code>Table</code> class provides
	 * 	this layout tool.</p>
	 * 
	 * 	<p>For a list of CSS properties supported by <code>ColorizableScrollbar</code> 
	 * 	objects see: <a href="scroll/ColorizableScrollbar.html"
	 * 	title="org.flashapi.swing.scroll.ColorizableScrollbar">
	 * 	<code>org.flashapi.swing.scroll.ColorizableScrollbar</code></a>.</p>
	 *
	 * 	<p><strong><code>DataGrid</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">row-bright-color</code></td>
	 * 			<td>Represents the color of a "bright" row item.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>rowBrightColor</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">row-dark-color</code></td>
	 * 			<td>Represents the color of a "dark" row item.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>rowDarkColor</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">row-selected-color</code></td>
	 * 			<td>Represents the background color of the selected row.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>rowSelectedColor</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">row-selected-color</code></td>
	 * 			<td>Represents the background color of a row  when the user rolls over it.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>rowOverColor</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">header-background-color</code></td>
	 * 			<td>Represents the background color of datagrid headers.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>headerBackgroundColor</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.Table
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.plaf.DataGridUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@includeExample DataGridExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class DataGrid extends ALM implements Observer, Listable, LafRenderer, Border, ColorizableScrollbar, Initializable, KeyObserver {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>DataGrid</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param width 	The width of the <code>DataGrid</code> instance, in pixels.
		 * 	@param itemsNum	The number of rows diplayed by the <code>DataGrid</code>
		 * 					instance.
		 * 	@param height 	The height of the <code>DataGrid</code> instance, in pixels.
		 */
		public function DataGrid(width:Number = 300, itemsNum:uint = 6, height:Number = NaN) {
			super();
			initObj(width, itemsNum, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		//public var onItemAdded:Function;
		//public var onItemRemoved:Function;
		//public var onItemUpdated:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _showHeader:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether the datagrid header is
		 * 	displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get showHeaders():Boolean {
			return _showHeader;
		}
		public function set showHeaders(value:Boolean):void {
			spas_internal::headerContainer.visible = _showHeader = value;
			fixPositions();
			setRefresh();
		}
		
		private var _showScrollBar:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether the datagrid scrollbar is
		 * 	displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get showScrollBar():Boolean {
			return _showScrollBar;
		}
		public function set showScrollBar(value:Boolean):void {
			_showScrollBar = value;
			spas_internal::vScroll.visible = value;
			setRefresh();
		}
		
		private var _showSeparators:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the separation  
		 * 	lines between each columns are visible (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 	
		 * 	@default true
		 */
		public function get showSeparators():Boolean {
			return _showSeparators;
		}
		public function set showSeparators(value:Boolean):void {
			_showSeparators = value;
			_showSeparators ? drawSeparators() : _separators.graphics.clear();
		}
		
		private var _rowBrightColor:* = NaN;
		/**
		 * 	Sets or gets the "bright" color of the datagrid rows.
		 * 	The <code>DataGrid</code> class renders rows by alternating "bright" and
		 * 	"dark" colors. The <code>rowBrightColor</code> represents the color
		 * 	of a "bright" row item. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	@default NaN
		 * 
		 * 	@see #rowDarkColor
		 * 	@see #rowBrightTexture
		 * 	@see #rowDarkTexture
		 */
		public function get rowBrightColor():* {
			return _rowBrightColor;
		}
		public function set rowBrightColor(value:*):void {
			_rowBrightColor = value;
			changeRowColors();
			drawRowsBackground();
		}
		
		private var _rowDarkColor:* = NaN;
		/**
		 * 	Sets or gets the "dark" color of the datagrid rows.
		 * 	The <code>DataGrid</code> class renders rows by alternating "bright" and
		 * 	"dark" colors. The <code>rowDarkColor</code> represents the color
		 * 	of a "dark" row item. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	@default NaN
		 * 
		 * 	@see #rowBrightColor
		 * 	@see #rowBrightTexture
		 * 	@see #rowDarkTexture
		 */
		public function get rowDarkColor():* {
			return _rowDarkColor;
		}
		public function set rowDarkColor(value:*):void {
			_rowDarkColor = value;
			changeRowColors();
			drawRowsBackground();
		}
		
		private var _rowSelectedColor:* = 0x999999;
		/**
		 * 	The color of the background for the specified row when the user selects  
		 * 	an item renderer in the datagrid. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	@default NaN
		 */
		public function get rowSelectedColor():* {
			return _rowSelectedColor;
		}
		public function set rowSelectedColor(value:*):void {
			_rowSelectedColor = getColor(value);
			//changeRowColors();
		}
		
		private var _rowOverColor:* = 0xCCCCCC;
		/**
		 * 	The color of the specified row background when the user rolls over an
		 * 	item renderer in the datagrid. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	@default NaN
		 */
		public function get rowOverColor():* {
			return _rowOverColor;
		}
		public function set rowOverColor(value:*):void {
			_rowOverColor = getColor(value);
			//changeRowColors();
		}
		
		private var _rowBrightTexture:BitmapData = null;
		/**
		 * 	Returns a reference to the <code>BitmapData</code> used as texture for the
		 * 	datagrid "bright" rows. Returns <code>null</code> is no texture is currently
		 * 	defined.
		 * 	
		 * 	<p>The <code>DataGrid</code> class renders rows by alternating "bright" and
		 * 	"dark" colors. The <code>rowBrightTexture</code> represents the texture
		 * 	of a "bright" row item. To set the texture of a "bright" row item, use the
		 * 	<code>setRowBrightTexture()</code> method.</p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #rowBrightColor
		 * 	@see #rowDarkColor
		 * 	@see #rowDarkTexture
		 * 	@see #setRowBrightTexture()
		 * 	@see #setRowDarkTexture()
		 */
		public function get rowBrightTexture():BitmapData {
			return _rowBrightTexture;
		}
		
		private var _rowDarkTexture:BitmapData = null;
		/**
		 * 	Returns a reference to the <code>BitmapData</code> used as texture for the
		 * 	datagrid "dark" rows. Returns <code>null</code> is no texture is currently
		 * 	defined.
		 * 	
		 * 	<p>The <code>DataGrid</code> class renders rows by alternating "bright" and
		 * 	"dark" colors. The <code>rowDarkTexture</code> represents the texture
		 * 	of a "dark" row item.To set the texture of a "dark" row item, use the
		 * 	<code>setRowDarkTexture()</code> method.</p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #rowBrightColor
		 * 	@see #rowDarkColor
		 * 	@see #rowBrightTexture
		 * 	@see #setRowBrightTexture()
		 * 	@see #setRowDarkTexture()
		 */
		public function get rowDarkTexture():BitmapData {
			return _rowDarkTexture;
		}
		
		private var _itemsNum:uint;
		/**
		 * 	The number of rows diplayed within the datagrid.
		 * 	
		 * 	@default 6
		 */
		public function get itemsNum():uint {
			return _itemsNum;
		}
		public function set itemsNum(value:uint):void {
			_itemsNum = value;
			setHeight($height);
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		spas_internal var headerItemRenderer:Class = DataGridHeader;
		/**
		 * 	Returns a reference to the class used as <code>DataGridHeaderRenderer</code>
		 * 	by this <code>DataGrid</code> instance.
		 * 
		 * 	@default DataGridHeader
		 * 
		 * 	@see #defaultItemRenderer
		 * 	@see #defaultItemEditor
		 * 	@see #defaultHeaderFontFormat
		 */
		public function get defaultHeaderItemRenderer():Class {
			return spas_internal::headerItemRenderer;
		}
		/*public function set defaultHeaderItemRenderer(value:Class):void { 
			headerItemRenderer = value;
		}*/
		
		private var _defaultItemRenderer:Class = DefaultDataGridItemRenderer;
		/**
		 * 	Sets or gets the default <code>DataGridItemRenderer</code> class 
		 * 	to be used by this <code>DataGrid</code> instance.
		 * 
		 * 	@default DefaultDataGridItemRenderer
		 * 
		 * 	@see #defaultHeaderItemRenderer
		 * 	@see #defaultItemEditor
		 * 	@see #defaultItemRendererFontFormat
		 */
		public function get defaultItemRenderer():Class {
			return _defaultItemRenderer;
		}
		public function set defaultItemRenderer(value:Class):void {
			_defaultItemRenderer = value;
		}
		
		private var _defaultItemEditor:ItemEditor;
		/**
		 * 	Sets or gets the default <code>ItemEditor</code> instance to be used
		 * 	by this <code>DataGrid</code> instance to edit <code>DataGridItemRenderer</code> 
		 * 	objects.
		 * 
		 * 	@default DefaultDataGridItemRenderer
		 * 
		 * 	@see #defaultHeaderItemRenderer
		 * 	@see #defaultItemRenderer
		 */
		public function get defaultItemEditor():ItemEditor {
			return _defaultItemEditor;
		}
		public function set defaultItemEditor(value:ItemEditor):void {
			_defaultItemEditor = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var itemFontFormat:FontFormat;
		/**
		 * 	@private
		 */
		private var _useDefaultItemFontFormat:Boolean = true;
		/**
		 * 	Sets or gets the <code>FontFormat</code> object used by default to format
		 * 	row texts within this <code>DataGrid</code> instance. The  default font
		 * 	format is defined by the current Look and Feel.
		 * 
		 * 	@see #defaultItemRenderer
		 */
		public function get defaultItemRendererFontFormat():FontFormat {
			return spas_internal::itemFontFormat;
		}
		public function set defaultItemRendererFontFormat(value:FontFormat):void {
			if(value != null) {
				_useDefaultItemFontFormat = false;
				spas_internal::itemFontFormat = value;
			} else {
				_useDefaultItemFontFormat = true;
				spas_internal::itemFontFormat = lookAndFeel.getDefautFontFormat();
			}
			spas_internal::upFontColor = spas_internal::itemFontFormat.color;
			if (_rowsCont.numElements == 0) return;
			var l:int = _rowsNum-1;
			for (; l>=0; l--) _rowsCont.getObjectAt(l).updateTextFormat();
		}
		
		/**
		 * 	@private
		 */
		spas_internal var headerFontFormat:FontFormat;
		/**
		 * 	Sets or gets the <code>FontFormat</code> object used by default to format
		 * 	header row texts within this <code>DataGrid</code> instance. The  default 
		 * 	header font format is defined by the current Look and Feel.
		 * 
		 * 	@see #defaultHeaderItemRenderer
		 */
		public function get defaultHeaderFontFormat():FontFormat {
			return spas_internal::headerFontFormat;
		}
		public function set defaultHeaderFontFormat(value:FontFormat):void {
			spas_internal::headerFontFormat = value;
		}
		
		private var _defaultRowHeight:Number = 20;
		/**
		 * 	Sets or gets the height used by default to render row items within this
		 * 	<code>DataGrid</code> instance.
		 * 
		 * 	@default 20
		 * 
		 * 	@see #headerHeight
		 */
		public function get defaultRowHeight():Number {
			return _defaultRowHeight;
		}
		public function set defaultRowHeight(value:Number):void {
			_defaultRowHeight = value;
			setHeight($height);
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		private var _headerHeight:Number = 22;
		/**
		 * 	Sets or gets the height used by default to render header items within this
		 * 	<code>DataGrid</code> instance.
		 * 
		 * 	@see #defaultRowHeight
		 */
		public function get headerHeight():Number {
			return _headerHeight;
		}
		public function set headerHeight(value:Number):void {
			_headerHeight = value;
			setRefresh();
		}
		
		/*
		private var _headerPosition:String = "top";
		
		public function get headerPosition():String {
			return _headerPosition;
		}
		public function set headerPosition(value:String):void {
			_headerPosition = value;
		}
		*/
		
		/**
		 * 	The background color of the datagrid headers row. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 */
		public function get headerBackgroundColor():* {
			return spas_internal::headerContainer.color;
		}
		public function set headerBackgroundColor(value:*):void {
			spas_internal::headerContainer.color = value;
		}
		
		/**
		 *  @private
		 */
		override public function get height():Number {
			//return _itemsHeightMode ? _content.y + _dataViewHeight : _height;
			return _currHeight;
		}
		override public function set height(value:Number):void {
			setHeight(value);
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		private var _minColWidth:Number = 25;
		/**
		 * 	[Partially implemented.]
		 * 
		 * 	Returns the minimum witdh of a column within this <code>DataGrid</code>
		 * 	instance.
		 * 
		 * 	@default 25
		 */
		public function get minColumnWidth():Number {
			return _minColWidth;
		}
		//public function set minColumnWidth(value:Number):void { _minColWidth = value; }
		
		/**
		 * 	@private
		 */
		spas_internal var enableRowsDrag:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the datagrid rows  
		 * 	can be used to perform a Drag and Drop Operation (<code>true</code>), or 
		 * 	not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get rowsDragEnabled():Boolean {
			return spas_internal::enableRowsDrag;
		}
		public function set rowsDragEnabled(value:Boolean):void {
			spas_internal::enableRowsDrag = value;
			updateDragEnabled();
		}
		
		/**
		 * 	@private
		 */
		spas_internal var upFontColor:*;
		/**
		 * 
		 * 
		 * 	@see #rowFontOverColor
		 * 	@see #rowFontDownColor
		 * 	@see #rowFontSelectedColor
		 */
		public function get rowFontUpColor():* {
			return spas_internal::upFontColor;
		}
		public function set rowFontUpColor(value:*):void {
			spas_internal::upFontColor = getColor(value);
		}
		
		/**
		 * 	@private
		 */
		spas_internal var overFontColor:*;
		/**
		 * 
		 * 	@see #rowFontUpColor
		 * 	@see #rowFontDownColor
		 * 	@see #rowFontSelectedColor
		 */
		public function get rowFontOverColor():* {
			return spas_internal::overFontColor;
		}
		public function set rowFontOverColor(value:*):void {
			spas_internal::overFontColor = getColor(value);
		}
		
		/**
		 * 	@private
		 */
		spas_internal var downFontColor:*;
		/**
		 * 
		 * 	@see #rowFontUpColor
		 * 	@see #rowFontOverColor
		 * 	@see #rowFontSelectedColor
		 */
		public function get rowFontDownColor():* {
			return spas_internal::downFontColor;
		}
		public function set rowFontDownColor(value:*):void {
			spas_internal::downFontColor = getColor(value);
		}
		
		/**
		 * 	@private
		 */
		spas_internal var selectedFontColor:*;
		/**
		 * 
		 * 	@see #rowFontUpColor
		 * 	@see #rowFontOverColor
		 * 	@see #rowFontDownColor
		 */
		public function get rowFontSelectedColor():* {
			return spas_internal::selectedFontColor;
		}
		public function set rowFontSelectedColor(value:*):void {
			spas_internal::selectedFontColor = getColor(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Border API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	The BorderDecorator instance for this datagrid.
		 */
		spas_internal var borderDecorator:BorderDecorator;
		
		/**
		 *	@inheritDoc
		 */
		public function get backgroundContainer():Sprite {
			return spas_internal::background;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundWidth():Number {
			return $width;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundHeight():Number {
			//return _itemsHeightMode ? _content.y + _dataViewHeight : _height;
			return _currHeight;
		}
		
		/**
		 *	@inheritDoc
		 */
		public function get bordersContainer():Sprite {
			return spas_internal::borders;
		}
		
		private var _borderStyle:String = BorderStyle.SOLID;
		/**
		 *	@inheritDoc
		 */
		public function get borderStyle():String {
			return _borderStyle;
		}
		public function set borderStyle(value:String):void {
			_borderStyle = value;
			redrawDecorator();
		}
		
		private var _btColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopColor():* {
			return _btColor;
		}
		public function set borderTopColor(value:*):void {
			_btColor = getColor(value);
			redrawDecorator();
		}
		
		private var _brColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightColor():* {
			return _brColor;
		}
		public function set borderRightColor(value:*):void {
			_brColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bbColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomColor():* {
			return _bbColor;
		}
		public function set borderBottomColor(value:*):void {
			_bbColor = getColor(value);
			redrawDecorator();
		}
		
		private var _blColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftColor():* {
			return _blColor;
		}
		public function set borderLeftColor(value:*):void {
			_blColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bShadowColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowColor():* {
			return _bShadowColor;
		}
		public function set borderShadowColor(value:*):void {
			_bShadowColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bHighlightColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightColor():* {
			return _bHighlightColor;
		}
		public function set borderHighlightColor(value:*):void {
			_bHighlightColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bto:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopOpacity():Number {
			return _bto;
		}
		public function set borderTopOpacity(value:Number):void {
			_bto = value;
			redrawDecorator();
		}
		
		private var _bro:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightOpacity():Number {
			return _bro;
		}
		public function set borderRightOpacity(value:Number):void {
			_bro = value;
			redrawDecorator();
		}
		
		private var _bbo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomOpacity():Number {
			return _bbo;
		}
		public function set borderBottomOpacity(value:Number):void {
			_bbo = value;
			redrawDecorator();
		}
		
		private var _blo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftOpacity():Number {
			return _blo;
		}
		public function set borderLeftOpacity(value:Number):void {
			_blo = value;
			redrawDecorator();
		}
		
		private var _bso:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowOpacity():Number {
			return _bso;
		}
		public function set borderShadowOpacity(value:Number):void {
			_bso = value;
			redrawDecorator();
		}
		
		private var _bho:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightOpacity():Number {
			return _bho;
		}
		public function set borderHighlightOpacity(value:Number):void {
			_bho = value;
			redrawDecorator();
		}
		
		/**
		 *  @private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Calls the redrawing functions od the BorderDecorator instance.
		 */
		private function redrawDecorator():void {
			spas_internal::borderDecorator.drawBackground();
			spas_internal::borderDecorator.drawBorders();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  ColorizableScrollbar API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarArrowColor():* {
			return spas_internal::vScroll.scrollbarArrowColor;
		}
		public function set scrollbarArrowColor(value:*):void {
			spas_internal::vScroll.scrollbarArrowColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarBaseColor():* {
			return spas_internal::vScroll.scrollbarBaseColor;
		}
		public function set scrollbarBaseColor(value:*):void {
			spas_internal::vScroll.scrollbarBaseColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarFaceColor():* {
			return spas_internal::vScroll.scrollbarFaceColor;
		}
		public function set scrollbarFaceColor(value:*):void {
			spas_internal::vScroll.scrollbarFaceColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarHighlightColor():* {
			return spas_internal::vScroll.scrollbarHighlightColor;
		}
		public function set scrollbarHighlightColor(value:*):void {
			spas_internal::vScroll.scrollbarHighlightColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarShadowColor():* {
			return spas_internal::vScroll.scrollbarShadowColor;
		}
		public function set scrollbarShadowColor(value:*):void {
			spas_internal::vScroll.scrollbarShadowColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarTrackColor():* {
			return spas_internal::vScroll.scrollbarTrackColor;
		}
		public function set scrollbarTrackColor(value:*):void {
			spas_internal::vScroll.scrollbarTrackColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarJoinColor():* {
			return spas_internal::vScroll.scrollbarJoinColor;
		}
		public function set scrollbarJoinColor(value:*):void {
			spas_internal::vScroll.scrollbarJoinColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarInactiveJoinColor():* {
			return spas_internal::vScroll.scrollbarInactiveJoinColor;
		}
		public function set scrollbarInactiveJoinColor(value:*):void {
			spas_internal::vScroll.scrollbarInactiveJoinColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarInactiveTrackColor():* {
			return spas_internal::vScroll.scrollbarInactiveTrackColor;
		}
		public function set scrollbarInactiveTrackColor(value:*):void{
			spas_internal::vScroll.scrollbarInactiveTrackColor  = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var rendererCollection:Dictionary;
		
		/**
		 * 	Adds a new <code>DataGridItemRenderer</code> class reference, associated 
		 * 	with the specified <code>dataField</code> parameter.
		 * 
		 * 	@param	dataField	Name of the field in the data provider items to 
		 * 						display as the item renderer.
		 * 	@param	itemRendererRef	The class reference of the <code>DataGridItemRenderer</code>
		 * 							to associate with the specified <code>dataField</code>.
		 * 
		 * 	@see #getItemRendererRef
		 * 	@see #removeItemRendererRef
		 */
		public function addItemRendererRef(dataField:String, itemRendererRef:Class):void {
			spas_internal::rendererCollection[dataField] = itemRendererRef;
			updateItemRenderers(dataField, itemRendererRef);
		}
		
		/**
		 * 	Returns the <code>DataGridItemRenderer</code> class reference associated  
		 * 	with the specified <code>dataField</code> parameter.
		 * 
		 * 	@param	dataField	Name of the field in the data provider items for  
		 * 						which to return the item renderer.
		 * 
		 * 	@see #addItemRendererRef
		 * 	@see #removeItemRendererRef
		 * 
		 * 	@return The <code>DataGridItemRenderer</code> class reference associated 
		 * 	with the specified <code>dataField</code> parameter.
		 */
		public function getItemRendererRef(dataField:String):Class {
			return spas_internal::rendererCollection[dataField];
		}
		
		/**
		 * 	Removes the <code>DataGridItemRenderer</code> class reference associated 
		 * 	with the specified <code>dataField</code> parameter.
		 * 
		 * 	@param	dataField	Name of the field in the data provider items for 
		 * 						which to remove the item renderer.
		 * 
		 * 	@see #addItemRendererRef
		 * 	@see #getItemRendererRef
		 */
		public function removeItemRendererRef(dataField:String):void {
			updateItemRenderers(dataField, _defaultItemRenderer);
			spas_internal::rendererCollection[dataField] = null;
			delete spas_internal::rendererCollection[dataField];
		}
		
		private function updateItemRenderers(dataField:String, itemRendererRef:Class):void {
			var l:int = spas_internal::columns.length - 1;
			var i:int = 0;
			var colIndex:int = -1;
			for (; i <= l; ++i) {
				if (spas_internal::columns[i].dataField == dataField) {
					colIndex = i;
					break;
				}
			}
			var itemSize:int = $objList.size;
			if (colIndex == -1) return;
			
			i = 0;
			var j:int = _currentDataCursor;
			l = _rowsCont.numElements -1;
			var dgr:DataGridRow;
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			var info:*;
			for (; i <= l; ++i, ++j) {
				var obj:Object = itemSize > j ? $objList.get(j).item : null;
				info = obj != null ? obj[dataField] : null;
				dgr = _rowsCont.getObjectAt(i) as DataGridRow;
				dgr.spas_internal::updateItemRenderer(colIndex, itemRendererRef, info, dataField);
			}
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemEditor API
		//
		//--------------------------------------------------------------------------
		
		private var _editorCollection:Dictionary;
		
		/**
		 * 	Adds a new <code>ItemEditor</code> class reference, associated with the
		 * 	specified <code>dataField</code> parameter.
		 * 
		 * 	@param	dataField	Name of the field in the data provider items to 
		 * 						display as the item editor.
		 * 	@param	itemEditorRef	The class reference of the <code>ItemEditor</code>
		 * 							to associate with the specified <code>dataField</code>.
		 * 
		 * 	@see #getItemEditor
		 * 	@see #removeItemEditor
		 */
		public function addItemEditor(dataField:String, itemEditorRef:Class):void {
			if (_editorCollection[dataField]) this.removeItemEditor(dataField);
			_editorCollection[dataField] = new itemEditorRef();
		}
		
		/**
		 * 	Returns the <code>ItemEditor</code> instance associated with the specified
		 * 	<code>dataField</code> parameter.
		 * 
		 * 	@param	dataField	Name of the field in the data provider items for  
		 * 						which to return the item editor.
		 * 
		 * 	@see #addItemEditor
		 * 	@see #removeItemEditor
		 * 
		 * 	@return The <code>ItemEditor</code> object associated with the specified
		 * 	<code>dataField</code> parameter.
		 */
		public function getItemEditor(dataField:String):ItemEditor {
			return _editorCollection[dataField];
		}
		
		/**
		 * 	Deletes the <code>ItemEditor</code> instance associated with the specified
		 * 	<code>dataField</code> parameter.
		 * 
		 * 	@param	dataField	Name of the field in the data provider items for 
		 * 						which to remove the item editor.
		 * 
		 * 	@see #addItemEditor
		 * 	@see #getItemEditor
		 */
		public function removeItemEditor(dataField:String):void {
			_editorCollection[dataField].finalize();
			_editorCollection[dataField] = null;
			delete _editorCollection[dataField];
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				Scrollable.spas_internal::changeCurrentScrollable(spas_internal::vScroll);
				doStartEffect();
			}
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Adds a row of headers into this <code>DataGrid</code> instance, built from
		 * 	values contained within the <code>value</code> parameter.
		 * 	The <code>addHeaders()</code> method should be better called internally,
		 * 	by the <code>DataGrid</code> instance, instead of being called programmatically.
		 * 
		 * 	@param	value	An <code>XML</code> object that contains value for building
		 * 					the row of headers.
		 */
		public function addHeaders(value:*):void {
			if (!isNull(spas_internal::headers)) {
				spas_internal::headers.finalize();
				resetColumns();
			}
			
			spas_internal::headers = new DataGridHeaderRow(this);
			var headerData:* = value.dataGridColumns == undefined ?
				value : value.dataGridColumns;
			spas_internal::headers.spas_internal::createRow( { rowData:headerData } );
			spas_internal::headers.spas_internal::setGridMap();
			spas_internal::headerContainer.addElement(spas_internal::headers);
			
			var i:int = 0;
			var j:int = _currentDataCursor;
			for (; i < _rowsNum; ++i, ++j) initDataGridRow(i, j);
			
			fixPositions();
			
			updateColumnsSizes();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			if(isNull(spas_internal::headers)) createHeaderRowFromData(value);
			var obj:Object;
			if (value is XML) {
				obj = XMLSerializer.decode(value);
			} else obj = value;
			
			obj.data = data;
			
			var i:int = obj.index = $objList.size;
			if (obj.selected == undefined) obj.selected = false;
			var li:ListItem = new ListItem(obj, $objList, value, data);
			
			_dataLength++;
			setMaxScroll();
			if (i >= _currentDataCursor && i < _currentDataCursor +_rowsNum) this.updateRow(i, i);
			
			//setRefresh();
			setScrollBarProps();
			//if (this.onItemAdded != null) this.onItemAdded(obj, i+1);
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			var li:ListItem = $objList.get(index) as ListItem;
			//var isSelected:Boolean = li.item.selected;
			var obj:Object = value is XML ? XMLSerializer.decode(value) : value;
			if (obj.selected == undefined) obj.selected = ListItem;
			obj.data = data;
			obj.index = index;
			li.spas_internal::setItem(obj);
			if (index >= _currentDataCursor && index < _currentDataCursor +_rowsNum)
				this.updateRow(index, index);
			
			//setRefresh();
			setScrollBarProps();
			//if (this.onItemUpdated != null) this.onItemUpdated(obj, index);
			return li;
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			/*if(isNull(spas_internal::headers)) createHeaderRowFromData(value);
			var obj:Object = value is XML ? XMLSerializer.decode(value) : value;
			
			obj.index = index;
			if (obj.selected == undefined) obj.selected = false;
			var li:ListItem = new ListItem(obj, objList, value, data, index);
			
			_dataLength++;
			
			if (index >= _currentDataCursor && index < _currentDataCursor +_rowsNum)
				this.updateRow(index, index);
			
			//setRefresh();
			return li;*/
			setScrollBarProps();
			return null;
		}
		
		/**
		 * 	Returns a reference to the <code>DataGridHeaderRow</code> instance,
		 * 	which contains all header items within this <code>DataGrid</code> instance.
		 * 
		 * 	@return	The <code>DataGridHeaderRow</code> instance of the datagrid.
		 */
		public function getHeaders():DataGridHeaderRow {
			return spas_internal::headers;
		}
		
		/**
		 * 	Returns a reference to the <code>DataGridRow</code> instance at the 
		 * 	specified index within this <code>DataGrid</code> instance.
		 * 
		 * 	@param index The index position at which to find a <code>DataGridRow</code>
		 * 				instance.
		 * 
		 * 	@return The <code>DataGridRow</code> instance of at the specified index.
		 */
		public function getRowAt(index:uint):DataGridRow {
			return getItemAt(index).item as DataGridRow;
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			unselectItem(item);
			if ($listItem != null) {
				if($listItem == item) $listItem = null;
			}
			var id:int = item.index;
			$objList.remove(item);
			//if (this.onItemRemoved != null) this.onItemRemoved(item);
			item.data = null;
			item = null;
			_dataLength--;
			setMaxScroll();
			if (id >= _currentDataCursor && id < _currentDataCursor +_rowsNum) {
				if (_currentDataCursor + _rowsNum >= _dataLength && _currentDataCursor > 0) {
					_currentDataCursor--;
				}
				updateVisibleRows();
			}
			//setRefresh();
			setScrollBarProps();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItemAt(index:int):void {
			this.removeItem($objList.get(index) as ListItem);
		}
		
		/**
		 * @private
		 */
		override public function removeAll():void {
			this.reset();
			$objList.clear();
			_dataLength = 0;
			var l:int = _rowsNum - 1;
			for (;  l >= 0;  l--) resetRow(l);
			_rowsBackground.y = _rowsCont.y =
			spas_internal::vScroll.value = _currentDataCursor = 0;
			setRefresh();
			setScrollBarProps();
		}
		
		/**
		 * 	@private
		 */
		public function removeHeaders():void {
			//TODO: implement the removeHeaders() method
		}
		
		/**
		 * 	[Partially implemented.]
		 * 
		 * 	Resets this <code>DataGrid</code> instance.
		 */
		public function reset():void {
			unselectAll();
		}
		
		/**
		 * 	Unselects all items within this <code>DataGrid</code> instance.
		 */
		public function unselectAll():void {
			if ($listItem != null) {
				unselectItem($listItem);
				$listItem = null;
			}
			$selectedIndex = -1;
			if ($multiple) resetItemColl();
		}
		
		/**
		 * 	Applies a background texture for all "bright" rows of the <code>DataGrid</code>
		 * 	instance.
		 * 
		 * 	@param	value	Any <code>IBitmapDrawable</code> object that you want to use
		 * 					as background texture for all "bright" rows.
		 * 
		 * 	@see #setRowDarkTexture()
		 */
		public function setRowBrightTexture(value:IBitmapDrawable):void {
			_rowBrightTexture = createTexture(value);
			drawRowsBackground();
		}
		
		/**
		 * 	Applies a background texture for all "dark" rows of the <code>DataGrid</code>
		 * 	instance.
		 * 
		 * 	@param	value	Any <code>IBitmapDrawable</code> object that you want to use
		 * 					as background texture for all "dark" rows.
		 * 
		 * 	@see #setRowBrightTexture()
		 */
		public function setRowDarkTexture(value:IBitmapDrawable):void {
			_rowDarkTexture = createTexture(value);
			drawRowsBackground();
		}
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, _currHeight);
		}
		
		/**
		 * @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, _currHeight);
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			var value:Object;
			for each (value in spas_internal::rendererCollection) value = null;
			spas_internal::rendererCollection = null;
			for each (value in _editorCollection) value = null;
			_editorCollection = null;
			spas_internal::borderDecorator.finalize();
			spas_internal::borderDecorator = null;
			deleteSeparatorButtons();
			resetColumns();
			spas_internal::vScroll.finalize();
			spas_internal::vScroll = null;
			_rowsCont.finalizeElements();
			_rowsCont.finalize();
			_rowsCont = null;
			//spas_internal::headerContainer.container.mask = null;
			spas_internal::headerContainer.finalizeElements();
			spas_internal::headers = null;
			spas_internal::headerContainer.finalize();
			spas_internal::headerContainer = null;
			_defaultItemEditor.finalize();
			_defaultItemEditor = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Keyboard management API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function notifyKeyDownEvent(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case Keyboard.DOWN :
					increaseItemValue();
					break;
				case Keyboard.UP : 
					decreaseItemValue();
					break;
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function notifyKeyUpEvent(event:KeyboardEvent):void {}
		
		private function increaseItemValue():void {
			if ($selectedIndex < _currentDataCursor) {
				_currentDataCursor = $selectedIndex +1;
				updateVisibleRows();
			} else if ($selectedIndex > _currentDataCursor + _rowsNum) {
				_currentDataCursor = $selectedIndex - _rowsNum + 1;
				updateVisibleRows();
			}
			if ($selectedIndex < _dataLength -1) {
				var dgr:DataGridRow;
				var currId:int;
				currId = $selectedIndex - _currentDataCursor;
				if (currId + 1 == _rowsNum) {
					_currentDataCursor++;
					updateVisibleRows();
				} else {
					currId++;
				}
				dgr = _rowsCont.getObjectAt(currId) as DataGridRow;
				spas_internal::currentRowChanged(dgr);
				selScrollthumbValue();
			}
		}
		
		private function selScrollthumbValue():void {
			spas_internal::vScroll.value = _currentDataCursor;
		}
		
		private function decreaseItemValue():void {
			if ($selectedIndex < _currentDataCursor) {
				_currentDataCursor = $selectedIndex;
				updateVisibleRows();
			} else if ($selectedIndex > _currentDataCursor + _rowsNum) {
				_currentDataCursor = $selectedIndex - _rowsNum;
				updateVisibleRows();
			}
			if ($selectedIndex > 0) {
				var dgr:DataGridRow;
				var currId:int;
				currId = $selectedIndex - _currentDataCursor;
				if (currId == 0) {
					_currentDataCursor--;
					$selectedIndex;
					updateVisibleRows();
					//spas_internal::vScroll.value++;
				} else {
					currId--;
				}
				dgr = _rowsCont.getObjectAt(currId) as DataGridRow;
				spas_internal::currentRowChanged(dgr);
				selScrollthumbValue();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var headers:DataGridHeaderRow = null;
		
		/**
		 *  @private
		 */
		spas_internal function get dataWidth():Number {
			var d:Number;
			if (!autoScrollPosition) d = 0;
			else if(!_showScrollBar) d = 0;
			else d = spas_internal::vScroll.thickness;
			return $width - d;
		}
		
		/**
		 *  @private
		 */
		spas_internal var columnsSizes:Array;
		
		/**
		 *  @private
		 */
		spas_internal var columns:Array;
		
		/**
		 *  @private
		 */
		spas_internal var headerContainer:DataGridHeaderContainer;
		
		/**
		 *  @private
		 */
		spas_internal var selectedColumnContainer:Shape;
		
		/**
		 *  @private
		 */
		spas_internal var vScroll:ScrollBar;
		
		/**
		 *  @private
		 */
		spas_internal var autoScrollPosition:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			fixPositions();
			super.createUIObject(x, y);
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			if (_previousWidth != $width) spas_internal::resizeColumns(false);
			if (spas_internal::headerContainer.width != $width)
				spas_internal::headerContainer.width = $width;
			drawRowsBackground();
			drawMask();
			spas_internal::borderDecorator.drawBackground();
			setScrollBarProps();
			drawSeparators();
			spas_internal::borderDecorator.drawBorders();
			setEffects();
		}
		
		/**
		 * @private
		 */
		override protected function changeCurrentIndex():void {
			if ($listItem != null) {
				if ($listItem.index == $selectedIndex) return;
				unselectItem($listItem);
			}
			if ($selectedIndex == -1) {
				_currentDataCursor = 0;
				updateVisibleRows();
			} else {
				var currId:int;
				if ($selectedIndex < _currentDataCursor) {
					_currentDataCursor = $selectedIndex;
					currId = $selectedIndex - _currentDataCursor;
				} else if ($selectedIndex > _currentDataCursor + _rowsNum) {
					_currentDataCursor = $selectedIndex - _rowsNum +1;
					currId = $selectedIndex - _currentDataCursor;
				} else {
					_currentDataCursor = $selectedIndex;
					currId = $selectedIndex - _currentDataCursor ;
				}
				updateVisibleRows();
				$listItem = $objList.get($selectedIndex) as ListItem;
				
				//$value = $listItem.value;
				//$data = $listItem.data;
				
				var drg:DataGridRow = _rowsCont.getObjectAt(currId) as DataGridRow;
				drg.selected = drg.rowItem.selected = true;
				if (_keyManager.getKeyObserver() != this) _keyManager.setKeyObserver(this);
				selScrollthumbValue();
			}
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		/**
		 *  @private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Called when the current row has been changed due to a user action.
		 * 
		 *  @param	caller
		 */
		spas_internal function currentRowChanged(caller:DataGridRow):void {
			var i:int = caller.index;
			var item:ListItem;
			if ($multiple && _keyManager.isControlPressed()) {
				registerCurrItemForMultipleSel();
				item = $objList.get(i) as ListItem;
				//print("isControlPressed");
				if ($itemsCollection.indexOf(item) == -1) {
					setRowSelected(caller, true);
					$itemsCollection.push(item);
				} else {
					setRowSelected(caller, false);
					$itemsCollection.splice(i, 1);
				}
			} else if ($multiple && _keyManager.isShiftPressed()) {
				//print("isShiftPressed");
				registerCurrItemForMultipleSel();
				
				
				
				
			} else {
				if ($multiple) resetItemColl();
				//print("noKeyIsPressed");
				if ($selectedIndex != i) {
					if ($listItem != null) unselectItem($listItem);
					setRowSelected(caller, true);
					$selectedIndex = i;
					$listItem = $objList.get($selectedIndex) as ListItem;
					selScrollthumbValue();
					if (_keyManager.getKeyObserver() != this) _keyManager.setKeyObserver(this);
				} else {
					setRowSelected(caller, false);
					$selectedIndex = -1;
					$listItem = null;
					_keyManager.deleteKeyObserver(this);
				}
			}
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function registerCurrItemForMultipleSel():void {
			if ($listItem != null) {
				$itemsCollection.push($listItem);
				$listItem = null;
				$selectedIndex = -1;
			}
		}
		
		private function resetItemColl():void {
			while($itemsCollection.length >= 1) {
				unselectItem($itemsCollection.shift());
			} 
		}
		
		private function setRowSelected(caller:DataGridRow, value:Boolean):void {
			caller.selected = caller.rowItem.selected = value;
		}
		
		private function unselectItem(item:ListItem):void {
			item.item.selected = false;
			var rowId:int = item.index - _currentDataCursor;
			if (rowId >= 0 && rowId < _rowsNum) {
				var drg:DataGridRow = _rowsCont.getObjectAt(rowId) as DataGridRow;
				setRowSelected(drg, false);
				//drg.selected = drg.rowItem.selected = false;
			}
			_keyManager.deleteKeyObserver(this);
		}
		
		////////////////////////////////////////////////
		/**
		 *  @private
		 */
		spas_internal function dispatchRendererClickedEvent(caller:ItemRenderer):void {
			var e:ItemRendererEvent = new ItemRendererEvent(ItemRendererEvent.ITEM_RENDERER_CLICKED)
			e.spas_internal::rendererRef = caller;
			dispatchEvent(e);
		}
		
		/**
		 *  @private
		 */
		spas_internal function dispatchRendererEditedEvent(caller:ItemRenderer):void {
			var e:ItemRendererEvent = new ItemRendererEvent(ItemRendererEvent.ITEM_RENDERER_EDITED)
			e.spas_internal::rendererRef = caller;
			dispatchEvent(e);
		}
		//////////////////////////////////////////////////
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			spas_internal::vScroll.lockLaf(lookAndFeel.getScrollBarLaf(), true);
			spas_internal::headerContainer.lockLaf(lookAndFeel.getHeaderLaf(), true);
			_scrollBoundsRatio = spas_internal::vScroll.upButtonSize + spas_internal::vScroll.downButtonSize;
			$backgroundColor = lookAndFeel.getBackgroundColor();
			if (_useDefaultItemFontFormat)
				spas_internal::itemFontFormat = lookAndFeel.getDefautFontFormat();
				
			spas_internal::upFontColor = spas_internal::overFontColor =
			spas_internal::downFontColor = spas_internal::selectedFontColor =
			spas_internal::itemFontFormat.color;
			
			
			
				//TODO: update all items font formats.
			spas_internal::headerFontFormat = lookAndFeel.getDefautHeaderFontFormat();
			changeRowColors();
			if (isNull(spas_internal::headers)) return;
			spas_internal::headers.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			var i:int = spas_internal::headers.numElements - 1;
			var dgh:DataGridHeader;
			for (; i >= 0; i--) {
				dgh = spas_internal::headers.getObjectAt(i);
				dgh.lockLaf(lookAndFeel.getHeaderLaf(), true);
				dgh.initFontFormat(spas_internal::headerFontFormat);
			}
			spas_internal::headers.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
		}
		
		/**
		 *  @private
		 */
		spas_internal function resizeColumns(updateSeparators:Boolean = true, createSeparatorButtons:Boolean = true):void {
			if (spas_internal::headers != null) {
				spas_internal::headers.spas_internal::updateColumnsSizes();
				spas_internal::headers.spas_internal::setGridMap();
				spas_internal::headers.spas_internal::updateLayout();
			}
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			//--> Calls a UIContainer elementList (ArrayList) index based object.
			var i:int = _rowsCont.numElements - 1;
			var dgr:DataGridRow;
			for (; i >= 0; i--) {
				dgr = _rowsCont.getObjectAt(i);
				dgr.spas_internal::setGridMap();
				dgr.spas_internal::updateLayout();
				dgr.spas_internal::refreshHitArea();
			}
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
			_rowsCont.spas_internal::updateLayout();
			updateColumnsSizes(createSeparatorButtons);
			if(updateSeparators) drawSeparators();
			_previousWidth = width;
		}
		
		/**
		 *  @private
		 */
		spas_internal function swapColumns(index1:uint, index2:uint):void {
			ArrayUtil.swapValuesAt(spas_internal::columns, index1, index2);
			fixColIndex(index1, index2);
			fixColIndex(index2, index1);
			ArrayUtil.swapValuesAt(spas_internal::columnsSizes, index1, index2);
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			spas_internal::headers.spas_internal::setGridMap();
			spas_internal::headers.swapElementsAt(index1, index2);
			var i:int = _rowsCont.numElements - 1;
			var dgr:DataGridRow;
			for (; i >= 0; i--) {
				dgr = _rowsCont.getObjectAt(i);
				dgr.spas_internal::setGridMap();
				dgr.swapElementsAt(index1, index2);
			}
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
			deleteSeparatorButtons();
			updateColumnsSizes();
			drawSeparators();
		}
		
		/**
		 *  @private
		 */
		spas_internal function startItemRendererEdition(itemRenderer:ItemRenderer, dataField:String):void {
			var r:Rectangle = itemRenderer.getRect(spas_internal::uioSprite);
			var editor:ItemEditor = _editorCollection[dataField] == null ?
				_defaultItemEditor : _editorCollection[dataField];
			editor.itemRenderer = itemRenderer;
			editor.text = itemRenderer.label;
			editor.data = itemRenderer.data;
			editor.resize(r.width, r.height);
			editor.display(r.x, r.y);
			$evtColl.addEvent(editor, ItemEditorEvent.VALIDATED, editionValidated);
			$evtColl.addEvent(editor, ItemEditorEvent.CANCELED, editionCanceled);
		}
		
		/**
		 *  @private
		 */
		spas_internal function dispatchDoubleClickEvent(caller:DataGridRow):void {
			var e:DataGridEvent = new DataGridEvent(DataGridEvent.ROW_DOUBLE_CLICK);
			e.spas_internal::currentRow = caller;
			this.dispatchEvent(e);
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemEditor API
		//
		//--------------------------------------------------------------------------
		
		private function editionValidated(e:ItemEditorEvent):void {
			var editor:ItemEditor = ItemEditor(e.target);
			removeEditionEvents(editor);
			var item:ItemRenderer = editor.itemRenderer;
			item.updateItem( { data:editor.data, label:editor.text } );
			editor.itemRenderer = null;
			editor.remove();
		}
		
		private function editionCanceled(e:ItemEditorEvent):void {
			var editor:ItemEditor = ItemEditor(e.target);
			removeEditionEvents(editor);
			editor.itemRenderer = null;
			editor.remove();
		}
		
		private function removeEditionEvents(editor:ItemEditor):void {
			$evtColl.removeEvent(editor, ItemEditorEvent.VALIDATED, editionValidated);
			$evtColl.removeEvent(editor, ItemEditorEvent.CANCELED, editionCanceled);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Sorting API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal function sortData(index:uint):void {
			if ($objList.size == 0) return;
			var dgc:DataGridColumn = spas_internal::columns[index];
			_currentField = dgc.dataField;
			if (!dgc.sortable) return;
			var cs:int = dgc.spas_internal::getCurrentSortType();
			var arr:Array = $objList.spas_internal::getStack();
			if (cs == DataGridColumn.UNSORT || cs == DataGridColumn.ASCENDING) {
				arr.sort(dscSort);
				dgc.spas_internal::setCurrentSortType(DataGridColumn.DESCENDING);
			} else {
				arr.sort(ascSort);
				dgc.spas_internal::setCurrentSortType(DataGridColumn.ASCENDING);
			}
			
			var l:int = _rowsNum-1;
			for (; l >= 0; l--) this.updateRow(l, l);
			
			var dgh:DataGridHeader = spas_internal::headers.getObjectAt(index);
			if (_currentHeader != null) {
				if (_currentHeader != dgh) _currentHeader.spas_internal::setSelected(false, -2);
			}
			_currentHeader = dgh;
			_currentHeader.spas_internal::setSelected(true, dgc.spas_internal::getCurrentSortType());
		}
		
		private var _currentHeader:DataGridHeader;
		private var _currentField:String;
		
		private function ascSort(obj1:ListItem, obj2:ListItem):Number {
			if (obj1.item[_currentField] < obj2.item[_currentField]) return -1;
			else if (obj1.item[_currentField] > obj2.item[_currentField]) return 1;
			return 0;
		}
		
		private function dscSort(obj1:ListItem, obj2:ListItem):Number {
			if (obj1.item[_currentField] > obj2.item[_currentField]) return -1;
			else if (obj1.item[_currentField] < obj2.item[_currentField]) return 1;
			return 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _keyManager:KeyboardManager;
		//--> containers
		private var _dataCont:Sprite;
		private var _rowsCont:Canvas;
		private var _separators:Shape;
		private var _separatorBtnCont:Sprite;
		private var _rowsMask:Shape;
		private var _rowsBackground:Shape;
		//--> variables
		private var _itemsHeightMode:Boolean = false;
		private var _currHeight:Number;
		private var _itemsHeightOffset:Number = 0;
		private var _dataViewHeight:Number;
		private var _rbc:uint;
		private var _rdc:uint;
		private var _previousWidth:Number = 0;
		private var _dataLength:int = 0;
		private var _currentDataCursor:int = 0;
		private var _maxScrollValue:int;
		private var _thumbMinSize:Number = 15;
		private var _scrollBoundsRatio:Number = 0;
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	The rowStack array is used to store RowDTO objects.
		 */
		private var _rowStack:Array;
		private var _rowsNum:Number = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, itemsNum:uint, height:Number):void {
			$width = width;
			_currHeight = height;
			_itemsNum = itemsNum;
			initDataGrid();
			spas_internal::setSelector(Selectors.DATAGRID);
			spas_internal::isInitialized(1);
		}
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	The initDataGrid method is called by the constructor function to initialize
		 * 	the datagrid.
		 */
		private function initDataGrid():void {
			_keyManager = UIDescriptor.getUIManager().keyboardManager;
			spas_internal::rendererCollection = new Dictionary(true);
			_editorCollection = new Dictionary(true);
			spas_internal::columns = [];
			$finalizeItems = false;
			//initMinSize(50, 50);
			spas_internal::autoScrollPosition = true;
			createContainers();
			setHeight(_currHeight);
			initRows();
			setMaxScroll();
			initLaf(DataGridUIRef);
			createBackgroundTextureManager(spas_internal::background);
			spas_internal::borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
		}
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	The initRows method stores RowDTO objects corresponding to the number of items
		 * 	defined by the constructor function.
		 * 	It initializes too the _dataViewHeight property.
		 */
		private function initRows():void {
			_rowStack = [];
			fixRowsNum();
			setDataViewHeight();
		}
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	This method is called by the initDataGrid function to create all containers
		 * 	and objects used by the datagrid.
		 */
		private function createContainers():void {
			createBackground();
			$content = new Sprite();
			spas_internal::uioSprite.addChild($content);
			_dataCont = new Sprite();
			$content.addChild(_dataCont);
			_rowsBackground = new Shape();
			_dataCont.addChild(_rowsBackground);
			_rowsCont = new Canvas();
			_rowsCont.autoAdjustSize = false;
			_rowsCont.layout = new TableVerticalLayout();
			_rowsCont.target = _dataCont;
			_rowsCont.display();
			_rowsMask = new Shape();
			_dataCont.addChild(_rowsMask)
			_dataCont.mask = _rowsMask;
			_separators = new Shape();
			spas_internal::selectedColumnContainer = new Shape();
			spas_internal::vScroll = new ScrollBar(null);
			spas_internal::vScroll.lockThumbSize = spas_internal::vScroll.useIncremental = true;
			spas_internal::vScroll.target = $content;
			spas_internal::vScroll.display();
			$evtColl.addEvent(spas_internal::vScroll, ScrollEvent.SCROLL, onScrollHandler)
			
			
			spas_internal::headerContainer = new DataGridHeaderContainer($width, _headerHeight);
			//--> TODO header heught must be checked each time header is updated.
			//spas_internal::headerContainer.autoHeight = true;
			spas_internal::headerContainer.target = spas_internal::uioSprite;
			spas_internal::headerContainer.display();
			
			spas_internal::uioSprite.addChild(spas_internal::selectedColumnContainer);
			spas_internal::uioSprite.addChild(_separators);
			_separatorBtnCont = new Sprite();
			spas_internal::uioSprite.addChild(_separatorBtnCont);
			spas_internal::borders = new Sprite();
			spas_internal::uioSprite.addChild(spas_internal::borders);
			_defaultItemEditor = new DefaultItemEditor();
			_defaultItemEditor.target = spas_internal::uioSprite;
		}
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	The createHeaderRowFromData function is used by the datagrid to retrieves header
		 * 	field references from a data set when no header had been defined before data is
		 * 	set to the fill datagrid.
		 */
		private function createHeaderRowFromData(obj:*):void {
			var headerData:XML = <dataGridColumns></dataGridColumns>;
			var prop:String;
			if (obj is XML) {
				var list:XMLList = obj.attributes();
				var i:uint = 0;
				for (; i < list.length(); i++) {
					prop = list[i].name();
					headerData.appendChild(<column dataField={prop} headerText={prop} />);
				}
			} else {
				for (prop in obj) {
					if (prop == "data") continue;
					headerData.appendChild(<column dataField={prop} headerText={prop} />);
				}
			}
			addHeaders(headerData);
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			//var hasHeaders:Boolean = Boolean(data.dataGridColumns != undefined);
			var l:int;
			var i:int;
			var a:Array = $dataProvider.toArray();
			l = a.length - 1;
			i = 0;
			var obj:Object;
			for (; i <= l; ++i) {
				obj = a[i];
				addItem(obj, obj.data);
			}
			var createSeparators:Boolean = Boolean(_separatorBtnCont.numChildren == 0);
			spas_internal::resizeColumns(createSeparators);
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			deleteSeparatorButtons(); 
			//--> TODO: add the _invalidateListUpdate process
			checkStrictMode("DataGrid");
			var data:XML = $xmlQuery.xml;
			var hasHeaders:Boolean = Boolean(data.dataGridColumns != undefined);
			switch($dataBindingMode) {
				case DataBindingMode.RESET:
					removeAll();
					break;
				case DataBindingMode.UPDATE:
				case DataBindingMode.MERGE:
					if (hasHeaders) resetColumns();
					break;
			}
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			if (hasHeaders) addHeaders(XML(data.dataGridColumns));
			var i:int = 0;
			var prop:XML;
			var di:XMLList = data.item;
			for each(prop in di) {
				var d:* = null;
				if (prop.@data != undefined) d = prop.@data.toXMLString();
				switch($dataBindingMode) {
					case DataBindingMode.INCREMENT:
					case DataBindingMode.RESET:
						addItem(prop, d);
						break;
					case DataBindingMode.MERGE :
					case DataBindingMode.UPDATE:
						updateItemAt(i, prop);
						break;
				}
				i++;
			}
			var createSeparators:Boolean = Boolean(_separatorBtnCont.numChildren == 0);
			spas_internal::resizeColumns(createSeparators);
			_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		private function drawRowsBackground():void {
			var h:Number = 0;
			var yPos:Number = 0;
			var i:uint = 0;
			var cursor:int = _currentDataCursor;
			var dto:RowDTO;
			var dgrColor:Number;
			
			var g:Graphics = _rowsBackground.graphics;
			g.clear();
			do {
				dto = _rowStack[i];
				h = dto != null ? dto.height : _defaultRowHeight;
				if (cursor % 2 == 0) {
					if (_rowDarkTexture)g.beginBitmapFill(_rowDarkTexture);
					else g.beginFill((isNaN(dgrColor)) ? _rdc : dgrColor);
				} else {
					if (_rowBrightTexture) g.beginBitmapFill(_rowBrightTexture);
					else g.beginFill((isNaN(dgrColor)) ? _rbc : dgrColor);
				}
				g.drawRect(0, yPos, $width, h);
				
				yPos += h;
				cursor++;
			} while (++i < _rowsNum);
		}
		
		private function changeRowColors():void {
			_rbc = isNaN(_rowBrightColor) ? lookAndFeel.getRowBrightColor() : _rowBrightColor;
			_rdc = isNaN(_rowDarkColor) ? lookAndFeel.getRowDarkColor() : _rowDarkColor;
		}
		
		private function drawSeparators():void {
			if (isNull(spas_internal::headers) || !_showSeparators) return;
			var i:uint = 0;
			var xPos:Number = 0;
			//var h:Number = _itemsHeightMode ? _content.y + _dataViewHeight : _height;
			var h:Number = _currHeight;
			var btn:Sprite;
			var l:int;
			with (_separators.graphics) {
				clear();
				lineStyle(1, 0xbbbbbb);
				l = spas_internal::columnsSizes.length - 1;
				for (; i < l; i++) {
					xPos += spas_internal::columnsSizes[i];
					moveTo(xPos, 0);
					lineTo(xPos, h);
					btn = _separatorBtnCont.getChildAt(i);
					btn.x = xPos;
				}
				xPos = spas_internal::dataWidth;
				moveTo(xPos, 0);
				lineTo(xPos, h);
				moveTo(0, $content.y);
				lineTo($width, $content.y);
				endFill();
			}
		}
		
		private function setScrollBarProps():void {
			if ($invalidateRefresh) return;
			if (!_showScrollBar) return;
			if(spas_internal::autoScrollPosition) {
				spas_internal::vScroll.length = _dataViewHeight;
				spas_internal::vScroll.x = $width - spas_internal::vScroll.thickness;
			}
			if (_dataLength > _rowsNum) {
				spas_internal::vScroll.scrollTargetPolicy = ScrollTargetPolicy.ENABLE_IF_NULL;
				var ratio:Number =  (_dataViewHeight / _defaultRowHeight) / _dataLength;
				var h:Number = (_dataViewHeight - _scrollBoundsRatio) * ratio;
				spas_internal::vScroll.thumbLength = Math.max(h, _thumbMinSize);
			} else spas_internal::vScroll.scrollTargetPolicy = ScrollTargetPolicy.DISABLE_IF_NULL;
			updateScrollValue();
		}
		
		private function fixPositions():void {
			var dh:Number = $content.y = _showHeader ? spas_internal::headerContainer.height : 0;
			_currHeight = _itemsHeightMode ? _dataViewHeight + dh : $height;
		}
		
		private function deleteSeparatorButtons():void {
			var item:*;
			var l:int = _separatorBtnCont.numChildren-1;
			for (; l >= 0; l--) {
				item = _separatorBtnCont.getChildAt(l);
				item.finalize();
				_separatorBtnCont.removeChildAt(l);
				item = null;
			}
		}
		
		private function updateColumnsSizes(createSeparatorButtons:Boolean = true):void {
			var l:int = spas_internal::columns.length - 1;
			var xPos:Number = 0;
			var w:Number;
			if (l > 0) {
				w = spas_internal::columnsSizes[0];
				spas_internal::columns[0].width = w;
				spas_internal::columns[0].spas_internal::setX(xPos);
				xPos += w;
			}
			if (l >= 1) {
				var i:uint = 1;
				var btn:DataGridSeparatorButton;
				for (; i <= l; ++i) {
					w = spas_internal::columnsSizes[i];
					spas_internal::columns[i].width = w;
					spas_internal::columns[i].spas_internal::setX(xPos);
					xPos += w;
					if(createSeparatorButtons) {
						btn = new DataGridSeparatorButton(
							this, spas_internal::columns[i - 1],
							spas_internal::columns[i]
						);
						_separatorBtnCont.addChild(btn);
					}
				}
			}
		}
		
		private function fixColIndex(index1:uint, index2:uint):void {
			var dgh:DataGridHeader = spas_internal::headers.getObjectAt(index1);
			dgh.index = index2;
			spas_internal::columns[index1].setItemRenderer(dgh);
		}
		
		private function resetColumns():void {
			var l:int = spas_internal::columns.length;
			var i:int = 0;
			for (; i < l; ++i) {
				spas_internal::columns[i].finalize();
				spas_internal::columns[i] = null;
			}
			spas_internal::columns = [];
			if(spas_internal::headers != null) spas_internal::headers.spas_internal::colsSizes = [];
		}
		
		private function updateRow(index:uint, dataCursor:uint):void {
			var dgr:DataGridRow = _rowsCont.getObjectAt(index) as DataGridRow;
			if (index >= $objList.size) {
				dgr.spas_internal::resetRow();
				dgr.spas_internal::setIndex(-1);
			} else  {
				dgr.spas_internal::updateRow($objList.get(dataCursor).item);
				dgr.spas_internal::setIndex(dataCursor);
			}
		}
		
		private function resetRow(index:uint):void {
			var dgr:DataGridRow = _rowsCont.getObjectAt(index) as DataGridRow;
			dgr.spas_internal::resetRow();
			dgr.spas_internal::setIndex(-1);
		}
		
		private function createRow():void {
			var dgr:DataGridRow = new DataGridRow(this);
			_rowsCont.addElement(dgr);
		}
		
		private function deleteRowAt(index:uint):void {
			var row:DataGridRow = _rowsCont.removeElementAt(index);
			row.finalize();
			row = null;
		}
		
		private function setMaxScroll():void {
			_maxScrollValue = spas_internal::vScroll.maximum = _dataLength - _rowsNum;
		}
		
		private function onScrollHandler(e:ScrollEvent):void {
			var v:Number = e.target.value;
			if (_currentDataCursor != v)  {
				_currentDataCursor = v;
				updateVisibleRows();
			}
		}
		
		private function updateDataViewPos():void {
			_rowsBackground.y = _rowsCont.y =
				(_currentDataCursor == _maxScrollValue) ? _itemsHeightOffset : 0;
		}
		
		private function updateScrollValue():void {
			setMaxScroll();
			selScrollthumbValue();
			//spas_internal::vScroll.value = _currentDataCursor / (_dataLength - _rowsNum);
			//spas_internal::vScroll.value = _currentDataCursor;
		}
		
		private function updateVisibleRows():void {
			var i:int = 0;
			var j:int = _currentDataCursor;
			for (; i < _rowsNum; ++i, ++j) this.updateRow(i, j);
			drawRowsBackground();
			updateDataViewPos();
		}
		
		private function createTexture(obj:IBitmapDrawable):BitmapData {
			var buffer:DisplayObject = obj as DisplayObject;
			var bmp:BitmapData = new BitmapData(buffer.width, buffer.height);
			bmp.draw(buffer);
			return bmp;
		}
		
		private function setHeight(value:Number):void {
			$height = value;
			_itemsHeightMode = isNaN(value) ? true : false;
			fixPositions();
		}
		
		private function fixRowsNum():void {
			_rowsNum = _itemsHeightMode ? _itemsNum : Math.ceil(($height - _headerHeight) / _defaultRowHeight);
			var i:int = 0;
			for (; i < _rowsNum; ++i) {
				_rowStack[i] = new RowDTO(_defaultRowHeight);
				this.createRow();
			}
		}
		
		private function setDataViewHeight():void {
			_dataViewHeight = _itemsHeightMode ? _rowsNum * _defaultRowHeight : $height - _headerHeight;
		}
		
		private function initDataGridRow(index:int, dataCursor:int):void {
			var obj:Object = $objList.size > dataCursor ? $objList.get(dataCursor).item : null;
			var dgr:DataGridRow = _rowsCont.getObjectAt(index) as DataGridRow;
			dgr.spas_internal::finalizeRowElements();
			dgr.spas_internal::initRow(obj);
			if (obj != null) dgr.spas_internal::setIndex(index);
		}
		
		/**
		 * 	Changes the number of items displayed by the Datagrid
		 * 	each time a new height or item height are set.
		 */
		private function setNewHeightProps():void {
			_itemsHeightOffset = _dataViewHeight - _rowsNum * _defaultRowHeight;
			if (_itemsHeightOffset == 0) return;
			else {
				_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
				var l:uint;
				var i:uint;
				if (_itemsHeightOffset > 0) {
					var id:uint = _rowsNum;
					l = Math.ceil(_itemsHeightOffset / _defaultRowHeight);
					_rowsNum += l;
					var j:int = _currentDataCursor + id;
					if (_dataLength < l + j) {
						var addRowsNum:int = _rowsNum - id;
						_currentDataCursor = (_currentDataCursor - addRowsNum) < 0 ? 0 : _currentDataCursor - addRowsNum;
						i = 0;
						j = _currentDataCursor;
						for (; i < id; ++i, ++j) this.updateRow(i, j);
					}
					i = 0;
					for (; i < l; ++i, ++j, ++id) {
						_rowStack[id] = new RowDTO(_defaultRowHeight);
						this.createRow();
						this.initDataGridRow(id, j);
						this.updateRow(id, j);
					}
				} else if (_itemsHeightOffset < 0) {
					l = Math.abs(Math.ceil(_itemsHeightOffset / _defaultRowHeight));
					var rdto:RowDTO;
					for (; l > 0; l--) {
						//i = --_rowsNum;
						rdto = _rowStack.pop();
						rdto = null;
						deleteRowAt(--_rowsNum);
					}
				}
				_itemsHeightOffset = _dataViewHeight - _rowsNum * _defaultRowHeight
				_rowsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
				_rowsCont.spas_internal::updateLayout();
			}
		}
		
		private function drawMask():void {
			with (_rowsMask.graphics) {
				clear();
				beginFill(0, .5);
				drawRect(0, 0, $width, _dataViewHeight);
				endFill();
			}
		}
		
		private function updateDragEnabled():void {
			var i:int = _rowsNum - 1;
			var dgr:DataGridRow;
			for (; i >= 0; i--) {
				dgr = _rowsCont.getObjectAt(i) as DataGridRow;
				dgr.spas_internal::updateDragEnabled(spas_internal::enableRowsDrag);
			}
		}
	}
}