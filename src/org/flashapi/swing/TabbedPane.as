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
	// TabbedPane.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0, 17/03/2010 22:15
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.button.TabButton;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.list.TabListItem;
	import org.flashapi.swing.plaf.libs.TabbedPaneUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("TabbedPane.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>TabbedPane</code> changes value due to mouse
	 * 	or keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>TabbedPane</code> instance has finished using the data provided by the DataProvider object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the <code>TabbedPane</code> instance has finished using the data provided by the XMLQuery object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 * 	<img src="TabbedPane.png" alt="TabbedPane" width="18" height="18"/>
	 * 
	 * 	The <code>TabbedPane</code> class creates a <code>MultiView</code> container,
	 * 	including a <code>TabBar</code> instance for navigating between the child view
	 * 	containers. There is one <code>TabBar</code> button associated with each view
	 * 	container,  and each <code>TabBar</code> button belongs to the <code>TabbedPane</code>
	 * 	container, not to the child. When the user clicks a <code>TabBar</code> button,
	 * 	the associated container view is displayed.
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>TabbedPane</code> instance. Each item for <code>DataProvider</code>
	 * 	object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value</code> parameter of the 
	 * 		<code>TabbedPane.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter of
	 * 		the <code>TabbedPane.addItem()</code> method,</li>
	 * 		<li><code>element:<em>untyped</em></code>; the <code>value</code> parameter of
	 * 		the <code>UIObject.addElement()</code> method,</li>
	 * 		<li><code>type:String</code>; the <code>type</code> parameter of the
	 * 		the <code>UIObject.addElement()</code> method.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>You also can assign a <code>XMLQuery</code> object to a <code>TabbedPane</code>
	 * 	instance.</p>
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="TabbedPane" urlPath="my_URLPath"&gt;
	 *			&lt;item element="element_url" label="label" type="type" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 	<p>The following table lists the attributes you can specify, their data types,
	 * 	and their purposes:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Must be <code>TabbedPane</code>; if <code>XMLQuery.strictMode</code> is <code>true</code>,
	 * 				you must specifie this attribute.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>TabbedPane.urlPath</code> property.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.element</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI of the child element loaded within this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.label</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used as label for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.type</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the type used as the <code>type</code> property for this
	 * 			item. Default value is <code>graphic</code> (<code>DataFormat.GRAPHIC</code>.)</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string used as the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 	<code>TabbedPane</code> instance:</p>
	 * 	<p>
	 * 		- using the <code>TabbedPane.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var tp:TabbedPane = new TabbedPane();
	 * 
	 * 			var li1:ListItem = tp.addItem("Label 1", myData1);
	 * 			li1.item.view.addElement("picture_01.jpg");
	 * 
	 * 			var li2:ListItem = tp.addItem("Label 2", myData2);
	 * 			li2.item.view.addElement("picture_02.jpg");
	 * 
	 * 			var li3:ListItem = tp.addItem("Label 3", myData3);
	 * 			li3.item.view.addElement("picture_03.jpg");
	 * 
	 * 			var li4:ListItem = tp.addItem("Label 4", myData4);
	 * 			li4.item.view.addElement("picture_04.jpg");
	 * 
	 * 			tp.display();
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>TabbedPane.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var tp:TabbedPane = new TabbedPane();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 
	 * 			dp.addAll(  { label:"Label 1", element:"picture_01.jpg", data:myData1 },
	 * 						{ label:"Label 2", element:"picture_02.jpg", data:myData2 },
	 * 						{ label:"Label 3", element:"picture_03.jpg", data:myData3 },
	 * 						{ label:"Label 4", element:"picture_04.jpg", data:myData4 });
	 * 			tp.dataProvider = dp;
	 * 
	 * 			tp.display();
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>TabbedPane.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item element="url_1.jpg" label="Label 1" data="myData1" /&gt;
	 *								&lt;item element="url_2.jpg" label="Label 2" data="myData2" /&gt;
	 *								&lt;item element="url_3.jpg" label="Label 3" data="myData3" /&gt;
	 * 								&lt;item element="url_4.jpg" label="Label 3" data="myData4" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var tp:TabbedPane = new TabbedPane();
	 * 			tp.xmlQuery = request;
	 * 
	 * 			tp.display();
	 * 		</listing>
	 * 	</p>
	 * 
	 *  @includeExample TabbedPaneExample.as
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.plaf.TabbedPaneUI
	 *  @see org.flashapi.swing.TabBar
	 *  @see org.flashapi.swing.MultiView
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class TabbedPane extends ALM implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>TabbedPane</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>TabbedPane</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>TabbedPane</code> instance, in
		 * 					pixels.
		 */
		public function TabbedPane(width:Number = 300, height:Number = 200) {
			super();
			initObj(width, height);
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
		
		private var _multiView:MultiView;
		/**
		 * 	Returns a reference to the <code>MultiView</code> instance used to hold
		 * 	elements within this <code>TabbedPane</code> instance.
		 */
		public function get multiView():MultiView {
			return _multiView;
		}
		
		private var _tabBar:TabBar;
		/**
		 * 	Returns a reference to the <code>TabBar</code> instance used to navigate
		 * 	between container within this <code>TabbedPane</code> instance.
		 */
		public function get navigationBar():TabBar {
			return _tabBar;
			}
		
		/**
		 *  Sets or gets the index of the current view container visible within
		 * 	this <code>TabbedPane</code> instance. If <code>-1</code>, no container
		 * 	is currently visible within this <code>TabbedPane</code> instance.
		 * 
		 * 	@default -1
		 */
		public function set index(value:int):void {
			_multiView.index = _tabBar.selectedIndex = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			$height = value;
			_multiView.height = value - (_buttonHeight);
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			$width = _multiView.width = value;
		}
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle (0, 0, $width, $height);
			return r;
		}
		
		/**
		 * @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle (0, 0, $width, $height);
			return r;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			var listItem:ListItem = _tabBar.addItem( { label:value, height:_buttonHeight }, data);
			var view:Canvas = _multiView.addView();
			var tli:TabListItem = new TabListItem(listItem.item, view);
			var li:ListItem = new ListItem(tli, $objList, value, data);
			if (!_invalidateListUpdate) {
				updateItemList();
				setRefresh();
			}
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			var listItem:ListItem = _tabBar.addItem( { label:value, height:_buttonHeight }, data);
			var view:Canvas = _multiView.addView();
			var tli:TabListItem = new TabListItem(listItem.item, view);
			var li:ListItem = new ListItem(tli, $objList, value, data, index);
			if (!_invalidateListUpdate) {
				updateItemList();
				setRefresh();
			}
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			var btn:TabButton = item.item;
			if(btn.displayed) btn.remove();
			$objList.remove(item);
			$listItem = null;
			$value = $data = null;
			setRefresh();
		}
		
		/**
		 *  @private 
		 */
		override public function finalize():void {
			_multiView.finalize();
			_multiView = null;
			_tabBar.finalize()
			super.finalize();
		}
		
		/**
		 * 	Removes and finalizes all elements 
		 */
		public function finalizeElements():void {
			_multiView.finalizeElements();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			if (!_multiView.displayed) {
				_multiView.display();
				_tabBar.display();
			}
			refresh();
			//fixDisplayContainer(_selectedIndex);
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void { 	}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function updateItemList():void {
			var it:Iterator = $objList.iterator;
			var s:uint = $objList.size;
			var btnWidth:Number;
			if (_tabBar.width > $width) {
				btnWidth = $width / s;
				_tabBar.setButtonsWidth(btnWidth);
			}
			it.reset();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _buttonHeight:Number = ABM.DEFAULT_HEIGHT;
		private var _invalidateListUpdate:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$width = width;
			$height = height;
			initMinSize(50, 50);
			initLaf(TabbedPaneUIRef);
			
			_multiView = new MultiView(0, $width, $height);
			_multiView.borderStyle = BorderStyle.SOLID;
			_multiView.target = spas_internal::uioSprite;
			_tabBar = new TabBar();
			_tabBar.target = spas_internal::uioSprite;
			fixControlsSize();
			
			$evtColl.addEvent(_tabBar, ListEvent.ITEM_CLICKED, itemClickedHandler);
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			
			spas_internal::setSelector(Selectors.TABBED_PANE);
			spas_internal::isInitialized(1);
		}
		
		private function fixControlsSize():void {
			_multiView.width = width;
			_multiView.y = _buttonHeight;
		}
		
		private function itemClickedHandler(e:ListEvent):void {
			var ind:uint = e.target.listItem.index;
			_multiView.index = ind;
			$listItem = $objList.get(ind) as ListItem;
			$value = _tabBar.label;
			$data = _tabBar.data;
			this.dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			_invalidateListUpdate = true;
			var it:Iterator = $dataProvider.iterator;
			var obj:Object;
			var li:ListItem;
			while(it.hasNext()) {
				obj = it.next();
				li = addItem(obj.label, obj.data);
				if(obj.element) {
					li.item.view.addElement(obj.element, obj.type != null ? obj.type : DataFormat.GRAPHIC);
				}
			}
			it.reset();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
			_invalidateListUpdate = false;
			updateItemList();
			setRefresh();
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			_invalidateListUpdate = true;
			var data:XML = $xmlQuery.xml;
			checkStrictMode("TabbedPane");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			var lab:String;
			var d:*;
			var li:ListItem;
			var c:Canvas;
			var prop:XML;
			for each(prop in data.item) {
				lab = prop.@label.toString();
				d = prop.@data;
				li = _tabBar.addItem(lab, d);
				if (prop.@element != null) {
					c = li.item.view;
					c.addElement(prop.@element, prop.@type != null ? prop.@type : DataFormat.GRAPHIC);
				}
			}
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
			_invalidateListUpdate = false;
			updateItemList();
			setRefresh();
		}
	}
}