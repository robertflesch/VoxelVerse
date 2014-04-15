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
	import com.developmentarc.core.datastructures.utils.HashTable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * The AbstractAction provides the base implementation of the IAction interface
	 * and supports the ability to add, remove and update the command list for the
	 * action.  This class is the recommended base class for all Actions.
	 * 
	 * @author James Polanco
	 * 
	 */
	public class AbstractAction extends EventDispatcher implements IAction
	{		
		/**
		 * Stores the list of the commands for Action. 
		 */
		protected var commandList:HashTable;
		
		/**
		 * Constructor. 
		 * 
		 */
		public function AbstractAction()
		{
			super(this);
			commandList = new HashTable();
		}

		/**
		 * Called by the EventBroker when a register command has been dispatched.  This method
		 * must be overriden by the base class.
		 * 
		 * @param command The command that was dispatched.
		 * @throws Error when not overriden.
		 * 
		 */
		public function applyAction(command:Event):void
		{
			throw new Error("The AbstractAction.applyAction() method was not overriden by the implementing class.");
		}
		
		/**
		 * Defines the commands that are registed for this action type.  This Array is a list of
		 * strings that define the Command types that should call applyAction when dispatched.
		 *  
		 * @param commands An Array of Command Types
		 * 
		 */
		public function get commands():Array {
			return commandList.getAllKeys();
		}
		
		[Bindable(event="commandChange")]
		public function set commands(commands:Array):void {
			commandList.removeAll();
			for each(var command:String in commands) {
				commandList.addItem(command, true);
			}
			dispatchEvent(new Event("commandChange"));
		}
		
		[Bindable(event="commandChange")]
		/**
		 * Enables the ability to add a single command to the Action.
		 *  
		 * @param command The Command type to register for.
		 * 
		 */
		public function addCommand(command:String):void {
			commandList.addItem(command, true);
			dispatchEvent(new Event("commandChange"));
		}
		
		[Bindable(event="commandChange")]
		/**
		 * Enables the ability to remove all commands for the action. 
		 * 
		 */
		public function removeAllCommands():void {
			commandList.removeAll();
			dispatchEvent(new Event("commandChange"));
		}
		
		[Bindable(event="commandChange")]
		/**
		 * The ability to remove a specific command from Action.
		 *  
		 * @param command The command to remove.
		 * 
		 */
		public function removeCommand(command:String):void {
			commandList.remove(command);
			dispatchEvent(new Event("commandChange"));
		}
		
	}
}