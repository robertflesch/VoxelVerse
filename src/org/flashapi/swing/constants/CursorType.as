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
	// CursorType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/01/2011 00:34
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>CursorType</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>type</code> property of the <code>Cursor</code>
	 * 	class.
	 * 
	 * 	@see org.flashapi.swing.cursor.Cursor#type
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CursorType {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new CursorType
		 * 				instance.
		 */
		public function CursorType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Default. The arrow cursor.
		 */
		public static const DEFAULT_CURSOR:String = "default";
		
		/**
		 * 	The cursor render as a crosshair
		 */
		public static const CROSSHAIR_CURSOR:String = "crosshair";
		
		/**
		 * 	The cursor indicates text.
		 */
		public static const TEXT_CURSOR:String = "text";
		
		/**
		 * 	The cursor indicates that the program is busy.
		 */
		public static const WAIT_CURSOR:String = "wait";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved down and left
		 * 	(south/west).
		 */
		public static const SW_RESIZE_CURSOR:String = "southWestResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved down and right
		 * 	(south/east).
		 */
		public static const SE_RESIZE_CURSOR:String = "southEastResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved up and left
		 * 	(north/west).
		 */
		public static const NW_RESIZE_CURSOR:String = "northWestResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved up and right
		 * 	(north/east).
		 */
		public static const NE_RESIZE_CURSOR:String = "northEastResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved up
		 * 	(north).
		 */
		public static const N_RESIZE_CURSOR:String = "northResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved down (south).
		 */
		public static const S_RESIZE_CURSOR:String = "southResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved left (west).
		 */
		public static const W_RESIZE_CURSOR:String = "westResize";
		
		/**
		 * 	The cursor indicates that an edge of a box is to be moved right (east).
		 */
		public static const E_RESIZE_CURSOR:String = "eastResize";
		
		/**
		 * 	The cursor render as a dragging hand.
		 */
		public static const HAND_CURSOR:String = "hand";
		
		/**
		 * 	The cursor indicates something that should be moved.
		 */
		public static const MOVE_CURSOR:String = "move";
		
		/**
		 * 	Cursor displayed for a vertically divided object.
		 */
		public static const V_DIVIDER_CURSOR:String = "verticalDivider";
		
		/**
		 * 	Cursor displayed for a horizontally divided object.
		 */
		public static const H_DIVIDER_CURSOR:String = "horizontalDivider";
		
		/**
		 * 	The cursor indicates something that should be copied.
		 */
		public static const COPY_CURSOR:String = "copy";
		
		/**
		 * 	Cursor displayed for a reject operation.
		 */
		public static const REJECT_CURSOR:String = "reject";
		
		/**
		 * 	The cursor indicates that the program is busy.
		 */
		public static const BUSY_CURSOR:String = "busy";
		
		/**
		 * 	The cursor indicates that help is available.
		 */
		public static const HELP_CURSOR:String = "help";
		
		/**
		 * 	The cursor render as a pointer.
		 */
		public static const POINTER_CURSOR:String = "pointer";
	}
}