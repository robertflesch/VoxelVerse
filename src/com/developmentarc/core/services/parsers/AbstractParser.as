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
	import flash.events.EventDispatcher;
	
	[Event(name="parseResult",type="com.developmentarc.core.services.events.DispatcherEvent")]
	[Event(name="parseFault",type="com.developmentarc.core.services.events.DispatcherEvent")] 
	/**
	 * <p>Class provides a base for all parsers in the service layer of an application. A parser
	 * is responsible for taking raw data in a paticular format and translating it into 
	 * an applicaiton specific format. </p>
	 * 
	 * <p>Each parser can define a result format, which is not required but useful and necessary in some instances.
	 * An example is when a parser is used with a HTTPRequestDispatcher class, which encapsulates a HTTPService class, which requires
	 * a parser to define the resultformat of the data to be returned from the service.  Other uses of the result format is to check the raw
	 * data returned making sure it is the format expected, however this type of logic must be defined in a custom parser and is not provided in
	 * this class.</p>
	 * 
	 * 
	 * @see com.developmentarc.core.services.delegates.AbstractDelegate AbstractDelegate
	 * @see com.developmentarc.core.services.RequestDispatcer.
	 * 
	 * @author Aaron Pedersen
	 */
	public class AbstractParser extends EventDispatcher implements IParser
	{
		
		public static const RESULT_FORMAT_OBJECT:String = "object";
		public static const RESULT_FORMAT_ARRAY:String = "array";
		public static const RESULT_FORMAT_XML:String = "xml";
		public static const RESULT_FORMAT_E4X:String = "e4x"
		public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
		public static const RESULT_FORMAT_TEXT:String = "text";
		
		/**
		 * @private
		 * 
		 * Defines the result format expected by this parser
		 */
		private var __resultFormat:String;
		
		/**
		 * Constructor, takes a result format with a default of RESULT_FORMAT_OBJECT
		 */
		public function AbstractParser(resultFormat:String=RESULT_FORMAT_OBJECT) {
			__resultFormat = resultFormat;
		}
		
		/**
		 * Returns the result format for this parser.
		 */
		public function get resultFormat():String {
			return __resultFormat;
		}
		
		/**
		 * Method accepts raw data and is translated into application specific data format.
		 * Method must be defined by child class or an error will occur
		 * 
		 * @param * Raw data
		 * 
		 * @return * Application specific data
		 */
		public function parse(data:*):* {
			throw new Error("Must be implemented by child class");
		}

	}
}