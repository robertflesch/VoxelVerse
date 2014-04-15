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
	 * The Class Debug Logger is proxy object for the DebugLogger.  When using the DebugLogger
	 * and you wish to pass in Class information, use the ClassDebugLogger in-place of referencing
	 * the DebugLogger.  This enables you to define the class and method information to be passed
	 * onto the DebugLogger.
	 * 
	 * <p>This information can be provided directly to the DebugLogger, but this Class provides 
	 * convenience methods to make this easier to use.</p>
	 * 
	 * @author Aaron Pedersen
	 * 
	 */
	public class ClassDebugLogger
	{
		private var _class:Class;
		
		/**
		 * Constructor.
		 *  
		 * @param classReference The class that is calling the ClassDebugLogger.
		 * 
		 */
		public function ClassDebugLogger(classReference:Class)
		{
			_class = classReference;
		}
		
		/**
		 * @see DebugLogger.info
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param methodReference The method in which the message was generated. Optional
		 * 
		 */
		public function info(message:String, method:String = ""):void
		{
			DebugLogger.info(message, _class, method);
		}
		
		/**
		 * @see DebugLogger.debug
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public function debug(message:String, method:String = ""):void
		{
			DebugLogger.debug(message, _class, method);
		}
		
		/**
		 * @see DebugLogger.warn
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public function warn(message:String, method:String = ""):void
		{
			DebugLogger.warn(message, _class, method);
		}
		
		/**
		 * @see DebugLogger.error
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public function error(message:String, method:String = ""):void
		{
			DebugLogger.error(message, _class, method);
		}
		
		/**
		 * @see DebugLogger.fatal
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param method The method in which the message was generated. Optional
		 * 
		 */
		public function fatal(message:String, method:String = ""):void
		{
			DebugLogger.fatal(message, _class, method);
		}

	}
}