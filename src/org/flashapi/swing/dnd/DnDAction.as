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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DnDAction.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/06/2009 00:22
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DnDAction</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>action</code> property of the
	 * 	<code>DnDOperation</code> class.
	 * 
	 * 	@see org.flashapi.swing.dnd.DnDOperation#action
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class DnDAction {
		
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
		 * 				DnDAction instance.
		 */
		public function DnDAction() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		// Technote: http://www.javaworld.com/javaworld/jw-03-1999/jw-03-dragndrop.html
		
		/**
		 * 	Constant that specifies that the type of drag action is "none";
		 * 	means that no action is taken.
		 */
		public static const DND_ACTION_NONE:String = "dndActionNone";
		
		/**
		 * 	Constant that specifies that the type of drag action is "copy";
		 * 	means that the drag source leaves the data intact.
		 */
		public static const DND_ACTION_COPY:String = "dndActionCopy";
		
		/**
		 * 	Constant that specifies that the type of drag action is "move";
		 * 	means that the drag source deletes the data upon successful
		 * 	completion of the drop.
		 */
		public static const DND_ACTION_MOVE:String = "dndActionMove";
		
		/**
		 * 	Constant that specifies that the type of drag action is "link";
		 * 	means a data change to either the source or the destination
		 * 	propagates to the other location.
		 */
		public static const DND_ACTION_LINK:String = "dndActionLink";
	}
}