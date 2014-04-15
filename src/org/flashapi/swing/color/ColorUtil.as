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
	// ColorUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/01/2011 12:08
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.util.RangeChecker;
	
	/**
	 * 	The <code>ColorUtil</code> class is an all-static class with methods for working
	 * 	with RGB colors within SPAS 3.0. You do not create instances of <code>ColorUtil</code>;
	 * 	instead you simply call static methods such as the <code>ColorUtil.getColor()</code>
	 * 	method.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ColorUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ColorUtil</code> instance.
		 */
		public function ColorUtil() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns an integer that represents the hexadecimal value of the color
		 * 	specified by the <code>value</code>. Possible values are:
		 * 	<ul>
		 * 		<li>a string that represents a color keyword from the current "Color
		 * 		Module",</li>
		 * 		<li>a positive integer,</li>
		 * 		<li>an hexadecimal RGB value.</li>
		 * 		<li>an hexadecimal RGB value in CSS string notation (e.g.
		 * 		'<code>#ff33cc</code>').</li>
		 * 	</ul>
		 * 
		 * 	@param	value The value from to retreive an hexadecimal color.
		 * 
		 * 	@return	The hexadecimal value of a color.
		 * 
		 * 	@see org.flashapi.swing.color.Color#colorModule
		 */
		public static function getColor(value:*):uint {
			return new Color().getValue(value);
		}
		
		/**
		 * 	Converts an hexadecimal RGB color to an hexadecimal RGB color with an alpha
		 * 	channel (ARGB).
		 * 
		 * 	<p>Hexadecimal RGB color are represented by the following format: 0xRRGGBB.<br/>
		 * 	Hexadecimal ARGB color are represented by the following one: 0xAARRGGBB.</p>
		 * 
		 * 	@param	rgb	A hexadicimal value that represents the color to Convert.
		 * 	@param	alpha	The alpha value used to Convert the color, from <code>0</code>
		 * 					(fully transparent) to <code>255</code> (fully opaque).
		 * 
		 * 	@return An interger that represents the converted ARGB color.
		 */
		public static function hexToARGB(rgb:uint, alpha:uint = 0xFF):uint { 
			return (alpha << 24) + rgb;
		}
		
		/**
		 * 	Converts an ARGB color to a RGB color and returns an integer that represents the
		 * 	new RGB value.
		 * 
		 * 	@param	argb	the numerical value of the ARGB color.
		 * 
		 * 	@return	An integer that represents a RGB color value.
		 */
		public static function argbToRgb(argb:uint):uint {
			return (argb & 0x00FFFFFF);
		}
		
		/**
		 * 	Converts a RGB color to an ARGB color by using the specified alpha value,
		 * 	and returns an integer that represents the new ARGB value.
		 * 
		 * 	@param	rgb the numerical value of the RGB color.
		 * 	@param	alpha	The alpha transparency value of the substitute color.
		 * 					Valid values are <code>0</code> to <code>255</code>.
		 * 					For example, <code>127</code> sets a transparency value of 50%. 
		 * 	
		 * 	@return	An integer that represents an ARGB color value.
		 */
		public static function rgbToArgb(rgb:uint, alpha:uint):uint {
			RangeChecker.check(alpha, MAX, 0, "alpha");
			return (alpha << 24) + rgb;
		}
		
		/**
		 * 	Blends smoothly from one color value to another. This method provides the same result
		 * 	as the <code>fl.motion.Color.interpolateColor()</code> method.
		 * 
		 * 	@param	fromValue	The starting color value, in the 0xRRGGBB or 0xAARRGGBB format.
		 * 	@param	toValue		The ending color value, in the 0xRRGGBB or 0xAARRGGBB format.
		 * 	@param	percent		The percent of the transition as a decimal, where
		 * 						<code>0</code> is the start and <code>1</code> is the end.
		 * 	@return	The interpolated color value, in the 0xRRGGBB or 0xAARRGGBB format.
		 * 
		 * 	@see fl.motion.Color.interpolateColor()
		 */
		public static function interpolate(fromValue:uint, toValue:uint, percent:Number):uint {
			var d:Number = 1 - percent;
			var fromA:uint = (fromValue >> 24) & MAX;
			var fromR:uint = (fromValue >> 16) & MAX;
			var fromG:uint = (fromValue >>  8) & MAX;
			var fromB:uint =  fromValue & MAX;
			var toA:uint = (toValue >> 24) & MAX;
			var toR:uint = (toValue >> 16) & MAX;
			var toG:uint = (toValue >>  8) & MAX;
			var toB:uint =  toValue & MAX;
			var a:uint = fromA * d + toA * percent;
			var r:uint = fromR * d + toR * percent;
			var g:uint = fromG * d + toG * percent;
			var b:uint = fromB * d + toB * percent;
			var color:uint = a << 24 | r << 16 | g << 8 | b;
			return color;		
		}
		
		//http://board.flashkit.com/board/archive/index.php/t-778746.html
		/**
		 * 	Converts an interger color value to an hexadecimal RGB string.
		 * 
		 * 	@param	color	The color interger value to convert.
		 * 
		 * 	@return	A string that represents an hexadecimal color in the RGB format. 
		 */
		public static function colorToRGB(color:uint):String {
			var obj:Object = getColorObj(color);
			var r:String = getHex(obj.r);
			var g:String = getHex(obj.g);
			var b:String = getHex(obj.b);
			return r.concat(g, b);
		}
		
		/**
		 * 	Converts an interger color value to an hexadecimal ARGB string.
		 * 
		 * 	@param	color	The color interger value to convert.
		 * 
		 * 	@return	A string that represents an hexadecimal color in the ARGB format. 
		 */
		public static function colorToARGB(color:uint):String {
			var obj:Object = getColorObj(color);
			var a:String = getHex(obj.a);
			var r:String = getHex(obj.r);
			var g:String = getHex(obj.g);
			var b:String = getHex(obj.b);
			return a.concat(r, g, b);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const MAX:uint = 0xFF;
		private static const HEX:String = "0123456789ABCDEF";
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private static function getColorObj(c:uint):Object {
			var o:Object = {};
			o.a = c >> 24 & 0xFF;
			o.r = c >> 16 & 0xFF;
			o.g = c >> 8 & 0xFF;
			o.b = c & 0xFF;
			return o;
		}
		
		private static function getHex(c:uint):String {
			return HEX.charAt((c >> 4) & 0xf) + HEX.charAt(c & 0xf);
		}
	}
}