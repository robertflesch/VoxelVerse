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
package com.developmentarc.core.services.parsers
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface is used to define the standard api for a parser in DevelopmentArc's service layer.
	 * A parser is responsible for taking raw data from a request and translating that data into
	 * an application specific format.
	 *
	 * @author Aaron Pedersen
	 */
	public interface IParser extends IEventDispatcher
	{
		/**
		 * Property defines the expected format of the raw data from the request.
		 * 
		 * @return String Result format of the raw data.
		 */
		function get resultFormat():String;
		
		/**
		 * Method is called when raw data is returned from a request's dispatcher and needs to be parsed into 
		 * an application specific format.
		 * 
		 * @param * Raw data of any type.Type is defined by implementor
		 * 
		 * @return * Application specific data format based on raw data passed in.
		 */ 
		function parse(data:*):*;
	}
}