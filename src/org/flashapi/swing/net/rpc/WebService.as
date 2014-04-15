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
	// WebService.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 13/01/2009 02:22
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	import flash.net.URLVariables;
	
	/**
	 * 	The <code>WebService</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 visual <code>WebService</code>.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface WebService extends IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the <code>URLVariables</code> object used within this 
		 * 	<code>WebService</code> instance to send HTTP data to a web service.
		 */
		function get request():URLVariables;
		function set request(value:URLVariables):void;
		
		/**
		 * 	Sets or gets the expected primitive format of data returned by the Web
		 * 	service. valid values are <code>DataFormat.TEXT</code> or
		 * 	<code>DataFormat.XML</code>.
		 * 
		 * 	@default DataFormat.TEXT
		 */
		function get resultFormat():String;
		function set resultFormat(value:String):void;
		
		/**
		 * 	A <code>String</code> that represents the root url where to locate a Web
		 * 	service.
		 * 
		 * 	@default null
		 */
		function get url():String;
		function set url(value:String):void;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the
		 * 	net connection with the Web service is active (<code>true</code>), or
		 * 	not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #close()
		 */
		function get isConnected():Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sends data to the Web service.
		 * 
		 * 	@see #close()
		 */
		function send():void;
		
		/**
		 * 	Forces to close the connection between the Web service and the SPAS 3.0
		 * 	application after a <code>WebService.send</code> has been called. You
		 * 	must call this method to ensure that the net connection is effectively
		 * 	deactivated when no more needed.
		 * 	
		 * 	@see #send()
		 * 	@see #isConnected
		 */
		function close():void;
		
		/**
		 * 	Adds an array collection of HTTP request headers to be appended to the
		 * 	HTTP request within this <code>WebService</code> object. The array 
		 * 	specified by the <code>value</code> parameter is composed of
		 * 	<code>URLRequestHeader</code> objects. Each <code>URLRequestHeader</code>
		 * 	object in the array must be a  object that contains a name string and a
		 * 	value string, as follows: <code>var rhArray:Array = 
		 * 	new Array(new URLRequestHeader("Content-Type", "text/html"));</code>
		 */
		function addHeader(value:Array):void;
		
		/**
		 * 	Use this method to indicate whether the downloaded data is received 
		 * 	as text (<code>URLLoaderDataFormat.TEXT</code>), raw binary data
		 * 	(<code>URLLoaderDataFormat.BINARY</code>), or URL-encoded variables
		 * 	(<code>URLLoaderDataFormat.VARIABLES</code>).
		 * 
		 * 	@param	value	A <code>URLLoaderDataFormat</code> to specify
		 * 					how downloaded data is received.
		 * 
		 * 	@default URLLoaderDataFormat.TEXT
		 */
		function setDataFormat(value:String = "text"):void;
		
		/**
		 * 	Use this method to control the HTTP form submission method. Valid
		 * 	Values are <code>URLRequestMethod.GET</code> or 
		 * 	<code>URLRequestMethod.POST</code>.
		 * 
		 * 	@default URLRequestMethod.GET
		 */
		function setRequestMethod(value:String = "get"):void;
	}
}