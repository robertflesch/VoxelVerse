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
	// Operation.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/03/2009 10:31
	* @see http://www.flashapi.org/
	*/
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import org.flashapi.swing.core.ProxyEventDispatcher;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.net.messaging.ChannelConnection;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	A proxy class used by <code>RemotingService</code> objects to enable treatement
	 * 	of specific operations when call to a remoting service succeeded.
	 * 	
	 * 	@see org.flashapi.swing.net.remoting.RemotingService
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public final class Operation extends ProxyEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Operation</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	channel	The <code>ChannelConnection</code> object that will be
		 * 					reponsible for the resulting operations after calling
		 * 					the remoting service.
		 * 	@param	serviceMember	A specific member of the called service, that
		 * 							will be accessed througt this operation.
		 * 	@param	parameters	A collection of parameters associated with the member
		 * 						specified by the <code>serviceMember</code> parameter.
		 */
		public function Operation(channel:ChannelConnection, serviceMember:String, parameters:Array = null) {
			super();
			initObj(channel, serviceMember, parameters);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var parameters:Array;
		
		/**
		 * 	@private
		 */
		spas_internal function execute():void {
			var arr:Array = [_serviceMem, _responder];
			_connection.call.apply(_connection, arr.concat(spas_internal::parameters));
			//--> Prevents the following error:
			//	Error #2044: asyncError non pris en charge : text=TypeError: Error #1006: value n'est pas une fonction.
			//	Error #2095: flash.net.NetConnection n’a pas été en mesure d’appeler l’élément de rappel AppendToGatewayUrl.
			//--> Needs to be replaced by a better header process.
			_channel.AppendToGatewayUrl(_client.gateway);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _responder:Responder;
		private var _channel:ChannelConnection;
		private var _connection:NetConnection;
		private var _serviceMem:String;
		private var _client:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(channel:ChannelConnection, serviceMember:String, parameters:Array):void {
			_channel = channel;
			_client = channel.client;
			_responder = new Responder(_client.result, _client.status);
			_connection = _channel.netConnection;
			_serviceMem = serviceMember;
			spas_internal::parameters = parameters;
		}
	}
}