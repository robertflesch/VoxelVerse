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

package org.flashapi.swing.button {
	
	// -----------------------------------------------------------
	//  ColorSprite
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 22/02/2011 21:23
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.Sprite;
	
	/**
	 * 
	 * 	The <code>ColorSprite</code> class represent an <code>Sprite</code> object
	 * 	used as button within a <code>WebsafeColorPicker</code> instance to let the
	 * 	user select a color.
	 * 
	 * 	@see org.flashapi.swing.WebsafeColorPicker
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 **/
	public class ColorSprite extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ColorSprite</code> instance.
		 */
		public function ColorSprite() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The value of the color associated with this <code>ColorSprite</code>
		 * 	instance.
		 */
		public var color:uint;
		
		/**
		 * 	The name of the color associated with this <code>ColorSprite</code>
		 * 	instance, represented as an hexadecimal string.
		 */
		public var hexa:String;
	}
}