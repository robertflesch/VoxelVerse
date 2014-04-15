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
	// ButtonsGroup.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0, 23/02/2010 15:10
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.databinding.DataProviderObject;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.SpasEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.util.ArrayList;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a new value is set to the <code>data</code> property of
	 * 	this <code>ButtonsGroup</code>.
	 * 
	 * 	<p>The <code>dataChanged</code> event is not dispatched until after the
	 * 	property changes.</p>
	 *
	 *  @eventType org.flashapi.swing.event.SpasEvent.DATA_CHANGED
	 */
	[Event(name = "dataChanged", type = "org.flashapi.swing.event.SpasEvent")]
	
	/**
	 *  Dispatched when a new <code>DataProvider</code> object is set to the to
	 * 	the <code>dataProvider</code> property of this <code>ButtonsGroup</code>.
	 * 
	 * 	<p>The <code>dataProviderChanged</code> event is not dispatched until 
	 * 	after the property changes.</p>
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.DATA_PROVIDER_CHANGED
	 */
	[Event(name = "dataProviderChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 * 	The <code>ButtonsGroup</code> class is the abstract class for all objects
	 * 	that are used to manage a group of related buttons. Contrary to button bars,
	 * 	button groups do not internally define the target container used to hold
	 * 	the group of buttons.
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonsGroup extends ArrayList {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Constructor. creates a new <code>ButtonsGroup</code> instance.
		 * 	
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 */
		public function ButtonsGroup(target:UIContainer = null) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoDisplay</code> property.
		 * 
		 * 	@see #autoDisplay
		 */
		protected var $autoDisplay:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether a button added to this
		 * 	<code>ButtonsGroup</code> is automatically displayed on the target
		 * 	container (<code>true</code>), or not (<code>false</code>).
		 * 	
		 * 	<p>Nothing will happen if <code>true</code> and <code>target</code> 
		 * 	property is <code>null</code>.</p>
		 * 
		 * 	@see #target
		 * 
		 * 	@default true
		 */
		public function get autoDisplay():Boolean {
			return $autoDisplay;
		}
		public function set autoDisplay(value:Boolean):void {
			$autoDisplay = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>data</code> property.
		 * 
		 * 	@see #data
		 */
		protected var $data:*;
		/**
		 *  The <code>data</code> property lets you pass a value to the
		 * 	<code>ButtonsGroup</code> object.
		 * 
		 * 	@default null
		 */
		public function get data():* {
			return $data;
		}
		public function set data(value:*):void {
			$data = value;
			this.dispatchEvent(new SpasEvent(SpasEvent.DATA_CHANGED));
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>index</code> property.
		 * 
		 * 	@see #index
		 */
		protected var $index:int = -1;
		/**
		 * 	@inheritDoc
		 */
		public function get index():int {
			return $index;
		}
		
		private var _listItem:ListItem;
		/**
		 * 	Returns a reference to the <code>ListItem</code> object associated
		 * 	with this <code>ButtonsGroup</code> object.
		 * 
		 * 	@default null
		 */
		public function get listItem():ListItem {
			return _listItem;
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
		 * 	Sets or gets the URI path for the <code>ALM</code> object.
		 * 
		 *	@see #dataProvider
		 *	@see org.flashapi.swing.databinding.DataProvider
		 * 
		 * 	@default ""
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
		 * 	Stores the internal value for the <code>dataProvider</code> property.
		 * 
		 * 	@see #dataProvider
		 */
		protected var $dataProvider:DataProviderObject = null;
		/**
		 * 	Sets or gets the <code>DataProvider</code> object for this <code>ButtonsGroup</code>
		 * 	object.
		 * 
		 *  @default null
		 */
		public function get dataProvider():DataProviderObject {
			return $dataProvider;
		}
		public function set dataProvider(value:DataProviderObject):void {
			$dataProvider = value;
			this.dispatchEvent(new ListEvent(ListEvent.DATA_PROVIDER_CHANGED));
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>name</code> property.
		 * 
		 * 	@see #name
		 */
		protected var $name:String;
		/**
		 * 	Indicates the instance name of the <code>ButtonsGroup</code> object.
		 */
		public function get name():String {
			return $name;
		}
		public function set name(value:String):void {
			$name = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selectedItem</code> property.
		 * 
		 * 	@see #selectedItem
		 */
		protected var $selectedItem:ABM;
		/**
		 * 	Returns the <code>ABM</code> instance that is the currently selected item
		 * 	in the <code>ButtonsGroup</code>, or <code>null</code> if there is no 
		 * 	currently selected item.
		 * 
		 * 	@default null
		 */
		public function get selectedItem():ABM {
			return $selectedItem;
		}
		/**
		* @private
		*/
		spas_internal function setSelectedItem(value:ABM):void {
			$selectedItem = value;
		}
		
		/**
		 *  @private
		 */
		spas_internal var elementType:String = null;
		/**
		 * 	Returns the type of the calling form element for this <code>ButtonGroup</code> 
		 * 	object when it is used as a <code>Form</code> element.
		 * 
		 * 	<p>Possible values are the <code>FormItemType</code> class constants.</p>
		 * 
		 *  @default null
		 * 
		 * 	@see org.flashapi.swing.Form
		 * 	@see org.flashapi.swing.constants.FormItemType
		 */
		public function get type():String {
			return spas_internal::elementType;
		}
		/**
		* @private
		*/
		spas_internal function setType(value:String):void {
			spas_internal::elementType = value;
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
		 * 	Sets or gets the currently defined value in the <code>ButtonGroup</code>
		 * 	object. Returns <code>null</code> if there is no currently defined value.
		 * 
		 * 	@default null
		 */
		public function get value():* {
			return $value;
		}
		public function set value(value:*):void {
			$value = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>toggleMode</code> property.
		 * 
		 * 	@see #toggleMode
		 */
		protected var $toggleMode:Boolean = false;
		/**
		 * 	Indicates whether the <code>ButtonGroup</code> object is a group of
		 * 	buttons that maintain their selected state (<code>true</code>), or
		 * 	not (<code>false</code>).
		 * 
		 * 	<p>Only one button in the <code>ButtonGroup</code> object can be
		 * 	"selected". This means that when a user selects a button, it remains
		 * 	 selected until a different button is selected.</p>
		 * 
		 * 	@default false
		 */
		public function get toggleMode():Boolean {
			return $toggleMode;
		}
		public function set toggleMode(value:Boolean):void { 
			$toggleMode = value;
			if($selectedItem != null) $selectedItem.selected = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>target</code> property.
		 * 
		 * 	@see #target
		 */
		protected var $target:UIContainer = null;
		/**
		 * 	Sets or gets the target <code>UIContainer</code> where all buttons in this
		 * 	group should be displayed.
		 * 
		 * 	@default null
		 * 
		 * 	@see #autoDisplay
		 */
		public function get target():UIContainer {
			return $target;
		}
		public function set target(value:*):void {
			$target = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Resets the <code>ButtonGroup</code> object.
		 */
		public function reset():void {
			if ($selectedItem != null) $selectedItem.selected = false;
			$index = -1;
			$value = null;
			_listItem = null;
			$data = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference of the previous selected button object.
		 */
		protected var $previousSelectedItem:ABM;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		* @private
		*/
		spas_internal function setSelectedIndex(value:ABM):void {
			$index = this.indexOf(value);
		}
		
		/**
		 * @private
		 */
		protected function dataProviderChangedHandler(e:ListEvent):void {}
		
		/**
		 * @private
		 */
		protected function setDataProviderCommonProperties(button:GroupButtonBase, obj:Object):void {
			button.group = this;
			applyProp(button, obj, "name");
			//if(obj.name != null) button.name = obj.name;
			applyProp(button, obj, "id");
			//if(obj.id != null) button.id = obj.id;
			applyProp(button, obj, "className");
			//if(obj.className != null) button.className = obj.className;
			button.data = obj.data;
			var dp:DataProviderObject = $dataProvider as DataProviderObject;
			dp.applyCommonProperties(button);
			if ($autoDisplay || $target == null) $target.addElement(button);
			applyProp(button, obj, "alt");
			applyProp(button, obj, "margin");
			applyProp(button, obj, "marginLeft");
			applyProp(button, obj, "marginTop");
			applyProp(button, obj, "marginRight");
			applyProp(button, obj, "marginBottom");
			dp = null;
			button.spas_internal::setIndex(this.indexOf(button));
			$evtColl.addEvent(button, UIMouseEvent.PRESS, unselectItem);
			$evtColl.addEvent(button, UIMouseEvent.CLICK, checkToggleMode);
		}
		
		/**
		 * @private
		 */
		protected function applyProp(btn:GroupButtonBase, obj:Object, prop:String):void {
			if(obj[prop] != null) btn[prop] = obj[prop];
		}
		
		/**
		 * @private
		 */
		protected  function checkToggleMode(e:UIMouseEvent):void {
			if (!$toggleMode) return;
			var btn:ABM = e.target as ABM;
			if ($previousSelectedItem != null) {
				if ($previousSelectedItem == btn) {
					btn.selected = false;
					$selectedItem = null; 
				} else btn.selected = true;
			} else btn.selected = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:UIContainer):void {
			$target = target;
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
		}
		
		private function unselectItem(e:UIMouseEvent):void {
			if (!$toggleMode) return;
			if ($selectedItem != null) {
				$previousSelectedItem = $selectedItem;
				$selectedItem.selected = false;
			} else $previousSelectedItem = null;
		}
	}
}