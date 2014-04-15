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
	//  ListBox.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 3.0.1, 11/04/2011 02:00
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.button.SelectableItem;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.constants.ScrollTargetPolicy;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.KeyObserver;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.KeyObserverEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.layout.TableVerticalLayout;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.ItemsList;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.managers.KeyboardManager;
	import org.flashapi.swing.plaf.libs.ListBoxUIRef;
	import org.flashapi.swing.scroll.ColorizableScrollbar;
	import org.flashapi.swing.scroll.Scrollable;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ListBox.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an item is clicked within the <code>ListBox</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name = "itemClicked", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when an item is clicked within the <code>ListBox</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_PRESSED
	 */
	[Event(name = "itemPressed", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>ListBox</code> instance changes value due to
	 * 	mouse or keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *
	 *  @eventType org.flashapi.swing.event.KeyObserverEvent.ENTER_KEY_UP
	 */
	[Event(name = "enterKeyUp", type = "org.flashapi.swing.event.KeyObserverEvent")]
	
	/**
	 *
	 *  @eventType org.flashapi.swing.event.KeyObserverEvent.ESCAPE_KEY_UP
	 */
	[Event(name="escapeKeyUp", type="org.flashapi.swing.event.KeyObserverEvent")]
	
	/**
	 * 	<img src="ListBox.png" alt="ListBox" width="18" height="18"/>
	 * 
	 * 	The <code>ListBox</code> class displays a vertical list of items. Its functionality
	 * 	is similar to that of the SELECT form element in HTML. If there are more items than
	 * 	can be displayed at once, it can display a vertical scroll bar so the user can
	 * 	access all items in the list. The user can select one or more items from the list,
	 * 	depending on the value of the <code>multiple</code> property.
	 * 
	 * 	<p>
	 * 		[<strong>Since SPAS 3.0 alpha 5.5, the <code>ListBox</code> class has been totally
	 * 		rewrotten for better performances. Please use the SPAS 3.0 Bug Manager to tell us
	 * 		about bugs you could find when using the new <code>ListBox</code> (version 3.0.0).
	 * 		</strong>]
	 * 	</p>
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>ListBox</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value</code> parameter of the
	 * 		<code>ListBox.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter
	 * 		of the <code>ListBox.addItem()</code> method,</li>
	 * 		<li><code>className:String</code>; the <code>className</code> parameter
	 * 		for the <code>ListBox</code> item,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the icon rendered by the
	 * 		<code>ListBox</code> item.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 
	 * 	<p>You also can assign a <code>XMLQuery</code> object to a <code>ListBox</code>
	 * 	instance.</p>
	 * 
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="ListBox" urlPath="my_URLPath"&gt;
	 *			&lt;item icon="my_icon.png" label="label" width="80" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 
	 * 	<p>The following table lists the attributes you can specify, their data types, and
	 * 	their purposes:</p>
	 * 
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Must be <code>"ListBox"</code>; if you set the <code>XMLQuery.strictMode</code>
	 * 			to <code>true</code> you must specifie this attribute.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>ListBox.urlPath</code> property.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.label</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used as label for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string used as the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.height</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td>Specifies the height for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.alt</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the alternate text for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.active</code></td>
	 * 			<td><code>Boolean</code></td>
	 * 			<td>Indicates whether this item is active (<code>true</code>),
	 * 			or not (<code>false</code>).</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.className</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the CSS class name for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.icon</code></td>
	 * 			<td><code><em>untyped</em></code></td>
	 * 			<td>Specifies the icon file for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.brush</code></td>
	 * 			<td><code>Brush</code></td>
	 * 			<td>Specifies the <code>Brush</code> class reference to draw
	 * 			the icon for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 	<code>ListBox</code> instance:</p>
	 * 	<p>
	 * 		- using the <code>ListBox.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var l:ListBox = new ListBox();
	 * 
	 * 			l.addItem("Label 1", myData1);
	 * 			l.addItem("Label 2", myData2);
	 * 			var li3:ListItem = l.addItem("Label 3", myData3);
	 * 			li3.item.setIcon("myIcon.jpg");
	 * 			var li4:ListItem = l.addItem("Label 4", myData4);
	 * 			li4.item.setIcon("myIcon.jpg");
	 * 
	 * 			l.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ListBox.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var l:ListBox = new ListBox();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 			dp.addAll(  { label:"Label 1", data:myData1 },
	 * 						{ label:"Label 2", data:myData2 },
	 * 						{ label:"Label 3", data:myData3, icon:"myIcon.jpg" },
	 * 						{ label:"Label 4", data:myData4, icon:"myIcon.jpg" });
	 * 			l.dataProvider = dp;
	 * 
	 * 			l.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ListBox.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item label="Label 1" data="myData1" /&gt;
	 *								&lt;item label="Label 2" data="myData2" /&gt;
	 *								&lt;item label="Label 3" data="myData3" icon="myIcon.jpg" /&gt;
	 * 								&lt;item label="Label 4" data="myData4" icon="myIcon.jpg" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var l:ListBox = new ListBox();
	 * 			l.xmlQuery = request;
	 * 
	 * 			l.display();
	 * 		</listing>
	 * 	</p>
	 * 
	 * 	@includeExample ListBoxExample.as
	 * 
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.plaf.ListBoxUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ListBox extends ALM implements Observer, ItemsList, Listable, LafRenderer, Border, ColorizableScrollbar, Initializable, KeyObserver {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>ListBox</code> instance with the 
		 * 					specified parameters.
		 *
		 * 	@param	width	The width of the <code>ListBox</code> instance, in pixels.
		 *	@param	size	The number of items displayed within the <code>ListBox</code>
		 * 					instance. 
		 * 	@param height 	The height of the <code>ListBox</code> instance, in pixels.
		 */
		public function ListBox(width:Number = 150, size:uint = 5, height:Number = NaN) {
			super();
			initObj(width, size, height);
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
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or returns the label value of the item selected within this
		 * 	<code>ListBox</code> instance. If no item is selected, returns
		 * 	<code>null</code>.
		 * 
		 * 	@default null
		 */
		public function get setSelected():String {
			return $value;
		}
		public function set setSelected(value:String):void {
			/*var it:Iterator = $objList.iterator;
			var si:SelectableItem;
			var li:Object;
			while(it.hasNext()) { 
				li = it.next();
				si = li.item;
				if(si.label == value) {
					$listItem = li as ListItem;
					$value = value;
					$data = li.data;
					displaySelectedItem(si);
				} else si.selected = false;
			}
			it.reset();*/
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
			_vScroll.visible = value;
			_previousWidth = 0;
			setRefresh();
		}
		
		private var _size:uint;
		/**
		 * 	Sets or gets the number of items displayed within this <code>ListBox</code>
		 * 	instance.
		 * 
		 * 	@default 5
		 */
		public function get size():uint {
			return _size;
		}
		public function set size(value:uint):void {
			_size = value;
			fixAutoHeight();
			setHeight($height);
			fixItemsNum();
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		private var _lineHeight:Number = 22;
		/**
		 * 	Sets or gets the height of all items displayed within this <code>ListBox</code>
		 * 	instance.
		 * 
		 * 	@default 22
		 */
		public function get lineHeight():Number {
			return _lineHeight;
		}
		public function set lineHeight(value:Number):void {
			_lineHeight = value;
			fixAutoHeight();
			setHeight($height);
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function get height():Number {
			//return _itemsHeightMode ? _content.y + _dataViewHeight : _height;
			return _currHeight;
		}
		override public function set height(value:Number):void {
			fixAutoHeight();
			setHeight(value);
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		private var _invalidateListUpdate:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the items
		 * 	displayed within this <code>ListBox</code> instance can be
		 * 	updated (<code>false</code>), or not (<code>true</code>).
		 * 
		 * 	@default false
		 */
		public function get invalidateListUpdate():Boolean {
			return _invalidateListUpdate;
		}
		public function set invalidateListUpdate(value:Boolean):void {
			_invalidateListUpdate = value;
		}
		
		/**
		 * 	Gets or sets the thickness of the <code>ScrollBar</code> instance
		 * 	displayed within this <code>ListBox</code> instance.
		 * 
		 * 	@see #vScrollBar
		 * 	@see #vscrollValue
		 */
		public function get scrollThickness():Number {
			return _vScroll.thickness;
		}
		public function set scrollThickness(value:Number):void {
			_vScroll.thickness = value;
		}
		
		/**
		 * 	Returns a reference to the <code>ScrollBar</code> instance displayed within
		 * 	this <code>ListBox</code> instance.
		 * 
		 * 	@see #vscrollValue
		 * 	@see #vscrollThickness
		 */
		public function get vScrollBar():ScrollBar {
			return _vScroll;
		}
		
		/**
		 * 	Gets or sets the current value of the <code>ScrollBar</code> instance
		 * 	displayed within this <code>ListBox</code> instance.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #vScrollBar
		 * 	@see #vscrollThickness
		 */
		public function get vscrollValue():Number {
			return _vScroll.value;
		}
		public function set vscrollValue(value:Number):void {
			_vScroll.value = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set autoHeight(value:Boolean):void {
			$autoHeight = value;
			fixAutoHeight();
			setHeight($height);
			setDataViewHeight();
			setNewHeightProps();
			setRefresh();
		}
		
		private var _unselectEnabled:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the items displayed
		 * 	within this <code>ListBox</code> instance can be unselected if
		 * 	<code>selected</code> and then clicked (<code>true</code>), or not 
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get unselectEnabled():Boolean {
			return _unselectEnabled;
		}
		public function set unselectEnabled(value:Boolean):void {
			_unselectEnabled = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Border API
		//
		//--------------------------------------------------------------------------
		
		private var _borderDecorator:BorderDecorator;
		
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
		
		private var _borders:Sprite;
		/**
		 *	@inheritDoc
		 */
		public function get bordersContainer():Sprite {
			return _borders;
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
		
		private function redrawDecorator():void {
			_borderDecorator.drawBackground();
			_borderDecorator.drawBorders();
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
			return _vScroll.scrollbarArrowColor;
		}
		public function set scrollbarArrowColor(value:*):void {
			_vScroll.scrollbarArrowColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarBaseColor():* {
			return _vScroll.scrollbarBaseColor;
		}
		public function set scrollbarBaseColor(value:*):void {
			_vScroll.scrollbarBaseColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarFaceColor():* {
			return _vScroll.scrollbarFaceColor;
		}
		public function set scrollbarFaceColor(value:*):void {
			_vScroll.scrollbarFaceColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarHighlightColor():* {
			return _vScroll.scrollbarHighlightColor;
		}
		public function set scrollbarHighlightColor(value:*):void {
			_vScroll.scrollbarHighlightColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarShadowColor():* {
			return _vScroll.scrollbarShadowColor;
		}
		public function set scrollbarShadowColor(value:*):void {
			_vScroll.scrollbarShadowColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarTrackColor():* {
			return _vScroll.scrollbarTrackColor;
		}
		public function set scrollbarTrackColor(value:*):void {
			_vScroll.scrollbarTrackColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarJoinColor():* {
			return _vScroll.scrollbarJoinColor;
		}
		public function set scrollbarJoinColor(value:*):void {
			_vScroll.scrollbarJoinColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarInactiveJoinColor():* {
			return _vScroll.scrollbarInactiveJoinColor;
		}
		public function set scrollbarInactiveJoinColor(value:*):void {
			_vScroll.scrollbarInactiveJoinColor = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarInactiveTrackColor():* {
			return _vScroll.scrollbarInactiveTrackColor;
		}
		public function set scrollbarInactiveTrackColor(value:*):void{
			_vScroll.scrollbarInactiveTrackColor  = value;
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
				Scrollable.spas_internal::changeCurrentScrollable(_vScroll);
				doStartEffect();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			var obj:Object;
			var d:* = data;
			switch(typeof(value)) {
				case PrimitiveType.XML :
					obj = convertXmlData(value);
					d = obj.data;
					break;
				case PrimitiveType.OBJECT :
					obj = value;
					d = obj.data;
					break;
				case PrimitiveType.STRING :
					obj = { label:value };
					break;
				
			}
			
			obj.selected = false;
			var i:int = obj.index = $objList.size;
			var li:ListItem = new ListItem(obj, $objList, obj.label, d);
			
			_dataLength++;
			setMaxScroll();
			if (i >= _currentDataCursor && i < _currentDataCursor +_selectItemNum) this.updateItemById(i, i);
			
			if (!$invalidateRefresh) updateAutoHeight();
			setScrollBarProps();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			var li:ListItem = $objList.get(index) as ListItem;
			var isSelected:Boolean = li.item.selected;
			var obj:Object = value is String ? { label:value } : value;
			obj.selected = isSelected;
			obj.index = index;
			li.spas_internal::setValue(obj.label);
			li.data = data;
			li.spas_internal::setItem(obj);
			if (index >= _currentDataCursor && index < _currentDataCursor +_selectItemNum)
				this.updateItemById(index, index);
			
			//setRefresh();
			setScrollBarProps();
			return li;
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			/*
			var obj:Object = value is XML ? XMLSerializer.decode(value) : value;
			
			obj.index = index;
			if (obj.selected == undefined) obj.selected = false;
			var li:ListItem = new ListItem(obj, objList, value, data, index);
			
			_dataLength++;
			
			if (index >= _currentDataCursor && index < _currentDataCursor +_selectItemNum)
				this.updateItemById(index, index);
			
			//setRefresh();
			return li;*/
			setScrollBarProps();
			return null;
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
			item.data = null;
			item = null;
			_dataLength--;
			setMaxScroll();
			if (id >= _currentDataCursor && id < _currentDataCursor +_selectItemNum) {
				if (_currentDataCursor + _selectItemNum >= _dataLength && _currentDataCursor > 0) {
					_currentDataCursor--;
				}
				updateVisibleItems();
			}
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
			var l:int = _selectItemNum - 1;
			for (;  l >= 0;  l--) resetSelectItem(l);
			_vScroll.value = _currentDataCursor = 0;
			setRefresh();
			setScrollBarProps();
		}
		
		/**
		 * 	[Partially implemented.]
		 * 
		 * 	Resets this <code>DataGrid</code> instance.
		 */
		public function reset():void {
			if ($listItem != null) {
				unselectItem($listItem);
				$listItem = null;
			}
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
			_borderDecorator.finalize();
			_borderDecorator = null;
			_vScroll.finalize();
			_vScroll = null;
			_itemsCont.finalizeElements();
			_itemsCont.finalize();
			_itemsCont = null;
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
		public function notifyKeyUpEvent(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case Keyboard.ENTER :
					dispatchKeyEvent(KeyObserverEvent.ENTER_KEY_UP);
					break;
				case Keyboard.ESCAPE : 
					dispatchKeyEvent(KeyObserverEvent.ESCAPE_KEY_UP);
					break;
			}
			
		}
		
		private function dispatchKeyEvent(type:String):void {
			this.dispatchEvent(new KeyObserverEvent(type));
		}
		
		private function increaseItemValue():void {
			if ($selectedIndex < _currentDataCursor) {
				_currentDataCursor = $selectedIndex +1;
				updateVisibleItems();
			} else if ($selectedIndex > _currentDataCursor + _selectItemNum) {
				_currentDataCursor = $selectedIndex - _selectItemNum + 1;
				updateVisibleItems();
			}
			if ($selectedIndex < _dataLength -1) {
				var si:SelectableItem;
				var currId:int;
				currId = $selectedIndex - _currentDataCursor;
				if (currId + 1 == _selectItemNum) {
					_currentDataCursor++;
					updateVisibleItems();
				} else {
					currId++;
				}
				si = _itemsCont.getObjectAt(currId) as SelectableItem;
				currentItemChanged(si);
				selScrollthumbValue();
			}
		}
		
		private function selScrollthumbValue():void {
			_vScroll.value = _currentDataCursor;
		}
		
		private function decreaseItemValue():void {
			if ($selectedIndex < _currentDataCursor) {
				_currentDataCursor = $selectedIndex;
				updateVisibleItems();
			} else if ($selectedIndex > _currentDataCursor + _selectItemNum) {
				_currentDataCursor = $selectedIndex - _selectItemNum;
				updateVisibleItems();
			}
			if ($selectedIndex > 0) {
				var si:SelectableItem;
				var currId:int;
				currId = $selectedIndex - _currentDataCursor;
				if (currId == 0) {
					_currentDataCursor--;
					$selectedIndex;
					updateVisibleItems();
				} else {
					currId--;
				}
				si = _itemsCont.getObjectAt(currId) as SelectableItem;
				currentItemChanged(si);
				selScrollthumbValue();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
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
				updateVisibleItems();
			} else {
				var currId:int;
				if ($selectedIndex < _currentDataCursor) {
					_currentDataCursor = $selectedIndex;
					currId = $selectedIndex - _currentDataCursor;
				} else if ($selectedIndex > _currentDataCursor + _selectItemNum) {
					_currentDataCursor = $selectedIndex - _selectItemNum +1;
					currId = $selectedIndex - _currentDataCursor;
				} else {
					_currentDataCursor = $selectedIndex;
					currId = $selectedIndex - _currentDataCursor ;
				}
				updateVisibleItems();
				$listItem = $objList.get($selectedIndex) as ListItem;
				$value = $listItem.value;
				$data = $listItem.data;
				var si:SelectableItem = _itemsCont.getObjectAt(currId) as SelectableItem;
				si.selected = $listItem.item.selected = si.dotted = true;
				if (_keyManager.getKeyObserver() != this) _keyManager.setKeyObserver(this);
				selScrollthumbValue();
			}
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
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
			if (_previousWidth != $width) {
				fixItemsWidth();
				changeItemsWidth();
				_previousWidth = $width;
			}
			drawMask();
			_borderDecorator.drawBackground();
			setScrollBarProps();
			_borderDecorator.drawBorders();
			setEffects();
		}
		
		private function currentItemChanged(caller:SelectableItem):void {
			var i:int = caller.index;
			if ($multiple) {
				
			} else {
				var newItem:ListItem = $objList.get(i) as ListItem;
				if ($selectedIndex != i) {
					if ($listItem != null) unselectItem($listItem);
					caller.selected = newItem.item.selected = caller.dotted = true;
					$value = newItem.value;
					$data = newItem.data;
					$selectedIndex = i;
					$listItem = newItem;
					selScrollthumbValue();
					if (_keyManager.getKeyObserver() != this) _keyManager.setKeyObserver(this);
				} else {
					if(_unselectEnabled) {
						caller.selected = $listItem.item.selected = caller.dotted = false;
						$selectedIndex = -1;
						$listItem = null;
						$value = null;
						$data = null;
						_keyManager.deleteKeyObserver(this);
					}
				}
			}
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function unselectItem(item:ListItem):void {
			item.item.selected = false;
			var itemId:int = item.index - _currentDataCursor;
			if (itemId >= 0 && itemId < _selectItemNum) {
				var si:SelectableItem = _itemsCont.getObjectAt(itemId) as SelectableItem;
				si.selected = si.dotted = false;
			}
			_keyManager.deleteKeyObserver(this);
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_vScroll.lockLaf(lookAndFeel.getScrollBarLaf(), true);
			_scrollBoundsRatio = _vScroll.upButtonSize + _vScroll.downButtonSize;
			$backgroundColor = lookAndFeel.getBackgroundColor();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _keyManager:KeyboardManager;
		private var _dataCont:Sprite;
		private var _itemsCont:Canvas;
		private var _itemsMask:Shape;
		private var _dataViewHeight:Number;
		private var _vScroll:ScrollBar;
		private var _previousWidth:Number = 0;
		private var _dataLength:int = 0;
		private var _currentDataCursor:int = 0;
		private var _itemsHeightMode:Boolean = false;
		private var _currHeight:Number;
		private var _selectItemNum:Number = 0;
		private var _itemsWidth:Number = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, size:uint, height:Number):void {
			_previousWidth = $width = width;
			_currHeight = height;
			_size = size;
			initListBox();
			spas_internal::setSelector(Selectors.LISTBOX);
			spas_internal::isInitialized(1);
		}
		
		private function fixItemsWidth():void {
			var d:Number = _showScrollBar ? _vScroll.thickness : 0;
			_itemsWidth = $width - d;
		}
		
		private function initListBox():void {
			_keyManager = UIDescriptor.getUIManager().keyboardManager;
			$finalizeItems = false;
			//initMinSize(50, 50);
			createContainers();
			fixItemsWidth();
			setHeight(_currHeight);
			initItems();
			setMaxScroll();
			initLaf(ListBoxUIRef);
			createBackgroundTextureManager(spas_internal::background);
			_borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
		}
		
		private function initItems():void {
			fixItemsNum();
			setDataViewHeight();
		}
		
		private function createContainers():void {
			createBackground();
			$content = new Sprite();
			spas_internal::uioSprite.addChild($content);
			_dataCont = new Sprite();
			$content.addChild(_dataCont);
			_itemsCont = new Canvas();
			_itemsCont.autoAdjustSize = false;
			_itemsCont.layout = new TableVerticalLayout();
			_itemsCont.target = _dataCont;
			_itemsCont.display();
			_itemsMask = new Shape();
			_dataCont.addChild(_itemsMask)
			_dataCont.mask = _itemsMask;
			_vScroll = new ScrollBar(null);
			_vScroll.lockThumbSize = _vScroll.useIncremental = true;
			_vScroll.target = $content;
			_vScroll.display();
			$evtColl.addEvent(_vScroll, ScrollEvent.SCROLL, onScrollHandler)
			
			_borders = new Sprite();
			spas_internal::uioSprite.addChild(_borders);
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			var l:int;
			var i:int;
			var a:Array = $dataProvider.toArray();
			l = a.length - 1;
			i = 0;
			for (; i <= l; ++i) addItem(a[i]);
			
			_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
			updateAutoHeight();
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			//--> TODO: add the _invalidateListUpdate process
			checkStrictMode("ListBox");
			var data:XML = $xmlQuery.xml;
			switch($dataBindingMode) {
				case DataBindingMode.RESET:
					removeAll();
					break;
				case DataBindingMode.UPDATE:
				case DataBindingMode.MERGE:
					break;
			}
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			var i:int = 0;
			var prop:XML;
			var di:XMLList = data.item;
			for each(prop in di) {
				/*var d:* = null;
				if (prop.@data != undefined) {
					d = prop.@data.toXMLString();
					delete prop.@data;
				}*/
				switch($dataBindingMode) {
					case DataBindingMode.INCREMENT:
					case DataBindingMode.RESET:
						addItem(prop);
						break;
					case DataBindingMode.MERGE :
					case DataBindingMode.UPDATE:
						updateItemAt(i, prop);
						break;
				}
				i++;
			}
			
			_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
			updateAutoHeight();
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		private var _thumbMinSize:Number = 15;
		private var _scrollBoundsRatio:Number = 0;
		
		private function setScrollBarProps():void {
			if ($invalidateRefresh) return;
			if (!_showScrollBar) return;
			_vScroll.length = _dataViewHeight;
			_vScroll.x = $width - _vScroll.thickness;
			if (_dataLength > _selectItemNum) {
				_vScroll.scrollTargetPolicy = ScrollTargetPolicy.ENABLE_IF_NULL;
				var ratio:Number =  (_dataViewHeight / _lineHeight) / _dataLength;
				var h:Number = (_dataViewHeight - _scrollBoundsRatio) * ratio;
				_vScroll.thumbLength = Math.max(h, _thumbMinSize);
			} else _vScroll.scrollTargetPolicy = ScrollTargetPolicy.DISABLE_IF_NULL;
			updateScrollValue();
		}
		
		private function fixPositions():void {
			_currHeight = _itemsHeightMode ? _dataViewHeight : $height;
		}
		
		private function updateItemById(index:uint, dataCursor:uint):void {
			var si:SelectableItem = _itemsCont.getObjectAt(index) as SelectableItem;
			if (index >= $objList.size) {
				resetSelectableItem(si);
			} else  {
				var item:Object = $objList.get(dataCursor).item;
				si.spas_internal::setIndex(dataCursor);
				si.enabled = true;
				si.selected = si.dotted = item.selected;
				updateSelectableItem(si, item);
			}
		}
		
		private function resetSelectItem(index:uint):void {
			var si:SelectableItem = _itemsCont.getObjectAt(index) as SelectableItem;
			resetSelectableItem(si);
		}
		
		private function createSelectableItem():void {
			var si:SelectableItem = new SelectableItem("");
			si.enabled = false;
			si.width = _itemsWidth;
			addItemHandlers(si);
			_itemsCont.addElement(si);
		}
		
		private function deleteSelectItemAt(index:uint):void {
			var si:SelectableItem = _itemsCont.removeElementAt(index) as SelectableItem;
			removeItemHandlers(si)
			si.finalize();
			si = null;
		}
		
		private function setMaxScroll():void {
			_vScroll.maximum = _dataLength - _selectItemNum;
		}
		
		private function onScrollHandler(e:ScrollEvent):void {
			var v:Number = e.target.value;
			if (_currentDataCursor != v)  {
				_currentDataCursor = v;
				updateVisibleItems();
			}
		}
		
		private function updateScrollValue():void {
			setMaxScroll();
			selScrollthumbValue();
		}
		
		private function updateVisibleItems():void {
			var i:int = 0;
			var j:int = _currentDataCursor;
			for (; i < _selectItemNum; ++i, ++j) this.updateItemById(i, j);
		}
		
		private function setHeight(value:Number):void {
			$height = value;
			_itemsHeightMode = isNaN(value) ? true : false;
			fixPositions();
		}
		
		private function fixItemsNum():void {
			_selectItemNum = _itemsHeightMode ? _size : Math.ceil($height / _lineHeight);
			var i:int = 0;
			for (; i < _selectItemNum; ++i) this.createSelectableItem();
		}
		
		private function setDataViewHeight():void {
			_dataViewHeight = _itemsHeightMode ? _selectItemNum * _lineHeight : $height;
		}
		
		private function initListBoxItem(index:int, dataCursor:int):void {
			var obj:Object = $objList.size > dataCursor ? $objList.get(dataCursor).item : null;
			var si:SelectableItem = _itemsCont.getObjectAt(index) as SelectableItem;
			if (obj != null) {
				si.spas_internal::setIndex(index);
				si.label = obj.label;
			} else {
				si.label = "";
			}
		}
		
		/**
		 * 	Changes the number of items displayed by the Datagrid
		 * 	each time a new height or item height are set.
		 */
		private function setNewHeightProps():void {
			var offset:Number = _dataViewHeight - _selectItemNum * _lineHeight;
			if (offset == 0) return;
			else {
				_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
				var l:uint;
				var i:uint;
				if (offset > 0) {
					var id:uint = _selectItemNum;
					l = Math.ceil(offset / _lineHeight);
					_selectItemNum += l;
					var j:int = _currentDataCursor + id;
					if (_dataLength < l + j) {
						var addItemNum:int = _selectItemNum - id;
						_currentDataCursor = (_currentDataCursor - addItemNum) < 0 ? 0 : _currentDataCursor - addItemNum;
						i = 0;
						j = _currentDataCursor;
						for (; i < id; ++i, ++j) this.updateItemById(i, j);
					}
					i = 0;
					for (; i < l; ++i, ++j, ++id) {
						this.createSelectableItem();
						this.initListBoxItem(id, j);
						this.updateItemById(id, j);
					}
				} else if (offset < 0) {
					l = Math.abs(Math.ceil(offset / _lineHeight));
					i = _selectItemNum -1;
					for (; l > 0; l--) {
						deleteSelectItemAt(i--);
					}
					_selectItemNum = _itemsCont.numElements;
				}
				_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
				_itemsCont.spas_internal::updateLayout();
			}
		}
		
		private function drawMask():void {
			with (_itemsMask.graphics) {
				clear();
				beginFill(0, .5);
				drawRect(0, 0, $width, _dataViewHeight);
				endFill();
			}
		}
		
		private function removeItemHandlers(si:SelectableItem):void {
			$listEvtColl.removeEvent(si, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.removeEvent(si, UIMouseEvent.RELEASE, releaseHandler);
		}
		
		private function addItemHandlers(si:SelectableItem):void {
			$listEvtColl.addEvent(si, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.addEvent(si, UIMouseEvent.RELEASE, releaseHandler);
		}
		
		private function pressHandler(e:UIMouseEvent):void {
			Scrollable.spas_internal::changeCurrentScrollable(_vScroll);
			var si:SelectableItem = e.target as SelectableItem;
			currentItemChanged(si);
			dispatchEvent(new ListEvent(ListEvent.ITEM_PRESSED));
		}
		
		private function updateSelectableItem(si:SelectableItem, value:*):void {
			si.label = value.label != null ? value.label : "";
			si.height = value.height != null ? value.height : _lineHeight;
			if (value.alt != null) si.alt = value.alt;
			if (value.icon != null) si.setIcon(value.icon);
			if (value.brush != null) si.drawIcon(value.brush);
			si.active = value.active != null ? value.active : true;
			if(value.className != null && value.className != undefined) si.className = value.className;
			//if(value.id != null && value.id != undefined) si.id = value.id;
		}
		
		private function convertXmlData(xmlData:XML):Object {
			var obj:Object = { };
			obj.label = xmlData.@label != undefined ? xmlData.@label.toXMLString() : "";
			obj.data = xmlData.@data;
			obj.height = (xmlData.@height != undefined) ? Number(xmlData.@height.toXMLString()) : _lineHeight;
			if (xmlData.@alt != undefined) obj.alt = xmlData.@alt.toXMLString();
			if (xmlData.@icon != undefined) obj.icon = xmlData.@icon.toXMLString();
			if (xmlData.@brush != undefined) obj.brush = xmlData.@brush;
			obj.active = xmlData.@active != undefined ? xmlData.@active : true;
			if(xmlData.@className != undefined) obj.className = xmlData.@className.toXMLString();
			return obj;
		}
		
		private function resetSelectableItem(si:SelectableItem):void {
			si.label = "";
			si.selected = si.enabled = si.dotted = false;
			si.spas_internal::setIndex(-1);
			si.height = _lineHeight;
			si.alt = null;
			si.deleteIcon();
			si.clearIcon();
			si.active = true;
			si.className = "";
			//si.id = value.id;
		}
		
		private function releaseHandler(e:UIMouseEvent):void {
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
		}
		
		private function changeItemsWidth():void {
			_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = true;
			var i:int = _itemsCont.numElements - 1;
			for (; i >= 0; i--) _itemsCont.getObjectAt(i).width = _itemsWidth;
			_itemsCont.spas_internal::invalidateLayoutUpdate = $invalidateRefresh = false;
		}
		
		private function fixAutoHeight():void {
			if ($autoHeight) $height = _lineHeight * Math.max(_size, _dataLength);
		}
		
		private function updateAutoHeight():void {
			if ($autoHeight) {
				$height = _lineHeight * Math.max(_size, _dataLength);
				setHeight($height);
				setDataViewHeight();
				setNewHeightProps();
			}
		}
	}
}