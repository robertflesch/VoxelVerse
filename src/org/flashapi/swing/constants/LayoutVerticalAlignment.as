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
	// LayoutVerticalAlignment.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/01/2011 10:49
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>LayoutVerticalAlignment</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>verticalAlignment</code> property of
	 * 	<code>Layout</code> instances.
	 * 
	 * 	@see org.flashapi.swing.layout.Layout#verticalAlignment
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LayoutVerticalAlignment {
		
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
		 * 				LayoutVerticalAlignment instance.
		 */
		public function LayoutVerticalAlignment() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that items are aligned-to-top within the container object.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Specifies that items are centered across the height of the container
		 * 	object.
		 */
		public static const MIDDLE:String = "middle";
		
		/**
		 * 	Specifies that items are aligned-to-bottom within the container object.
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const BASELINE:String = "baseline";
	}
}