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
	// Menu.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.1.1, 04/10/2011 19:06
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.button.SelectableItem;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.MenuIconName;
	import org.flashapi.swing.constants.MenuItemType;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.constants.ScrollableOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.list.ButtonList;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.libs.MenuUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Menu.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an item is clicked within the <code>Menu</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name = "itemClicked", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>Menu</code> instance value changes due to mouse
	 * 	or keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/*
	 *  Dispatched when the Menu instance has finished using the data provided by the DataProvider object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]*/
	
	/*
	 *  Dispatched when the Menu instance has finished using the data provided by the XMLQuery object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]*/
	
	/**
	 * 	<img src="Menu.png" alt="Menu" width="18" height="18"/>
	 * 
	 *	The <code>Menu</code> class creates a single menu of individually selectable
	 * 	choices, similar to the File or Edit menu found in most software applications.
	 * 	To easily create complex menus with sub-menu items, use the <code>MenuBuilder</code>
	 * 	class. 	After a Menu control has opened, it remains visible until it is closed
	 * 	by any of the following actions:
	 * 	<ul>
	 * 		<li>a call to the <code>Menu.remove()</code> method,</li>
	 * 		<li>when a user selects an active menu item,</li>
	 * 		<li>when a user clicks outside of the <code>Menu</code> instance.</li>
	 * 	</ul>
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>Menu</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value.label</code> parameter for the
	 * 			<code>Menu.addItem()</code> method.</li>
	 * 		<li><code>type:String</code>; the <code>value.type</code> parameter for the
	 * 			<code>Menu.addItem()</code> method.
	 * 			Meaningful values are <code>""</code> (en empty string), <code>separator</code>,
	 * 			<code>check</code>, or <code>radio</code>.</li>
	 * 		<li><code>toggled:Boolean</code>; the <code>value.toggled</code> parameter for
	 * 			the <code>Menu.addItem()</code> method.
	 * 			Specifies whether a check or radio item is selected. If not specified, the
	 * 			item is treated as if the value were <code>false</code> and the item is not
	 * 			selected. </li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter for the
	 * 			<code>Menu.addItem()</code> method.</li>
	 * 		<li><code>id:String</code>; the unique identifer parameter for the
	 * 			<code>Menu.addItem()</code> method.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>You also can assign a <code>XMLQuery object</code> to a <code>Menu</code> instance.</p>
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="Menu" urlPath="my_URLPath"&gt;
	 *			&lt;item label="label" type="type" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 	<p>The following table lists the attributes you can specify, their data types,
	 * 		and their purposes:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td>String</td>
	 * 			<td>Must be <code>Menu</code>; if the <code>XMLQuery.strictMode</code>
	 * 				property is <code>true</code>, you must specifie this attribute.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>Menu.urlPath</code> property.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.menuitem.label</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used as label for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.menuitem.active</code></td>
	 * 			<td><code>Boolean</code></td>
	 * 			<td>Specifies whether the user can select the menu item (<code>true</code>),
	 * 				or not (<code>false</code>). If not specified, the value is automatically
	 * 				<code>true</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.menuitem.type</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the type used as the <code>type</code> property for this item.
	 * 			Default value is <code>""</code> (an empty string).</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.menuitem.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string that represents the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 		<code>Menu</code> instance:</p>
	 * 	<p>
	 * 		- using the <code>Menu.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var m:Menu = new Menu();
	 * 
	 * 			m.addItem("Label 1", myData1);
	 * 			m.addItem("Label 2", myData2);
	 * 			
	 * 			var obj:Object = { type:"separator" };
	 * 			m.addItem(obj);
	 * 
	 * 			m.addItem("Label 3", myData3);
	 * 
	 * 			m.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>Menu.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var m:Menu = new Menu();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 
	 * 			dp.addAll(  { label:"Label 1", data:myData1 },
	 * 						{ label:"Label 2", data:myData2 },
	 * 						{ type:"separator" },
	 * 						{ label:"Label 3", data:myData3 });
	 * 			m.dataProvider = dp;
	 * 
	 * 			m.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>Menu.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item label="Label 1" data="myData1" /&gt;
	 *								&lt;item label="Label 2" data="myData2" /&gt;
	 *								&lt;item type="separator" /&gt;
	 * 								&lt;item label="Label 3" data="myData3" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var m:Menu = new Menu();
	 * 			m.xmlQuery = request;
	 * 
	 * 			m.display()
	 * 		</listing>
	 * 	</p>
	 * 
	 *  @includeExample MenuExample.as
	 * 
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.plaf.MenuUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 	@see org.flashapi.swing.MenuBuilder
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Menu extends ButtonList implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>Menu</code> instance with the specified
		 * 					width.
		 * 
		 * 	@param	width	The width of the <code>Menu</code> instance, in pixels.
		 */
		public function Menu(width:Number = 150) {
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
		
		private var _autoRemove:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Menu</code>
		 * 	instance have to be removed when the user clicks on an item
		 * 	(<code>true</code>), or not (<code>false</code>).
		 *  
		 * 	@default true
		 */
		public function get autoRemove():Boolean {
			return _autoRemove;
		}
		public function set autoRemove(value:Boolean):void {
			_autoRemove = value;
		}
		
		private var _itemHeight:Number = 20;
		/**
		 * 	Sets or gets the height for all items displayed within in the <code>Menu</code>
		 * 	instance.
		 * 
		 * 	@default 20
		 */
		public function get itemHeight():Number {
			return _itemHeight;
		}
		public function set itemHeight(value:Number):void { 
			_itemHeight = value;
			updateItemsProp("height", _itemHeight);
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			return spas_internal::itemContainer.height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Selectable items color management
		//
		//--------------------------------------------------------------------------
		
		/*override public function set color(value:*):void { 
			if (value == Color.DEFAULT) {
				spas_internal::useDefaultLafColor = true;
				//colors.up = "none";
			} else {
				$color = getColor(value); //colors.up = 
				spas_internal::useDefaultLafColor = false;
			}
			var it:Iterator = objList.iterator;
			var si:SelectableItem;
			while(it.hasNext()) {
				var next:ListItem = it.next() as ListItem;
				si = next.item;
				if (si.color != $color) si.color = color;
			}
			it.reset();
			setRefresh();
		}*/
		
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			return createItem(value, data);
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			return createItem(value, data);
		}
		
		/**
		 * 	@private
		 */
		override public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			var li:ListItem = $objList.get(index) as ListItem;
			var it:* = li.item;
			if (it is Separator) return null;
			
			var si:SelectableItem = it as SelectableItem;
			si.invalidateMetricsChanges = si.invalidateRefresh = true;
			var lab:String;
			var tpe:String;
			var grpName:String;
			var act:Boolean = true;
			var tog:Boolean = false;
			var __id:String = null;
			var icn:String = null;
			var cName:String = null;
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					tpe = MenuItemType.DEFAULT;
					lab = value;
					break;
				case PrimitiveType.OBJECT :
					tpe = value.type != null ? value.type : MenuItemType.DEFAULT;
					lab = value.label;
					act = value.active != null ? value.active : true;
					tog = value.toggled != null ? value.toggled : false;
					grpName = value.groupName != null ? value.groupName : null;
					cName = value.className != null ? value.className : null;
					__id = (value.id != null && value.id != undefined) ? value.id : null;
					icn = value.icon != null ? value.icon : null;
					break;
			}
			if (si.paddingRight != _itemRightPadding) si.paddingRight = _itemRightPadding;
			if (si.paddingLeft != _itemLeftPadding) si.paddingLeft = _itemLeftPadding;
			if(si.height != _itemHeight) si.height = _itemHeight;
			si.invalidateMetricsChanges = si.invalidateRefresh = false;
			si.label = lab;
			//si.spas_internal::setType(tpe);
			//si.active = act;
			//si.data = data;
			//si.toggle = tog;
			switch ($dataBindingMode) {
				case DataBindingMode.UPDATE :
					li.data = data;
					break;
				case DataBindingMode.MERGE :
					if (data != null) li.data = data;
					break;
			}
			li.spas_internal::setValue(si.label);
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			//spas_internal::children = [];
			//spas_internal::children = null;
			if(spas_internal::parentMenu != null) spas_internal::parentMenu = null;
			spas_internal::itemContainer.finalizeElements();
			spas_internal::itemContainer.finalize();
			spas_internal::itemContainer = null;
			super.finalize();
		}
		
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
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var itemContainer:Box;
		
		/**
		 *  @private
		 */
		spas_internal var depth:uint;
		
		/**
		 *  @private
		 */
		spas_internal var parentMenu:Menu;
		
		/**
		 *  @private
		 */
		//spas_internal var children:Array;
		
		//--------------------------------------------------------------------------
		//
		//  MenuBuilder methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal function lockMenu():void {
			_lockMenu = true;
		}
		
		/**
		 *  @private
		 */
		spas_internal function unlockMenu():void {
			_lockMenu = false;
			updateItemList();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function updateItemList():void {
			$dataList = new Dictionary();
			var it:Iterator = $objList.iterator;
			var i:uint = 0;
			var si:SelectableItem;
			var next:ListItem;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				if(next.item is SelectableItem) {
					si = next.item;
					//si.invalidateMetricsChanges = si.invalidateRefresh = true;
					//if (si.paddingRight != _itemRightPadding) si.paddingRight = _itemRightPadding;
					//if (si.paddingLeft != _itemLeftPadding) si.paddingLeft = _itemLeftPadding;
					si.spas_internal::setIndex(i);
					//if(si.height != _itemHeight) si.height = _itemHeight;
					$dataList[si] = next;
					//si.invalidateMetricsChanges = si.invalidateRefresh = false;
				}
				++i;
			}
			it.reset();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var it:Iterator = $objList.iterator;
			var next:ListItem;
			var si:SelectableItem;
			//var elm:Element;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				si = next.item;
				fixItemLaf(si);
				//--> TODO: change all icon brushes.
			}
			it.reset();
			spas_internal::itemContainer.lockLaf(lookAndFeel.getBoxLaf(), true);
			setItemContainerProperties();
			if (lookAndFeel.getStartEffect() != null) {
				$hasDisplayEffect = true;
				this.displayEffectRef = lookAndFeel.getStartEffect();
			}
		}
		
		private function fixItemLaf(si:SelectableItem):void {
			si.lockLaf(lookAndFeel.getSelectableItemLaf(), true);
			si.iconColors.up = lookAndFeel.getOutIconColor();
			si.iconColors.down = lookAndFeel.getPressedIconColor();
			si.iconColors.over = lookAndFeel.getOverIconColor();
			si.iconColors.disabled = lookAndFeel.getInactiveIconColor();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _lockMenu:Boolean = false;
		private var _itemIsPressed:Boolean = false;
		private var _itemRightPadding:Number = 20;
		private var _itemLeftPadding:Number = 20;
		private var _rightIconList:Dictionary;
		private var _buttonGroups:Dictionary;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number):void {
			$finalizeItems = false;
			$parent = $stage;
			$width = width;
			spas_internal::lafDTO.shadow = $dropShadow = true;
			initMinSize(0, 0);
			createItemContainer();
			initLaf(MenuUIRef);
			spas_internal::itemContainer.display();
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_DOWN, detectMenuStageMouseDown);
			spas_internal::setSelector(Selectors.MENU);
			spas_internal::isInitialized(1);
		}
		
		private function createItemContainer():void {
			//spas_internal::children = [];
			_rightIconList = new Dictionary(true);
			_buttonGroups = new Dictionary(true);
			spas_internal::itemContainer = new Box($width);
			spas_internal::itemContainer.spas_internal::setSelector(Selectors.MENU_CONTAINER);
			spas_internal::itemContainer.data = this;
			spas_internal::itemContainer.layout.orientation = LayoutOrientation.VERTICAL;
			spas_internal::itemContainer.verticalGap = spas_internal::itemContainer.padding = 0;
			spas_internal::itemContainer.target = spas_internal::uioSprite;
			spas_internal::itemContainer.autoHeight = true;
		}
		
		private function setItemContainerProperties():void {
			if (spas_internal::itemContainer.spas_internal::useDefaultLafBackgroundColor)
				spas_internal::itemContainer.backgroundColor = lookAndFeel.getColor();
			spas_internal::itemContainer.borderColor = lookAndFeel.getBorderColor();
			spas_internal::itemContainer.borderStyle = lookAndFeel.getBorderStyle();
		}
		
		private function addAvents(si:SelectableItem):void {
			$listEvtColl.addEvent(si, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.addEvent(si, UIMouseEvent.RELEASE, releaseHandler);
		}
		
		private function releaseHandler(e:UIMouseEvent):void {
			var si:SelectableItem = e.target as SelectableItem;
			$listItem = $dataList[si];
			$value = si.label;
			this.spas_internal::setIndex(si.index);
			$data = si.data;
			_itemIsPressed = false;
			if (_autoRemove) this.remove();
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function pressHandler(e:UIMouseEvent):void {
			var si:SelectableItem = e.target as SelectableItem;
			if (si.active) {
				var isChecked:Boolean = false;
				_itemIsPressed = true;
				if (si.type == MenuItemType.CHECK) {
					var ic:Icon = _rightIconList[si] as Icon;
					if (ic.hasIcon) {
						ic.clear();
						isChecked = false;
					} else {
						ic.paint();
						isChecked = true;
					}
				} else if (si.type == MenuItemType.RADIO) {
					var it:Iterator = si.group.iterator;
					while(it.hasNext()) {
						var item:SelectableItem = it.next() as SelectableItem;
						ic = _rightIconList[item] as Icon;
						if (item == si) {
							ic.paint();
							isChecked = true;
						} else  {
							ic.clear();
							isChecked = false;
						}
					}
					it.reset();
				}
				setIconCheckedState(si, isChecked);
				if($toggleMode) {
					if($listItem != null) $listItem.item.selected = false;
					si.selected = true;
				}
				var le:ListEvent = new ListEvent(ListEvent.ITEM_PRESSED);
				le.spas_internal::pressedItemRef = $dataList[si];
				dispatchEvent(le);
			}
		}
		
		private function setIconCheckedState(si:SelectableItem, selected:Boolean):void {
			si.spas_internal::isIconChecked = selected;
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			/*var it:Iterator = _dataProvider.iterator;
			it.reset();
			while(it.hasNext()) {
				var obj:Object = it.next();
				addItem(obj.label, obj.data);
			}
			it.reset();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
			updateItemList();*/
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			/*var data:XML = _xmlQuery.xml;
			checkStrictMode("Menu");
			if(data.@urlPath) _urlPath = data.@urlPath.toString();
			for each(var prop:XML in data.item) {
				var li:ListItem = addItem(prop.@label.toString(), prop.@data.toString());
				var view:Container = li.item.view;
				view.removeChildren();
				view.addChild(prop.@element, prop.@type != null ? prop.@type : "graphic");
			}
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
			updateItemList();*/
		}
		
		private function detectMenuStageMouseDown(e:MouseEvent):void {
			if (!_autoRemove) return;
			if ($displayEffectIsRendering) { this.remove(); return; }
			if (!_itemIsPressed && !spas_internal::uioSprite.hitTestPoint($stage.mouseX, $stage.mouseY, true))
				this.remove();
		}
		
		/**
		 *  @private
		 */
		private function updateItemsProp(prop:String, value:Number):void {
			var it:Iterator = $objList.iterator;
			var si:SelectableItem;
			var next:ListItem;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				if(next.item is SelectableItem) {
					si = next.item;
					si[prop] = value;
				}
			}
			it.reset();
		}
		
		private function createItem(value:*, data:* = null, index:int = -1):ListItem {
			var lab:String;
			var tpe:String;
			var __id:String = null;
			var cName:String = null;
			var li:ListItem;
			var isNotStringObj:Boolean = true;
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					tpe = "";
					lab = value;
					isNotStringObj = false;
					break;
				case PrimitiveType.OBJECT :
					tpe = value.type != null ? value.type : "";
					cName = value.className != null ? value.className : null;
					__id = (value.id != null && value.id != undefined) ? value.id : null;
					lab = value.label;
					break;
			}
			if (tpe == MenuItemType.SEPARATOR) {
				var sep:Separator = new Separator();
				sep.lockLaf(lookAndFeel.getSeparatorLaf(), true);
				sep.orientation = ScrollableOrientation.HORIZONTAL;
				sep.margin = 4;
				sep.fixToParentWidth = true;
				if (__id != null) sep.id = __id;
				if (cName != null) sep.className = cName;
				index == -1 ? 	spas_internal::itemContainer.addElement(sep) :
								spas_internal::itemContainer.addElementAt(sep, index);
				li = new ListItem(sep, $objList, null, null, index);
			} else if (tpe == MenuItemType.RADIO || tpe == MenuItemType.CHECK || tpe == MenuItemType.DEFAULT ) {
				if(isNotStringObj) {
					var act:Boolean = value.active != null ? value.active : true;
					var tog:Boolean = value.toggled != null ? value.toggled : false;
					var grpName:String = value.groupName != null ? value.groupName : null;
					var icn:String = value.icon != null ? value.icon : null;
				} else {
					act = true;
					tog = false;
				}
				var si:SelectableItem = new SelectableItem(lab);
				si.spas_internal::bindedObj = this;
				si.spas_internal::setSelector(Selectors.MENU_ITEM);
				fixItemLaf(si);
				si.fixToParentWidth = true;
				si.height = _itemHeight;
				si.paddingRight = _itemRightPadding;
				si.paddingLeft = _itemLeftPadding;
				si.spas_internal::setType(tpe);
				si.active = act;
				si.data = data;
				addAvents(si);
				var ic:Icon = new Icon();
				ic.name = MenuIconName.ICON_LEFT;
				ic.target = si.container;
				if (icn != null) {
					ic.clear();
					ic.addIcon(icn);
				} else {
					var brushRect:Rectangle = new Rectangle(0, 0, _itemHeight, _itemLeftPadding);
					var b:StateBrush;
					var dto:LafDTO = ic.spas_internal::lafDTO;
					switch(tpe) {
						case MenuItemType.CHECK :
							b = ic.setBrush(lookAndFeel.getCheckIconBrush(), brushRect, dto) as StateBrush;
							break;
						case MenuItemType.RADIO :
							b = ic.setBrush(lookAndFeel.getRadioIconBrush(), brushRect, dto) as StateBrush;
							break;
						default :
							break;
					}
					if (b != null) b.colors = si.iconColors;
				}
				si.spas_internal::iconsStack.push(ic);
				if (grpName != null) {
					if (_buttonGroups[grpName] == null) _buttonGroups[grpName] = new ButtonsGroup();
					si.group = _buttonGroups[grpName];
				}
				if (tog && icn == null) ic.paint();
				_rightIconList[si] = ic;
				ic.display();
				ic.spas_internal::setDepth(si.container.numChildren-2);
				index == -1 ? 	spas_internal::itemContainer.addElement(si) :
								spas_internal::itemContainer.addElementAt(si, index);
				li = new ListItem(si, $objList, value, data, index);
				if (__id != null) si.id = __id;
				if (cName != null) si.className = cName;
			}
			if(_lockMenu) return li;
			updateItemList();
			setRefresh();
			return li;
		}
	}
}