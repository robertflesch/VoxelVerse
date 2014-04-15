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
	//  Color.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.5.0, 11/01/2011 12:08
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>Color</code> class is used to encapsulate sets of colors into the 
	 * 	default RGB color space rendered by the Flash Player. It also provides the
	 * 	basic API for manipulating colors within SPAS 3.0.
	 * 
	 * 	<p>SPAS 3.0 colors are encapsulated into different "Color Modules". "Color
	 * 	Modules" are predefined sets of RGB color spaces that simplifies the naming
	 * 	of colors.</p>
	 * 
	 * 	@see org.flashapi.swing.color.ColorModule
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Color {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Color</code> object.
		 */
		public function Color() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant value that represents the default work space color whithin the
		 * 	SPAS 3.0 API.
		 */
		public static const DEFAULT_WORKSPACE_COLOR:uint = 0xB0BDC3;
		
		/**
		 * 	A constant value that represents the windows work space color whithin the
		 * 	SPAS 3.0 API.
		 */
		public static const WINDOWS_WORKSPACE_COLOR:uint = 0xECE9D8;
		
		/**
		 * 	A constant value that indicates the default look and feel color for all
		 * 	SPAS 3.0 objects color properties.
		 */
		public static const DEFAULT:String = "default";
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static var colorModuleClass:Class = SVGCK;
		/**
		 * 	Returns a reference of the current class used as "Color Module".
		 * 	SPAS 3.0 "Color Module" classes must implement the <code>ColorModule</code>
		 * 	interface.
		 * 
		 * 	<p>The default value is a <code>SVGCK</code> class instance.</p>
		 * 
		 * 	@see org.flashapi.swing.color.SVGCK
		 * 	@see org.flashapi.swing.color.ColorModule
		 */
		public static function get colorModule():Class {
			return spas_internal::colorModuleClass;
		}
		public static function set colorModule(value:Class):void {
			spas_internal::colorModuleClass = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a positive integer that represents the numerical value
		 * 	of the specified RGB color.
		 * 
		 * 	@param	value	The color definition. Possible values are:
		 * 					<ul>
		 * 						<li>a string that represents a color keyword from the
		 * 							current Color Module,</li>
		 * 						<li>a positive integer,</li>
		 * 						<li>an hexadecimal RGB value.</li>
		 * 						<li>an hexadecimal RGB value in CSS string notation
		 * 							(e.g. '<code>#ff33cc</code>').</li>
		 * 					</ul>
		 * 					
		 * 	@return		the numerical value of the RGB color passed as the
		 * 				<code>value</code> parameter.
		 * 
		 * 	@see org.flashapi.swing.color.ColorModule
		 */
		public function getValue(value:*):uint {
			if (isNaN(Number(value))) {
				//--> Prevents ColorModule error when using CSS colors (e.g. #ff33cc)
				//	  and CSS properties not defined in the CSSManager class:
				if (value.indexOf('#') != -1) return Number(value.replace(SHARP, "0x"));
				var c:ColorModule = new spas_internal::colorModuleClass(value);
				return c.color;
			} else return Number(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const SHARP:RegExp = /#/;
	}
}