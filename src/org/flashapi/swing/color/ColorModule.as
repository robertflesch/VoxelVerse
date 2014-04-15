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

package org.flashapi.swing.color {
	
	// -----------------------------------------------------------
	// ColorModule.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/01/2008 20:53
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ColorModule</code> interface implements methods to manipulate 
	 * 	colors from different "Color Modules". A SPAS 3.0 "Color Module" 
	 * 	represents a list of predefined colors. You can use SPAS 3.0 "Color Modules" 
	 * 	to create your own colormaps.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ColorModule {
		
		/**
		 *  Returns the RGB color value for this <code>ColorModule</code> object.
		 */
		function get color():uint;
		
		/**
		 *  Returns a valid hexadecimal RGB color value for this <code>ColorModule</code>
		 * 	object.
		 * 	<p>The following example shows the diference between an actionscript and a
		 * 	CSS hexadecimal RGB color value:
		 * 	<pre>
		 * 		var my_SVGCK:SVGCK = new SVGCK("burlywood");
		 * 		trace(my_SVGCK.cssValue); // Displays #DEB887 instead of 0xDEB887
		 * 	</pre>
		 * 	</p>
		 * 
		 * 	@return	the CSS hexadecimal RGB color value for this <code>ColorModule</code>
		 * 			object.
		 */
		function get cssValue():String;
		
		/**
		 * 	Returns the color name of this <code>ColorModule</code> object.
		 * 
		 * 	@default null
		 * 	@return	the color name of this <code>ColorModule</code> object.
		 */
		function get name():String;
		
		/**
		 * 	Returns a string representation of the hexadecimal RGB color value
		 * 	for this <code>ColorModule</code> object.
		 * 	<pre>
		 * 		var my_SVGCK:SVGCK = new SVGCK("burlywood");
		 * 		trace(my_SVGCK); // Displays 0xDEB887
		 * 	</pre>
		 * 
		 * 	@return	a string which represents the hexadecimal RGB color value for
		 * 	this <code>ColorModule</code> object.
		 */
		function toString():String;
	}
}