/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2009 DevelopmentArc LLC
 * version 1.0
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
	public class DebugLogger
	{
		// PRIVATE
		static private var _inst:DebugLog; // stores singleton instance
		static private var __enabled:Boolean = true; // determines if the logging messages should be processed
		static private var __externalInterfaceEnabled:Boolean = true // determines if the externalInterface api is exposed for JavaScript logging
		static private var __cacheLimit:int = 500; // the default limit of the cache
		static private var __messageLevel:int = DebugMessage.INFO // the current message level
		static private var __appId:String = "FLEX_APP";
		
		// PUBLIC CONSTANTS				
		/**
		 * Represents the unique identifier for the Debug Logger that is used by the Local Connection to communicate with the
		 * fLogger Application Panel.
		 */		
		static public const DEBUG_LOGGER_BROADCASTER:String = "_DEBUG_LOGGER_BROADCASTER";
		
		/**
		 * Represents the unique identifier for the listener application (fLogger panel) that wishes to subscribe to messages
		 * dispatched by the fLogger. 
		 */
		static public const DEBUG_LOGGER_SUBSCRIBER:String = "_DEBUG_LOGGER_SUBSCRIBER";
		
		/**
		 * Represents the method name that is used by the subscriber to announce its presence on launch.
		 */		
		static public const DEBUG_LOGGER_HANDSHAKE:String = "messageHandshake";
		
		/**
		 * Represents the method name that the dLogger uses to broadcast messges to the current subscriber.
		 */		
		static public const DEBUG_LOGGER_MESSAGE:String = "debugMessageSent";
		
		/**
		 * Represents the prefix required for the private connection after the handshake has been completed. 
		 */		
		static public const PANEL_PREFIX:String = "_PANEL_PREFIX";
		
		// PUBLIC METHODS
		
		/**
		 * Dispatches an INFO level message to either the log cache or the active fLogger UI tool.  INFO messages are the lowest level of log statements
		 * and are intended to provide basic messages such as construction of an object, calls to a method, etc.
		 *  
		 * @param message Text message to be dispatched and displayed.
		 * @param classReference The class in which the message wwas generated. Optional
		 * @param methodReference The method in which the message was generated. Optional
		 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional
		 * 
		 */
		static public function info(message:String, classReference:* = null, methodReference:String = null, sourceType:String = null):void
		{
			if(!__enabled) return;
			if(__messageLevel > DebugMessage.INFO) return;
			instance.sendMessage(message, DebugMessage.INFO, classReference, methodReference, sourceType);
		}
		
		/**
		 * Dispatches a DEBUG level message to either the log cache or the active fLogger UI tool.  DEBUG messages are intended for developers who need
		 * log statements that can be filtered above INFO messages but are only useful during development.  DEBUG message should be removed once the intended
		 * issue has been resolved.
		 * 
		 * @param message Text message to be dispatched and displayed.
		 * @param classReference The class in which the message wwas generated. Optional
		 * @param methodReference The method iµn which the message was generated. Optional
		 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional
		 * 
		 */
		static public function debug(message:String, classReference:* = null, methodReference:String = null, sourceType:String = null):void
		{
			if(!__enabled) return;
			if(__messageLevel > DebugMessage.DEBUG) return;
			instance.sendMessage(message, DebugMessage.DEBUG, classReference, methodReference, sourceType);
		}
		
		/**
		 * Dispatches a WARN level message to either the log cache or the active fLogger UI tool.  WARN messges are intended to inform developers that
		 * some issue within the system has occured and should be reviewed for possible errors.  Warinings are not considered an error and may be an
		 * acceptable issue in some cases.
		 * 
		 * @param message Text message to be dispatched and displayed.
		 * @param classReference The class in which the message was generated. Optional
		 * @param methodReference The method in which the message was generated. Optional
		 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional		 
		 * 
		 */
		static public function warn(message:String, classReference:* = null, methodReference:String = null, sourceType:String = null):void 
		{
			if(!__enabled) return;
			if(__messageLevel > DebugMessage.WARN) return;
			instance.sendMessage(message, DebugMessage.WARN, classReference, methodReference, sourceType);
		}
		
		/**
		 * Dispatches an ERROR level message to either the log cache or the active fLogger UI tool.  ERROR messges are intended to inform developers
		 * that a serious issue has occured that may cause system instability.  Errors should be reviewed immediately and the cause of the error should
		 * be resolved before release.
		 * 
		 * @param message Text message to be dispatched and displayed.
		 * @param classReference The class in which the message was generated. Optional
		 * @param methodReference The method in which the message was generated. Optional
		 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional 
		 * 
		 */
		static public function error(message:String, classReference:* = null, methodReference:String = null, sourceType:String = null):void
		{
			if(!__enabled) return;
			if(__messageLevel > DebugMessage.ERROR) return;
			instance.sendMessage(message, DebugMessage.ERROR, classReference, methodReference, sourceType);
		}
		
		/**
		 * Dispatches a FATAL level message to either the log cache or the active fLogger UI tool.  FATAL messges are intended to inform developers
		 * that the application can no longer continue operation.  Fatal errors are the highest level of failure.
		 * 
		 * @param message Text message to be dispatched and displayed.
		 * @param classReference The class in which the message was generated. Optional
		 * @param methodReference The method in which the message was generated. Optional
		 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional
		 * 
		 */
		static public function fatal(message:String, classReference:* = null, methodReference:String = null, sourceType:String = null):void
		{
			if(!__enabled) return;
			instance.sendMessage(message, DebugMessage.FATAL, classReference, methodReference, sourceType);
		}
		
		/**
		 * Defines the debugging state of fLogger.  When fLogger is disabled the debugging cached is cleared and all messages are
		 * ignored by the DebugLogger Class.  By default the fLogger is enabled and messages are stored in cache.  It is recommended
		 * that in your application that code is added to determine if the application is in debug mode and if not the set the debugginEnabled
		 * value to false to prevent un-needed memory usage for cache and message creation.
		 *  
		 * @param enabled True enables debug logging, Flase disables.
		 * 
		 */
		static public function set debuggingEnabled(enabled:Boolean):void
		{
			__enabled = enabled;
			instance.setDebugging(enabled);
		}
		
		static public function get debuggingEnabled():Boolean
		{
			return __enabled;
		}
		
		static public function set externalInterfaceEnabled(enabled:Boolean):void {
			__externalInterfaceEnabled = enabled;
			instance.setExternalInterface(enabled);
		}
		
		static public function get externalInterfaceEnabled():Boolean {
			return __externalInterfaceEnabled;
		}
		
		
		/**
		 * Defines the number of cached items that should be stored before the fist item in the cache is removed.  If the cache limit is reached before
		 * an active connection is made the first chached message is removed and the new cached message is added to the stack.  This continues until an
		 * active connection by the fLogger UI is made which then clears the cache and caching is then disabled.
		 *  
		 * @param value Maximum number of items to hold in the cache.
		 * 
		 */
		static public function set cacheLimit(value:int):void
		{
			__cacheLimit = value;
			instance.setCacheLimit(value);
		}
		
		static public function get cacheLimit():int
		{
			return __cacheLimit;
		}
		
		/**
		 * Defines the minimum message level that is logged.
		 * 
		 * @param level
		 * 
		 */
		static public function set messageLevel(level:int):void
		{
			switch(level)
			{
				// set all to the level unless info or an invalid level
				case DebugMessage.ERROR:
				case DebugMessage.WARN:
				case DebugMessage.FATAL:
				case DebugMessage.DEBUG:
					__messageLevel = level;
				break;
				
				default:
					__messageLevel = DebugMessage.INFO;
			}
			
			instance.setMessageLevel(__messageLevel);
		}
		static public function getClassLogger(classReference:Class):ClassDebugLogger {
			return new ClassDebugLogger(classReference);
		}
		
		/**
		 * Used to define a unique ID for an application.  This value must be set
		 * before a connection is made.  If this value is set after a connection
		 * is made the ID will be ignored.
		 *  
		 * @param value
		 * 
		 */
		static public function set appID(value:String):void
		{
			__appId = value;
		}
		
		static public function get appID():String
		{
			return __appId;
		}
		
		// PRIVATE METHODS
		
		/*
		 * Used to manage a singleton pattern without developers requiring knowledge of instance.  This also prevents exposure of public methods
		 * on the class itself and allows a private class to be the main instance that handles cache and message management.
		 *
		 */
		static private function get instance():DebugLog
		{
			// check if instance exists, return instance
			if(!_inst) _inst = new DebugLog();
			return _inst;
		}

	}
}

/* PRIVTE SINGLETON CLASS */

import com.developmentarc.core.utils.LocalConnectionManager;
import com.developmentarc.core.utils.events.LocalConnectionEvent;
import com.developmentarc.core.utils.logging.DebugLogger;
import com.developmentarc.core.utils.logging.DebugMessage;
import com.developmentarc.core.utils.logging.ExternalInterfaceDebugLogger;

import flash.events.TimerEvent;
import flash.external.ExternalInterface;
import flash.utils.Timer;

	

class DebugLog
{
	static public const DEFAULT_CACHE_LIMIT:int = 500;
	
	public const DEFAULT_CONNECTON:String = "DEFAULT_CONNECTON";
	public const PRIVATE_CONNECTON:String = "PRIVATE_CONNECTON";
	
	private var _cacheLog:Array;
	private var _cacheLimit:int = DEFAULT_CACHE_LIMIT;
	private var _messageLevel:int = 0;
	private var _inCache:Boolean = true;
	private var _enabled:Boolean = true;
	private var _privateConnectionID:String;
	private var _appID:String;
	private var _externalInterfaceHasBeenEnabled:Boolean = false;
	private var _externalInterfaceEnabled:Boolean = false;

	
	private var _connection:LocalConnectionManager;
	private var _disconnectTimer:Timer;
	
	
	public function DebugLog()
	{
		// Constructor
		_cacheLog = new Array();
		_cacheLog.push(new DebugMessage("*** START MESSAGE CACHE ***", DebugMessage.SYSTEM_MESSAGE));
		
		_appID = DebugLogger.appID + "_" +new Date().time;
		
		_disconnectTimer = new Timer(1000, 1);
		_disconnectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handleDisconnectRequest);
		
		startConnection();
	}
	
	public function setDebugging(value:Boolean):void
	{
		if(value)
		{
			// enable debugging
			_enabled = true;
			if(!_connection) startConnection();
		} else {
			// disable debugging
			_enabled = false;
			endConnection();
			_cacheLog = new Array();
		}
	}
	public function setExternalInterface(value:Boolean):void {
		// Turn the API on
		if(value && !_externalInterfaceEnabled) {
			_externalInterfaceEnabled = value;
			try {
				openExternalInterfaceAPI();
			} catch (e:Error) {
				DebugLogger.error("DebugLogger is unable to open the ExternalInterface.  Verify that the application is not running from a local file path and is being hosted via HTTP path.");
			}
		}
		// Turn the API off
		else if(_externalInterfaceEnabled) {
			_externalInterfaceEnabled = value;
		}
		
	
	}
	public function setCacheLimit(value:int):void
	{
		_cacheLimit = value;
		if(_cacheLog.length > _cacheLimit)
		{
			// determine difference and splice log
			var diff:int = _cacheLog.length - _cacheLimit;
			_cacheLog.splice(0, diff);
		}
	}
	
	public function setMessageLevel(level:int):void
	{
		_messageLevel = level;
		if(_inCache)
		{
			// clear out all the non-level messages
			var len:int = _cacheLog.length;
			var newCache:Array = new Array();
			for(var i:uint; i < len; i++)
			{
				var msg:DebugMessage = DebugMessage(_cacheLog[i]);
				if(msg.type >= level)
				{
					newCache.push(msg);
				}
			}
			
			_cacheLog = newCache;
		}
	}
	/**
	 * Dispatches a FATAL level message to either the log cache or the active fLogger UI tool.  FATAL messges are intended to inform developers
	 * that the application can no longer continue operation.  Fatal errors are the highest level of failure.
	 * 
	 * @param msg Text message to be dispatched and displayed.
	 * @param type Type of message that is to be displayed
	 * @param classReference The class in which the message was generated. Optional
	 * @param methodReference The method in which the message was generated. Optional
	 * @param source Identify where the message was generated (ActionScript, JavaScript). Optional
	 * 
	 */
	public function sendMessage(msg:String, type:int, classReference:* = null, methodReference:String = null, sourceType:String = null):void
	{
		var dMsg:DebugMessage = new DebugMessage(msg, type, classReference, methodReference, sourceType);
		dMsg.id = _appID;
		
		// if in cache store in cache, else broadcast message
		if(_inCache)
		{
			if(_cacheLog.length >= _cacheLimit)
			{
				// pull off the first item
				_cacheLog.shift();
			}
			_cacheLog.push(dMsg);
		} else {
			if(!_enabled) return;
			dispatchMessage(dMsg);
		}
	}
	
	public function messageHandshake(msg:DebugMessage):void
	{
		if(DebugLogger.debuggingEnabled && !_enabled) _enabled = true;
		var msg:DebugMessage = new DebugMessage("creation", DebugMessage.HANDSHAKE);
		msg.id = _appID;
		_connection.sendMessage(DebugLogger.DEBUG_LOGGER_SUBSCRIBER, "connectToClient", msg);
	}
	
	public function establishPrivateConnection(msg:DebugMessage):void
	{	
		// we now have a private connection, disconnect the handshake channel
		endConnection();
		if(!_enabled) return; // we shouldn't be connecting in the first place
		
		_privateConnectionID = msg.message;
		startConnection(_appID, PRIVATE_CONNECTON);
		
		if(_inCache)
		{
			// connection is live
			_inCache = false;
			clearQueue();
		}
	}
	
	public function handleConnectionEvents(event:LocalConnectionEvent):void
	{
		switch(event.type)
		{
			case LocalConnectionEvent.CONNECTION_ERROR:
				trace("debugLog: connection error.");
			break;
			
			case LocalConnectionEvent.SENT_MESSAGE_ERROR:
				trace("debugLog: connection message error -- " + event.errorMessage);
			break;
			
			case LocalConnectionEvent.STATUS_MESSAGE:
				if(_connection && event.status == "error") _enabled = false;
			break;
		}
	}
	
	/* Called when a connection is made to the  */
	public function clearQueue():void
	{
		// dispatch queue
		var len:int = _cacheLog.length;
		for(var i:uint; i < len; i++)
		{
			dispatchMessage(DebugMessage(_cacheLog[i]));
		}
		
		// send end cache
		var msg:DebugMessage = new DebugMessage("*** END MESSAGE CACHE ***", DebugMessage.SYSTEM_MESSAGE);
		msg.id = _appID;
		dispatchMessage(msg);
		
		// clear the cache
		_cacheLog = new Array();
	}
	
	public function dispatchMessage(msg:DebugMessage):void
	{
		if(!_connection) return;
		_connection.sendMessage(_privateConnectionID, "debugMessageSent", msg);
	}
	
	protected function handleDisconnectRequest(event:TimerEvent):void
	{
		endConnection();
		_disconnectTimer.stop();
	}
	
	private function openExternalInterfaceAPI():void {
		if(!_externalInterfaceHasBeenEnabled) {
			ExternalInterface.addCallback("info", ExternalInterfaceDebugLogger.info);
			ExternalInterface.addCallback("debug", ExternalInterfaceDebugLogger.debug);
			ExternalInterface.addCallback("warn", ExternalInterfaceDebugLogger.warn);
			ExternalInterface.addCallback("error", ExternalInterfaceDebugLogger.error);
			ExternalInterface.addCallback("fatal", ExternalInterfaceDebugLogger.fatal);
			_externalInterfaceHasBeenEnabled = true
		}
	}
	
	internal function startConnection(target:String = DebugLogger.DEBUG_LOGGER_BROADCASTER, type:String = DEFAULT_CONNECTON):void
	{
		_connection = new LocalConnectionManager(this, target);
		_connection.addEventListener(LocalConnectionEvent.CONNECTION_ERROR, handleConnectionEvents);
		_connection.addEventListener(LocalConnectionEvent.STATUS_MESSAGE, handleConnectionEvents);
		
		switch(type)
		{
			case DEFAULT_CONNECTON:
				var msg:DebugMessage = new DebugMessage("creation", DebugMessage.HANDSHAKE);
				msg.id = _appID;
				_connection.sendMessage(DebugLogger.DEBUG_LOGGER_SUBSCRIBER, "connectToClient", msg);
			break;
		}
		
	}
	
	internal function endConnection():void
	{
		_connection.removeEventListener(LocalConnectionEvent.CONNECTION_ERROR, handleConnectionEvents);
		_connection.removeEventListener(LocalConnectionEvent.STATUS_MESSAGE, handleConnectionEvents);
		_connection.disconnect();
		_connection = null;
	}
}