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
	// ChannelConnection.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/03/2009 11:57
	* @see http://www.flashapi.org/
	*/
	
	import flash.net.NetConnection;
	import org.flashapi.swing.net.AMFHeader;
	
	/**
	 *  The <code>ChannelConnection</code> interface is the markup interface
	 * 	for all objects that manage channel objects which are used to send messages 
	 * 	to a target destination.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ChannelConnection {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Provides access to the associated <code>NetConnection</code> for this
		 * 	channel connection.
		 */
		function get netConnection():NetConnection;
		
		/**
		 * 	Returns the client object for this channel connection.
		 */
		function get client():Object;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds the <code>AMFHeader</code> object specified by the <code>header</code> 
		 * 	parameter to this channel connection.
		 * 
		 * 	@param	header	An <code>AMFHeader</code> that encapsulates the <code>AMF</code>
		 * 					context header within this channel connection.
		 */
		function addHeader(header:AMFHeader):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>AppendToGatewayUrl</code> modifies the gateway of a
		 * 	<code>NetConnection</code> object with the session id of the current session.
		 * 	The <code>ChannelConnection</code> interface defines this method to prevent
		 * 	calls of the native <code>AppendToGatewayUrl</code> method of the
		 * 	<code>NetConnection</code> class.
		 * 	
		 * 	<p class="hide">
		 * 	http://blog.robskelly.com/2009/06/appendtogatewayurl/
		 *  Error #2044: asyncError non pris en charge : text=TypeError: Error #1006: value n'est pas une fonction.
		 *	Error #2095: flash.net.NetConnection n’a pas été en mesure d’appeler l’élément de rappel AppendToGatewayUrl.
		 * 	</p>
		 */
		function AppendToGatewayUrl(value:String):void;
	}
}