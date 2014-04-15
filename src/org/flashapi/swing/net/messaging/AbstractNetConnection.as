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

package org.flashapi.swing.net.messaging {
	
	// -----------------------------------------------------------
	// AbstractNetConnection.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/12/2007 02:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.net.AMFHeader;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 	
	 * 	The <code>AbstractNetConnection</code> class defines abstract methods and
	 * 	properties for all <code>ChannelConnection</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractNetConnection extends EventDispatcher implements IEventDispatcher, ChannelConnection {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AbstractNetConnection</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	client	Indicates the object on which callback methods should be invoked.
		 * 	@param	encoding The default object encoding for <code>NetConnection</code>
		 * 						objects created in the current SPAS 3.0 application.
		 */
		public function AbstractNetConnection(client:Object = null, encoding:uint = ObjectEncoding.DEFAULT) {
			super();
			initObj(client, encoding);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>netConnection</code> property.
		 * 
		 * 	@see #netConnection
		 */
		protected var $connection:NetConnection;
		
		/**
		 *  @inheritDoc
		 */
		public function get netConnection():NetConnection {
			return $connection;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get client():Object {
			return $connection.client;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function AppendToGatewayUrl(value:String):void {
			if (value != null) $connection.connect(value);
        }
		
		/**
		 *  @inheritDoc
		 */
		public function addHeader(header:AMFHeader):void {
			$connection.addHeader(header.operation, header.mustUnderstand, header.param);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(client:Object, encoding:uint):void {
			$connection = new NetConnection();
			$connection.client = isNull(client) ? this : client;
			$connection.objectEncoding = encoding;
		}
	}
}