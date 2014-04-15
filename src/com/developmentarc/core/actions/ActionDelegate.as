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
package com.developmentarc.core.actions
{
	import com.developmentarc.core.actions.actions.IAction;
	import com.developmentarc.core.datastructures.utils.HashTable;
	import com.developmentarc.core.utils.EventBroker;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * The ActionDelegate is responsible for brokering commands to the actions
	 * that have registered for the command type.  When an Action is registered
	 * to the ActionDelegate, the Delegate reviews the commands for the specific action
	 * and then registers to the EventBroker to track the requested Command.  When the
	 * Command is dispatched to the EventBroker the Action's applyAction() method was
	 * assigned and is called.
	 * 
	 * @author James Polanco
	 * 
	 */
	public class ActionDelegate extends EventDispatcher
	{
		private var _actions:HashTable;
		private var _activeCommands:HashTable;
		
		/**
		 * Constructor. 
		 * 
		 */
		public function ActionDelegate()
		{
			super(this);
			
			// set up
			_actions = new HashTable();
			_activeCommands = new HashTable();
		}
		
		/**
		 * Defines an Array of IActions that are then registered through the delegate
		 * to the Action's commands Array. The ActionDelegate can be used in MXML and 
		 * we encourge this to enable a centralized location for where the Actions and 
		 * Commands are assigned.
		 * 
		 * @example When assigning code via MXML, use this syntax: <listing version="3.0">
&lt;controllers:ActionDelegate&gt;
	&lt;controllers:actions&gt;
		&lt;mx:Array&gt;
			&lt;actiontypes:BasicAction commands="{[BasicCommand.MY_BASIC_COMMAND]}" /&gt;
			&lt;actiontypes:MultipleCommandAction commands="{[BasicCommand.A_SECOND_COMMAND, BasicCommand.MY_BASIC_COMMAND]}" /&gt;
		&lt;/mx:Array&gt;
	&lt;/controllers:actions&gt;
&lt;/controllers:ActionDelegate&gt;
		 * </listing>
		 * 
		 * @param value
		 * 
		 */
		public function get actions():Array {
			return _actions.getAllKeys();
		}
		
		public function set actions(value:Array):void {
			unregisterActions(_actions.getAllKeys());
			_actions.removeAll();
			
			for each(var action:IAction in value) {
				_actions.addItem(action, true);
			}
			// register the current actions
			registerActions(_actions.getAllKeys());
		}
		
		/**
		 * Used to add a single action to to the ActionDelegate.
		 *  
		 * @param action The action to register.
		 * 
		 */
		public function addAction(action:IAction):void {
			_actions.addItem(action, true);
			action.addEventListener("commandChange", handleCommandChange, false, 0, true);
			registerCommands(action);
		}
		
		/**
		 * Removes an action from the ActionDelegate.
		 *  
		 * @param action The action to remove.
		 * 
		 */
		public function removeAction(action:IAction):void {
			_actions.remove(action);
			unregisterCommands(action, action.commands);
		}
		
		/**
		 * Registers the action array and the commands assigned to that action.
		 *  
		 * @param actions The array of IActions to register to commands.
		 * 
		 */
		protected function registerActions(actions:Array):void {
			var len:int = actions.length;
			for(var i:uint = 0; i < len; i++) {
				// validate that the list was actions
				if(!actions[i] is IAction) throw Error("Invalid Action was registered to an ActionDelegate.");
				
				// register the action
				var action:IAction = IAction(actions[i]);
				action.addEventListener("commandChange", handleCommandChange, false, 0, true);
				registerCommands(action);
			}
		}
		
		/**
		 * Unregisters an Array of IActions from their commands.
		 * 
		 * @param actions The Array if IActions to unregister.
		 * 
		 */
		protected function unregisterActions(actions:Array):void {
			var len:int = actions.length;
			for(var i:uint = 0; i < len; i++) {				
				// unregister the action
				var action:IAction = IAction(actions[i]);
				action.removeEventListener("commandChange", handleCommandChange);
				unregisterCommands(action, action.commands);
			}
		}
		
		/**
		 * Registers the Action's commands via the EventBroker.
		 *  
		 * @param action The action to register.
		 * 
		 */
		protected function registerCommands(action:IAction):void {
			var commands:Array = action.commands;
			_activeCommands.addItem(action, commands);
			for each(var commandType:String in commands) {
				EventBroker.subscribe(commandType, action.applyAction);
			}
		}
		
		/**
		 * Unregisters the Action's commands via the EventBroker.
		 *  
		 * @param action The action to unregister.
		 * 
		 */
		protected function unregisterCommands(action:IAction, commands:Array):void {
			for each(var commandType:String in commands) {
				EventBroker.unsubscribe(commandType, action.applyAction);
			}
		}
		
		/**
		 * When the commands of a registered Action change this method
		 * unregisters exiting commands and then registers the new command list.
		 * This method is important when assigning commands via MXML due to the
		 * population order of child tags.
		 *  
		 * @param event The change event.
		 * 
		 */
		protected function handleCommandChange(event:Event):void {
			var action:IAction = IAction(event.currentTarget);
			if(_activeCommands.containsKey(action)) {
				// unregister previous commands
				unregisterCommands(action, _activeCommands.getItem(action) as Array);
			}
			registerCommands(action);
		}
	}
}