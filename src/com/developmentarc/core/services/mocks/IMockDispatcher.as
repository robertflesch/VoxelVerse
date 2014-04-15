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
	import com.developmentarc.core.services.parsers.IParser;
	import com.developmentarc.core.services.requests.IRequest;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface defines the API for a mock dispatcher. 
	 * The responsibility of a mock dispatcher is to fake a dispatcher to a given service and
	 * return data in the same format that the request's parser is expecting.
	 * 
	 * @see com.developmentarc.core.services.mocks.AbstractMockDispatcher AbstractMockDispatcher 
	 * 
	 * @author Aaron Pedersen
	 */
	public interface IMockDispatcher extends IEventDispatcher
	{
		/**
		 * Method fakes a dispatch of the provided request providing a result data in 
		 * the same format as the request's associated parser.
		 * 
		 * @param request IRequest to fake.
		 * @param parser IParser used to keep the same API as IDispatcher.
		 * 
		 * @returns Unique ID of the request after it has been dispatched.
		 */
		function dispatch(request:IRequest, parser:IParser):*;
		
		/**
		 * Method fakes a cancel of a given request.
		 * 
		 * @param request IRequest to cancel
		 * @param key * Unique ID of the request when it was dispatched.
		 */
		function cancel(request:IRequest, key:*):void;		
	}
}