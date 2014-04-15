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
package com.developmentarc.core.actions.commands
{
	import com.developmentarc.core.utils.EventBroker;
	
	import flash.events.Event;

	/**
	 * The AbstractCommand is a base class for any extending Command.  The AbstractCommand
	 * adds a dispatch() helper method to make command dispatching easier.
	 *  
	 * @author James Polanco
	 * 
	 */
	public class AbstractCommand extends Event
	{
		/**
		 * Constructor.
		 *  
		 * @param type The type of command.
		 * 
		 */
		public function AbstractCommand(type:String)
		{
			super(type, false, false);
		}
		
		/**
		 * Dispatches the command through the EventBroker which will
		 * then be passed to any registered action. 
		 * 
		 */
		public function dispatch():void {
			EventBroker.broadcast(this);
		}
		
	}
}