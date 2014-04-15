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

package org.flashapi.collector {
	
	// -----------------------------------------------------------
	// EventCollector.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 15/06/2011 13:08
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import org.flashapi.collector.core.collector_internal;
	import org.flashapi.collector.core.EventListnerProxy;
	import org.flashapi.collector.exceptions.NullEventException;
	
	use namespace collector_internal;
	
	/**
	 * 	The <code>EventCollector</code> class helps developers to easily manage
	 * 	events through Actionscript 3.0 event model, and prevent memory leaks.
	 * 
	 * 	@see org.flashapi.collector.EventListnerProxy
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class EventCollector {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>EventCollector</code> object.
		 */
		public function EventCollector() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the number of events registred within this <code>EventCollector</code>
		 * 	object.
		 */
		public function get length():int {
			return _stack.length;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<p>Registers an event listener object with an <code>EventDispatcher</code>
		 * 	object so that the listener receives notification of an event once only.
		 * 	Once the registred event is fired, the event listener for the associated
		 * 	<code>EventDispatcher</code> object is removed. Thus means that you
		 * 	can not listen a "one shot event" more than one time.</p>
		 * 
		 * 	@param	obj		The <code>EventDispatcher</code> registred with the event
		 * 					listener object.
		 * 	@param	event	The type of event.
		 * 	@param	func	The listener function that processes the event. This function
		 * 					must accept an <code>Event</code> object as its only parameter
		 * 					and must return nothing. The function can have any name.
		 * 	@param	useCapture	Determines whether the listener works in the capture
		 * 						phase or the target and bubbling phases.
		 * 	@param	priority	The priority level of the event listener. The priority is
		 * 						designated by a signed 32-bit integer. The higher the
		 * 						number, the higher the priority. All listeners with priority
		 * 						<code>n</code> are processed before listeners of priority
		 * 						<code>n-1</code>. If two or more listeners share the same
		 * 						priority, they are processed in the order in which they
		 * 						were added.
		 * 	@param	useWeakReference	Determines whether the reference to the listener
		 * 						is strong or weak. A strong reference (the default)
		 * 						prevents your listener from being garbage-collected.
		 * 						A weak reference does not. 
		 */
		public function addOneShotEvent(obj:IEventDispatcher, event:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			var ec:EventCollector = this;
			var autoRemoveFunc:Function = function(e:Event):void {
				ec.removeEvent(obj, event, func);
				ec.removeEvent(obj, event, autoRemoveFunc);
			}
			_addEvent(obj, event, func);
			_addEvent(obj, event, autoRemoveFunc);
			obj.addEventListener(event, autoRemoveFunc);
			obj.addEventListener(event, func, useCapture, priority, useWeakReference);
		}
		
		/**
		 * 	Registers an event listener object with an <code>EventDispatcher</code> object
		 * 	so that the listener receives notification of an event.
		 * 
		 * 	@param	obj		The <code>EventDispatcher</code> registred with the event
		 * 					listener object.
		 * 	@param	event	The type of event.
		 * 	@param	func	The listener function that processes the event. This function
		 * 					must accept an <code>Event</code> object as its only parameter
		 * 					and must return nothing. The function can have any name.
		 * 	@param	useCapture	Determines whether the listener works in the capture
		 * 						phase or the target and bubbling phases.
		 * 	@param	priority	The priority level of the event listener. The priority is
		 * 						designated by a signed 32-bit integer. The higher the
		 * 						number, the higher the priority. All listeners with priority
		 * 						<code>n</code> are processed before listeners of priority
		 * 						<code>n-1</code>. If two or more listeners share the same
		 * 						priority, they are processed in the order in which they
		 * 						were added.
		 * 	@param	useWeakReference	Determines whether the reference to the listener
		 * 						is strong or weak. A strong reference (the default)
		 * 						prevents your listener from being garbage-collected.
		 * 						A weak reference does not. 
		 */
		public function addEvent(obj:IEventDispatcher, event:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_addEvent(obj, event, func);
			obj.addEventListener(event, func, useCapture, priority, useWeakReference);
		}
		
		/**
		 * 	Registers an event listener object with each <code>EventDispatcher</code>
		 * 	object of the <code>collection</code> array parameter, so that the listener
		 * 	receives notification of an event.
		 * 
		 * 	@param	collection	An array collection of <code>EventDispatcher</code> objects
		 * 						to register with the event listener object.
		 * 	@param	event	The type of event.
		 * 	@param	func	The listener function that processes the event. This function
		 * 					must accept an <code>Event</code> object as its only parameter
		 * 					and must return nothing. The function can have any name.
		 * 	@param	useCapture	Determines whether the listener works in the capture
		 * 						phase or the target and bubbling phases.
		 * 	@param	priority	The priority level of the event listener. The priority is
		 * 						designated by a signed 32-bit integer. The higher the
		 * 						number, the higher the priority. All listeners with priority
		 * 						<code>n</code> are processed before listeners of priority
		 * 						<code>n-1</code>. If two or more listeners share the same
		 * 						priority, they are processed in the order in which they
		 * 						were added.
		 * 	@param	useWeakReference	Determines whether the reference to the listener
		 * 						is strong or weak. A strong reference (the default)
		 * 						prevents your listener from being garbage-collected.
		 * 						A weak reference does not. 
		 */
		public function addEventCollection(collection:Array, event:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			var l:int = collection.length - 1;
			var obj:IEventDispatcher;
			for (; l >= 0; l--) {
				obj = collection[l];
				_addEvent(obj, event, func);
				obj.addEventListener(event, func, useCapture, priority, useWeakReference);
			}
		}
		
		/**
		 * 	Adds a collection of event types to the specified object. The method is used to assign
		 * 	a common behavior to different event types to the same object.
		 * 
		 * 	@param	obj		The <code>EventDispatcher</code> registred with the collection
		 * 					of event listener objects.
		 * 	@param	func	The listener function that processes the event. This function
		 * 					must accept an <code>Event</code> object as its only parameter
		 * 					and must return nothing. The function can have any name.
		 * 	@param	events		An array collection of event listener object types.
		 * 	@param	useCapture	Determines whether the listener works in the capture
		 * 						phase or the target and bubbling phases.
		 * 	@param	priority	The priority level of the event listener. The priority is
		 * 						designated by a signed 32-bit integer. The higher the
		 * 						number, the higher the priority. All listeners with priority
		 * 						<code>n</code> are processed before listeners of priority
		 * 						<code>n-1</code>. If two or more listeners share the same
		 * 						priority, they are processed in the order in which they
		 * 						were added.
		 * 	@param	useWeakReference	Determines whether the reference to the listener
		 * 						is strong or weak. A strong reference (the default)
		 * 						prevents your listener from being garbage-collected.
		 * 						A weak reference does not. 
		 */
		public function addEventsByTypes(obj:Object, func:Function, events:Array, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			var l:int = events.length - 1;
			var e:String;
			for (; l >= 0; l--) {
				e = events[l];
				_addEvent(obj, e, func);
				obj.addEventListener(e, func, useCapture, priority, useWeakReference);
			}
		}
		
		/**
		 * 	Removes a registered event listener object from this <code>EventCollector</code>
		 * 	object.
		 * 
		 * 	@param	obj		The <code>EventDispatcher</code> registred with the event
		 * 					listener object to remove.
		 * 	@param	event	The type of event.
		 * 	@param	func	The listener function that processes the event.
		 */
		public function removeEvent(obj:Object, event:String, func:Function):void {
			checkObject(obj);
			var elp:EventListnerProxy;
			for each(elp in _stack) {
				if(checkProxy(elp, obj, event, func)) {
					_stack.splice(_stack.indexOf(elp), 1);
					elp.collector_internal::objRef.removeEventListener(elp.collector_internal::eventRef, elp.collector_internal::funcRef);
					elp.finalize();
					elp = null;
					break;
				}
			} 
		}
		
		/**
		 * 	Removes a collection of registered event listener object from this 
		 * 	<code>EventCollector</code> object.
		 * 
		 * 	@param	collection	An array collection of <code>EventDispatcher</code> objects
		 * 						registred with the event listener object.
		 * 	@param	event	The type of event.
		 * 	@param	func	The listener function that processes the event.
		 */
		public function removeEventCollection(collection:Array, event:String, func:Function):void {
			var l:int = collection.length - 1;
			for (; l > 0; l--) this.removeEvent(collection[l], event, func);
		}
		
		/**
		 * 	Removes all events registred fo a specific type of <code>EventDispatcher</code>
		 * 	object.
		 * 
		 * 	@param	classDefinition	The class reference for all objectsyou want to remove
		 * 							all registred event.
		 */
		public function removeEventByClassDefinition(classDefinition:Class):void {
			var elp:EventListnerProxy;
			for each(elp in _stack) {
				if(elp.collector_internal::objRef is classDefinition) {
					//trace(elp.collector_internal::objRef);
					_stack.splice(_stack.indexOf(elp), 1);
					elp.collector_internal::objRef.removeEventListener(elp.collector_internal::eventRef, elp.collector_internal::funcRef);
					elp = null;
					break;
				}
			} 
		}
		
		/**
		 * 	Removes the event listener registred at the specified index from this
		 * 	<code>EventCollector</code> object.
		 * 
		 * 	@param	index	The index of the event listener to remove.
		 */
		public function removeEventAt(index:int):void {
			var elp:EventListnerProxy = _stack[index];
			elp.finalize();
			_stack[index] = null;
			_stack.splice(index, 1);
		}
		
		/**
		 * 	Returns the event listener proxy registred at the specified index within this
		 * 	<code>EventCollector</code> object.
		 * 
		 * 	@param	index	The index of the event listener to retrieve.
		 * 
		 * 	@return	The event listener proxy registred at the specified index.
		 */
		public function getEventAt(index:int):EventListnerProxy {
			return _stack[index];
		}
		
		/**
		 * 	Remove all events registred within this <code>EventCollector</code> object.
		 */
		public function removeAllEvents():void {
			var elp:EventListnerProxy;
			var i:int = _stack.length - 1;
			for(; i>=0; i--) {
				elp = _stack[i];
				deleteProxy(elp);
				elp = null;
			}
		}
		
		/**
		 * 	Removes all registred events for the specified object.
		 * 
		 * 	@param	obj	The <code>EventDispatcher</code> object for which to remove
		 * 				all registered events.
		 */
		public function removeObjectEvents(obj:Object):void {
			checkObject(obj);
			var elp:EventListnerProxy;
			var i:int = _stack.length - 1;
			for (; i >= 0; i--) {
				elp = _stack[i]
				if (elp.collector_internal::objRef === obj) deleteProxy(elp);
			}
			elp = null;
		}
		
		/**
		 * 	Checks whether the <code>EventDispatcher</code> object has any listeners registered
		 * 	for a specific type of event.
		 * 
		 * 	@param	obj		The <code>EventDispatcher</code> object to test.
		 * 	@param	event	 The type of event.
		 * 	@param	func	The listener function that processes the event to check.
		 * 
		 * 	@return	A value of <code>true</code> if the specified listener object is registered;
		 * 			<code>false</code> otherwise.
		 */
		public function hasRegisteredEvent(obj:Object, event:String, func:Function):Boolean {
			var elp:EventListnerProxy;
			var i:int = _stack.length - 1;
			for (; i >= 0; i--) {
				elp = _stack[i];
				if(checkProxy(elp, obj, event, func)) return true;
			} return false;
		}
		
		/**
		 * 	Checks whether the <code>EventDispatcher</code> object is contained within this
		 * 	<code>EventCollector</code> object.
		 * 
		 * 	@param	obj	The <code>EventDispatcher</code> object to test.
		 * 
		 * 	@return	A value of <code>true</code> if the <code>EventCollector</code> object
		 * 			contains the specified listener object; <code>false</code> otherwise.
		 */
		public function objectIsRegistered(obj:Object):Boolean {
			var i:int = _stack.length - 1;
			for (; i >= 0; i--) {
				if(_stack[i].obj===obj) return true;
			} return false;
		}
		
		/**
		 * 	Returns the string representation of this <code>EventCollector</code> object.
		 * 
		 * 	@return	A string representation of the <code>EventCollector</code> object.
		 */
		 public function toString():String {
			var str:String = "";
			var i:int = _stack.length - 1;
			var elp:EventListnerProxy;
			for(; i>=0; i--) {
				elp = _stack[i];
				str += "Registered object: " + elp.collector_internal::objRef + ", registered event: " +
				elp.collector_internal::eventRef + ";\n";
			} return str;
		}
		
		/**
		 * 	Frees the memory used by this <code>EventCollector</code> object.
		 */
		public function finalize():void {
			this.removeAllEvents();
			_stack = [];
			_stack = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private var _stack:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_stack = [];
		}
		
		private function _addEvent(obj:Object, event:String, func:Function):void {
			checkObject(obj);
			var elp:EventListnerProxy;
			for each(elp in _stack) {
				if(checkProxy(elp, obj, event, func)) {
					_stack.splice(_stack.indexOf(elp), 1); 
					break;
				}
			}
			_stack.push(new EventListnerProxy(obj, event, func));
		}
		
		private function checkObject(obj:Object):void {
			if(obj==null) throw new NullEventException();
		}
		
		private function checkProxy(elp:EventListnerProxy, o:Object, e:String, f:Function):Boolean {
			return (elp.collector_internal::objRef === o && elp.collector_internal::eventRef === e && elp.collector_internal::funcRef === f);
		}
		
		private function deleteProxy(elp:EventListnerProxy):void {
			_stack.splice(_stack.indexOf(elp), 1);
			elp.collector_internal::objRef.removeEventListener(elp.collector_internal::eventRef, elp.collector_internal::funcRef);
			elp.finalize();
		}
	}
}