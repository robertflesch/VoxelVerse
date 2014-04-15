/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2009 DevelopmentArc LLC
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
 package com.developmentarc.core.services.mocks
{
	import com.developmentarc.core.datastructures.utils.HashTable;
	import com.developmentarc.core.services.events.DispatcherEvent;
	import com.developmentarc.core.services.parsers.IParser;
	import com.developmentarc.core.services.requests.IRequest;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	
	/**
	 * <p>Class provides a base for all mock dispatchers to build on top of. Override both dispatch and cancel to 
	 * create the mock data that is required by the given request. For the dispatch method, after constructing
	 * the data calling super.dispatch will cause the dispatcher to fire a DispatcherEvent.RESULT in an Asynchronous manner via
	 * setTimeout.  Set the delay property to change the default delay of setTimeout,which is 500 milliseconds.
	 * 
	 * @author Aaron Pedersen 
	 */
	public class AbstractMockDispatcher extends EventDispatcher implements IMockDispatcher
	{
		

		private var map:HashTable;
		/**
		 * Result of the last request
		 */
		public var result:Object;
		
		/**
		 * Error message of the last request. Used when mocking a failure
		 */
		public var errorMessage:String;
		
		/**
		 * Event type of the dispatching event. Use DispatcherEvent.RESULT for a successful
		 * dispatch or DispatcherEvent.FAULT for an failure
		 */
		public var eventType:String = DispatcherEvent.RESULT;	
		
		/**	
		 * Delay when calling the  DispatcherEvent.
		 */ 
		public var delay:uint = 500;
		
		/**
		 * Constructor
		 */
		public function AbstractMockDispatcher() {
			map = new HashTable();
		}

		/**
		 * Method creates a DispatcherEvent to be dispatched after a set delay. If exteneded,
		 * call super.dispatch to insure the event is dispatched as expected.
		 * 
		 * @param request IRequest to process.
		 * @param parser IParser used to keep the same API as IDispatcher.
		 * 
		 * @returns Unique ID of the request after it has been dispatched.
		 */
		public function dispatch(request:IRequest, parser:IParser):* {
			// create event
			var dispatcherEvent:DispatcherEvent = new DispatcherEvent(eventType);
			dispatcherEvent.uid = generateUID();;
			dispatcherEvent.result = result;
			
			if(eventType == DispatcherEvent.FAULT) {
				createFaultEvent();
	
			}		
			// Add to map so we can find it when the event is ready to dispatch.
			map.addItem(request, dispatcherEvent);

			// Set timeout to dispatch event later.
			setTimeout(function():void{dispatchMock(request)}, delay);
			
			return dispatcherEvent.uid;
		}
		
		/**
		 * Method will mock a canceling of a request. Must be defined by child in order to use.
		 * 
		 * @param request IRequest to cancel
		 * @param key * Unique ID of the request when it was dispatched.
		 */
		public function cancel(request:IRequest, key:*):void {
			throw new Error("Child must implement");
		}
		
		/**
		 * Method mocks a fault Event of whatever type needed and returns it.
		 * This method is used when eventType is set to DispatchEvent.FAULT.
		 * 
		 * @returns Event of a fault to mimic fault from dispatcher.
		 */
		public function createFaultEvent():Event {
			throw new Error("Child must implement");
		}
		
		/**
		 * @private
		 * Method is used to dispatch the DispatcherEvent created during the dispatch method of this class.
		 * 
		 * @param request IRequest used to locate the DispatcherEvent created during the dispatch method.
		 */
		private function dispatchMock(request:IRequest):void {
			
			var dispatcherEvent:DispatcherEvent = DispatcherEvent(map.getItem(request));
			
			dispatchEvent(dispatcherEvent);
			
			map.remove(request);
		}
		
		/**
		 * Method creates a unique id based on Math.random(). Override to provide a differnet
		 * means for creating an unique id.
		 * 
		 * @returns * Unique identifier.
		 */
		protected function generateUID():* {
			return Math.random();
		}		
		
	}
}