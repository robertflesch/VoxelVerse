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
	// LayoutHorizontalAlignment.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/01/2011 10:49
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>LayoutHorizontalAlignment</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>horizontalAlignment</code> property of
	 * 	<code>Layout</code> instances.
	 * 
	 * 	@see org.flashapi.swing.layout.Layout#horizontalAlignment
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LayoutHorizontalAlignment {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new 
		 * 				LayoutHorizontalAlignment instance.
		 */
		public function LayoutHorizontalAlignment() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	This value indicates that each row of the container object should be
		 * 	left-justified.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	This value indicates that each row of the container object should be
		 * 	right-justified.
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * 	This value indicates that each row of the container object should be
		 * 	centered.
		 */
		public static const CENTER:String = "center";
		
		/**
		 * 	This value indicates that each row of the container object should be
		 * 	justified to the leading edge of the container orientation (e.g. to the
		 * 	left in a left-to-right oriented container).
		 * 
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const LEADING:String = "leading";
		
		/**
		 * 	This value indicates that each row of the container object should be
		 * 	justified to the trailing edge of the container orientation (e.g. to the
		 * 	right in a left-to-right oriented container).
		 * 
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const TRAILING:String = "trailing";
	}
}