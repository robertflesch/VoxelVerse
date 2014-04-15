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

package org.flashapi.swing.button.core {
	
	// -----------------------------------------------------------
	// AbstractButtonBar.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0, 23/02/2010 15:10
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.ButtonBarOrientation;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.list.ButtonList;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.util.BooleanUtil;
	import org.flashapi.swing.util.Iterator;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an item is clicked within the <code>ButtonBar</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name = "itemClicked", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>ButtonBar</code> instance has finished using
	 * 	data provided by the <code>DataProvider</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the <code>ButtonBar</code> instance has finished using
	 * 	data provided by the <code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 * 	The <code>AbstractButtonBar</code> class is the base class for all SPAS 3.0
	 * 	button bars.
	 * 
	 * 	<p>Button bars tipically define a horizontal or vertical row of related buttons
	 * 	with a common appearance.</p>
	 * 
	 * 	<p>The following properties can be defined by <code>DataProvider</code> or 
	 * 	<code>XMLQuery</code> items:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>item</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>label</code></td>
	 * 			<td>Sets the <code>label</code> property of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>width</code></td>
	 * 			<td>Sets the <code>width</code> property of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>height</code></td>
	 * 			<td>Sets the <code>height</code> property of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>alt</code></td>
	 * 			<td>Sets the <code>alt</code> property of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>icon</code></td>
	 * 			<td>Sets the icon element of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>brush</code></td>
	 * 			<td>Sets the icon <code>StateBrush</code> object of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>active</code></td>
	 * 			<td>Sets the <code>active</code> property of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>selected</code></td>
	 * 			<td>Sets the <code>selected</code> property of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>className</code></td>
	 * 			<td>Sets the CSS class name of the button.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>id</code></td>
	 * 			<td>Sets the CSS Unique Identifier of the button.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * <p><strong><code>AbstractButtonBar</code> instances support the following CSS properties:</strong></p>
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
	 * 		<tr>
	 * 			<td><code class="css">orientation</code></td>
	 * 			<td>Sets the object orientation.</td>
	 * 			<td>Valid values are <code class="css">horizontal</code> and
	 * 			<code class="css">vertical</code></td>
	 * 			<td><code>orientation</code></td>
	 * 			<td>Properties.ORIENTATION</td>
	 * 		</tr>
	 * 	</table> 
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.list.ALM#xmlQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractButtonBar extends ButtonList implements Listable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractButtonBar</code> instance.
		 * 
		 * 	@param	orientation	The button bar orientation. Possible values are 
		 * 						<code>ButtonBarOrientation.HORIZONTAL</code> or
		 * 						<code>ButtonBarOrientation.VERTICAL</code>.
		 * 						Default Value is <code>ButtonBarOrientation.HORIZONTAL</code>.
		 * 	@param	width	The button bar width, in pixels. Default Value is
		 * 					<code>100</code> px.
		 */
		public function AbstractButtonBar(orientation:String = "horizontal", width:Number = 100) {
			super();
			initObj(orientation, width);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>gap</code> property.
		 * 
		 * 	@see #gap
		 */
		protected var $gap:Number = 0;
		/**
		 *  Sets or gets the <code>gap</code> property for the <code>ButtonBar</code>
		 * 	instance. It defines the offset between each button displayed within the
		 * 	<code>ButtonBar</code>.
		 * 
		 * 	@default 0
		 */
		public function get gap():Number {
			return $gap;
		}
		public function set gap(value:Number):void { 
			$gap = value;
			switch($orientation) {
				case ButtonBarOrientation.HORIZONTAL :
					$itemContainer.horizontalGap = value;
					break;
				case ButtonBarOrientation.VERTICAL :
					$itemContainer.verticalGap = value;
					break;
			}
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>orientation</code> property.
		 * 
		 * 	@see #orientation
		 */
		protected var $orientation:String;
		/**
		 * 	Sets or gets the orientation of the <code>ButtonBar</code> instance.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>ButtonBarOrientation.HORIZONTAL</code></li>
		 * 		<li><code>ButtonBarOrientation.VERTICAL</code></li>
		 * 	</ul>
		 * 
		 * 	@default ButtonBarOrientation.HORIZONTAL
		 * 
		 * 	@see org.flashapi.swing.constants.ButtonBarOrientation
		 */
		public function get orientation():String {
			return $orientation;
		}
		public function set orientation(value:String):void {
			setOrientation(value);
			updateItemList();
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			//if(_orientation == ButtonBarOrientation.VERTICAL) {
				var r:Rectangle = $itemContainer.getBounds(null);
				$height = r.height;
			//}
			return $height;
		}
		
		/**
		 * 	@private
		 */
		override public function get width():Number {
			//if(_orientation == ButtonBarOrientation.HORIZONTAL) {
				var r:Rectangle = $itemContainer.getBounds(null);
				$width = r.width;
			//}
			return $width;
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
			var btn:ABM;
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					btn = new $buttonClass();
					btn.label = value;
					break;
				case PrimitiveType.OBJECT :
					btn = new $buttonClass();
					btn.label = (value.label != null) ? value.label : "";
					if (value.width != null) btn.width = value.width;
					if (value.height != null) btn.height = value.height;
					if (value.alt != null) btn.alt = value.alt;
					if (value.icon != null) btn.setIcon(value.icon);
					if (value.brush != null) btn.drawIcon(value.brush);
					if (value.active != null) btn.active = BooleanUtil.decode(value.active);
					if (value.selected != null) btn.selected = BooleanUtil.decode(value.selected);
					if (value.className != null && value.className != undefined)
					btn.className = value.className;
					if(value.id != null && value.id != undefined) btn.id = value.id;
					break;
			}
			btn.spas_internal::setSelector($buttonSelector);
			addEvents(btn);
			btn.lockLaf(lookAndFeel.getButtonLaf(), true);
			$itemContainer.addElement(btn);
			var li:ListItem = new ListItem(btn, $objList, btn.label, data);
			if (!$invalidateListUpdate) setRefresh();
			if (btn.selected && $toggleMode) {
				$listItem = li;
				$value = li.value;
				//this.spas_internal::setIndex(btn.index);
				$data = $listItem.data;
			}
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			var btn:ABM = new $buttonClass(value);
			btn.lockLaf(lookAndFeel.getButtonLaf(), true);
			addEvents(btn);
			$itemContainer.addElementAt(btn, index);
			var li:ListItem = new ListItem(btn, $objList, value, data, index);
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			if($displayed) {
				$itemContainer.remove();
				unload();
				if($listEvtColl != null) $listEvtColl.removeAllEvents();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			var li:ListItem = $objList.get(index) as ListItem;
			var btn:ABM = li.item as ABM;
			btn.invalidateMetricsChanges = btn.invalidateRefresh = true;
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					btn.label = value;
					li.spas_internal::setValue(value);
					break;
				case PrimitiveType.OBJECT :
					btn.label = value.label != null ? 
						value.label : "", li.spas_internal::setValue(btn.label);
					if (value.width != null) btn.width = value.width;
					if (value.height != null) btn.height = value.height;
					if (value.alt != null) btn.alt = value.alt;
					if (value.icon != null) btn.setIcon(value.icon);
					if (value.brush != null) btn.drawIcon(value.brush);
					btn.active = value.active != null ? value.active : true;
					btn.selected = value.selected != null ? value.selected : false;
					if (value.className != null && value.className != undefined)
						btn.className = value.className;
					if(value.id != null && value.id != undefined) btn.id = value.id;
					break;
			}
			btn.invalidateMetricsChanges = btn.invalidateRefresh = false;
			if ($dataBindingMode != DataBindingMode.MERGE) li.data = data;
			else {
				if (data != null) li.data = data;
			}
			if (!$invalidateListUpdate) setRefresh();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$itemContainer.finalizeElements();
			$itemContainer.finalize();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A reference to the class that defines buttons common appareances and
		 * 	behaviors.
		 */
		protected var $buttonClass:Class;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>Canvas</code> instance that is used to
		 * 	hold all buttons.
		 */
		protected var $itemContainer:Canvas;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the list
		 * 	is currently not available for updates (<code>true</code>), or not
		 * 	(<code>false</code>).
		 */
		protected var $invalidateListUpdate:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the buttons common CSS selector properties.
		 */
		protected var $buttonSelector:String;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function fixButtonWidth(btn:ABM):void {
			if ($orientation == ButtonBarOrientation.VERTICAL && btn.width != $width)
				btn.width = $width;
			else btn.redraw(); //--> Redraws the button to ensure that changes like label properties are displayed.
		}
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			$itemContainer.display();
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			updateItemList();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var it:Iterator = $objList.iterator;
			it.reset();
			while (it.hasNext()) {
				var btn:ABM = it.next().item;
				btn.lockLaf(lookAndFeel.getButtonLaf(), true);
			}
			it.reset();
		}
		
		/**
		 *  @private
		 */
		override protected function changeCurrentIndex():void {
			if ($objList.size < 1) return;
			var btn:ABM;
			if ($listItem != null && $toggleMode) {
				btn = $listItem.item as ABM;
				btn.selected = false;
			}
			if ($selectedIndex == -1) {
				$value = "";
				$data = null;
			} else {
				$listItem = $objList.get($selectedIndex) as ListItem;
				btn = $listItem.item as ABM;
				if($toggleMode) btn.selected = true;
				$value = btn.label;
				$data = $listItem.data;
			}
			this.spas_internal::setIndex($selectedIndex);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(orientation:String, width:Number):void {
			$finalizeItems = false;
			$width = width;
			initMinSize(0, 0);
			$itemContainer = new Canvas();
			//$itemContainer.autoAdjustSize = false;
			$itemContainer.autoSize = true;
			setOrientation(orientation);
			$itemContainer.target = spas_internal::uioSprite;
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
		}
		
		private function addEvents(btn:ABM):void {
			$listEvtColl.addEvent(btn, UIMouseEvent.PRESS, pressHandler);
			$listEvtColl.addEvent(btn, UIMouseEvent.RELEASE, releaseHandler);
		}
		
		private function releaseHandler(e:UIMouseEvent):void {
			var btn:* = e.target as $buttonClass;
			$listItem = $dataList[btn];
			$value = btn.label;
			this.spas_internal::setIndex(btn.index);
			$data = $listItem.data;
			if ($toggleMode) btn.selected = true;
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function pressHandler(e:UIMouseEvent):void {
			if ($toggleMode) {
				if ($listItem != null) $listItem.item.selected = false;
			}
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			var it:Iterator = $dataProvider.iterator;
			$invalidateListUpdate = true;
			var i:int = 0;
			var obj:Object;
			while(it.hasNext()) {
				obj = it.next();
				$dataBindingMode == DataBindingMode.INCREMENT ? addItem(obj, obj.data) : updateItemAt(i, obj, obj.data);
				i++;
			}
			it.reset();
			$invalidateListUpdate = false;
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			//checkStrictMode("");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			$invalidateListUpdate = true;
			var i:int = 0;
			var obj:Object;
			for each(var prop:XML in data.item) {
				obj = new Object();
				setXmlProp(obj, prop, "label");
				setXmlProp(obj, prop, "width");
				setXmlProp(obj, prop, "height");
				setXmlProp(obj, prop, "alt");
				setXmlProp(obj, prop, "icon");
				setXmlProp(obj, prop, "brush");
				setXmlProp(obj, prop, "active");
				setXmlProp(obj, prop, "selected");
				setXmlProp(obj, prop, "className");
				setXmlProp(obj, prop, "id");
				var d:* = prop.@data != undefined ? prop.@data.toString() : null;
				$dataBindingMode == DataBindingMode.INCREMENT ? addItem(obj, d) : updateItemAt(i, obj, d);
				i++;
			}
			$invalidateListUpdate = false;
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		private function setXmlProp(obj:Object, item:XML, prop:String):void {
			if (item.@[prop] != undefined) obj[prop] = item.@[prop].toXMLString();
		}
		
		private function setOrientation(value:String):void {
			$orientation = value;
			switch(value) {
				case ButtonBarOrientation.VERTICAL :
					$itemContainer.layout.orientation = LayoutOrientation.VERTICAL;
					break;
				case ButtonBarOrientation.HORIZONTAL :
					$itemContainer.layout.orientation = LayoutOrientation.HORIZONTAL;
					break;
			}
		}
	}
}