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
	// QueueMode.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/12/2008 22:09
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>QueueMode</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>queueMode</code> property of the
	 * 	<code>DisplayQueueManager</code> class.
	 * 
	 * 	@see org.flashapi.swing.managers.DisplayQueueManager#queueMode
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class QueueMode {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new QueueMode
		 * 				instance.
		 */
		public function QueueMode() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>DisplayQueueManager</code> class uses a "sequential" 
		 * 	computationalgorithm to manage display lists rendering.
		 */
		public static const SEQUENTIAL :String = "sequential ";
		
		/**
		 * 	The <code>DisplayQueueManager</code> class uses a "random" computation
		 * 	algorithm to manage display lists rendering.
		 */
		public static const RANDOM:String = "random";
		
		/**
		 * 	The <code>DisplayQueueManager</code> class uses a "parallel" 
		 * 	computation algorithm to manage display lists rendering.
		 */
		public static const PARALLEL:String = "parallel";
	}
}