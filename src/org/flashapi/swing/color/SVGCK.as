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
	// SVGCK.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/01/2008 02:09
	* @see http://www.flashapi.org/
	*/
	
	/**
	 *  The <code>SVGCK</code> class is the "Color Module" for the
	 * 	SVG color keywords table.
	 * 
	 * 	<p><strong>The <code>SPASCK</code> class is the default "Color Module" for
	 * 	the SPAS 3.0 API.</strong></p>
	 * 
	 * 	@see http://www.w3.org/TR/css3-color/#svg-color
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SVGCK extends ColorModuleBase implements ColorModule {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SVGCK</code> instance.
		 * 
		 * 	@param	name	The color keyword for the color to determine from the SVG
		 * 					"Color Module".
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An InvalidArgumentException
		 * 			if the color keyword specified by the <code>name</code> parameter does
		 * 			not exist in the SVG "Color Module".
		 */
		public function SVGCK(name:String) {
			super(name, COLOR_PARSER, true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const A:Object = {
			aliceblue:"0xF0F8FF", antiquewhite:"0xFAEBD7", aqua:"0x00FFFF",
			aquamarine:"0x7FFFD4", azure:"0xF0FFFF"
		};
		
		private static const B:Object = {
			beige:"0xF5F5DC", bisque:"0xFFE4C4", black:"0x000000", blanchedalmond:"0xFFEBCD",
			blue:"0x0000FF", blueviolet:"0x8A2BE2", brown:"0xA52A2A", burlywood:"0xDEB887"
		};
		
		private static const C:Object = {
			cadetblue:"0x5F9EA0", chartreuse:"0x7FFF00", chocolate:"0xD2691E",
			coral:"0xFF7F50", cornflowerblue:"0x6495ED", cornsilk:"0xFFF8DC",
			crimson:"0xDC143C", cyan:"0x00FFFF"
		};
		
		private static const D:Object = {
			darkblue:"0x00008B", darkcyan:"0x008B8B", darkgoldenrod:"0xB8860B",
			darkgray:"0xA9A9A9", darkgreen:"0x006400", darkgrey:"0xA9A9A9",
			darkkhaki:"0xBDB76B", darkmagenta:"0x8B008B", darkolivegreen:"0x556B2F",
			darkorange:"0xFF8C00", darkorchid:"0x9932CC", darkred:"0x8B0000",
			darksalmon:"0xE9967A", darkseagreen:"0x8FBC8F", darkslateblue:"0x483D8B",
			darkslategray:"0x2F4F4F", darkslategrey:"0x2F4F4F", darkturquoise:"0x00CED1",
			darkviolet:"0x9400D3", deeppink:"0xFF1493", deepskyblue:"0x00BFFF",
			dimgray:"0x696969", dimgrey:"0x696969", dodgerblue:"0x1E90FF"
		};
		
		private static const F:Object = {
			firebrick:"0xB22222", floralwhite:"0xFFFAF0", forestgreen:"0x228B22",
			fuchsia:"0xFF00FF"
		};
		
		private static const G:Object = {
			gainsboro:"0xDCDCDC", ghostwhite:"0xF8F8FF", gold:"0xFFD700",
			goldenrod:"0xDAA520", gray:"0x808080", green:"0x008000",
			greenyellow:"0xADFF2F", grey:"0x808080"
		};
		
		private static const HIK:Object = {
			honeydew:"0xF0FFF0", hotpink:"0xFF69B4", indianred:"0xCD5C5C",
			indigo:"0x4B0082", ivory:"0xFFFFF0", khaki:"0xF0E68C"
		};
		
		private static const L:Object = {
			lavender:"0xE6E6FA", lavenderblush:"0xFFF0F5", lawngreen:"0x7CFC00",
			lemonchiffon:"0xFFFACD", lightblue:"0xADD8E6", lightcoral:"0xF08080",
			lightcyan:"0xE0FFFF", lightgoldenrodyellow:"0xFAFAD2", lightgray:"0xD3D3D3",
			lightgreen:"0x90EE90", lightgrey:"0xD3D3D3", lightpink:"0xFFB6C1",
			lightsalmon:"0xFFA07A", lightseagreen:"0x20B2AA", lightskyblue:"0x87CEFA",
			lightslategray:"0x778899", lightslategrey:"0x778899", lightsteelblue:"0xB0C4DE",
			lightyellow:"0xFFFFE0", lime:"0x00FF00", limegreen:"0x32CD32", linen:"0xFAF0E6"
		};
		
		private static const M:Object = {
			magenta:"0xFF00FF", maroon:"0x800000", mediumaquamarine:"0x66CDAA",
			mediumblue:"0x0000CD", mediumorchid:"0xBA55D3", mediumpurple:"0x9370DB",
			mediumseagreen:"0x3CB371", mediumslateblue:"0x7B68EE", mediumspringgreen:"0x00FA9A",
			mediumturquoise:"0x48D1CC", mediumvioletred:"0xC71585", midnightblue:"0x191970",
			mintcream:"xF5FFFA", mistyrose:"0xFFE4E1", moccasin:"0xFFE4B5"
		};
		
		private static const NO:Object = {
			navajowhite:"0xFFDEAD", navy:"0x000080", oldlace:"0xFDF5E6", olive:"0x808000",
			olivedrab:"0x6B8E23", orange:"0xFFA500", orangered:"0xFF4500", orchid:"0xDA70D6"
		};
		
		private static const P:Object = {
			palegoldenrod:"0xEEE8AA", palegreen:"0x98FB98", paleturquoise:"0xAFEEEE",
			palevioletred:"0xDB7093", papayawhip:"0xFFEFD5", peachpuff:"0xFFDAB9",
			peru:"0xCD853F", pink:"0xFFC0CB", plum:"0xDDA0DD", powderblue:"0xB0E0E6",
			purple:"0x800080"
		};
		
		private static const RT:Object = {
			red:"0xFF0000", rosybrown:"0xBC8F8F", royalblue:"0x4169E1",
			tan:"0xD2B48C", teal:"0x008080", thistle:"0xD8BFD8", tomato:"0xFF6347",
			turquoise:"0x40E0D0"
		};
		
		private static const S:Object = {
			saddlebrown:"0x8B4513", salmon:"0xFA8072", sandybrown:"0xF4A460",
			seagreen:"0x2E8B57", seashell:"0xFFF5EE", sienna:"0xA0522D", silver:"0xC0C0C0",
			skyblue:"0x87CEEB", slateblue:"0x6A5ACD", slategray:"0x708090",
			slategrey:"0x708090", snow:"0xFFFAFA", springgreen:"0x00FF7F",
			steelblue:"0x4682B4"
		};
		
		private static const VWY:Object = {
			violet:"0xEE82EE", wheat:"0xF5DEB3", white:"0xFFFFFF", whitesmoke:"0xF5F5F5",
			yellow:"0xFFFF00", yellowgreen:"0x9ACD32"
		};
		
		private static var COLOR_PARSER:Object = {
			a:A, b:B, c:C, d:D, f:F, g:G, h:HIK, i:HIK, k:HIK, l:L, m:M, n:NO, o:NO,
			p:P, r:RT, t:RT, s:S, v:VWY, w:VWY, y:VWY
		};
		
	}
}