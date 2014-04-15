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
package com.developmentarc.core.utils.logging
{
	/**
	 * The DebugMessage is used for the CachedLogging System to pass messages
	 * from the Debug application to the Debug Log panel AIR application.  This
	 * message contains important information about the broadcasted message used for
	 * display and tracking purposes in the Debug Logger panel.
	 * 
	 * @author James Polanco
	 * 
	 */
	public class DebugMessage
	{
		// CONSTANT TYPES
		/**
		 * Defines the Message as Informational, which is the lowest priority of the message types. 
		 */
		static public const INFO:int = 0;
		
		/**
		 * Defines the Message as Debugging, which is the 2nd lowest priority of the message types.  
		 */		
		static public const DEBUG:int = 1;
		
		/**
		 * Defines the Message as Warning, which is the 3rd highest priority of the message types.  
		 */
		static public const WARN:int = 2;
		
		/**
		 * Defines the Message as an Error, which is the 2nd highest priority of the message types.  
		 */
		static public const ERROR:int = 3;
		
		/**
		 * Defines the Message as Fatal, which is the highest priority of the message types.  
		 */
		static public const FATAL:int = 4;
		
		// SPECIAL MESSAGE TYPES
		/**
		 * Used to define the initial handshake message used by the DebugLogger. 
		 */
		static public const HANDSHAKE:int = 200;
		
		/**
		 * Used to define an internal system message for the DebugLogger. 
		 */
		static public const SYSTEM_MESSAGE:int = 201;
		
		// SOURCE TYPES
		/**
		 * Defines the source type of the message as ActionScript. 
		 */
		static public const SOURCE_ACTIONSCRIPT:String = "AS";
		
		/**
		 * Defines the source type of the message as JavaScript. 
		 */		
		static public const SOURCE_JAVASCRIPT:String = "JS";
		
		/**
		 * Store the time of the message creation. 
		 */
		public var time:Date;
		/**
		 * Stores the user message broadcasted by the Debug call. 
		 */		
		public var message:String;
		/**
		 * Stores the type of the message.  This value is one of the default
		 * message constants defined above.
		 */
		public var type:int;
		/**
		 * Stores a unique id of the message. 
		 */		
		public var id:String;
		/**
		 * Stores the class name of the broadcasting Debug call. 
		 */		
		public var className:String;
		/**
		 * Stores the source type.  This is one of the source type constants. 
		 */		
		public var sourceType:String;
		/**
		 * Stores the name of the method that called the Debugger. 
		 */		
		public var methodName:String;
		
		/**
		 * Creates a new debug message that is used to pass data from the DebugLogger to the fLogger UI tool.
		 *  
		 * @param msg Text message to display in the UI.
		 * @param msgType The message level.
		 * @param classReference The class in which the message wwas generated. Optional
		 * @param methodReference The method in which the message was generated. Optional
		 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional
		 * @param passedTime The time the message stores as the creation time.
		 * 
		 */
		public function DebugMessage(msg:String = "", msgType:int = 0,classReference:* = null, methodReference:String = null, source:String = null, passedTime:Date = null)
		{
			super();
			message = msg;
			type = msgType;
			
			if(classReference is Class) {
				className = Object(classReference).valueOf();
				className = className.replace(/(\[class|\]|\s)/g, "");
			}
			else {
				className = classReference;
			}		
			
			methodName = methodReference;
			sourceType = (source) ? source : DebugMessage.SOURCE_ACTIONSCRIPT;
			
			if(time)
			{
				// set the time
				time = passedTime; 
			} else {
				// use the creation as the time
				time = new Date();
			}
		}

	}
}