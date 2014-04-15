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
	 * The ExternalInterfaceDebugLogger is proxy object for the DebugLogger.  When using the DebugLogger
	 * and you wish to pass in calls from JS information, use the ExternalInterfaceDebugLogger in-place 
	 * of referencing the DebugLogger.  This enables you to define the class and method information to be passed
	 * onto the DebugLogger and defines the type as JavaScript.
	 * 
	 * <p>This information can be provided directly to the DebugLogger, but this Class provides 
	 * convenience methods to make this easier to use.</p>
	 * 
	 * @author Aaron Pedersen
	 * 
	 */
	public class ExternalInterfaceDebugLogger
	{
		
		/**
		 * Constructor.
		 * 
		 */
		public function ExternalInterfaceDebugLogger()
		{
		}
		
		/**
		 * @see DebugLogger.info
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param methodReference The method in which the message was generated. Optional
		 * 
		 */
		public static function info(message:String, classReference:String = "", method:String = ""):void {
			if(DebugLogger.externalInterfaceEnabled) {
				DebugLogger.info(message, classReference, method, DebugMessage.SOURCE_JAVASCRIPT);
			}
		}
		
		/**
		 * @see DebugLogger.debug
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public static function debug(message:String, classReference:String = "", method:String = ""):void {
			if(DebugLogger.externalInterfaceEnabled) {
				DebugLogger.debug(message, classReference, method, DebugMessage.SOURCE_JAVASCRIPT);
			}
		
		}
		
		/**
		 * @see DebugLogger.warn
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public static function warn(message:String, classReference:String = "", method:String = ""):void {
			if(DebugLogger.externalInterfaceEnabled) {
				DebugLogger.warn(message, classReference, method, DebugMessage.SOURCE_JAVASCRIPT);
			}
		
		}
		
		/**
		 * @see DebugLogger.debug
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public static function error(message:String, classReference:String = "", method:String = ""):void {
			if(DebugLogger.externalInterfaceEnabled) {
				DebugLogger.error(message, classReference, method, DebugMessage.SOURCE_JAVASCRIPT);
			}
		
		}
		
		/**
		 * @see DebugLogger.fatal
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public static function fatal(message:String, classReference:String = "", method:String = ""):void {
			if(DebugLogger.externalInterfaceEnabled) {
				DebugLogger.fatal(message, classReference, method, DebugMessage.SOURCE_JAVASCRIPT);
			}
		
		}
		
	}
}