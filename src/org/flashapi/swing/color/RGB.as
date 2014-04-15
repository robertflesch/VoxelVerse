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
	// RGB.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/06/2008 23:43
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>RGB</code> class is used encapsulate and manipulate RGB color
	 * 	components within the default RGB color space rendered by the Flash Player.
	 * 
	 * 	<p>Every color has an implicit alpha value of <code>255</code> (fully opaque)
	 * 	or an explicit one provided in the constructor. The alpha value defines the
	 * 	transparency of a color and can be represented by a float value in the range
	 * 	<code>[0 , 255]</code>. An alpha value of <code>255</code> means that the
	 * 	color is completely opaque and an alpha value of <code>0</code> means that
	 * 	the color is completely transparent.</p>
	 * 
	 * 	@see org.flashapi.swing.color.Color
	 * 	@see org.flashapi.swing.color.ColorModule
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RGB {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * 	Constructor. Creates a new <code>RGB</code> instance.
		 * 
		 * 	@param	... args 	a number of parameters which can be accepted by the 
		 * 						constructor method. Possible case are:
		 * 		<ul>
		 * 			<li>	<code>RGB(name:String)</code><br />
		 * 					Creates an opaque RGB color with the specified name of
		 * 					the color, based upon the current "ColorModule",
		 * 					eg. <code>"black"</code> for <code>0x000000</code>. Alpha
		 * 					is defaulted to <code>255</code>.
		 * 			</li> 
		 * 			<li>	<code>RGB(hexa:uint)</code><br />
		 * 					Creates an opaque RGB color with the specified hexadecimal
		 * 					value of the color,
		 * 					eg. <code>0x000000</code> for <code>black</code>. Alpha
		 * 					is defaulted to <code>255</code>.
		 * 			</li>
		 * 			<li>	<code>RGB(hexa:uint, hasAlpha:Boolean)</code><br />
		 * 					Creates an RGB color with the specified combined RGBA value
		 * 					consisting of the alpha component in bits 24-31, the red
		 * 					component in bits 16-23, the green component in bits
		 * 					8-15, and the blue component in bits 0-7. If the <code>hasAlpha</code>
		 * 					argument is <code>false</code>, alpha is defaulted to <code>255</code>. 
		 * 			</li>
		 * 			<li>	<code>RGB(r:uint, g:uint, b:uint)</code><br />
		 * 					Creates an opaque RGB color with the specified red, green,
		 * 					and blue values in the range <code>[0 , 255]</code>. Alpha
		 * 					is defaulted to <code>255</code>.
		 * 			</li>
		 * 			<li>	<code>RGB(r:uint, g:uint, b:uint, a:uint)</code><br />
		 * 					Creates an opaque RGBA color with the specified red, green,
		 * 					blue and alpha values in the range <code>[0 , 255]</code>.
		 * 			</li>
		 * 		</ul>
		 */
		public function RGB(... args) {
			super();
			initObj(args);
		}
	    
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the alpha component of this color in the range <code>0-255</code>.
		 */
		public function get alpha():uint {
			return (_value >> 24) & 0xFF;
		}
		
		/**
		 * 	Returns the blue component of this color in the range <code>0-255</code>. 
		 */
		public function get blue():uint {
			return (_value >> 0) & 0xFF;
		}
		
		private var _value:uint;
		/**
		 * 	Returns the RGB integer value that represents this color.
		 */
		public function get color():uint {
			return _value;
		}
		
		/**
		 * 	Returns the green component of this color in the range <code>0-255</code>. 
		 */
		public function get green():uint {
			return (_value >> 8) & 0xFF;
		}
		
		/**
		 * 	Returns the red component of this color in the <code>0-255</code>. 
		 */
		public function get red():uint {
			return (_value >> 16) & 0xFF;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines a new color value that is a brighter version of this RGB color.
		 * 
		 * 	<p>This method applies a scale factor to each of the three RGB components
		 * 	of this RGB color to create a brighter version of it.</p>
		 * 
		 * 	<p><strong>Although brighter and darker are inverse operations, the results
		 * 	of a series of invocations of these two methods might be inconsistent because
		 * 	of rounding errors.</strong></p>
		 * 
		 * 	@param	factor	A <code>Number</code> from <code>0</code> (full) to <code>1</code>
		 * 					(none), that represents the brightness factor.
		 * 
		 * 	@return	a new color value that is a brighter version this RGB color.
		 */
		public function brighter(factor:Number = 0.5):uint {
			var r:uint;
			var g:uint;
			var b:uint;
			var i:uint;
			r = red, g = green, b = blue, i = int(1/(1-factor));
			if (r == 0 && g == 0 && b == 0) return new RGB(i, i, i).color;
			if (r > 0 && r < i) r = i;
			if (g > 0 && g < i) g = i;
			if (b > 0 && b < i) b = i;
			return new RGB(	Math.min(int(r / factor), 255),
							Math.min(int(g / factor), 255),
							Math.min(int(b / factor), 255)
						).color;
		}
		
		/**
		 * 	Defines a new color that is a darker version of this RGB color.
		 * 
		 * 	<p>This method applies a scale factor to each of the three RGB components
		 * 	of this RGB color to create a darker version of it.</p>
		 * 	
		 * 	<p><strong>Although brighter and darker are inverse operations, the
		 * 	results of a series of invocations of these two methods might be inconsistent
		 * 	because of rounding errors.</strong></p>
		 * 
		 * 	@param	factor	A <code>Number</code> from <code>0</code> (full) to <code>1</code>
		 * 					(none), that represents the darkening factor.
		 * 
		 * 	@return	a new color value that is a darker version of this RGB color.
		 */
		public function darker(factor:Number = 0.5):uint {
			return new RGB(
				Math.max(int(red * factor), 0), Math.max(int(green * factor), 0),
				Math.max(int(blue * factor), 0)
			).color;
		}
		
		/**
		 * 	Determines whether another object is equal to this RGB color
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 	<p>The result is <code>true</code> if and only if the argument
		 * 	is not <code>null</code> and is a <code>RGB</code> object that has
		 * 	the same red, green, blue, and alpha values as this this RGB color.</p>
		 * 
		 * 	@param	o	the object to test for equality with this RGB color.
		 * 	@return		<code>true</code> if the objects are equals; <code>false</code> otherwise.
		 */
		public function equals(o:Object):Boolean {
			return (o is RGB && o.value == _value);
		}
		
		/**
		 * 	Returns a string representation of this RGB color.
		 * 
		 * 	@return	A string representation of this RGB color.
		 */
		public function toString():String {
	        return "r=" + red + ", g=" + green + ", b=" + blue;
	    }
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(args:Array):void {
			var r:uint;
			var g:uint;
			var b:uint;
			var a:uint;
			if (args.length == 1) {
				if (typeof(args[0]) == PrimitiveType.STRING) _value = new Color().getValue(args[0]);
				else _value = 0xFF000000 | args[0];
			} else if(args.length==2) {
				(args[1]==true) ? _value = args[0] : _value = 0xff000000 | args[0];
			} else if(args.length==3) {
				r = args[0], g = args[1], b = args[2], a = 255;
				testColorValueRange(r, g, b, a);
				_value = ((a & 0xFF) << 24) |((r & 0xFF) << 16) | ((g & 0xFF) << 8) | ((b & 0xFF) << 0);
			} else if(args.length==4) {
				r = args[0], g = args[1], b = args[2], a = args[3];
				testColorValueRange(r, g, b, a);
				_value = ((a & 0xFF) << 24) |((r & 0xFF) << 16) | ((g & 0xFF) << 8) | ((b & 0xFF) << 0);
			} else {
				//throw new IllegalArgumentException("Color parameter outside of expected range: ");
			}
		}
		
		private function testColorValueRange(r:uint, g:uint, b:uint, a:uint):void {
			checkValue(r, Locale.spas_internal::LABELS.RED_LABEL);
			checkValue(g, Locale.spas_internal::LABELS.BLUE_LABEL);
			checkValue(b, Locale.spas_internal::LABELS.GREEN_LABEL);
			checkValue(a, Locale.spas_internal::LABELS.ALPHA_LABEL);
		}
		
		private function checkValue(v:uint, component:String):void {
			if (v > 255)
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.COLOR_COMPONENT_ERROR + component);
		}
	}
}