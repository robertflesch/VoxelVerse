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
package com.developmentarc.core.services
{
	import com.developmentarc.core.datastructures.utils.HashTable;
	import com.developmentarc.core.services.dispatchers.IDispatcher;
	import com.developmentarc.core.services.events.DispatcherEvent;
	import com.developmentarc.core.services.events.RequestEvent;
	import com.developmentarc.core.services.mocks.IMockDispatcher;
	import com.developmentarc.core.services.parsers.IParser;
	import com.developmentarc.core.services.requests.AbstractRequest;
	import com.developmentarc.core.services.requests.IRequest;
	import com.developmentarc.core.utils.InstanceFactory;
	
	/**
	 * <p>The RequestDelegate is the central class for DevelopmentArc's service layer.  The job of the delegate is to pass a request through the various points
	 * of the service layer. Each request  coming into the delegate will provide a class reference to a paticular dispatcher (for retrieving data) and 
	 * a parser (processing raw data) and then back to the request for storage.  </p>
	 * 
	 * <p>
	 * <b>Request Lifecycle</b>
	 * When a request is started, the delegate will either create or look up the reference dispatcher class (IDispatcher) and the required parser class (IParser).  
	 * The request and the parser are then provided to the dispatcher for processing.  The dispatcher's job is to retrieve of store data into a data source. That 
	 * data source can be anything the developer wishes.  Provided in the framework is a HTTPRequestDispatcher for retrieving data via an HTTPService. </p>
	 * 
	 * <p>When data returns successfully from the dispatcher the delegate will consume the raw data and pass it to the parser for processing.  The goal of the 
	 * parser is to convert raw data (e4x, xml, object, JSON, etc..) into application specific data types (DataObjects).  When finished
	 * the parser will pass back the translated data, which the delegate will pass back to the request for saving into the appliction</p>
	 * 
	 * <p>
	 * <b>Request Lifecycle phases</b>
	 * When a request enters into a phase, a RequestEvent will be dispatched from the request with the same type as the phase.
	 * <ul>
	 *   <li>RequestEvent.CREATED - When a request is instantiated, the first phase is created.</li>
	 * 	 <li>RequestEvent.DISPATCHED - When a request has been dispatched to it's dispatcher.</li>
	 *   <li>RequestEvent.RETURNED - A request enters the returned phase when the dispathcer has successfully returned data to the delegate.</li>
	 * 	 <li>RequestEvent.FAILURE - A request enters this phase, when a dispatcher has faulted during the dispatching of the request. The request will be marked as a failure and will not continue. The 
	 *    original DispatcherEvent will be included inside of the ResultEvent allowing for application diagnostic.</li>
	 *   <li>RequestEvent.PARSING - Marked when the delegate has passed a request's raw data to the parser for processing.</li>
	 *   <li>RequestEvent.COMPLETE - After data has been returned, parsed and saved via the request itself the request will be marked complet.</li>
	 *   <li>RequestEvent.ERROR - If a parser errors during its processing the request will be marked as an error and will halt the lifecycle of the request. Inside of the ResultEvent that is dispatched from 
	 *   the request will be the original Error allowing for all listeners to take appropriate action.</li>
	 *   <li>RequestEvent.CANCEL - If a request is canceled at anypoint in the lifecycle, it will be marked as Canceled and will not continue.</li>
	 * </ul>
	 * </p>
	 * 
	 * <p>
	 * <b>Interacting Directly with RequestDelegate</b>
	 * The goal is to provide access to the RequestDelegate only through the Request itself. AbtractRequest provides a start and stop method which handle communication with the RequestDelegate. 
	 * Meaning, there is little direct communication with the RequestDelegate.  
	 * </p>
	 * 
	 * <p>
	 * <b>Mock Dispatchers</b>
	 * In many situations, the client-side application will be build in parallel with the service-side APIs. In those cases mock dispatchers are needed to mimic the returned raw data
	 * from services that have yet to be built.  The service layer provides a solution to turn the service layer into "mock mode".  By default the RequestDelegate is set to "live" but can 
	 * be switched via  static property "mode" which can take two values MODE_MOCK, or MODE_LIVE.   However, there is also a switch inside of the dispatcher layer of the system.  
	 * When creating a dispatcher one can also create mock dispatcher and link a class reference to that class via the dispatcher.  The deleagte
	 * can then switch a second flag to mark that it is also in "mock" mode.  When both the RequestDelegate and the dispatcher are in "mock" mode the mock dispatcher will 
	 * be leveraged.   The goal of the two point flag system is to allow some services to be live while others are not. 
	 * </p>
	 * 
	 * @see com.developmentarc.core.services.requests.AbstractRequest AbstractRequest
	 * @see com.developmentarc.core.services.dispatchers.AbstractDispatcher AbstractDispatcher
	 * @see com.developmentarc.core.services.parsers.AbstractParser AbstractParser
	 * 
	 * @author Aaron Pedersen
	 */
	public class RequestDelegate
	{
		
	
		/* STATIC PROPERTIES */
		
		public static const MODE_MOCK:String = "MODE_MOCK";
		public static const MODE_LIVE:String = "MODE_LIVE";
		
		/* PRIVATE PROPERTIES */
		
		/**
		 * @private
		 * The static instance of the class. 
		 */
		static protected var __instance:RequestDelegate;
		
		/**
		 * @private
		 * Map holding current requests in the system
		 */
		private var _requests:HashTable;
		
		/**
		 * @private
		 * Holder of each parser in the system. The goal
		 * is to only have one parser of each type
		 */
		private var _parserFactory:InstanceFactory;
		
		/**
		 * @private
		 * Holder of each dispatcher in the system. Only one per 
		 * Class will be created.
		 */
		private var _dispatcherFactory:InstanceFactory;
		
		/**
		 * @private
		 * Holds one instance of each mock dispatcher used.
		 */
		private var _mockFactory:InstanceFactory;
		
		/**
		 * @private
		 * Mode is set to live by default
		 */
		private var __mode:String = MODE_LIVE;
		
		/**
		 * Constructor (Singleton)
		 */
		public function RequestDelegate(lock:Class)
		{
			// only extendend classes can call the instance directly
			if(!lock is SingletonLock) throw new Error("Invalid use of RequestDelegate constructor, do not call directly.", 9001);
		
			// Create instance properites
			_requests = new HashTable();
			_parserFactory = new InstanceFactory();
			_dispatcherFactory = new InstanceFactory();
			_mockFactory = new InstanceFactory();
			
			// Listen to ResultEvent and Fault event on each dispatcher
			
		}
		/**
		 * Returns the current instance of the RequestDelegate.
		 * 
		 * @return Current instance of the factory.
		 */
		static protected function get instance():RequestDelegate {
			if(!__instance) __instance = new RequestDelegate(SingletonLock);
			return __instance;
		}
		
		/**
		 * Enables extended Classes to access the lock.
		 *  
		 * @return The lock Class.
		 */
		static protected function get lock():Class {
			return SingletonLock;
		}
		
		/**
		 * <p>Method executes the provided request. This is the entry point into 
		 * the service layer and kicks off the request life cycle.</p>
		 * 
		 * <p>This method is static and encapsulates a singleton instance of the RequestDelegate</p>
		 * 
		 * @param request IRequest to be executed.
		 */
		static public function start(request:IRequest):void {
			instance.startRequest(request);
		}
		/**		
		 * <p>Method will hault the provided request at anypoint in it's lifecycle.
		 * Upon stopping the request, it's phase will be mared as ResultEvent.CANCEL.</p>
		 * 
		 * <p>This method is static and encapsulates a singleton instance of the RequestDelegate</p>
		 * 
		 * @param request IRequest to be stopped
		 */
		static public function stop(request:IRequest):void {
			instance.stopRequest(request);
		}
		
		/**
		 * Sets the mode of the RequestDelegate.Available options are MODE_MOCK and MODE_LIVE.
		 * Default is MODE_LIVE.
		 * 
		 * <p>This method is static and encapsulates a singleton instance of the RequestDelegate</p>
		 */ 
		static public function set mode(mode:String):void {
			instance.__mode = mode;
		}
		static public function get mode():String {
			return instance.__mode
		}
		
		/**
		 * <p>Method executes a given request by calling it's IDispatcher.
		 * This method will kick off the complete lifecycle for the provided
		 * request. After the dispatcher returns a result the raw data
		 * will be parsed by the request's parser. </p>
		 * 
		 * <p>If both the RequestDeleagte and the dispatcher are in mock mode, the dispatcher's
		 * mock dispatcher will be used rather than the dispathcer.</p>
		 * 
		 * @param request IRequest to be executed.
		 */
		public function startRequest(request:IRequest):void {
			// Get dispatcher
			var dispatcher:IDispatcher = getDispatcher(request);
			
			// Get parser
			var parser:IParser = getParser(request);
						
			// Dispatch request
			var key:*;
			// Mock Mode
			if(mode == MODE_MOCK && request.mode == AbstractRequest.MODE_MOCK) {
				// Get mock dispatcher
				var mock:IMockDispatcher = getMock(request);
				// Dispatch via mock
				key = mock.dispatch(request, parser);
			}	
			// Live
			else {
				key = dispatcher.dispatch(request, parser);
			}	
			// Store Request
			_requests.addItem(key, request);
			
			// Set request phase to dispatched
			request.dispatch();
		}
		
		/**
		 * Method stops a given request at anypoint in its lifecycle. The dispatcher is first engaged
		 * to cancel the request.  After calling cancel on the dispatcher, the request is marked
		 * as RequestEvent.CANCEL and removed from the current request map to indicate the request has stopped. This will help stop any further 
		 * action by the delegate on this request in case the request not canceled in the dispatcher.
		 * 
		 * @param request IRequest to be stopped. 
		 */
		public function stopRequest(request:IRequest):void {
			
			// If request has finished, return
			if(request.phase == RequestEvent.CANCEL || 
				request.phase == RequestEvent.COMPLETE ||
				request.phase == RequestEvent.ERROR) {
					return;
			}
				
			// Get dispatcher
			var dispatcher:IDispatcher = getDispatcher(request);

			// Remove request
			var keys:Array = _requests.getAllKeys();
			var keyLen:uint = keys.length;
			var key:*;
			for(var i:uint=0;i<keyLen;i++) {
				var item:* = _requests.getItem(keys[i]);
				
				// If match, remove
				if(item == request) {
					key = keys[i];
					break;
				}
			}
			
			// Only cancel if key was found
			if(key) {
				// Cancel request
				// Mock Mode
				if(mode == MODE_MOCK && request.mode == AbstractRequest.MODE_MOCK) {
					var mock:IMockDispatcher = getMock(request);
					mock.cancel(request, key);
				}
				// Live	
				else {
					dispatcher.cancel(request, key);
				}	
			
				// Remove request
				_requests.remove(key);
				
				// Set phase to cancel			
				request.cancel();
			}
		}
		/**
		 * @private
		 * 
		 * Method returns an instance of the IParser defined by the provided request.
		 * Only one parser is created in this instance and will be stored internally
		 * 
		 * @param request IRequest object who defines the parser class to use
		 * 
		 * @return IParser Single instance of IParser defined by provided request.
		 */
		private function getParser(request:IRequest):IParser {
			var parser:IParser;
			
			parser = _parserFactory.getInstance(request.parserClass);
			
			return parser;
		}
		/**
		 * @private
		 * 
		 * Method returns an instance of the IDispatcher defined by the provided request.
		 * Only one dispatcher is created in this instance and will be stored internally
		 * 
		 * @param request IRequest object who defines the parser class to use
		 * 
		 * @return IDispatcher Single instance of IDispatcher defined by provided request.
		 */
		private function getDispatcher(request:IRequest):IDispatcher {
			var dispatcher:IDispatcher;
			
			var hasInstance:Boolean = _dispatcherFactory.containsInstance(request.dispatcherClass); 
			
			dispatcher = _dispatcherFactory.getInstance(request.dispatcherClass);
			
			// If instance was not created before - add events
			if(!hasInstance) {
				dispatcher.addEventListener(DispatcherEvent.RESULT, handleDispatcherResult);
				dispatcher.addEventListener(DispatcherEvent.FAULT, handleDispatcherFault);
			}
			return dispatcher;
		}
		
		/**
		 * @private
		 * 
		 * Method returns an instance of IMockDispatcher defined by the provided dispathcer.
		 * Only one mock will be created in this instance and will be stored internally.
		 * 
		 * @param dispatcher IDispatacher who deifned the mock delegate class.
		 * 
		 * @return IMockDispatcher Dispatcher who mocks the request.
		 */
		private function getMock(request:IRequest):IMockDispatcher {
			var mock:IMockDispatcher;
			
			var hasInstance:Boolean = _mockFactory.containsInstance(request.mockClass); 
			
			mock = _mockFactory.getInstance(request.mockClass);
			
			// If instance was not created before - add events
			if(!hasInstance) {
				mock.addEventListener(DispatcherEvent.RESULT, handleDispatcherResult);
				mock.addEventListener(DispatcherEvent.FAULT, handleDispatcherFault);
			}
			return mock;
		}
		
		/**
		 * <p>Method handles result event from IDispatcher. This method indicates 
		 * the dispatcher has successfully retrieved data and it's now ready to parse.
		 * Method will retrieve parser for request and call parse() to translate raw data into appropriate format.
		 * After data has been parsed, the request is invoked to save the data where appropriate. 
		 * Upon completion the request is marked as COMPLETE and removed from the delegate system.</p>
		 * 
		 * <p>If an error occures during parsing, the request is marked as an ERROR and removed from the system.</p>
		 * 
		 * @param event DispatcherEvent defining the request and data
		 */
		private function handleDispatcherResult(event:DispatcherEvent):void {
			// Get request
			var request:IRequest = _requests.getItem(event.uid);
			
			// If requst has been removed from the system, igonore and return
			if(!request) return;
			
			// Set phase to returned
			request.returned();
			
			// Call parser
			var parser:IParser = _parserFactory.getInstance(request.parserClass);
			
			// Set phase to parsing
			request.parsing();
			
			// Parse raw data
			var data:*;
			var successfulParse:Boolean = true;
			try {
				data = parser.parse(event.result);
			}
			catch(err:Error) {
				request.error(err);
				successfulParse = false;
			}
			// Only if request was successfully parsed
			if(successfulParse) {
				// Call request to save data
				request.saveData(data);
			
				// Change request phase to complete
				request.complete();
			}
			// Remove request from delegate system
			_requests.remove(event.uid);
		}
		
		/**
		 * Method handles fault event from IDispatcher indicating an failure occured
		 * while dispatching the Request.  Method will mark request as a Failure and will remove from from the delegation system.
		 * 
		 * @param event DispatcherEvent from IDispatcher that failed.
		 */
		private function handleDispatcherFault(event:DispatcherEvent):void {
			// Get request
			var request:IRequest = _requests.getItem(event.uid);
			
			// Set phase to error
			request.failure(event.originalEvent);
			
			// Remove request
			_requests.remove(event.uid);
		}
	}
}

class SingletonLock
{
	public function SingletonLock() {}
}