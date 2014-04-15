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
	// LabelPlacement.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 23/11/2010 18:53
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>LabelPlacement</code> class defines the constants for the allowed
	 * 	values of the <code>labelPlacement</code> property of a <code>Button</code>,
	 * 	<code>CheckBox</code>, <code>ComboBox</code>, etc..
	 * 
	 * 	<p>This property is often implemented by <code>UIObjects</code> that use
	 * 	both, icon and text controls.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LabelPlacement {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new LabelPlacement
		 * 				instance.
		 */
		public function LabelPlacement() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that the label appears above the icon.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	Specifies that the label appears to the left of the icon.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Specifies that the label appears below the icon.
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * 	Specifies that the label appears to the right of the icon.
		 */
		public static const RIGHT:String = "right";
	}
}