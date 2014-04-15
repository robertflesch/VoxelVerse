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
	// IResponder.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/03/2009 11:57
	* @see http://www.flashapi.org/
	*/
	
	/**
	 *  The <code>IResponder</code> interface defines the base API for objects
	 *  that are used to respond to remote or asynchronous calls to a remote
	 * 	application server.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface IResponder {
		
		/**
		 *  This method is called by a service when a value has been received
		 *  without errors from the server.
		 * 
		 * 	@param data	An <code>Object</code> that contains data information
		 * 				returned by the server.
		 * 
		 * 	@see #status
		 */
		function result(data:Object):void;
		
		/**
		 *  This method is called by a service when an error has been received
		 * 	from the server.
		 * 
		 * 	@param info	An <code>Object</code> that contains information about
		 * 				errors returned by the server.
		 * 
		 * 	@see #result
		 */
		function status(info:Object):void;
	}
}