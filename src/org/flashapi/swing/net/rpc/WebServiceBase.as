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

package org.flashapi.swing.net.rpc {
	
	// -----------------------------------------------------------
	// WebServiceBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 23/02/2010 15:28
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.WebServiceEvent;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when attempt to the Web service returns a valid result.
	 *
	 *  @eventType org.flashapi.swing.event.WebServiceEvent.RESULT
	 */
	[Event(name = "result", type = "org.flashapi.swing.event.WebServiceEvent")]
	
	/**
	 *  Dispatched when attempt to the Web service fails and returns a fault
	 * 	object.
	 *
	 *  @eventType org.flashapi.swing.event.WebServiceEvent.FAULT
	 */
	[Event(name = "fault", type = "org.flashapi.swing.event.WebServiceEvent")]
	
	/**
	 *  Dispatched when attempt to the Web service fails and occurs a security
	 * 	error.
	 *
	 *  @eventType org.flashapi.swing.event.WebServiceEvent.SECURITY_ERROR
	 */
	[Event(name = "securityError", type = "org.flashapi.swing.event.WebServiceEvent")]
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>WebServiceBase</code> is the base class for classes that provides
	 * 	interractions between a SPAS 3.0 application and Web services, such as 
	 * 	XML-RPC-based services.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WebServiceBase extends EventDispatcher implements WebService, IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>WebServiceBase</code> instance with the
		 * 	specified URI.
		 * 
		 * 	@param	rootUrl	A <code>String</code> that represents the root url where 
		 * 					to locate a Web service.
		 */
		public function WebServiceBase(rootUrl:String = null) {
			super();
			initObj(rootUrl);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines the default <code>URLRequestHeader</code> header used by
		 * 	<code>WebService</code> objects.
		 */
		public static const DEFAULT_HEADERS:URLRequestHeader =
			new URLRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>request</code> property.
		 * 
		 * 	@see #request
		 */
		protected var $urlVars:URLVariables;
		/**
		 * 	@inheritDoc
		 */
		public function get request():URLVariables {
			return $urlVars;
		}
		public function set request(value:URLVariables):void {
			$urlVars = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>resultFormat</code> property.
		 * 
		 * 	@see #resultFormat
		 */
		protected var $resultFmt:String = DataFormat.TEXT;
		/**
		 * 	@inheritDoc
		 */
		public function get resultFormat():String {
			return $resultFmt;
		}
		public function set resultFormat(value:String):void {
			$resultFmt = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>url</code> property.
		 * 
		 * 	@see #url
		 */
		protected var $url:String = null;
		/**
		 * 	@inheritDoc
		 */
		public function get url():String {
			return $url;
		}
		public function set url(value:String):void {
			$url = $urlRequest.url = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>isConnected</code>
		 * 	property.
		 * 
		 * 	@see #isConnected
		 */
		protected var $flowIsOpen:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get isConnected():Boolean {
			return $flowIsOpen;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function close():void {
			if ($flowIsOpen) {
				$urlLoader.close();
				$flowIsOpen = false;
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function send():void {
			$urlRequest.data = $urlVars;
			//UIManager.debugger.print(urlRequest.data);
			$flowIsOpen = true;
			$urlLoader.load($urlRequest);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addHeader(value:Array):void {
			$headers.push(value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function setDataFormat(value:String = "text"):void {
			$urlLoader.dataFormat = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function setRequestMethod(value:String = "get"):void {
			$urlRequest.method = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>URLRequest</code> instance
		 * 	for this <code>WebServiceBase</code>.
		 */
		protected var $urlRequest:URLRequest;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>URLLoader</code> instance
		 * 	for this <code>WebServiceBase</code>.
		 */
		protected var $urlLoader:URLLoader;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Array</code> that contains all HTTP header for this 
		 * 	<code>WebServiceBase</code>.
		 */
		protected var $headers:Array = [WebServiceBase.DEFAULT_HEADERS];
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>EventCollector</code> instance
		 * 	for this <code>WebServiceBase</code>.
		 */
		protected var $evtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function createService():void {
			$urlRequest = new URLRequest($url);
			$urlLoader = new URLLoader();
			setDataFormat();
			setRequestMethod();
			$urlVars = new URLVariables();
			$evtColl.addEvent($urlLoader, Event.COMPLETE, resultsEventHandler);
			$evtColl.addEvent($urlLoader, SecurityErrorEvent.SECURITY_ERROR, securityEventHandler);
			$evtColl.addEvent($urlLoader, IOErrorEvent.IO_ERROR, errorsEventHandler);
		}
		
		/**
		 * 	@private
		 */
		protected function resultsEventHandler(e:Event):void {
			var wse:WebServiceEvent = new WebServiceEvent(WebServiceEvent.RESULT);
			switch($resultFmt) {
				case DataFormat.TEXT :
					wse.spas_internal::resultRef = e.target.data as String;
					break;
				case DataFormat.XML :
					wse.spas_internal::resultRef = new XML(e.target.data);
					break;
				/*case DataFormat.VARIABLES :
					e.result = urlLoader.data; break;
					//e.result = urlLoader.data;
					break;*/
			}
			this.dispatchEvent(wse);
			$flowIsOpen = false;
		}
		
		/**
		 * 	@private
		 */
		protected function errorsEventHandler(event:IOErrorEvent):void {
			dispatchFaultEvent(WebServiceEvent.FAULT);
		}
		
		/**
		 * 	@private
		 */
		protected function securityEventHandler(event:SecurityErrorEvent):void {
			dispatchFaultEvent(WebServiceEvent.SECURITY_ERROR);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(rootUrl:String):void {
			$evtColl = new EventCollector();
			$url = rootUrl;
			createService();
		}
		
		private function dispatchFaultEvent(type:String):void {
			var e:WebServiceEvent = new WebServiceEvent(type);
			dispatchEvent(e);
			$flowIsOpen = false;
		}
	}
}