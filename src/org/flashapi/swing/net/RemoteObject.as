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

package org.flashapi.swing.net {
	
	// -----------------------------------------------------------
	// RemoteObject.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/03/2009 13:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.net.ObjectEncoding;
	import org.flashapi.swing.net.remoting.AbstractRemotingService;
	
	/**
	 * 	The <code>RemoteObject</code> class gives you access to classes on a remote
	 * 	application server.
	 * 
	 * 	<p>The following example shows how to implement a basic "Hello World"
	 * 	application from a PHP class:</p>
	 * 	<listing version="3.0">
	 * 	&lt;?php
	 * 		class HelloWorld {
	 * 			function sayHello() {
	 * 				return 'Hello World!';
	 * 			}
	 * 		}
	 * 	?&gt;
	 * 	</listing>
	 * 	<listing version="3.0">
	 * 		var ro:RemoteObject = new RemoteObject("HelloWorld", "amfphp/gateway.php");
	 * 		ro.onResult = trace; 
	 * 		ro.sayHello() //traces out "Hello World!"
	 * 	</listing>
		<listing version="3.0">
	 * 		var ro:RemoteObject = new RemoteObject("HelloWorld", "amfphp/gateway.php");
	 * 		ro.addEventListener(ResultEvent.RESULT, resultHandler); 
	 * 		function resultHandler(e:ResultEvent):void {
	 * 			trace(e.result);
	 * 		}
	 * 		ro.sayHello() //traces out "Hello World!"
	 * 	</listing>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	dynamic public class RemoteObject extends AbstractRemotingService {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>RemoteObject</code> instance with the
		 * 	specified parameters.
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
		public function RemoteObject(service:String = null, gateway:String = null, encoding:int = ObjectEncoding.AMF3) {
			super(service, gateway, encoding);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$objectDescriptor = "[object RemoteObject]";
		}
	}
}