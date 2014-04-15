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
	// MenuBar.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 10/11/2010 14:49
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.flashapi.swing.button.MenuButton;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.databinding.XMLQuery;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.list.ButtonList;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.libs.MenuBarUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("MenuBar.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an item is clicked within this <code>MenuBar</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name = "itemClicked", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>MenuBar</code> instance has been populated by
	 * 	an <code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 * 	<img src="MenuBar.png" alt="MenuBar" width="18" height="18"/>
	 * 
	 * 	The <code>MenuBar</code> class creates a horizontal, top-level menu bar that contains
	 * 	menu items with a common look and feel. Clicking on a top-level menu item opens
	 * 	a pop-up submenu which is an instance of the <code>MenuBuilder</code> class.
	 * 
	 * 	<p>For information and samples about the attributes you can use with xml data
	 * 	for <code>MenuBuilder</code> instances, see the <code>MenuBuilder</code> class.</p> 
	 * 
	 * <p><strong><code>MenuBar</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">gap</code></td>
	 * 			<td>Sets the gap of the object.</td>
	 * 			<td>Possible values are positive numbers.</td>
	 * 			<td><code>gap</code></td>
	 * 			<td>Properties.GAP</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 *  @includeExample MenuBarExample.as
	 * 
	 * 	@see org.flashapi.swing.MenuBuilder
	 * 	@see org.flashapi.swing.list.ALM#XMLQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 * 	@see org.flashapi.swing.plaf.MenuBarUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MenuBar extends ButtonList implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>MenuBar</code> instance with the 
		 * 					specified width.
		 * 
		 * 	@param	width	The width of the <code>MenuBar</code> instance, in pixels.
		 */
		public function MenuBar(width:Number = 100) {
			super();
			initObj(width);
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
		 * 	@private
		 */
		override public function set autoHeight(value:Boolean):void {
			$autoHeight = _itemContainer.autoHeight = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set autoWidth(value:Boolean):void {
			$autoWidth = _itemContainer.autoWidth = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set autoSize(value:Boolean):void {
			$autoSize = _itemContainer.autoSize = value;
			setRefresh();
		}
		
		private var _barRightPadding:Number = 10;
		/**
		 *  Sets or gets the right-hand padding value for this <code>MenuBar</code>
		 * 	instance, in pixels.
		 * 
		 * 	@default 10
		 * 
		 * 	@see #barLeftPadding
		 */
		public function get barRightPadding():Number {
			return _barRightPadding;
		}
		public function set barRightPadding(value:Number):void { 
			_barRightPadding = _itemContainer.paddingRight = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		private var _barLeftPadding:Number = 10;
		/**
		 *  Sets or gets the left-hand padding value for this <code>MenuBar</code>
		 * 	instance, in pixels.
		 * 
		 * 	@default 10
		 * 
		 * 	@see #barRightPadding
		 */
		public function get barLeftPadding():Number {
			return _barLeftPadding;
		}
		public function set barLeftPadding(value:Number):void { 
			_barLeftPadding = _itemContainer.paddingLeft = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		private var _gap:Number = 0;
		/**
		 *  Sets or gets the horizontal gap value for this <code>MenuBar</code> instance,
		 * 	in pixels.
		 * 
		 * 	@default 0
		 */
		public function get gap():Number {
			return _gap;
		}
		public function set gap(value:Number):void { 
			_gap = _itemContainer.horizontalGap = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			return _itemContainer.height;
		}
		
		private var _itemHeight:Number = 22;
		/**
		 *  Sets or gets the height of all menu items displayed within this
		 * 	<code>MenuBar</code> instance, in pixels.
		 * 
		 * 	@default 22
		 */
		public function get itemHeight():Number {
			return _itemHeight;
		}
		public function set itemHeight(value:Number):void { 
			_itemHeight = value;
			//setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function get width():Number {
			return _itemContainer.width;
		}
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			spas_internal::lafDTO.width = $width = _itemContainer.width = value;
			_itemContainer.spas_internal::updateLayout();
			setRefresh();
		}
		
		/**
		 * @private
		 */
		private var _trayColor:*;
		/**
		 * 	Sets and gets the tray color for this <code>MenuBar</code> instance.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a>
		 * 	recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a>
		 * 	section of the document to get valid SVG color keyword names.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 * 	@default null
		 */
		public function get trayColor():* {
			return _trayColor;
		}
		public function set trayColor(value:*):void {
			spas_internal::lafDTO.trayColor = _trayColor = getColor(value);
			if ($displayed) {
				spas_internal::lafDTO.currentTarget = _tray;
				lookAndFeel.drawTray();
			}
		}
		
		/**
		 * @private
		 */
		private var _trayAlpha:Number = 1;
		/**
		 * 	Sets and gets the tray opacity for this <code>MenuBar</code> instance,
		 * 	from <code>0</code> (fully transparent) to <code>1</code> (fully opaque).
		 * 
		 * 	@default 1
		 */
		public function get trayAlpha():Number {
			return _trayAlpha;
		}
		public function set trayAlpha(value:Number):void {
			spas_internal::lafDTO.trayAlpha = _trayAlpha = value;
			if ($displayed) {
				spas_internal::lafDTO.currentTarget = _tray;
				lookAndFeel.drawTray();
			}
		}
		
		/*override public function set fixToParentWidth(value:Boolean):void {
			_fixToParentWidth = _itemContainer.fixToParentWidth = value; setRefresh();
		}*/
		/*override public function set fixToParentHeight(value:Boolean):void {
			_fixToParentHeight = _itemContainer.fixToParentHeight = value; setRefresh();
		}*/
		//override public function get height():Number { return _itemContainer.height; }
		/*override public function set toggleMode(value:Boolean):void { 
			_toggleMode = value;
			if (_currentItem != null && _barIsActive) _currentItem.selected = false;
			updateItemList();
		}*/
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the item element with the ID specified by the <code>value</code>
		 * 	parameter.
		 * 
		 * 	@param	value 	A string representing the unique ID of the element being
		 * 					sought. 
		 * 
		 *  @return The element with the specified ID.
		 */
		public function getElementByID(value:String):* {
			return UIDescriptor.getUIManager().document.getElementByID(value);
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			if($displayed) {
				unload();
				if($listEvtColl != null) $listEvtColl.removeAllEvents();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			var menu:MenuBuilder;
			for each(menu in $dataList) {
				menu.finalize();
				menu = null;
			}
			spas_internal::lafDTO.spas_internal::finalize();
			_itemContainer.finalizeElements();
			_itemContainer.finalize();
			_itemContainer = null;
			super.finalize();
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		public function setToggleModeAt(index:uint, value:Boolean):void {
			//var mb:MenuBuilder = 
			//mb.setToggleModeAt(index, value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			spas_internal::lafDTO.currentTarget = _tray;
			lookAndFeel.drawTray();
			spas_internal::lafDTO.currentTarget = _borders;
			lookAndFeel.drawBorder();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var it:Iterator = $objList.iterator;
			var btn:MenuButton;
			var lafRef:Class = lookAndFeel.getButtonLaf();
			while (it.hasNext()) {
				btn = it.next().item as MenuButton;
				btn.lockLaf(lafRef, true);
			}
			it.reset();
			var menu:MenuBuilder;
			lafRef = lookAndFeel.getMenuLaf();
			for each(menu in $dataList) menu.lockLaf(lafRef, true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _itemContainer:Box;
		private var _currentItem:MenuButton = null;
		private var _barIsActive:Boolean = false;
		private var _tray:Sprite;
		private var _borders:Sprite;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number):void {
			$finalizeItems = false;
			spas_internal::lafDTO.trayColor = null;
			spas_internal::lafDTO.trayAlpha = 1;
			initMinSize();
			initSize(width, _itemHeight);
			createContainers();
			initLaf(MenuBarUIRef);
			//_toggleMode = true;
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			spas_internal::setSelector(Selectors.MENU_BAR);
			$dataList = new Dictionary();
			spas_internal::isInitialized(1);
		}
		
		private function addAvents(btn:MenuButton):void {
			$listEvtColl.addEvent(btn, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.addEvent(btn, UIMouseEvent.RELEASE, releaseHandler);
			$listEvtColl.addEvent(btn, UIMouseEvent.ROLL_OVER, rollOverHandler);
		}
		
		private function rollOverHandler(e:UIMouseEvent):void {
			//trace(_barIsActive);
			if (_barIsActive) {
				var btn:MenuButton = e.target as MenuButton;
				if(btn != _currentItem) {
					$dataList[_currentItem].remove();
					_currentItem = btn;
					displayMenu();
				}
			}
		}
		
		private function releaseHandler(e:UIMouseEvent):void {
			/*var btn:MenuButton = e.uio as MenuButton;
			//_listItem = dataList[btn];
			_value = btn.label;
			//this.spas_internal::setIndex(btn.index);
			_data = btn.data;
			//var li:ListItem = new ListItem(btn, _listItem, _value, _data);
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));*/
			
			displayMenu();
		}
		
		private function pressHandler(e:UIMouseEvent):void {
			var btn:MenuButton = e.target as MenuButton;
			_barIsActive = !_barIsActive;
			//trace(_barIsActive)
			if (_barIsActive) {
				if (_currentItem == null) _currentItem = btn;
				else if(_currentItem != btn) {
					$dataList[_currentItem].remove();
					_currentItem = btn;
				}
				//displayMenu();
			} else {
				if (_currentItem != null) {
					$dataList[_currentItem].remove();
					_currentItem = null;
				}
			}
		}
		
		private function displayMenu():void {
			if (_currentItem == null) return;
			var pt:Point = getMenuCoordinates();
			$dataList[_currentItem].display(pt.x, pt.y);
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			//TODO: for all menus in dataList, menu.finalize().
			var data:XML = $xmlQuery.xml;
			checkStrictMode("MenuBar");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			var d:XMLList = data.children();
			$dataBindingMode == DataBindingMode.INCREMENT ?
				createMenuBar(d) : updateMenuBar(d);
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
			//--> Must be called to actualize size changes:
			setRefresh();
		}
		
		private function updateMenuBar(data:XMLList):void {
			var i:int = 0;
			var l:int = data.length();
			var li:ListItem;
			var lab:String;
			var itemData:*;
			var btn:MenuButton;
			var redrawBtn:Boolean;
			var subLength:int;
			for (; i < l; i++) {
				li = $objList.get(i) as ListItem;
				lab = data[i].@label != null ? data[i].@label.toString() : null;
				itemData = data[i].@data;
				btn = li.item as MenuButton;
				redrawBtn = (btn.label != lab);
				switch ($dataBindingMode) {
					case DataBindingMode.UPDATE :
						btn.label = lab == null ? "" : lab;
						li.data = btn.data = itemData;
						li.spas_internal::setValue(btn.label);
						break;
					case DataBindingMode.MERGE :
						if (lab != null) {
							btn.label = lab;
							li.spas_internal::setValue(btn.label);
						}
						if (itemData != null) li.data = btn.data = itemData;
						break;
				}
				if (redrawBtn) {
					btn.width = NaN;
					btn.redraw();
				}
				subLength = data[i].children().length();
				if (subLength > 0) updateMenu(data[i].children(), btn);
				setLafDTOSize();
			}
		}
		
		private function createMenuBar(data:XMLList):void {
			var i:int = 0;
			var l:int = data.length();
			var lab:String;
			var itemData:*;
			var btn:MenuButton;
			var subLength:int;
			var li:ListItem;
			for (; i < l; i++) {
				lab = data[i].@label != null ? data[i].@label.toString() : "";
				itemData = data[i].@data;
				btn = new MenuButton(lab);
				btn.lockLaf(lookAndFeel.getButtonLaf(), true);
				btn.height = _itemHeight;
				btn.data = itemData;
				//if(_toggleMode) btn.toggle = true;
				subLength = data[i].children().length();
				if (subLength > 0) createNewMenu(data[i].children(), btn);
				li = new ListItem(btn, $objList, btn.label, itemData);
				_itemContainer.addElement(btn);
			}
			setLafDTOSize();
		}
		
		private function createNewMenu(data:XMLList, btn:MenuButton):void {
			var menu:MenuBuilder = new MenuBuilder();
			menu.lockLaf(lookAndFeel.getMenuLaf(), true);
			$listEvtColl.addEvent(menu, UIOEvent.REMOVED, menuRemovedHandler);
			$listEvtColl.addEvent(menu, ListEvent.ITEM_PRESSED, dispatchItemPressedEvent);
			$listEvtColl.addEvent(menu, ListEvent.ITEM_CLICKED, dispatchItemClickedEvent);
			$listEvtColl.addEvent(menu, ListEvent.LIST_CHANGED, dispatchListChangedEvent);
			var query:XMLQuery = new XMLQuery();
			query.add(createMenuData(data));
			menu.xmlQuery = query;
			$dataList[btn] = menu;
			addAvents(btn);
		}
		
		private function updateMenu(data:XMLList, btn:MenuButton):void {
			var menu:MenuBuilder = $dataList[btn];
			menu.dataBindingMode = $dataBindingMode;
			var query:XMLQuery = new XMLQuery();
			query.add(createMenuData(data));
			menu.xmlQuery = query;
		}
		
		private function dispatchItemPressedEvent(e:ListEvent):void {
			var le:ListEvent = new ListEvent(ListEvent.ITEM_PRESSED);
			le.spas_internal::pressedItemRef = e.spas_internal::pressedItemRef;
			dispatchEvent(le);
		}
		
		private function dispatchItemClickedEvent(e:ListEvent):void {
			dispatchMenuChangedEvent(e, ListEvent.ITEM_CLICKED);
		}
		
		private function dispatchListChangedEvent(e:ListEvent):void {
			dispatchMenuChangedEvent(e, ListEvent.LIST_CHANGED);
		}
		
		private function dispatchMenuChangedEvent(e:ListEvent, type:String):void {
			var m:MenuBuilder = e.target as MenuBuilder;
			$listItem = m.listItem;
			$value = m.value;
			$data = m.data;
			dispatchEvent(new ListEvent(type));
		}
		
		private function createMenuData(data:XMLList):XML {
			var menuData:XML = <query></query>;
			menuData.appendChild(data);
			return menuData;
		}
		
		private function createContainers():void {
			_tray = new Sprite();
			_borders = new Sprite();
			spas_internal::uioSprite.addChild(_tray);
			_itemContainer = new Box($width);
			_itemContainer.horizontalGap = _itemContainer.verticalGap = _gap;
			_itemContainer.backgroundAlpha = 0;
			_itemContainer.target = spas_internal::uioSprite;
			_itemContainer.autoSize = true;
			_itemContainer.setPadding(0, _barRightPadding, 0, _barLeftPadding);
			_itemContainer.display();
			spas_internal::uioSprite.addChild(_borders);
		}
		
		private function getMenuCoordinates():Point {
			var pt:Point = spas_internal::uioSprite.localToGlobal(_currentItem.position);
			pt.y += _itemHeight;
			return pt;
		}
		
		private function menuRemovedHandler(e:UIOEvent):void {
			if (_barIsActive) 
				_barIsActive = (spas_internal::uioSprite.hitTestPoint($stage.mouseX, $stage.mouseY));
			if (!_barIsActive) _currentItem = null;
		}
		
		private function setLafDTOSize():void {
			spas_internal::lafDTO.spas_internal::setSize(_itemContainer.width, _itemContainer.height);
		}
	}
}