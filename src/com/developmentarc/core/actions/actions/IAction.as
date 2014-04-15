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
package com.developmentarc.core.actions.actions
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * The IAction represents the basics of a simple Action that is
	 * used by the ActionDelegate and Command structure.
	 * 
	 * @author James Polanco
	 * 
	 */
	public interface IAction extends IEventDispatcher
	{
		/**
		 * This method is called by the EventBroker when a registerd
		 * command has been broadcasted.  The argument type is set to
		 * Event which is the base class of the AbstractCommand.  The
		 * EventBroker can dispatch both Events and Commands to an Action
		 * depending on how the action was registered to the command.
		 * 
		 * @param command The command(Event) passed from the EventBroker.
		 * 
		 */
		function applyAction(command:Event):void
		
		/**
		 * Returns an Array of Strings which represent the type of command
		 * to register to.
		 *  
		 * @return Array of Command types.
		 * 
		 */
		function get commands():Array
	}
}