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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// ProxyEventDispatcher.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/03/2009 17:44
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	
	/**
	 * 	The <code>ProxyEventDispatcher</code> class provides dynamic classes capabilities
	 * 	to <code>IEventDispatcher</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	dynamic public class ProxyEventDispatcher extends Proxy implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ProxyEventDispatcher</code> instance.
		 */
		public function ProxyEventDispatcher() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		// IEventDispatcher API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Registers an event listener object with an <code>EventDispatcher</code>
		 * 	object so that the listener receives notification of an event. You can
		 * 	register event listeners on all nodes in the display list for a specific
		 * 	type of event, phase, and priority.
		 * 
		 * 	@param	type	The type of event.
		 * 	@param	listener	The listener function that processes the event. This
		 * 						function must accept an <code>Event</code> object as
		 * 						its only parameter and must return nothing, as this
		 * 						example shows: <code>function(evt:Event):void</code>
		 * 	@param	useCapture	Determines whether the listener works in the capture
		 * 						phase or the target and bubbling phases. If <code>useCapture</code>
		 * 						is set to <code>true</code>, the listener processes
		 * 						the event only during the capture phase and not in
		 * 						the target or bubbling phase. If <code>useCapture</code>
		 * 						is <code>false</code>, the listener processes the event
		 * 						only during the target or bubbling phase.
		 * 	@param	priority	The priority level of the event listener. Priorities
		 * 						are designated by a 32-bit integer. The higher the number,
		 * 						the higher the priority. All listeners with priority
		 * 						<code>n</code> are processed before listeners of priority
		 * 						<code>n-1</code>. If two or more listeners share the same
		 * 						priority, they are processed in the order in which they
		 * 						were added. The default priority is <code>0</code>.
		 * 	@param	useWeakReference	Determines whether the reference to the listener
		 * 						is strong or weak. A strong reference (the default)
		 * 						prevents your listener from being garbage-collected.
		 * 						A weak reference does not.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			$dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * 	Dispatches an event into the event flow. The event target is the
		 * 	<code>EventDispatcher</code> object upon which <code>dispatchEvent()</code>
		 * 	is called.
		 * 
		 * 	@param	event The <code>Event</code> object dispatched into the event flow.
		 * 
		 * 	@return	A value of <code>true</code> unless <code>preventDefault()</code> is
		 * 			called on the event, in which case it returns <code>false</code>.
		 */
		public function dispatchEvent(event:Event):Boolean {
			return $dispatcher.dispatchEvent(event);
		}
		
		/**
		 * 	Checks whether the <code>EventDispatcher</code> object has any listeners
		 * 	registered for a specific type of event. This allows you to determine where
		 * 	an <code>EventDispatcher</code> object has altered handling of an event
		 * 	type in the event flow hierarchy. To determine whether a specific event
		 * 	type will actually trigger an event listener, use <code>IEventDispatcher.willTrigger()</code>.
		 * 
		 * 	<p>The difference between <code>hasEventListener()</code> and <code>willTrigger()</code>
		 * 	is that <code>hasEventListener()</code> examines only the object to which it belongs,
		 * 	whereas <code>willTrigger()</code> examines the entire event flow for the event
		 * 	specified by the <code>type</code> parameter.</p>
		 * 
		 * 	@param	type The type of event.
		 * 
		 * 	@return A value of <code>true</code> if a listener of the specified type is registered;
		 * 			<code>false</code> otherwise.
		 */
		public function hasEventListener(type:String):Boolean {
			return $dispatcher.hasEventListener(type);
		}
		
		/**
		 * 	Removes a listener from the <code>EventDispatcher</code> object. If there
		 * 	is no matching listener registered with the <code>EventDispatcher</code>
		 * 	object, a call to this method has no effect.
		 * 
		 * 	@param	type The type of event.
		 * 	@param	listener The listener object to remove.
		 * 	@param	useCapture 	Specifies whether the listener was registered for the capture
		 * 						phase or the target and bubbling phases. If the listener was
		 * 						registered for both the capture phase and the target and bubbling
		 * 						phases, two calls to <code>removeEventListener()</code> are
		 * 						required to remove both: one call with <code>useCapture</code>
		 * 						set to <code>true</code>, and another call with <code>useCapture</code>
		 * 						set to <code>false</code>.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			$dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * 	Checks whether an event listener is registered with this <code>EventDispatcher</code>
		 * 	object or any of its ancestors for the specified event type. This method returns
		 * 	<code>true</code> if an event listener is triggered during any phase of the event
		 * 	flow when an event of the specified type is dispatched to this <code>EventDispatcher</code>
		 * 	object or any of its descendants.
		 * 
		 * 	<p>The difference between <code>hasEventListener()</code> and <code>willTrigger()</code>
		 * 	is that <code>hasEventListener()</code> examines only the object to which it belongs,
		 * 	whereas <code>willTrigger()</code> examines the entire event flow for the event
		 * 	specified by the <code>type</code> parameter.</p>
		 * 
		 * 	@param	type The type of event.
		 * 
		 * 	@return A value of <code>true</code> if a listener of the specified type will be
		 * 			triggered; <code>false</code> otherwise.
		 */
		public function willTrigger(type:String):Boolean {
			return $dispatcher.willTrigger(type);
		}
		
		//--------------------------------------------------------------------------
		//
		//   Public methods from Object prototype not inherited by Proxy
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the primitive value of the specified object. If this object does
		 * 	not have a primitive value, the object itself is returned.
		 * 
		 * 	@return	The primitive value of this object or the object itself.
		 */
		public function valueOf():Object {
			return this;
		}
		
		/**
		 * 	Returns the string representation of the specified object.
		 * 
		 * 	@return	A string representation of the object.
		 */
		public function toString():String {
			return $objectDescriptor;
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the encapsulated <code>EventDispatcher</code>
		 * 	for this <code>ProxyEventDispatcher</code> object.
		 */
		protected var $dispatcher:EventDispatcher;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the string representation of this object.
		 */
		protected var $objectDescriptor:String = "[object ProxyEventDispatcher]";
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$dispatcher = new EventDispatcher(this);
		}
	}
}