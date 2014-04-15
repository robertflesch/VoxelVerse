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
	import mx.rpc.http.HTTPService;
	
	/**
	 * <p>Class provides an extension from the AbstractRequest to handle HTTPService requests.
	 * On top of the AbstractRequest properties this request provides  additional ones, to describe
	 * specifc properties on the HTTPService. Those include the method of the HTTPService (GET or POST), 
	 * the content type (see HTTPService), and a boolean to toggle showing the Flex busy cursor during the 
	 * request's communication with the server.</p>
	 * 
	 * <p>* NOTE: HTTPRequest is Flex specific and you will need the Flex 3.0+ SDK.</p>
	 * 
	 * <p>Although it is not marked as the default, the HTTPRequestDisptacher has been build to be used with this class
	 * to provide a seemless solution for the HTTPService.</p>
	 * 
	 * <p>This class can be used as is to create dynamic requests in an application or can be extended to 
	 * provide static requests that can either define a single API or an entire domain service.  The latter is 
	 * DevelopmentArc's prefered method of architecture, because it provides a single point of construction for a request and 
	 * modification can easily be made din that single location.</p>
	 * 
	 * 
	 * @see mx.rpc.http.HTTPService;
	 * 
	 * @author Aaron Pedersen
	 */
	public class HTTPRequest extends AbstractRequest
	{
		public static const METHOD_GET:String = "GET"; // GET
		public static const METHOD_POST:String = "POST"; // POST
		/*
		CURRENTLY NOT SUPPORTED, since most browsers do not support
		public static const METHOD_HEAD:String = "HEAD"; // GET 
		public static const METHOD_OPTIONS:String = "OPTIONS"; // GET
		public static const METHOD_PUT:String = "PUT" // POST
		public static const METHOD_TRACE:String = "TRACE"; 
		public static const METHOD_DELETE:String = "DELETE"; // POST
		*/
   		public static const CONTENT_TYPE_XML:String = "application/xml";
    	public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
		
		// Private get/set properties
		/**
		 * @private
		 * Method of the given HTTPService request.
		 */
		private var __method:String;
		
		/**
		 * @private
		 * Content Type to use when sending the HTTPSerivce request.
		 */
		private var __contentType:String;
		
		/**
		 * @private 
		 * Flag specificying whether or not the busy cursor should be shown during the 
		 * HTTPSerivce Request.
		 */
		private var __showBusyCursor:Boolean;
		
		/**
		 * Constructor
		 * 
		 * @param type String used to define a specific type this request will be. HTTPRequest does not use this. Extend to implement usage.
		 * @param uri String for root url of the service request
		 * @param source String defines the source of the url. Useful when defining a specific API.
		 * @param dispathcerClass Class reference to the dispatcher used by this request.
		 * @param parserClass Class reference to the parser used to translate raw data from the result of this request in to application specific data.
		 * @param method String used to define the HTTPService method used. Default is METHOD_GET.
		 * @param contentType String defines the content type of the HTTPService.  Default is CONTENT_TYPE_FORM.
		 * @param showBusyCursor Boolean flag marking if the busy cursor is to be shown during the HTTPService request. Default is false.
		 */
		public function HTTPRequest(type:String, uri:String, source:String, dispatcherClass:Class, parserClass:Class, mode:String=AbstractRequest.MODE_LIVE, mockDispatcher:Class=null, method:String=METHOD_GET, contentType:String=CONTENT_TYPE_FORM, showBusyCursor:Boolean=false)
		{
			__method = method;
			__contentType = contentType;
			__showBusyCursor = showBusyCursor;
			super(type, uri, source, dispatcherClass, parserClass, mode, mockDispatcher);
		}
		
		/**
		 * Method of the HTTPService for this paticular request.
		 * 
		 * <p>Note: Property is read-only and can only be set via the constructor</p>
		 * 
		 * @return String. Values can be METHOD_GET or METHOD_POST.  Default is METHOD_GET.
		 */
		public function get method():String {
			return __method;
		}
		
		/**
		 * Content type the HTTPService for this request.
		 * 
		 * <p>Note: Property is read-only and can only be set via the constructor</p>
		 * 
		 * @param String. See HTTPService for avaible options.
		 */
		public function get contentType():String {
			return __contentType;
		}
		
		/**
		 * Boolean describing if the busy cursor should be shown
		 * when this request is proccessed.
		 * 
		 * <p>Note: Property is read-only and can only be set via the constructor</p>
		 * 
		 * @return Boolean. Default is false.
		 */
		public function get showBusyCursor():Boolean {
			return __showBusyCursor;
		}
		
	}
}