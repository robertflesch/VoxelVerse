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

package org.flashapi.tween.constant {
	
	// -----------------------------------------------------------
	// EaseType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/07/2007 13:11
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>EaseType</code> class is an enumeration of constant values that
	 * 	specify the type of ease to use in tween animations. The constants are
	 * 	provided for use as values in the <code>type</code> parameter of classes
	 * 	that implement the <code>Easing</code> interface.
	 * 
	 * 	@see org.flashapi.tween.effects.Easing
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class EaseType {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 */
		public function EaseType() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Starts the motion by backtracking and then reversing direction and moving
		 * 	toward the target.
		 */
		public static const IN:String = "in";
		
		/**
		 * 	Starts the motion by moving towards the target, overshooting it slightly,
		 * 	and then reversing direction back toward the target.
		 */
		public static const OUT:String = "out";
		
		/**
		 * 	Combines the <code>EaseType.IN</code> and <code>EaseType.OUT</code> effects
		 * 	to start the motion by backtracking, then reversing direction and moving
		 * 	toward the target, overshooting the target slightly, reversing direction
		 * 	again, and then moving back toward the target.
		 */
		public static const BOTH:String = "both";
	}
}