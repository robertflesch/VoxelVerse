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
package com.developmentarc.core.services.dispatchers
{
	import com.developmentarc.core.services.events.DispatcherEvent;
	import com.developmentarc.core.services.parsers.IParser;
	import com.developmentarc.core.services.requests.HTTPRequest;
	import com.developmentarc.core.services.requests.IRequest;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	

	/**
	 * <p>Class defines a dispatcher that wraps an instance of the HTTPService class provided by flex.  This class should be 
	 * used for any HTTPService calls made in the serivce layer. The goal is to provide one HTTPService, 
	 * that all requests can use to execute their required call.</p>
	 * 
	 *  <p>* NOTE: HTTPRequest is Flex specific and you will need the Flex 3.0+ SDK.</p>
	 * 
	 * <p>When using this dispatcher a HTTPRequest or an extension is necessary to provide the method and content type of
	 * the incoming request which will be leveraged by the HTTPService.</p>
	 * 
	 * <p>
	 * <b>Events</b>
	 * <br />
	 * <p>A DispatcherEvent.RESULT is dispatched upon a successful response from the HTTPService.  The dispatcher bundles
	 * the unique id of the request, the resulting data, and the original event.</p>
	 * 
	 * <p>Upon a failure of the HTTPService, a DispatcherEvent.FAULT is dispathced with the unique id and the original event.</p>
	 * 
	 * @author Aaron Pedersen
	 */
	public class HTTPRequestDispatcher extends AbstractDispatcher
	{
		// Private properties
		/**
		 * Instance of the HTTPService
		 */
		protected var service:HTTPService;
			
		/**
		 * Constructor creates instance of HTTPService and listens to 
		 * ResultEvent.RESULT and  FaultEvent.FAULT events on the service
		 */
		public function HTTPRequestDispatcher()
		{
			super();
			service = new HTTPService();
			service.addEventListener(ResultEvent.RESULT, handleResult);
			service.addEventListener(FaultEvent.FAULT, handleFault);
		}
		
		/**
		 * <p>Method takes the given request (IRequest) and parser (IParser) and updates the HTTPService
		 * with the unique data of the request. The parser is important because it defines the resultFormat 
		 * of the data passed back from the service.</p>
		 * 
		 * <p>For Post requests, the requests parameters (request.params) is assigned to the request property of the service, otherwise for 
		 * Get requests, the parameters are turned into a query string and appended to the end of the url.</p>
		 * 
		 * <p>The url will be made up of the request's uri and source properties and the querystring if a Get.</p>
		 * 
		 * @param request IRequest for the desired request.
		 * @param parser IParser associated with the provied request.
		 * 
		 * @return * AsyncToken provided when calling send on the HTTPService
		 */
		override public function dispatch(request:IRequest, parser:IParser):* {
			// Properties from request

			service.method = HTTPRequest(request).method;
			service.contentType = HTTPRequest(request).contentType;
			service.url = request.uri + request.source;
			
			if(service.method == HTTPRequest.METHOD_GET) {
				// Build query string key / value pairs
				service.url += buildQueryString(request.params);
				service.request = null;
			}
			else {
				service.request = request.params;
			}
			// Properties from parser
			service.resultFormat = parser.resultFormat;
			
			// Send service
			return service.send();
		}
		
		/**
		 * Method cancels a given request based on the AsyncToken that is provided.
		 * 
		 * @param request IRequest Not used in this implementation
		 * @param * AsyncToken Unique id of the request to cancel.
		 */
		override public function cancel(request:IRequest, key:*):void {
			service.cancel(AsyncToken(key).message.messageId);
		}
		
		/**
		 * Method handles ResultEvent.RESULT events that are dispatched from the HTTPService.
		 * The method will take the event token (AsyncToken), result data and the original event
		 * and bundle it inside of a DispatcherEvent with a type of RESULT and dispatch.
		 * 
		 * @param event ResultEvent from a given request.
		 */
		protected function handleResult(event:ResultEvent):void {
			var dispatcherEvent:DispatcherEvent = new DispatcherEvent(DispatcherEvent.RESULT);
			// Mapping origin event to new event
			dispatcherEvent.uid = event.token;
			dispatcherEvent.result = event.result;
			dispatcherEvent.originalEvent = event;
			
			dispatchEvent(dispatcherEvent);
		}
		/**
		 * method handles FaultEvent.FAULT events that are dispatched from the HTTPService.
		 * The method will map the event token (AsyncToken) and the original event to a new 
		 * DispatcherEvent with a type of FAULT and dispatch.
		 * 
		 * @param event FaultEvent from a given request.
		 */
		protected function handleFault(event:FaultEvent):void {
			var dispatcherEvent:DispatcherEvent = new DispatcherEvent(DispatcherEvent.FAULT);
			// Mapping origin event to new event
			dispatcherEvent.uid = event.token;
			dispatcherEvent.originalEvent = event;
			dispatchEvent(dispatcherEvent);
		}
		
		/**
		 * Method task an object into a query string. Format will be
		 * "?var1=value1&var2=value2".
		 * 
		 * @param parameters Object to be converted.
		 */
		public static function buildQueryString(parameters:Object):String {
			 // build the param list
            var count:int = 0;
            var str:String = "";
            for(var param:String in parameters) {
                var prefix:String = (count > 0) ? "&" : "?";
                str += prefix + param + "=" + parameters[param];
                count++;
            }
            return str;
		}
	}
}