/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2008 DevelopmentArc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 * ***** END MIT LICENSE BLOCK ***** */
package com.developmentarc.core.controllers
{
	import com.developmentarc.core.controllers.interfaces.ISelectable;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * Class defines a group of seletable items allowing the items to work as one entity. Upon selection of one of the items, each otheritem in the group is deselected.  
	 * The goal of SelectionGroup is to provide developers with an alternative to the low-level direct access to the SelectionController provides.  
	 * One advantage to using SelectionGroup is the ability to define groups and items via MXML, which SelectionController can not do.  <br />
	 * 
	 * By default SelectionGroup will listent o MouseClick.CLICK events, but this an be overriden by defined a comma seperated list of event types.  
	 * Because SelectionGroup requires listeners when items are added to the group, ISelectable items must extend an EventDispatcher class or implement the IEventDispatcher.  <br />
	 * 
	 */
	public class SelectionGroup
	{
		
		// PUBLIC VARIABLES
		// PROTECTED VARIABLES
		
		// PRIVATE VARIABLES
		private var __groupId:int;
		private var _eventString:String;
		private var _events:Array;
		
		// PRIVATE GET/SET VARIABLES
		
		/**
		 * Constructor.  Automatically generates a unique id for the selection group. 
		 * 
		 */
		public function SelectionGroup()
		{
			// Generate new Id for group
			this.__groupId = SelectionController.generateNewId();
		}
		
		// PUBLIC METHODS
		/**
		 * Method takes an ISelectable item and adds the item to the selection
		 * group.
		 * 
		 * @param item Item to be added to the selection group.
		 */
		public function addItem(item:ISelectable):void {
			SelectionController.addItem(item, this.__groupId);
		}
		
		/**
		 * Used to remove an item from the selection group.
		 *  
		 * @param item The item to remove from the group.
		 * 
		 */
		public function removeItem(item:ISelectable):void {
			SelectionController.removeItem(item);
		}
		// PROTECTED METHODS
		
		// PRIVATE METHODS

		// GET/SET METHODS

		/**
		 * Unique id of the group
		 * 
		 * @return int Unique group id
		 */
		public function get groupId():int {
			return __groupId;
		}
		
		/**
		 * GroupId can not be set by an outside class
		 * 
		 */
		public function set groupId(groupId:int):void {
			throw Error("Read only property");
		}
		
		/**
		 * Returns the comma seperated list of events used by this
		 * group.
		 * 
		 * @return Comma seperated list of events.
		 */
		public function get events():String {
			return _eventString;
		}
		
		/**
		 * Property sets the events that the group will listen to in
		 * order to make it's selection of an item. This property
		 * can only be set once. An error will be thrown
		 * if it is set multiple times.
		 * Also the property must be set before items are set. Items
		 * require events to be defined and can not be adjusted after the 
		 * fact.
		 *  
		 * @param value Comma seperated list of events.
		 */
		public function set events(value:String):void {
			if(_eventString) {
				throw new Error("Events can only be set once");
			}
			else if(this.items.length > 0) {
				throw new Error("Events must be set before items are set");
			}
			
			_eventString = value;
			// Remove spaces in between the commas and then split by commas
			_events = value.replace(/(\s)+,/, ",").replace(/,(\s)+/,",").split(",");
		}
		/**
		 * Variable holds all items currently in the group
		 * 
		 * @return Array All items in the group
		 */
		public function get items():Array {
			return SelectionController.getAllItemsInGroup(this.__groupId);
		}
		/**
		 * Variable resets all items in the group with the new array provided
		 * 
		 * @param values Array containing all items to be included in the group
		 */
		public function set items(values:Array):void {
			// Set events
			var events:Array = (_events && events.length > 0) ? _events : [MouseEvent.CLICK];
			var eventLen:uint = events.length;
			
			// Remove event listeners
			
			var itemLen:uint = items.length;
			// Loop through all items currently in the group
			for(var x:uint; x<itemLen;x++) {
				// Loop through all events available
				for(var i:uint; i < eventLen;i++) {
					IEventDispatcher(items[x]).removeEventListener(events[i], handleSelection);
				}
			}	
			
			// Deselect all items before clearing
			SelectionController.deselectAll(this.__groupId);
			
			// Clear all items
			SelectionController.removeAllItems(this.__groupId);

			// Add all new targets
			var valueLen:uint = values.length;
			// Loop through all items currently in the group
			for(x = 0; x < valueLen;x++) {
				if(values[x] != null) {
					// Loop through all events available
					for(i = 0; i < eventLen;i++) {
						IEventDispatcher(values[x]).addEventListener(events[i], handleSelection);
					}
					SelectionController.addItem(values[x], this.__groupId);
				}
			}	
		}
		
		/**
		 * Handler method for each event the group is listening to to indicate selection.
		 * 
		 * @param event Event dispatched from ISelectableItem
		 */
		protected function handleSelection(event:Event):void {
			SelectionController.selectItem(ISelectable(event.currentTarget));
		}

	}
}