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
package com.developmentarc.core.services.events
{
	import flash.events.Event;

	/**
	 * Event class used by the Dispatcher portion of the service layer. Events are fired 
	 * when a dispatcher has either a success return of data from the service or whena  failure has occured.
	 * 
	 * @author Aaron Pedersen
	 */
	public class DispatcherEvent extends Event
	{
		public static const RESULT:String = "dispatcherResult";
		public static const FAULT:String = "dispatcherFault";
		
		/**
		 * Unique id of the request.
		 */
		public var uid:*;
		
		/**
		 * Resulting data from the returned request.
		 */
		public var result:Object;
		
		/**		
		 * Event that might have been dispatched by the encapsulated service. 
		 */
		public var originalEvent:Event;
		
		/**
		 * Constructor
		 */
		public function DispatcherEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}