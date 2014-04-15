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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// IconListBox.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/03/2010 14:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.IconizedButton;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.libs.IconListBoxUIUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an item is clicked within the <code>IconListBox</code>
	 * 	instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name = "itemClicked", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when an item is clicked within the <code>IconListBox</code>
	 * 	instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_PRESSED
	 */
	[Event(name = "itemPressed", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>IconListBox</code> instance changes value
	 * 	due to mouse or keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name="listChanged", type="org.flashapi.swing.event.ListEvent")]
	
	/**
	 * 	The <code>IconListBox</code> class displays a list of iconized items. Its
	 * 	functionality is very similar to that of <code>ListBox</code>. The user can
	 * 	select one or more items from the list, depending on the value of the
	 * 	<code>multiple</code> property defined by the <code>Listable</code> interface.
	 * 
	 * 	<p>
	 * 	As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	instance to a <code>IconListBox</code> object.
	 * 	Each item for DataProvider object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>alt:String</code>; the <code>value</code> parameter for the
	 * 			<code>IconListBox.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter for
	 * 			the <code>IconListBox.addItem()</code> method,</li>
	 * 		<li><code>className:String</code>; the <code>className</code> parameter for
	 * 			<code>IconListBox</code> items,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the icon rendered by
	 * 			<code>IconListBox</code> items.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class IconListBox extends ButtonList implements Observer, ItemsList, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>IconListBox</code> instance with the
		 * 	specified width.
		 * 
		 * 	@param	width	The width of this <code>IconListBox</code> instance, in
		 * 					pixels.
		 */
		public function IconListBox(width:Number = 150) {
			super();
			initObj(width);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Only returns the selected <code>value</code> property for this <code>IconListBox</code>
		 * 	instance.
		 */
		public function get setSelected():String {
			return $value;
		}
		public function set setSelected(value:String):void {
			/*var it:Iterator = objList.iterator;
			var ib:SelectableItem;
			var li:Object;
			while(it.hasNext()) { 
				li = it.next();
				ib = li.item;
				if(ib.alt == value) {
					_listItem = li as ListItem, _value = value, _data = li.data;
					displaySelectedItem(ib);
				} else ib.selected = false;
			}
			it.reset();*/
		}
		
		private var _size:uint;
		/**
		 * 	@inheritDoc
		 */
		public function get size():uint {
			return _size;
		}
		public function set size(value:uint):void {	}
		
		/**
		 * 	@inheritDoc
		 */
		public function get invalidateListUpdate():Boolean {
			return _invalidateListUpdate;
		}
		public function set invalidateListUpdate(value:Boolean):void {
			_invalidateListUpdate = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get backgroundAlpha():Number {
			return _box.backgroundAlpha;
		}
		override public function set backgroundAlpha(value:Number):void {
			_box.backgroundAlpha = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get backgroundColor():* {
			return _box.backgroundColor;
		}
		override public function set backgroundColor(value:*):void {
			_box.backgroundColor = value;
		}
		
		/**
		 * 	@private
		 */
		/*override public function set height(value:Number):void {
			super.height = _box.height = value;
		}*/
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			return _box.height;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get width():Number {
			return _box.width;
		}
		override public function set width(value:Number):void {
			_box.width = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Border API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@inheritDoc
		 */
		public function get backgroundContainer():Sprite {
			return _box.backgroundContainer;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundWidth():Number {
			return _box.backgroundWidth;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundHeight():Number {
			return _box.backgroundHeight;
		}
		
		/**
		 *	@inheritDoc
		 */
		public function get bordersContainer():Sprite {
			return _box.bordersContainer;
		}
		
		/**
		 *	@private
		 */
		override public function get borderAlpha():Number {
			return _box.borderAlpha;
		}
		override public function set borderAlpha(value:Number):void {
			_box.borderAlpha = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		public function get borderStyle():String {
			return _box.borderStyle;
		}
		public function set borderStyle(value:String):void {
			_box.borderStyle = value;
		}
		
		/**
		 *	@private
		 */
		override public function get borderWidth():Number {
			return _box.borderWidth;
		}
		override public function set borderWidth(value:Number):void {
			_box.borderWidth = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get topLeftCorner():Number {
			return _box.topLeftCorner;
		}
		override public function set topLeftCorner(value:Number):void {
			_box.topLeftCorner = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get topRightCorner():Number {
			return _box.topRightCorner;
		}
		override public function set topRightCorner(value:Number):void {
			_box.topRightCorner = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get bottomRightCorner():Number {
			return _box.bottomRightCorner;
		}
		override public function set bottomRightCorner(value:Number):void {
			_box.bottomRightCorner = value;
		}
		
		/**
		 *	@inheritDoc
		 */
		override public function get bottomLeftCorner():Number {
			return _box.bottomLeftCorner;
		}
		override public function set bottomLeftCorner(value:Number):void {
			_box.bottomLeftCorner = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderTopColor():* {
			return _box.borderTopColor;
		}
		public function set borderTopColor(value:*):void {
			_box.borderTopColor = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderRightColor():* {
			return _box.borderRightColor;
		}
		public function set borderRightColor(value:*):void {
			_box.borderRightColor = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomColor():* {
			return _box.borderBottomColor;
		}
		public function set borderBottomColor(value:*):void {
			_box.borderBottomColor = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftColor():* {
			return _box.borderLeftColor;
		}
		public function set borderLeftColor(value:*):void {
			_box.borderLeftColor = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowColor():* {
			return _box.borderShadowColor;
		}
		public function set borderShadowColor(value:*):void {
			_box.borderShadowColor = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightColor():* {
			return _box.borderHighlightColor;
		}
		public function set borderHighlightColor(value:*):void {
			_box.borderHighlightColor = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderTopOpacity():Number {
			return _box.borderTopOpacity;
		}
		public function set borderTopOpacity(value:Number):void {
			_box.borderTopOpacity = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderRightOpacity():Number {
			return _box.borderRightOpacity;
		}
		public function set borderRightOpacity(value:Number):void {
			_box.borderRightOpacity = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomOpacity():Number {
			return _box.borderBottomOpacity;
		}
		public function set borderBottomOpacity(value:Number):void {
			_box.borderBottomOpacity = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftOpacity():Number {
			return _box.borderLeftOpacity;
		}
		public function set borderLeftOpacity(value:Number):void {
			_box.borderLeftOpacity = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowOpacity():Number {
			return _box.borderShadowOpacity;
		}
		public function set borderShadowOpacity(value:Number):void {
			_box.borderShadowOpacity = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightOpacity():Number {
			return _box.borderHighlightOpacity;
		}
		public function set borderHighlightOpacity(value:Number):void {
			_box.borderHighlightOpacity = value;
		}
		
		/**
		 *  @private
		 */
		override public function get texture():* {
			return _box.texture;
		}
		override public function set texture(value:*):void {
			_box.texture = value;
		}
		
		/**
		 *  @private
		 */
		override public function get gradientProperties():Object {
			return _box.gradientProperties;
		}
		override public function set gradientProperties(value:Object):void {
			_box.gradientProperties = value;
		}
		
		/**
		 *  @private
		 */
		override public function get textureManager():TextureManager {
			return _box.textureManager;
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
			var ib:IconizedButton = new IconizedButton(null, 22, 22);
			ib.lockLaf(lookAndFeel.getButtonLaf(), true);
			ib.target = $content;
			updateItem(ib, value);
			//ib.spas_internal::setSelector($buttonSelector);
			var li:ListItem = new ListItem(ib, $objList, ib.alt, data);
			addHandlers(ib);
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
			var ib:IconizedButton = new IconizedButton(null, 20, 20);
			ib.lockLaf(lookAndFeel.getButtonLaf(), true);
			addHandlers(ib);
			ib.target = $content;
			updateItem(ib, value);
			var li:ListItem = new ListItem(ib, $objList, ib.alt, data, index);
			if (!_invalidateListUpdate) {
				updateItemList();
				setRefresh();
			}
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function removeAll():void {
			super.removeAll();
			$listEvtColl.removeAllEvents();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			var ib:IconizedButton = item.item;
			removeHandlers(ib);
			if(ib.displayed) ib.remove();
			//var id:int = $dataStack.splice($dataStack.indexOf(ib), 1);
			$objList.remove(item);
			var l:int = $dataStack.length;
			if (multiple && l>0) {
				$listItem = $dataList[$dataStack[l-1]];
				$value = $dataList[$dataStack[l-1]].alt;
				$data = $dataList[$dataStack[l-1]].data;
			} else {
				$listItem = null;
				$value = $data = null;
			}
			updateItemList();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItemAt(index:int):void {
			var ib:IconizedButton = $objList.get(index).item;
			removeHandlers(ib);
			super.removeItemAt(index);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function reset():void {
			if($listItem != null) {
				$listItem.item.selected = $listItem.item.dotted = false;
				$listItem = null;
			}
			$value = "";
			$data = null;
		}
		
		/**
		 * 	@private
		 */
		override public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			var li:ListItem = $objList.get(index) as ListItem;
			var ib:IconizedButton = li.item as IconizedButton;
			ib.invalidateMetricsChanges = ib.invalidateRefresh = true;
			updateItem(ib, value);
			li.spas_internal::setValue(ib.alt);
			ib.invalidateMetricsChanges = ib.invalidateRefresh = false;
			if ($dataBindingMode != DataBindingMode.MERGE) li.data = data;
			else { if (data != null) li.data = data; }
			if (!_invalidateListUpdate) {
				updateItemList();
				setRefresh();
			}
			return li;
		}
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return _box.getBounds(targetCoordinateSpace);
		}
		
		/**
		 * @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return _box.getRect(targetCoordinateSpace);
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			//_box.finalize();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			_box.display();
			updateItemList();
			refresh();
		}
		
		/**
		 * @private
		 */
		override protected function updateItemList():void {
			$dataList = new Dictionary();
			var it:Iterator = $objList.iterator;
			_box.invalidateLayout = true;
			_box.removeElements();
			var i:uint = 0;
			var _listHeight:Number = 0;
			var ib:IconizedButton;
			while(it.hasNext()) {
				var next:ListItem = it.next() as ListItem;
				ib = next.item;
				//ib.width = scrollableArea.isVScrollBarActive ? _width - scrollableArea.spas_internal::VScrollBar.width : _width;
				$dataList[ib] = next;
				ib.spas_internal::setIndex(i);
				_box.addElement(ib);
				_listHeight += ib.height;
				i++;
			}
			it.reset();
			_box.invalidateLayout = false;
		}
		
		/**
		 * @private
		 */
		protected function redrawItemRenderers():void {
			/*var it:Iterator = objList.iterator;
			var ib:IconizedButton;
			while(it.hasNext()) {
				ib = it.next().item; 
				ib.width = scrollableArea.isVScrollBarActive ? _width - scrollableArea.spas_internal::VScrollBar.width : _width;
				ib.height = _lineHeight;
			}
			it.reset();*/
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			fixItemsLaf();
			_box.lockLaf(lookAndFeel.getBoxLaf(), true);
		}
		
		/**
		 *  @private
		 */
		override protected function changeCurrentIndex():void {
			if ($listItem) $listItem.item.selected = false;
			$listItem = $objList.get($selectedIndex) as ListItem;
			$value = $listItem.value;
			$data = $listItem.data;
			displaySelectedItem($listItem.item as IconizedButton);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _box:Box;
		private var _invalidateListUpdate:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number):void {
			$width = width;
			_invalidateListUpdate = false;
			createContainers();
			initLaf(IconListBoxUIUIRef);
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			spas_internal::setSelector("iconlistbox");
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			_box = new Box();
			_box.target = container;
			_box.autoHeight = true;
		}
		
		private function removeHandlers(ib:IconizedButton):void {
			$listEvtColl.removeEvent(ib, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.removeEvent(ib, UIMouseEvent.RELEASE, releaseHandler);
		}
		
		private function addHandlers(ib:IconizedButton):void {
			$listEvtColl.addEvent(ib, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.addEvent(ib, UIMouseEvent.RELEASE, releaseHandler);
		}
		
		private function pressHandler(e:UIMouseEvent):void {
			var ib:IconizedButton = e.target as IconizedButton;
			displaySelectedItem(ib);
			dispatchEvent(new ListEvent(ListEvent.ITEM_PRESSED));
		}
		
		private function displaySelectedItem(selectedItem:IconizedButton):void {
			if($dataStack[0]) $dataStack[0].selected = $dataStack[0].dotted = false;
			$dataStack = [];
			if(!selectedItem.selected) $dataStack.push(selectedItem);
			//selectedItem.dotted = !selectedItem.dotted;
			selectedItem.selected = !selectedItem.selected;
		}
		
		private function releaseHandler(e:UIMouseEvent):void {
			//var selectedItem:IconizedButton = e.target as IconizedButton;
			var l:int = $dataStack.length;
			if(l>0) {
				var ib:IconizedButton = $dataStack[l-1];
				$listItem = $dataList[ib];
				$value = $dataList[ib].value;
				$data = $dataList[ib].data;
				spas_internal::setIndex($dataList[ib].index);
			} else {
				$listItem = null;
				$value = $data = null;
				spas_internal::setIndex( -1);
			}
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			var it:Iterator = $dataProvider.iterator;
			it.reset();
			_invalidateListUpdate = true;
			var i:int = 0;
			var obj:Object;
			while(it.hasNext()) {
				obj = it.next();
				$dataBindingMode == DataBindingMode.INCREMENT ?
					addItem(obj, obj.data) : updateItemAt(i, obj, obj.data);
				i++;
			}
			it.reset();
			updateItemList();
			setRefresh();
			_invalidateListUpdate = false;
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			checkStrictMode("IconListBox");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			invalidateListUpdate = true;
			var i:int = 0;
			for each(var prop:XML in data.item) {
				var obj:Object = new Object();
				//setXmlProp(obj, prop, "width");
				setXmlProp(obj, prop, "height");
				setXmlProp(obj, prop, "alt");
				setXmlProp(obj, prop, "icon");
				setXmlProp(obj, prop, "brush");
				setXmlProp(obj, prop, "active");
				setXmlProp(obj, prop, "selected");
				setXmlProp(obj, prop, "className");
				setXmlProp(obj, prop, "id");
				var d:* = prop.@data != undefined ? prop.@data.toString() : null;
				$dataBindingMode ==
					DataBindingMode.INCREMENT ? addItem(obj, d) : updateItemAt(i, obj, d);
				i++;
			}
			updateItemList();
			setRefresh();
			_invalidateListUpdate = false;
			
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		private function setXmlProp(obj:Object, item:XML, prop:String):void {
			if (item.@[prop] != undefined) obj[prop] = item.@[prop].toXMLString();
		}
		
		private function fixItemsLaf():void {
			var it:Iterator = $objList.iterator;
			var next:ListItem;
			while (it.hasNext()) {
				next = it.next() as ListItem;
				next.item.lockLaf(lookAndFeel.getButtonLaf(), true);
			}
			it.reset();
		}
		
		private function updateItem(ib:IconizedButton, value:*):void {
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					ib.alt = value;
					break;
				case PrimitiveType.OBJECT :
					if (value.alt != null) ib.alt = value.alt;
					//ib.height = value.height != null ? value.height : _lineHeight;
					if (value.icon != null) ib.setIcon(value.icon);
					if (value.brush != null) ib.drawIcon(value.brush);
					ib.active = value.active != null ? value.active : true;
					ib.selected = value.selected != null ? value.selected : false;
					if (value.className != null && value.className != undefined)
						ib.className = value.className;
					if(value.id != null && value.id != undefined) ib.id = value.id;
					break;
			}
		}
	}
}