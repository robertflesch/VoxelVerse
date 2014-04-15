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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// NetStatusCode.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/02/2011 22:56
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>NetStatusCode</code> class is an enumeration of constant values 
	 * 	to represent properties that describe the <code>info</code> object used by
	 * 	<code>AbstractRemotingService</code> instances when a remoting connection
	 * 	failed.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class NetStatusCode {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				NetStatusCode instance.
		 */
		public function NetStatusCode() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An error; indicates that packet encoded in an unidentified format.
		 */
		public static const CALL_BAD_VERSION:String = "NetConnection.Call.BadVersion";
		
		/**
		 * 	An error; indicates that the <code>NetConnection.call</code> method was
		 * 	not able to invoke the server-side method or command.
		 */
		public static const CALL_FAILED:String = "NetConnection.Call.Failed";
		
		/**
		 * 	An error; indicates that nn Action Message Format (AMF) operation is
		 * 	prevented for security reasons.
		 */
		public static const CALL_PROHIBITED:String = "NetConnection.Call.Prohibited";
		
		/**
		 * 	An status; indicates that the connection was closed successfully.
		 */
		public static const CONNECT_CLOSED:String = "NetConnection.Connect.Closed";
		
		/**
		 * 	An error; indicates that the connection attempt failed.
		 */
		public static const CONNECT_FAILED:String = "NetConnection.Connect.Failed";
		
		/**
		 * 	An status; indicates that the connection attempt succeeded.
		 */
		public static const CONNECT_SUCCESS:String = "NetConnection.Connect.Success";
		
		/**
		 * 	An error; indicates that the connection attempt did not have permission to
		 * 	access the application.
		 */
		public static const CONNECT_REJECTED:String = "NetConnection.Connect.Rejected";
		
		/**
		 * 	An error; indicates that the specified application is shutting down.
		 */
		public static const CONNECT_APP_SHUT_DOWN:String = "NetConnection.Connect.AppShutdown";
		
		/**
		 * 	An error; indicates that the application name specified during connect
		 * 	is invalid.
		 */
		public static const CONNECT_INVALID_APP:String = "NetConnection.Connect.InvalidApp";
	}
}