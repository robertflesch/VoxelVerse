/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2009 DevelopmentArc LLC
 * version 1.1
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
package com.developmentarc.core.utils
{
	import com.developmentarc.core.utils.events.LocalConnectionEvent;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.registerClassAlias;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	[Event(name="connectionError", type="com.developmentarc.core.utils.events.LocalConnectionEvent")]
	[Event(name="sentMessageError", type="com.developmentarc.core.utils.events.LocalConnectionEvent")]
	[Event(name="statusMessage", type="com.developmentarc.core.utils.events.LocalConnectionEvent")]
	/**
	 * The LocalConnectionManager provides a simpler interface to the Flash LocalConnection that is designed to support
	 * retention of Class type when communication with other ActionScript 3 Applications.  For Class retention to work
	 * both Application must contain the custom class.  If the class does not existing in the receiving Application an
	 * error event will be dispatched.
	 * 
	 * <p>To use this utility create a new instance of the Class providing the target Object that methods send from another 
	 * LocalConnection should be applied to, create a connection to expose this application to other LCM enabled applications
	 * and then brodacast messages with sendMessage() method. </p>
	 * 
	 * @author jpolanco
	 * 
	 */
	public class LocalConnectionManager extends EventDispatcher
	{
		
		/**
		* Stores the LC instance for the Class.
		*/
		protected var connection:LocalConnection;
		
		/**
		* Stores the connection target object that should be called when a message from the LC is received.
		*/
		protected var connectionTarget:Object;
		
		/**
		* Stores the connection name for the current application for communication.
		*/
		protected var currentConnectionName:String;
		
		/**
		 * Stores the current domain list that was defined at construction. 
		 */
		protected var currentDomainList:Array;
		
		/**
		 * Constructor.  Creates a new instance of a LCM and establishes the LocalConnection instance during construction.
		 * 
		 * <p>The constructor also opens the application for communication with other LCM enabled applications based on the name provided.  For other LCM
		 * enabled apps to successfully communicate the app must be on an approved domain and know the name that is defined for
		 * this application. Only one application at a time can be connected via the provided name.  If an application is already
		 * connected via this name the LCM will dispatch a LocalConnectionEvent.CONNECTION_ERROR.  If a connection name is not provided then
		 * the two error communication will not be able to function, this is why the argument is required.</p>
		 * 
		 * @param connTarget This is the object that LC message calls are applied to when received from another applicaiton.
		 * @param connectionName The application communication name
		 * @param domainList An array of domains to allow communication with the LC, if no value is set the default is '*'. 
		 * @param autoConnect Determines if the manager should attempt to auto connect on construction.
		 * 
		 */
		public function LocalConnectionManager(connTarget:Object, connectionName:String, domainList:Array = null, autoConnect:Boolean = true)
		{
			super(this);
			
			connectionTarget = connTarget;
			currentDomainList = domainList;
			
			if(!autoConnect) return;
			
			connect(connectionName);
		}
		
		/**
		 * Updates the approved domain list on the LocalConnection.
		 * 
		 * @param domainArray A list of strings that represent the allowed domains.
		 * 
		 */
		public function addDomain(domainArray:Array):void
		{
			connection.allowDomain(domainArray);
		}
		
		/**
		 * Ends the current local conenction session and removes all handlers
		 * so that Garbage collection can occur. 
		 * 
		 */		
		public function disconnect():void
		{
			if(!connection) return;
			
			try
			{
				connection.close();
			} catch (e:Error) {
				// swallow close errors, connection may no longer exist
			}
			
			connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, handleAsyncEvent);
			connection.removeEventListener(StatusEvent.STATUS, handleStatusEvent);
			
			connection = undefined;
		}
		
		/**
		 * Used to determine of the LocalConnectionManager has an active connection.
		 *  
		 * @return True if connected, false if not connected to a LocalConnection instance.
		 * 
		 */
		public function get connected():Boolean {
			return (connection) ? true : false;
		}
		
		/**
		 * Used to connect to a local connection name.  If the local connection is not
		 * connected this method creates a new connection and connects to the name
		 * provided. If a name is not provided the default name defined at the construction
		 * is used or the last name called via the connect method.
		 * 
		 * <p>If a connection is currently established, this method disconnects from the
		 * exisiting connection and creates a new connection.</p>
		 *  
		 * @param connectionName
		 * 
		 */
		public function connect(connectionName:String = undefined, domainList:Array = null):void {
			
			if(connectionName) {
				currentConnectionName = connectionName;
			}
			
			if(domainList) {
				currentDomainList = domainList;
			}
			
			// make sure we aren't already connected
			if(connection) disconnect();
			
			// create connection
			connection = new LocalConnection();
			connection.client = this;
			if(currentDomainList)
			{
				connection.allowDomain(currentDomainList);
			} else {
				connection.allowDomain("*");
			}
			
			// register events
			connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, handleAsyncEvent);
			connection.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			
			// we are set to autoconnect, make the connection
			try
			{
				// try to connect based on the provided name
				connection.connect(currentConnectionName);
			} catch (e:Error) {
				// unable to connect, probable cause is existing connection
				var event:LocalConnectionEvent = new LocalConnectionEvent(LocalConnectionEvent.CONNECTION_ERROR);
				event.errorMessage = e.message;
				event.errorID = e.errorID;
				dispatchEvent(event);
			}
		}
		
		/**
		 * DO NOT USE.  This method is a communication method that is used by the connecting LCM applications.  This method is exposed
		 * as public only to allow access by the LC.
		 * 
		 * @private
		 * @param aliasList
		 * 
		 */
		public function registerTypes(aliasList:Array, caller:String):void
		{
			// register any alias
			var len:int = aliasList.length;
			for(var i:uint; i < len; i++)
			{
				var path:String = aliasList[i];
				try 
				{
					// get the class instance and register
					var classInst:Class = getDefinitionByName(path) as Class;
					registerClassAlias( path, classInst );
				} catch (e:Error) {
					// inform the caller that an error has occured.
					connection.send(caller, "messageError", "registerTypes", ("type does not exist on receving application: " + path), currentConnectionName);
					
					// class does not exisit within the application
					var lce:LocalConnectionEvent = new LocalConnectionEvent(LocalConnectionEvent.SENT_MESSAGE_ERROR);
					lce.errorID = 5001;
					lce.errorMessage = "The requested class " + path + " does not exist in this application.";
					dispatchEvent(lce);
				}
			}
		}
		
		/**
		 * DO NOT USE.  This method is a communication method that is used by the connecting LCM applications.  This method is exposed
		 * as public only to allow access by the LC.
		 * 
		 * @private
		 * @param aliasList
		 * 
		 */
		public function message(methodName:String, argList:Array, caller:String):void
		{
			// determine if target has requested method
			var found:Boolean = false;
			var classInfo:XML = describeType(connectionTarget);
			for each(var method:XML in classInfo..method)
			{
				if(method.@name == methodName)
				{
					found = true;
					break;
				}
			}
			
			// call the method or dispatch an error
			if(found)
			{
				try
				{
					connectionTarget[methodName].apply(connectionTarget, argList);
				} catch (e:Error) {
					
					// inform the caller that an error has occured.
					connection.send(caller, "messageError", methodName, e.message, currentConnectionName);
					
					// dispatch so the current application can handle the error
					var lce:LocalConnectionEvent = new LocalConnectionEvent(LocalConnectionEvent.SENT_MESSAGE_ERROR);
					lce.errorID = e.errorID;
					lce.errorMessage = e.message + " on " + currentConnectionName;
					dispatchEvent(lce);
				}
			} else {
				// method not found on target
				connection.send(caller, "messageError", methodName, "unable to find requested method", currentConnectionName);
			}
		}
		
		/**
		 * DO NOT USE.  This method is a communication method that is used by the connecting LCM applications.  This method is exposed
		 * as public only to allow access by the LC.
		 * 
		 * @private
		 * @param aliasList
		 * 
		 */
		public function messageError(methodName:String, errorString:String, callee:String):void
		{	
			// status message has been dispatched
			var lce:LocalConnectionEvent = new LocalConnectionEvent(LocalConnectionEvent.SENT_MESSAGE_ERROR);
			lce.errorID = 5000;
			lce.errorMessage = "error calling method " + methodName + " on " + callee + ": " + errorString +".";
			dispatchEvent(lce);
		}
		
		/**
		 * Used to track Async errors from the LC instance.
		 * 
		 * @param event AsyncEvent thrown by the LC.
		 * 
		 */
		protected function handleAsyncEvent(event:AsyncErrorEvent):void
		{
			// async has occurred, we could not connenct to the object
			var lce:LocalConnectionEvent = new LocalConnectionEvent(LocalConnectionEvent.SENT_MESSAGE_ERROR);
			lce.errorID = event.error.errorID;
			lce.errorMessage = event.error.message + " on " + currentConnectionName;
			dispatchEvent(lce);
		}
		
		/**
		 * Used to track Status events from the LC instance.
		 * 
		 * @param event Status event from the LC.
		 * 
		 */
		protected function handleStatusEvent(event:StatusEvent):void
		{
			// status message has been dispatched
			var lce:LocalConnectionEvent = new LocalConnectionEvent(LocalConnectionEvent.STATUS_MESSAGE);
			lce.statusMessage = event.level + " on " + currentConnectionName;
			lce.status = event.level;
			lce.statusCode = event.code;
			dispatchEvent(lce);
		}
		
		/**
		 * Calls the application via the target name and method defined in the arguments.  This method retains the Class definitions
		 * and marks the arguments according to their type so that the receiving application can re-cast back to the correct Class. The
		 * receiving application must have the same defined type and the method argument count must match both order and type in order
		 * for the call to be successfully completed.
		 * 
		 * @param target The name of the application exposed via connectionName to call the method on.
		 * @param methodName The method to call on the target application.
		 * @param args Common seperated argument values for the defined method.
		 * 
		 */
		public function sendMessage(target:String, methodName:String, ...  args):void
		{
			if(!connection) return;
			
			var argList:Array = new Array();
			var aliasList:Array = new Array();
			
			// type all the arguments
			if(args)
			{
				var len:int = args.length;
				for(var i:uint; i < len; i++)
				{
					var item:Object = args[i];
					var path:String = getQualifiedClassName(item)
					if(path.indexOf("::") > -1)
					{
						var seperator:int = path.indexOf("::");
						path = path.substr(0, seperator) + "." + path.substr((seperator + 2), path.length);
					}
					var classInst:Class = getDefinitionByName(path) as Class;
					registerClassAlias( path, classInst );
					aliasList.push(path);
					argList.push(item);
				}
			}
			connection.send(target, "registerTypes", aliasList, currentConnectionName);
			connection.send(target, "message", methodName, argList, currentConnectionName); 
		}
		
	}
}