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

package org.flashapi.swing.brushes {
	
	// -----------------------------------------------------------
	// ColorStateUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/01/2009 00:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.state.ColorState;
	
	/**
	 * 	The <code>ColorStateUtil</code> class provides a static method used by
	 * 	<code>Brush</code> objects to retreive the color of a specified state.
	 * 
	 * 	<p>You cannot create a <code>ColorStateUtil</code> object directly from
	 * 	ActionScript code. If you call <code>new ColorStateUtil()</code>, an 
	 * 	exception is thrown.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ColorStateUtil {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A <code>DeniedConstructorAccess</code> if you try to create
		 * 				a new <code>ColorStateUtil</code> instance;
		 */
		public function ColorStateUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public static methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Retreives the color of a specified state for a <code>Brush</code> object.
		 * 
		 * 	@param	state	The current state of the <code>Brush</code> object. Possible
		 * 					values are constants defined by the <code>States</code> class.
		 * 	@param	colorState	The <code>ColorState</code> object used by this method to
		 * 					retrive the color. 
		 * 
		 * 	@return	The color for the specified state.
		 * 
		 * 	@see org.flashapi.swing.constants.States;
		 * 	@see org.flashapi.swing.state.ColorState;
		 */
		public static function getColor(state:String, colorState:ColorState):uint {
			var c:uint;
			switch(state) {
				case States.OUT :
					c = colorState.up;
					break;
				case States.PRESSED :
					c = colorState.down;
					break;
				case States.OVER :
					c = colorState.over;
					break;
				case States.INACTIVE :
					c = colorState.disabled;
					break;
				case States.SELECTED :
					c = colorState.selected;
					break;
			}
			return c;
		}
	}
}