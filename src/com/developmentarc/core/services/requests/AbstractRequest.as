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
package com.developmentarc.core.services.requests
{
	import com.developmentarc.core.services.RequestDelegate;
	import com.developmentarc.core.services.events.RequestEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="created",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="dispatched",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="returned",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="parsing",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="cancel",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="failure",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="error",type="com.developmentarc.core.services.events.RequestEvent")]
	[Event(name="complete",type="com.developmentarc.core.services.events.RequestEvent")] 
	/**
	 * <p>Abstract class used as the base for all request inside of the DevelopmentArc service layer.
	 * The responsibility of the Request is to define all of the detailed information for a given instance of a service call. A Request is simply a custom data object
	 * that is used by the RequestDelegate and the Request's Dispatcher. The Request's other responsiblity is to save
	 * the data passed back from the RequestDelegate (after it has been parsed) to a paticular location in the application.    
	 * 
	 * <p>
	 * <b>Properties</b>
	 * A request can define 5 properties during construction of the Request. The goal is for developers to define their own Requests and provide the default into the
	 * AbstractRequest constructor.  The first three properties are custom properties that are used in conjunction with the dispatcher that is associated with this request. It is 
	 * up to the developer to define each to meet the purpose of the request and dispatcher. For an example of usage, look how HTTPRequestDispatcher's use each parameter.  
	 * The final two properties are used to link the request with a Dispatcher (IDispatcher) and a Parser (IParser)
	 * </p>
	 * <p> Breakdown Below</p>
	 * <ul>
	 *   <li>type - A request can define a type which can be used to toggle between different variables when invoking a service request.  If the type is not needed, set it to a blank string.</li>
	 *   <li>uri - Is used as the root of the service path, which would be the root url in a HTTPService or to define the DB path used when connection to a local SQLLite DB in AIR.</li>
	 *   <li>source - Can be used to define the the details of a uri. Example, for a HTTPService this would be the specific API of a service or for a DB connection the table.</li>
	 *   <li>dispatcherClass - Class reference to the associated Dispatcher (IDispather). A dispather is responsible for encapsulating a service type and instance and executing this paticular request
	 * through the service layer</li>
	 * <li>parserClass - Class reference to the Parser (IParser) which is responsible for parsing the raw data returned from the dispather</li>
	 * </ul>
	 * </p>
	 * 
	 * <p>
	 * <b>Mock</b>
	 * A Request class can define an IMockDispatcher via a class reference which when the Request and the RequestDelegate are in "mock" mode, will be used
	 * to fake, the service request and simple return data in the format expected.  This is useful when developing a system that does not yet have a complete service api
	 * or database constructed.  By having a seperate switch in both the RequestDelegate and the AbstractRequest, developers can toggle on and off from an application and a Request level
	 * their mock implementation. This allows for easier Unit Testing and parallel development with server teams that are creating the service API.
 	 * </p>
 	 * 
	 * <p>
	 * <b>LifeCycle</b>
	 * As a request moves through the service layer the request will will enter various lifecycle phases, each of which are defined in this class. See RequestDelegate 
	 * for definition of each event.
	 * </p>
	 * 
	 * @see com.developmentarc.core.services.RequestDelegate RequestDelegate
	 * @see com.developmentarc.core.services.dispatchers.AbstractDispatcher AbstractDispatcher
	 * @see com.developmentarc.core.services.parsers.AbstractParser AbstractParser
	 * @see com.developmentarc.core.services.requests.HTTPRequest HTTPRequest
	 *  
	 * @auther Aaron Pedersen
	 * </p>
	 */
	 
	public class AbstractRequest extends EventDispatcher implements IRequest
	{
		
		/* STATIC PROPERTIES */
		public static const MODE_MOCK:String = "MODE_MOCK";
		public static const MODE_LIVE:String = "MODE_LIVE";
		
		// PRIVATE GET/SET METHODS
		
		/**
		 * @private
		 * Type of this instance of the request
		 */
		private var __type:String;
		
		/**
		 * @private
		 * Address to service. Unique use per implementation of this class
		 */
		private var __uri:String;
		
		/**
		 * @private
		 * Unique source of an address. Could be used for defining specific api on domain. 
		 * Unique use per implementation.
		 */
		private var __source:String;
		
		/**
		 * @private
		 * Class reference to an IParser class used to parse this requests data
		 */
		private var __parserClass:Class;
		
		/**
		 * @private 
		 * 
		 * Class reference to IDispathcer class used to dispatch this paticular request via a service, 
		 * which is defined inside of the dispatcher
		 */
		private var __dispatcherClass:Class;
		
		/**
		 * @private
		 * 
		 * Used to stop an object of parameters used in the service request. This could be a sql statement or a set of get paraemters.
		 * The implementation will define the appropriate use.
		 */
		private var __params:Object;
		
		/**
		 * @private
		 * Marks the current mode of the dispatcher
		 */
		private var __mode:String;
		
		/**
		 * @private
		 * Class reference to the IMockDispatcher class
		 */
		private var __mockClass:Class

			
		// Protected properties
		/** Stores the request's internal current phase state value.
		 * This property is protected and intended to be accessible
		 * from extended Classes.  The value is publicly read-able
		 * via the phase getter.
		 */
		protected var currentPhase:String;
		
		
		/**
		 * Constructor.
		 * 
		 * @param type String used to define a specific type this request will be.
		 * @param uri String for root address to use for this request.
		 * @param source String for unique parts of the address that may be unique for a paticular instance.
		 * @param dispathcerClass Class reference to the dispatcher used by this request.
		 * @param parserClass Class reference to the parser used to translate raw data from the result of this request in to application specific data.
		 */
		public function AbstractRequest(type:String, uri:String, source:String, dispatcherClass:Class, parserClass:Class, mode:String=MODE_LIVE, mockClass:Class=null) {
			__type = type;
			__uri = uri;
			__source = source;
			__parserClass = parserClass;
			__dispatcherClass = dispatcherClass;
			__mockClass = mockClass;
			__mode = mode;
			
			// Mark as created
			create();
		}
		
		/**
		 * <p>Defines the type of request. A type's purpose is defined
		 * by child classes in conjunction with the associated dispatcher and it's required usage 
		 * of the type property. </p>
		 * 
		 * <p>NOTE: This property is read-only and defined 
		 * via the constructor.</p>
		 * 
		 * @return String The type  defined on this request
		 */
		public function get type():String {
			return __type;	
		}
		/**
		 * Defined the uri for this request. A uri's usage is to be defined
		 * by child classes with a direct correlation with the associated dispathcer and it's required usage.  
		 * 
		 * <p>NOTE: This property is read-only and defined 
		 * via the constructor.</p>
		 * 
		 * @returns String URI for this request
		 */
		public function get uri():String {
			return __uri;
		}
		
		/**
		 * Property defining the source of this request. The source's usage is defined
		 * but child classes in conjunction with the referenced dispatcher class and it's usage.
		 * 
		 * @return String Source of the request
		 */ 
		public function get source():String {
			return __source;
		}
		
		/**
		 * Class reference to the parser used to parse the request's raw data into application an
		 * application specific format.
		 *
		 * @return Class Class reference to an IParser.
		 */
		public function get parserClass():Class {
			return __parserClass;
		}
		
		/**
		 * Class reference to the dispatcher used to dispatch the request. The dispatcher encapsulates a
		 * paticular service and executes the request based on the state of the request.
		 * 
		 * @return Class Class reference to an IDispatcher
		 */
		public function get dispatcherClass():Class {
			return __dispatcherClass;
		}
		
		
		public function get params():Object {
			return __params;
		}
		/**
		 * Returns an object defining a set of parameters used to execute the request.
		 * 
		 * @return Object An object paticular to the child classes of this class.
		 */
		public function set params(value:Object):void {
		    __params = value;
		}
		
		/**
		 * The current phase the request lifeccyle that a paticular request is currently in.
		 * 
		 * @return String The current phase.
		 */
		public function get phase():String {
			return currentPhase;
		}
		
		/**
		 * The current mode of the application. Default is MOCK_LIVE
		 * 
		 * @return String Mock mode.
		 */
		public function get mode():String {
			return __mode;
		}
		
		/**
		 * Reference to the IMockDispatcher used to mock this disptacher.
		 * 
		 * @return Class Class reference to IMockDispatcher.
		 */
		public function get mockClass():Class {
			return __mockClass;
		}
		
// Dispatch methods
		/**
		 * Method executes this request based on the given dispatcher and parser. The method
		 * has direct communcication with the RequestDelegate.
		 */
		public function start():void {
			RequestDelegate.start(this);
		}
		
		/**
		 * Method attempts to stop this request by communicating with the RequestDelegate
		 */
		public function stop():void {
			RequestDelegate.stop(this);
		}
		
// PHASE EVENTS
		/**
		 * <p>The method sets the current phase to RequestEvent.CREATE marking that request has been created. The method will
		 * also dispatch a RequestEvent.CREATED.</p>
		 * 
		 * <p>
		 * NOTE: Method is not to be called outside of this class, it's children or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed during creation of a request, overrideing this method is acceptable, but be 
		 * sure to call super.create() to insure the phase is set and the event is dispatched.
		 * </p>
		 */ 
		public function create():void {
			currentPhase = RequestEvent.CREATED;
			dispatchEvent(new RequestEvent(RequestEvent.CREATED));
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegate when a request has been sent to it's dispatcher.
		 * The method sets the current phase to RequestEvent.DIPATCHED marking that request has been dispatched. The method will
		 * also dispatch a RequestEvent.DIPATCHED event updating all listeners.</p>
		 * 
		 * <p>
		 * NOTE: Method should not to be called outside of this class, it's children or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed  after a request has been dispatched, overrideing this method is acceptable, but be 
		 * sure to call super.dispatch() to insure the phase is set and the event is dispatched.
		 * </p>
		 */ 
		public function dispatch():void {
			currentPhase = RequestEvent.DISPATCHED;
			dispatchEvent(new RequestEvent(RequestEvent.DISPATCHED));
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegate when a dispatcher has returned with a result from the request.
		 * The method sets the current phase to RequestEvent.RETURNED marking that request has been returned successfully. The method will
		 * also dispatch a RequestEvent.RETURNED event updating all listeners.</p>
		 * 
		 * <p>
		 * NOTE: Method should not to be called outside of this class, it's children or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed  after a request has been returned, overrideing this method is acceptable, but be 
		 * sure to call super.returned() to insure the phase is set and the event is dispatched.
		 * </p>
		 */ 
		public function returned():void {
			currentPhase = RequestEvent.RETURNED;
			dispatchEvent(new RequestEvent(RequestEvent.RETURNED));
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegate when the raw data from a request is being parsed.
		 * The method sets the current phase to RequestEvent.PARSING marking that request is currently in the parsing stage. The method will
		 * also dispatch a RequestEvent.PARSING event updating all listeners.</p>
		 * 
		 * <p>
		 * NOTE: Method should not to be called outside of this class, it's children or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed  when a request enters the parsing phase, overrideing this method is acceptable, but be 
		 * sure to call super.parsing() to insure the phase is set and the event is dispatched.
		 * </p>
		 */ 		
		public function parsing():void {
			currentPhase = RequestEvent.PARSING;
			dispatchEvent(new RequestEvent(RequestEvent.PARSING));
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegate when a request is cancled.
		 * The method sets the current phase to RequestEvent.CANCEL marking that request has been canceled. The method will
		 * also dispatch a RequestEvent.CANCEL event updating all listeners.</p>
		 * 
		 * <p>
		 * NOTE: Method should not to be called outside of this class, it's children or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed  after a request has been canceled, overrideing this method is acceptable, but be 
		 * sure to call super.cancel() to insure the phase is set and the event is dispatched.
		 * </p>
		 */ 
		public function cancel():void {
			currentPhase = RequestEvent.CANCEL;
			dispatchEvent(new RequestEvent(RequestEvent.CANCEL));
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegates when the Request's dispatcher faults.
		 * The RequestDelegate will bundle the orignal event from the service that is encapsulated inside of the Dispatcher and pass it to this method.  The method will create a new 
		 * RequestEvent of type FAILURE and add the original event and then dispatch. The current phase will also be changed to Failure.</p>
		 * <p>
		 * If more functionality is needed  after a request has failed, overrideing this method is acceptable, but be 
		 * sure to call super.failure() to insure the phase is set and the event is dispatched.
		 * </p>
		 * 
		 * @param originalEvent Event of the originating fault event from the dispatcher.
		 */ 
		public function failure(originalEvent:Event):void {
			currentPhase = RequestEvent.FAILURE;
			
			var event:RequestEvent = new RequestEvent(RequestEvent.FAILURE);
			event.originalEvent = originalEvent;
			
			dispatchEvent(event);
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegate when a request has errored while parsing the raw data of a resulting Request.
		 * The method sets the current phase to RequestEvent.ERROR marking that request has experienced an error. The method will
		 * dispatch a RequestEvent.ERROR event updating all listeners, providing the original Error object.</p>
		 * 
		 * <p>
		 * NOTE: Method should not to be called outside of this class, it's children, or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed  after a request has errored, overrideing this method is acceptable, but be 
		 * sure to call super.error() to insure the phase is set and the event is dispatched.
		 * </p>
		 * 
		 * @param error Error from the origin.
		 */ 
		public function error(originalError:Error):void {
			currentPhase = RequestEvent.ERROR;
			
			var event:RequestEvent = new RequestEvent(RequestEvent.ERROR);
			event.originalError = originalError;
			
			dispatchEvent(event);
		}
		
		/**
		 * <p>This method is invoked through the RequestDelegate when a request has completed its parsing and has succcessfully saved it's data to the application.
		 * The method sets the current phase to RequestEvent.COMPLETE marking that request has been completed. The method will
		 * also dispatch a RequestEvent.COMPLETE event updating all listeners.</p>
		 * 
		 * <p>
		 * NOTE: Method should not to be called outside of this class, it's children or the RequestDispatcher.
		 * </p>
		 * 
		 * <p>
		 * If more functionality is needed  after a request has been completed, overrideing this method is acceptable, but be 
		 * sure to call super.complete() to insure the phase is set and the event is dispatched.
		 * </p>
		 */ 
		public function complete():void {
			currentPhase = RequestEvent.COMPLETE;
			dispatchEvent(new RequestEvent(RequestEvent.COMPLETE));
		}
		/**
		 * Method takes the parsed data and saves it to the appropriate area of the application.
		 * This method must be overriden by children classes or an error will be thrown.
		 * 
		 * @para * Object to be saved to the application.
		 */
		public function saveData(data:*):void {
			throw new Error("Must be implemented by child class");
		}
	}
}