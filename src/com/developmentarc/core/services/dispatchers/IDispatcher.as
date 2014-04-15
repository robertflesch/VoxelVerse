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
	import com.developmentarc.core.services.parsers.IParser;
	import com.developmentarc.core.services.requests.IRequest;
	
	import flash.events.IEventDispatcher;
	
	/**	
	 * <p>Interface is used to define the standard API for a dispatcher in DevelopmentArc's
	 * service layer. The purpose of a dispatcher is to encapsulate a service instance and reuse that
	 * instance for the life of the application lifecycle.  A dispatcher's task is to use the given Request and use it's provided
	 * data along with it's parser to construct and execute a service call. The implementing class is
	 * responsible for listening to the service events and upon a success or failure respond dispatch a DispatcherEvent informing 
	 * the system of the result.</p>
	 * 
	 * @author Aaron Pedersen
	 */ 
	public interface IDispatcher extends IEventDispatcher
	{
		/**
		 * Method is used to dispatch a request based on the provided request and parser.
		 *
		 * @param request IRequest defining information needed to execute the service request.
		 * @param parser IParser provided in case information off the parser is needed to define and execute the service request.
		 * 
		 * @returns * An unique id marking the request.
		 */
		function dispatch(request:IRequest, parser:IParser):*;
		
		/**
		 * Method used to cancle a request once is has already been dispatched.
		 * 
		 * @param request IRequest to be canceled.
		 * @param * Unique id used to define the request in the dispatcher.
		 */
		function cancel(request:IRequest, key:*):void;

	}
}