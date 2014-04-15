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
	// RemotingService.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 20/03/2009 11:57
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.net.messaging.ChannelConnection;
	import org.flashapi.swing.net.messaging.IResponder;
	
	/**
	 *  The <code>RemotingService</code> interface defines the base API for
	 *  objects that provide access to a remoting service structure.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface RemotingService extends IResponder{
		
		/**
		 * 	Returns a reference to the <code>ChannelConnection</code> object of
		 * 	this <code>RemotingService</code> instance.
		 */
		function get channelConnection():ChannelConnection;
	}
}