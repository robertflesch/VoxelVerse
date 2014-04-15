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
	// ScrollBarElements.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17-SEP-2006
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>ScrollBarElements</code> class is an enumeration of constant values 
	 * 	that you can use to determine the elemtn which is currently pressed within a
	 * 	<code>Scrollable</code> object.
	 * 
	 * 	@see org.flashapi.swing.scroll.Scrollable
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class ScrollBarElements {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new 
		 * 				ScrollBarElements instance.
		 */
		public function ScrollBarElements() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that no element is currently pressed within the <code>Scrollable</code>
		 * 	object.
		 */
		public static const NONE:String = "none";
		
		/**
		 * 	Indicates that the track is the element which is currently pressed within
		 * 	the <code>Scrollable</code> object.
		 */
		public static const TRACK:String = "track";
		
		/**
		 * 	Indicates that the scroll up button is the element which is currently  
		 * 	pressed within the <code>Scrollable</code> object.
		 */
		public static const UP_BUTTON:String = "upButton";
		
		/**
		 * 	Indicates that the scroll down button is the element which is currently  
		 * 	pressed within the <code>Scrollable</code> object.
		 */
		public static const DOWN_BUTTON:String = "downDutton";
		
		/**
		 * 	Indicates that the thumb button is the element which is currently pressed 
		 * 	within the <code>Scrollable</code> object.
		 */
		public static const THUMB:String = "thumb";
	}
}