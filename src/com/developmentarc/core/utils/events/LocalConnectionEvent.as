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
package com.developmentarc.core.utils.events
{
	import flash.events.Event;

	/**
	 * The LocalConnectionEvent is used by the LocalConnectionManager as a single communication Event to handle
	 * the basic events that can occur duing use.  This Event type helps consolidate the different events that
	 * are dispatched by the Flash LocalConnection.
	 * 
	 * @author jpolanco
	 * @version 0.1
	 */
	public class LocalConnectionEvent extends Event
	{
		/**
		* Dispatched when the LocalConnectionManager can not connect to the requested application name.  This is usually
		* caused by another application already connected via the provided name.
		*/
		static public const CONNECTION_ERROR:String = "CONNECTION_ERROR";
		
		/**
		* When a message can not be sent properly by the LocalConnectionManager this error is dispatched.  If the error
		* is caused by a callback from another application using the LCM protocol then the event will contain details
		* about the cause of the error.
		*/
		static public const SENT_MESSAGE_ERROR:String = "SENT_MESSAGE_ERROR";
		
		/**
		* Dispatched when a status message has been sent.
		*/
		static public const STATUS_MESSAGE:String = "STATUS_MESSAGE";
		
		/**
		* Contains the error message that has been generated or received.
		*/
		public var errorMessage:String;
		
		/**
		* Stores the error ID if provided.
		*/
		public var errorID:int;
		
		/**
		* Stores the sting verison of the status message that contains the instance name that reported the error.
		*/
		public var statusMessage:String;
		
		/**
		* Contains the simple status string.
		*/
		public var status:String;
		
		/**
		* Contains the status code for a status message.
		*/
		public var statusCode:String;
		
		/**
		 * Constructor.  Same as the base Event Class.
		 * 
		 * @param type The Event Type
		 * @param bubbles Defines if the event should bubble.
		 * @param cancelable Defines if the event can be cancelled.
		 * 
		 */
		public function LocalConnectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}