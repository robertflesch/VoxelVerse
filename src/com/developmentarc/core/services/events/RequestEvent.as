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
	 * <p>Request events are thrown at various points of a request's life cycle.  As 
	 * a request moves through phase of the service layer's system, events will be dispatched
	 * informing all listeners of the current state of that request.  See the RequestDispatcher for
	 * details on the request lifecycle.</p>
	 * 
	 * @see com.developmentarc.core.services.RequestDelegate RequestDelegate
	 * 
	 * @author Aaron Pedersen
	 */
	public class RequestEvent extends Event
	{
		public static const CREATED:String = "created";
		public static const DISPATCHED:String = "dispatched";
		public static const RETURNED:String = "returned";
		public static const PARSING:String = "parsing";
		public static const CANCEL:String = "cancel";
		public static const FAILURE:String = "failure";
		public static const ERROR:String = "error";
		public static const COMPLETE:String = "complete";
		
		/**
		 * Original Event. Used for type FAILURE
		 */
		 public var originalEvent:Event;


		/**
		 * Original Error. Used for type ERROR.
		 */
		public var originalError:Error;	

		/**
		 * Constructor
		 */
		public function RequestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}