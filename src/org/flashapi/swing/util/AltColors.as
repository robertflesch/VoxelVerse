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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// AltColors.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/06/2008 23:43
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.color.RGB;
	
	/**
	 * 	A utility class used within Look and Feel methods to create two alternative
	 * 	colors from the original one. The alternative colors are generate from both,
	 * 	darker and brighter algorithm of the <code>RGB</code> class. Developers
	 * 	can adjust the darker and brighter intensity.
	 * 
	 * 	@see org.flashapi.swing.color.RGB
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AltColors extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AltColors</code> object with the specified
		 * 	parameters.
		 * 
		 * 	@param	altColor	The color from which to generate a darker and a brighter
		 * 						alternative colors.
		 * 	@param	brightnessFactor	Specifies the intensity of the brightness factor,
		 * 								from <code>0</code> (full) to <code>1</code>
		 * 								(none).
		 * 	@param	darknessFactor	Specifies the intensity of the darkening factor,
		 * 							from <code>0</code> (full) to <code>1</code> (none).
		 */
		public function AltColors(altColor:uint, brightnessFactor:Number = 0.5, darknessFactor:Number = 0.5) {
			super();
			initObj(altColor, brightnessFactor, darknessFactor);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The first color defined by the <code>AltColors</code> object; a copy of
		 * 	the original color.
		 */
		public var color1:uint;
		
		/**
		 * 	The second color defined by the <code>AltColors</code> object; a copy of
		 * 	the original color.
		 */
		public var color2:uint;
		
		/**
		 * 	The third color defined by the <code>AltColors</code> object; a brighter
		 * 	version of the original color.
		 * 
		 * 	@see org.flashapi.swing.color.RGB#brighter()
		 */
		public var color3:uint;
		
		/**
		 * 	The fourth color defined by the <code>AltColors</code> object; a darker
		 * 	version of the original color.
		 * 
		 * 	@see org.flashapi.swing.color.RGB#darker()
		 */
		public var color4:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(altColor:uint, brightnessFactor:Number, darknessFactor:Number):void {
			var rgb:RGB = new RGB(altColor);
			this.color1 = altColor;
			this.color2 = altColor;
			this.color3 = rgb.brighter(brightnessFactor);
			this.color4 = rgb.darker(darknessFactor);
		}
	}
}