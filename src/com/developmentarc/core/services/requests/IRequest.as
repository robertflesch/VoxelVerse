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
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * <p>The ITask interface allows the implemented class to be treated
	 * as a Request object allowing for it to be used through
	 * DevelopmentArc's service layer via the RequestDelegate.</p>
	 * 
	 * <p>A mock API is also build-in allowing for a service's result to be mocked up in the case a service is not yet completed.</p>
	 *  
	 * @see com.developmentarc.core.services.requests.AbstractRequest AbstractRequest
	 * 
	 * @author Aaron Pedersen
	 */
	public interface IRequest extends IEventDispatcher
	{
		
		/**
		 * Property supply's the type of request
		 * 
		 * @return String Type of request.
		 */
		function get type():String;
		
		/**
		 * Root address of the request.
		 * 
		 * @return String uri.
		 */
		function get uri():String;
		
		/**
		 * Source of the request, used with the uri to make up a specific address.
		 * 
		 * @return String Source path.
		 */
		function get source():String;
		
		/**
		 * Class reference to the parser class used to parse this request's data
		 * 
		 * @return Class Class Reference to IParser implementation .
		 */
		function get parserClass():Class;
		
		/**
		 * Class reference to the dispatcher class used to dispatch this request.
		 * 
		 * @return Class Class reference to a IDispatcher implementation 
		 */
		function get dispatcherClass():Class;
		
		/**
		 * Object storing parameters used in this requests.
		 * 
		 * @return Object Parameters
		 */
		function get params():Object;
		
		/**
		 * Defines the current phase this request is in.
		 *
		 * @return String Current phase		 
		 */
		function get phase():String;
		
		/**
		 * The current mode the dispatcher is in; mock or live.
		 */
		function get mode():String;
		
		/**
		 * Class refernce to a IMockDispatcher used to mock up data to imitate a real service request
		 * 
		 * @return Class Class reference to IMockDispatcher implementation
		 */
		function get mockClass():Class;
		
		/**
		 * Starts request.
		 */
		function start():void;
		
		/**
		 * Stops request.
		 */
		function stop():void;
		
		/**
		 * Marks request has been created
		 */
		function create():void;
		
		/**
		 * Marks a request has been canceled
		 */
		function cancel():void;
		
		/**
		 * Marks a request has been dispatched via the dispatcher
		 */
		function dispatch():void;
		
		/**
		 * Marks a request has returned from the dispatcher successfully
		 */
		function returned():void;
		
		/**
		 * Marks a request's data is being parsed.
		 */
		function parsing():void;
		
		/**
		 * Marks a request has errored during the dispatching of the request.
		 */
		function failure(originalEvent:Event):void;
		
		
		/**
		 * Marks a request has errored during parsing of the result raw data
		 */
		function error(originalError:Error):void;
		
		/**
		 * Marks a request has completed its parsing and has saved it's data
		 */
		function complete():void;
		
		/**
		 * Method is called when data has been parsed and needs to be saved.
		 * It's up to the request to save the data in the appropriate location.
		 */
		function saveData(data:*):void;
	}
}