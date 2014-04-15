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
	// MediaState.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/01/2009 13:59
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>MediaState</code> class is an enumeration of constant values that
	 * 	are returned by the <code>state</code> property of <code>Media</code> objects.
	 * 
	 * 	@see org.flashapi.swing.media.Media#state
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class MediaState {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new MediaState
		 * 				instance.
		 */
		public function MediaState() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>Media</code> object is currently stopped.
		 */
		public static const STOPPED:String = "stopped";
		
		/**
		 * 	The <code>Media</code> object is buffering.
		 */
		public static const BUFFERING:String = "buffering";
		
		/**
		 * 	The net connection from the Web service used with the <code>Media</code>
		 * 	object has been closed.
		 */
		public static const CLOSED:String = "closed";
		
		/**
		 * 	The <code>Media</code> object has encountered a server connection error.
		 */
		public static const CONNECTION_ERROR:String = "connectionError";
		
		/**
		 * 	The <code>Media</code> object has been disconnected from the Web service.
		 */
		public static const DISCONNECTED:String = "disconnected";
		
		/**
		 * 	The <code>Media</code> object is loading.
		 */
		public static const LOADING:String = "loading";
		
		/**
		 * 	The <code>Media</code> object is currently paused.
		 */
		public static const PAUSED:String = "paused";
		
		/**
		 * 	The <code>Media</code> object is currently playing.
		 */
		public static const PLAYING:String = "playing";
	}
}