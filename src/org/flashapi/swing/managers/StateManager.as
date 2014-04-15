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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// StateManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/01/2009 02:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.IllegalStateException;
	import org.flashapi.swing.exceptions.IndexOutOfBoundsException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>StateManager</code> class is a convenient class that lets you easilly
	 * 	assign a specific action to a state and navigates between each state.
	 * 
	 * 	<p>State actions consist in specific <code>Function</code> objects that are
	 * 	called each time a new state is required.</p>
	 * 
	 * 	<p>Navigation between states can be done by using the programmatic API, such
	 * 	as the <code>next()</code> methods, or by assigning an (or several) event producer
	 * 	objects. Event producerers listen events dispatched by an external
	 * 	<code>EventDispatcher</code> object to change the current state of the 
	 * 	<code>StateManager</code> instance to the next registred one.</p>
	 * 
	 * 	<p>States are index based, the index depending on the order the state action
	 * 	has been added to the <code>StateManager</code> object. The initial index
	 * 	is <code>-1</code>, which means that no state action has been called, or
	 * 	the <code>StateManager</code> has been reseted by using the <code>reset()</code>
	 * 	method.</p>
	 * 
	 *  @includeExample StateManagerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class StateManager extends EventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>StateManager</code> object.
		 * 
		 */
		public function StateManager() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _currentId:int = -1;
		/**
		 * 	Returns an integer that indicates the current state of this
		 * 	<code>StateManager</code> object.
		 * 
		 * 	@default -1
		 */
		public function get currentState():int {
			return _currentId;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a new state action to this <code>StateManager</code> object. The
		 * 	state action is added at the end of the <code>StateManager</code> stack.
		 * 	
		 * 	@param	action	A <code>Function</code> object that defines a specific
		 * 					state.
		 * 
		 * 	@return	The index of the added state action within the <code>StateManager</code>
		 * 			stack.
		 * 
		 * 	@see #addActions()
		 * 	@see #remove()
		 * 	@see #removeAll()
		 */
		public function add(action:Function):int {
			return _stack.push(action);
		}
		
		/**
		 * 	Adds a collection of state actions to this <code>StateManager</code> object.
		 * 	All items in the collection are <code>Function</code> objects that defines
		 * 	a specific state action to add. All state actions are added at the end of
		 * 	the <code>StateManager</code> stack and must be comma separated.
		 * 
		 * 	@param	... actions	A collection of comma separated state actions to
		 * 						add to this <code>StateManager</code> object.
		 * 
		 * 	@return	The index of the last added state action within the 
		 * 			<code>StateManager</code> stack.
		 * 
		 * 	@see #add()
		 * 	@see #remove()
		 * 	@see #removeAll()
		 */
		public function addActions(... actions):int {
			var l:uint = actions.length;
			var i:uint = 0;
			for (; i < l; i++) _stack.push(actions[i]);
			return _stack.length;
		}
		
		/**
		 * 	Declares an event listener, from an external <code>EventDispatcher</code> 
		 * 	instance, that will change the current state of this <code>StateManager</code>
		 * 	to the next one, each time the watched event is fired.
		 * 	
		 * 	@param	listener	The <code>EventDispatcher</code> instance that will
		 * 						produce the event to watch.
		 * 	@param	type		The type of event to watch.
		 * 
		 * 	@see #removeEventProducer()
		 * 	@see #removeAllEventProducers()
		 */
		public function addEventProducer(listener:EventDispatcher, type:String):void {
			_eventColl.addEvent(listener, type, nextStateHandler);
		}
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all subprocess will
		 * 	be killed for this <code>StateManager</code> object. After calling this
		 * 	function you have to set the <code>StateManager</code> to <code>null</code>
		 * 	to make it elligible for garbage collection.
		 */
		public function finalize():void {
			removeAll();
			_stack = null;
			_eventColl.finalize();
			_eventColl = null;
		}
		
		/**
		 * 	Removes a state action to this <code>StateManager</code> object.
		 * 
		 * 	@param	action	The <code>Function</code> object that defines the 
		 * 					specific state action to remove.
		 * 
		 * 	@return The number of state actions still registered within the
		 * 			<code>StateManager</code> stack.
		 * 
		 * 	@see #add()
		 * 	@see #addActions()
		 * 	@see #removeAll()
		 */
		public function remove(action:Function):int {
			var i:int = _stack.indexOf(action);
			_stack.splice(i, 1);
			return _stack.length;
		}
		
		/**
		 * 	Removes all state actions registered within this <code>StateManager</code>
		 * 	object.
		 * 
		 * 	@see #add()
		 * 	@see #addActions()
		 * 	@see #remove()
		 */
		public function removeAll():void {
			_stack = [];
			_currentId = -1;
		}
		
		/**
		 * 	Removes an event listener registered within this <code>StateManager</code>
		 * 	object.
		 * 	
		 * 	@param	listener	The <code>EventDispatcher</code> instance that
		 * 						produces the event to remove.
		 * 	@param	type		The type of event to remove.
		 * 
		 * 	@see #removeEventProducer()
		 * 	@see #addEventProducer()
		 */
		public function removeEventProducer(listener:EventDispatcher, type:String):void {
			_eventColl.removeEvent(listener, type, nextStateHandler);
		}
		
		/**
		 * 	Removes all event producers registered within this <code>StateManager</code>
		 * 	object.
		 * 
		 * 	@see #removeEventProducer()
		 * 	@see #addEventProducer()
		 */
		public function removeAllEventProducers():void {
			_eventColl.removeAllEvents();
		}
		
		/**
		 * 	Calls the next state action registered within this <code>StateManager</code>
		 * 	object. If the current state index is the last of the list, calls the first 
		 * 	registered state action.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalStateException 
		 * 	 			An <code>IllegalStateException</code> if no state action
		 * 				is registered this within <code>StateManager</code> object.
		 * 
		 * 	@see #goToState()
		 * 	@see #previous()
		 */
		public function next():void {
			var l:int = _stack.length - 1;
			checkIllegalAccess(l);
			if (_currentId++ >= l) _currentId = 0;
			_stack[_currentId]();
		}
		
		/**
		 * 	Calls the state action specified by the <code>index</code> parameter.
		 * 	
		 * 	@param	index	The index at which to call the registered state
		 * 					action.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IndexOutOfBoundsException 
		 * 	 			A <code>IndexOutOfBoundsException</code> if the
		 * 				<code>index</code> is lower than <code>0</code> or
		 * 				greater that the number of actions added to this
		 * 				<code>StateManager</code> object.
		 *  @throws org.flashapi.swing.exceptions.IllegalStateException 
		 * 	 			An <code>IllegalStateException</code> if no state action
		 * 				is registered this within <code>StateManager</code> object.
		 * 
		 * 	@see #next()
		 * 	@see #previous()
		 */
		public function goToState(index:int):void {
			var l:int = _stack.length - 1;
			checkIllegalAccess(l);
			if (index <0 || index>l) throw new IndexOutOfBoundsException();
			_currentId = index;
			_stack[_currentId]();
		}
		
		/**
		 * 	Calls the previous state action registered within this <code>StateManager</code>
		 * 	object. If the current state index is <code>0</code>, calls the last registered
		 * 	state action.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalStateException 
		 * 	 			An <code>IllegalStateException</code> if no state action
		 * 				is registered this within <code>StateManager</code> object.
		 * 
		 * 	@see #goToState()
		 * 	@see #next()
		 */
		public function previous():void {
			var l:int = _stack.length - 1;
			checkIllegalAccess(l);
			if (_currentId-- < 0) _currentId = l;
			_stack[_currentId]();
		}
		
		/**
		 * 	Resets the <code>StateManager</code> object which means that the next
		 * 	state index called by the <code>next()</code> method will be <code>-1</code>.
		 * 
		 * 	@see #next()
		 * 	@see #currentState
		 */
		public function reset():void {
			_currentId = -1;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:Array;
		private var _eventColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_stack = [];
			_eventColl = new EventCollector();
		}
		
		private function nextStateHandler(e:Event):void {
			this.next();
		}
		
		private function checkIllegalAccess(length:int):void {
			if (length <= 0) {
				throw new IllegalStateException(Locale.spas_internal::ERRORS.STATE_MANAGER_ERROR);
			}
		}
	}
}