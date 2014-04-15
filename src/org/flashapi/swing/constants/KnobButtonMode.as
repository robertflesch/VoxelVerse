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
	// KnobButtonMode.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/04/2010 00:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>KnobButtonMode</code> class is an enumeration of constant 
	 * 	values that you can use to set the <code>knobButtonMode</code> property of
	 * 	<code>KnobButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.KnobButton#knobButtonMode
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class KnobButtonMode {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new KnobButtonMode
		 * 				instance.
		 */
		public function KnobButtonMode() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that you must drag the mouse horizontally, after the mouse
		 * 	button has been pressed over the knob button, to change the button value.
		 */
		public static const HORIZONTAL:String = "horizontal";
		
		/**
		 * 	Indicates that you must drag the mouse vertically, after the mouse
		 * 	button has been pressed over the knob button, to change the button value.
		 */
		public static const VERTICAL:String = "vertical";
		
		/**
		 * 	Indicates that you must drag the mouse circularly to turn the knob button,
		 * 	after the mouse button has been pressed over it, to change the button value.
		 */
		public static const CIRCULAR:String = "circular";
	}
}