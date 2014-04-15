////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing.net.remoting {
	
	// -----------------------------------------------------------
	// AbstractRemotingService.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/03/2009 10:31
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.flash_proxy;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.NetStatusCode;
	import org.flashapi.swing.core.ProxyEventDispatcher;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.FaultEvent;
	import org.flashapi.swing.event.NetConnectionEvent;
	import org.flashapi.swing.event.ResultEvent;
	import org.flashapi.swing.net.AMFHeader;
	import org.flashapi.swing.net.messaging.AbstractNetConnection;
	import org.flashapi.swing.net.messaging.ChannelConnection;
	
	use namespace spas_internal;
	use namespace flash_proxy;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Call.BadVersion</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CALL_BAD_VERSION
	 */
	[Event(name = "callBadVersion", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Call.Failed</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CALL_FAILED
	 */
	[Event(name = "callFailed", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Call.Prohibited</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CALL_PROHIBITED
	 */
	[Event(name = "callProhibited", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Connect.Closed</code>
	 * 	status message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CONNECT_CLOSED
	 */
	[Event(name = "connectClosed", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Connect.Failed</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CONNECT_FAILED
	 */
	[Event(name = "connectFailed", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Connect.Success</code>
	 * 	status message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CONNECT_SUCCESS
	 */
	[Event(name = "connectSuccess", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Connect.Rejected</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CONNECT_REJECTED
	 */
	[Event(name = "connectRejected", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Connect.AppShutdown</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CONNECT_APP_SHUT_DOWN
	 */
	[Event(name = "connectAppShutdown", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 *  Dispatched when server returns a <code>NetConnection.Connect.InvalidApp</code>
	 * 	error message to this <code>RemotingService</code>.
	 *
	 *  @eventType org.flashapi.swing.event.NetConnectionEvent.CONNECT_INVALID_APP
	 */
	[Event(name = "connectInvalidApp", type = "org.flashapi.swing.event.NetConnectionEvent")]
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>AbstractRemotingService</code> class provides abstract methods and
	 * 	properties for creating <code>ServerRemoting</code>	services.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	dynamic public class AbstractRemotingService extends ProxyEventDispatcher implements RemotingService {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AbstractRemotingService</code> instance 
		 * 	with the specified parameters.
		 * 
		 * 	@param	service	A string that indicates the service to use on the remote 
		 * 					application server.
		 * 	@param	gateway	A string path to connect to the service if not <code>null</code>.
		 * 					Possible values are constants of the <code>RemotingServiceType</code>
		 * 					class.
		 * 	@param	encoding	Indicates the prior version of ActionScript to work with.
		 * 						Possible values are constants of the <code>ObjectEncoding</code>
		 * 						class.
		 */
		public function AbstractRemotingService(service:String = null, gateway:String = null, encoding:uint = ObjectEncoding.DEFAULT) {
			super();
			initObj(service, gateway, encoding);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Callback method that is called when attempt to the remote application
		 * 	server succeeded and a the result is returned. You do not call this method
		 * 	directly.
		 * 
		 * 	@param data:Object 	An object; provides access to information about
		 * 						the result of the call to the remote application
		 * 						server.
		 */
		public var onResult:Function = null;
		
		/**
		 * 	Callback method that is called when attempt to the remote application
		 * 	server failed. You do not call this method directly.
		 * 
		 * 	@param info:Object 	An object; provides access to information about
		 * 						the error encountered after the call to the remote 
		 * 						application server.
		 */
		public var onFault:Function = null;
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _gateway:String;
		/**
		 * 	Returns the string path to connect to the remote application server. 
		 * 	Possible values are constants of the <code>RemotingServiceType</code> class
		 * 	or <code>null</code> if no path is defined.
		 * 
		 * 	@default null
		 */
		public function get gateway():String {
			return _gateway;
		}
		/*public function set gateway(value:String):void {
			_gateway = value;
		}*/
		
		private var _service:String = null;
		/**
		 * 	Returns a <code>String</code> A string that represents the service to use
		 * 	on the remote application server, or <code>null</code> if no path is
		 * 	defined.
		 * 
		 * 	@default null
		 */
		public function get service():String {
			return _service;
		}
		/*public function set service(value:String):void {
			_service = value;
		}*/
		
		private var _channel:AbstractNetConnection;
		/**
		 * 	@inheritDoc
		 */
		public function get channelConnection():ChannelConnection {
			return _channel;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function result(data:Object):void {
			if (onResult != null) onResult(data);
			$dispatcher.dispatchEvent(new ResultEvent(ResultEvent.RESULT, data));
		}
		
		/**
		 *  @inheritDoc
		 */
		public function status(info:Object):void {
			if (onFault != null) onFault(info);
			$dispatcher.dispatchEvent(new FaultEvent(FaultEvent.FAULT, info));
		}
		
		/**
		 * 	Sets the credentials for the destination accessed by the service when
		 * 	using Data Services on the server side.
		 * 	The credentials are applied to all services connected over the same
		 * 	ChannelSet. Note that services that use a proxy or a third-party adapter
		 * 	to a remote endpoint will need to setRemoteCredentials instead.
		 * 
		 * 	@param username The username for the destination.
		 * 	@param password The password for the destination.
		 * 	@param charset 	The character set encoding to use while encoding the
		 * 					credentials. The default is null, which implies the
		 * 					legacy charset of ISO-Latin-1. The only other supported
		 * 					charset is &quot;UTF-8&quot;.
		 */
		public function setCredentials(username:String, password:String, charset:String = null):void {
			var param:Object  = { userid:username, password:password };
			var header:AMFCredentialsHeader = new AMFCredentialsHeader(param);
			_channel.addHeader(header as AMFHeader);
		}
		
		//--------------------------------------------------------------------------
		//
		// flash_proxy API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override flash_proxy function hasProperty(name:*):Boolean {
            return (typeof this[name] != "undefined" ? true : false);
        }
		
		/**
		 * @private
		 */
		override flash_proxy function getProperty(name:*):* {
			if (typeof spas_internal::operations[name] == "undefined")
				spas_internal::operations[name] = new Operation(_channel, _service + "." + name);
            return spas_internal::operations[name];
        }
        
		/**
		 * @private
		 */
		override flash_proxy function callProperty(methodName:*, ...parameters:*):* {
			if(typeof spas_internal::operations[methodName] == "undefined") this[methodName];
			spas_internal::operations[methodName].spas_internal::parameters = parameters;
			spas_internal::operations[methodName].spas_internal::execute();
			return spas_internal::operations[methodName];
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal var operations:Object;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>EventCollector</code> instance
		 * 	for this <code>AbstractRemotingService</code>.
		 */
		protected var $evtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(service:String, gateway:String, encoding:uint):void {
			_service = service;
			$evtColl = new EventCollector();
			spas_internal::operations = { };
			if (gateway != null) _gateway = gateway;
			_channel = new AbstractNetConnection(this, encoding);
			var c:NetConnection = _channel.netConnection;
			$evtColl.addEvent(c, NetStatusEvent.NET_STATUS, dispatchNetStatusEvent);
			$evtColl.addEvent(c, IOErrorEvent.IO_ERROR, dispatchConnectEvent);
			$evtColl.addEvent(c, SecurityErrorEvent.SECURITY_ERROR, dispatchConnectEvent);
			$evtColl.addEvent(c, AsyncErrorEvent.ASYNC_ERROR, dispatchConnectEvent);
			c.connect(_gateway);
		}
		
		private function dispatchNetStatusEvent(e:NetStatusEvent):void {
			var tpe:String;
			var inf:Object = e.info;
			switch(inf.code) {
				case NetStatusCode.CALL_BAD_VERSION:
					tpe = NetConnectionEvent.CALL_BAD_VERSION;
					break;
				case NetStatusCode.CALL_FAILED:
					tpe = NetConnectionEvent.CALL_FAILED;
					break;
				case NetStatusCode.CALL_PROHIBITED:
					tpe = NetConnectionEvent.CALL_PROHIBITED;
					break;
				case NetStatusCode.CONNECT_CLOSED:
					tpe = NetConnectionEvent.CONNECT_CLOSED;
					break;
				case NetStatusCode.CONNECT_FAILED:
					tpe = NetConnectionEvent.CONNECT_FAILED;
					break;
				case NetStatusCode.CONNECT_SUCCESS:
					tpe = NetConnectionEvent.CONNECT_SUCCESS;
					break;
				case NetStatusCode.CONNECT_REJECTED:
					tpe = NetConnectionEvent.CONNECT_REJECTED;
					break;
				case NetStatusCode.CONNECT_APP_SHUT_DOWN:
					tpe = NetConnectionEvent.CONNECT_APP_SHUT_DOWN;
					break;
				case NetStatusCode.CONNECT_INVALID_APP:
					tpe = NetConnectionEvent.CONNECT_INVALID_APP;
					break;
			}
			this.dispatchEvent(new NetConnectionEvent(tpe, inf));
		}
		
		private function dispatchConnectEvent(e:Event):void {
			$dispatcher.dispatchEvent(e);
		}
	}
}