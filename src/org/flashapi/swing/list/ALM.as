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
	// ALM.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0, 22/02/2010 21:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.databinding.DataProviderObject;
	import org.flashapi.swing.databinding.XMLQueryObject;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.util.ArrayList;
	import org.flashapi.swing.util.Iterator;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when ALM.dataProvider is set.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.DATA_PROVIDER_CHANGED;
	 */
	[Event(name = "dataProviderChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when ALM.xmlQuery is set.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.XML_QUERY_CHANGED;
	 */
	[Event(name="xmlQueryChanged", type="org.flashapi.swing.event.ListEvent")]
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 *  The <code>ALM</code> class (Abstract List Methods) is the abstract class that
	 * 	defines common methods and properties for all <code>Listable</code> subclasses.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ALM extends UIObject implements Listable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ALM</code> instance.
		 */
		public function ALM() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>listItem</code> property.
		 * 
		 * 	@see #listItem
		 */
		protected var $listItem:ListItem = null;
		/**
		 *  @inheritDoc
		 */
		public function get listItem():ListItem {
			return $listItem;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get length():int {
			return $objList.size;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>multiple</code> property.
		 * 
		 * 	@see #multiple
		 */
		protected var $multiple:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get multiple():Boolean {
			return $multiple;
		}
		public function set multiple(value:Boolean):void {
			$multiple = value;
			if (value && $itemsCollection == null) $itemsCollection = [];
			else if(!value && $itemsCollection != null) $itemsCollection = null;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>itemsCollection</code> property.
		 * 
		 * 	@see #itemsCollection
		 */
		protected var $itemsCollection:Array;
		/**
		 * 	@inheritDoc
		 */
		public function get itemsCollection():Array {
			return $itemsCollection;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>dataBindingMode</code> property.
		 * 
		 * 	@see #dataBindingMode
		 */
		protected var $dataBindingMode:String = DataBindingMode.INCREMENT;
		/**
		 *  @inheritDoc
		 */
		public function get dataBindingMode():String {
			return $dataBindingMode;
		}
		public function set dataBindingMode(value:String):void {
			$dataBindingMode = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>dataProvider</code> property.
		 * 
		 * 	@see #dataProvider
		 */
		protected var $dataProvider:DataProviderObject = null;
		/**
		 * 	@inheritDoc
		 */
		public function get dataProvider():DataProviderObject {
			return $dataProvider;
		}
		public function set dataProvider(value:DataProviderObject):void {
			$dataProvider = value;
			dispatchEvent(new ListEvent(ListEvent.DATA_PROVIDER_CHANGED));
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>xmlQuery</code> property.
		 * 
		 * 	@see #xmlQuery
		 */
		protected var $xmlQuery:XMLQueryObject = null;
		/**
		 * 	@inheritDoc
		 */
		public function get xmlQuery():XMLQueryObject {
			return $xmlQuery;
		}
		public function set xmlQuery(value:XMLQueryObject):void {
			$xmlQuery = value;
			if($xmlQuery.xml != null) dispatchEvent(new ListEvent(ListEvent.XML_QUERY_CHANGED));
			$evtColl.addEvent($xmlQuery, LoaderEvent.XML_COMPLETE, xmlLoadedHandler);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selectedIndex</code> property.
		 * 
		 * 	@see #selectedIndex
		 */
		protected var $selectedIndex:int = -1;
		/**
		 * 	@inheritDoc
		 */
		public function get selectedIndex():int {
			return $selectedIndex;
		}
		public function set selectedIndex(value:int):void {
			$selectedIndex = value;
			changeCurrentIndex();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>urlPath</code> property.
		 * 
		 * 	@see #urlPath
		 */
		protected var $urlPath:String = "";
		/**
		 * 	@inheritDoc
		 */
		public function get urlPath():String {
			return $urlPath;
		}
		public function set urlPath(value:String):void {
			$urlPath = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>value</code> property.
		 * 
		 * 	@see #value
		 */
		protected var $value:*;
		/**
		 * 	@inheritDoc 
		 */
		public function get value():* {
			return $value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>label</code> property.
		 * 
		 * 	@see #label
		 */
		protected var $label:String = null;
		/**
		 * 	@inheritDoc
		 */
		public function get label():String {
			return $label;
		}
		public function set label(value:String):void {
			$label = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>invalidateStrictMode</code> property.
		 * 
		 * 	@see #invalidateStrictMode
		 */
		protected var $invalidateStrictMode:Boolean = false;
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Use this property to prevent strict mode checking when using <code>XMLQueryObjects</code>
		 * 	with encapsulation.
		 * 
		 * 	@default false
		 */
		public function get invalidateStrictMode():Boolean {
			return $invalidateStrictMode;
		}
		public function set invalidateStrictMode(value:Boolean):void {
			$invalidateStrictMode = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			if ($xmlQuery != null) {
				$xmlQuery.finalize();
				$xmlQuery = null;
			}
			var it:Iterator = $objList.iterator;
			var li:ListItem;
			while (it.hasNext()) {
				li = it.next() as ListItem;
				if ($finalizeItems) li.item.finalize();
				li.finalize();
				li = null;
			}
			$objList.finalize();
			$objList = null;
			$dataList = new Dictionary();
			$dataList = null;
			$dataStack = [];
			$dataStack = null;
			$listEvtColl.finalize();
			$listEvtColl = null;
			super.finalize();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getAllProperties(onlyListItems:Boolean = false):Array {
			var a:Array = [];
			var it:Iterator = $objList.iterator;
			while (it.hasNext()) {
				var li:ListItem = it.next() as ListItem;
				if(onlyListItems) a.push(li);
				else {
					var obj:Object = new Object();
					obj.item = li.item;
					obj.index = li.item.index;
					obj.value = li.value;
					obj.data = li.data;
					a.push(obj);
				}
			}
			it.reset();
			return a;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addItem(value:*, data:* = null):ListItem {
			return undefined;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addItemAt(index:int, value:*, data:* = null):ListItem {
			return undefined;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getItemAt(index:int):ListItem {
			return $objList.get(index) as ListItem;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function removeAll():void {
			$objList.clear();
			$listEvtColl.removeAllEvents();
			updateItemList();
			setRefresh();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function removeItem(item:ListItem):void { }
		
		/**
		 * 	@inheritDoc
		 */
		public function removeItemAt(index:int):void {
			$objList.removeAt(index);
			updateItemList();
			setRefresh();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			return undefined;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether <code>UIObjects</code>
		 * 	associated with registred <code>ListItem</code> objects must call the
		 * 	<code>finalize()</code> method and be deleted (<code>true</code>), or not
		 * 	(<code>false</code>).
		 */
		protected var $finalizeItems:Boolean = true;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Represents the stack array where the registred <code>ListItem</code> objects
		 * 	are stored.
		 */
		protected var $objList:ArrayList;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal stack used to store a specific list of object to associate with 
		 * 	the registred <code>ListItem</code> objects within this <code>Listable</code>
		 * 	instance.
		 */
		protected var $dataList:Dictionary = null;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal stack used to store specific data associated with the registred
		 * 	<code>ListItem</code> objects within this <code>Listable</code> instance.
		 */
		protected var $dataStack:Array;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>EventCollector</code> object which is 
		 * 	used to manage events, relating to registred <code>ListItem</code> objects
		 * 	within this <code>Listable</code> instance.
		 */
		protected var $listEvtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function updateItemList():void { }
		
		/**
		 * @private
		 */
		protected function changeCurrentIndex():void { }
		
		/**
		 * @private
		 */
		protected function checkStrictMode(ref:String):void {
			if(!$invalidateStrictMode) $xmlQuery.checkStrictMode(ref);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$objList = new ArrayList();
			$listEvtColl = new EventCollector();
			$dataStack = [];
		}
		
		private function xmlLoadedHandler(e:LoaderEvent):void {
			dispatchEvent(new ListEvent(ListEvent.XML_QUERY_CHANGED));
		}
	}
}