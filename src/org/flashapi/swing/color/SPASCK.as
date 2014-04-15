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
	// SPASCK.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/01/2008 01:09
	* @see http://www.flashapi.org/
	*/
	
	/**
	 *  The <code>SPASCK</code> class is the "Color Module" for the SPAS 3.0 color
	 * 	keywords table. The SPAS 3.0 "Color Module" gives you access to 500 colors,
	 * 	each one defined by a unique corresponding name.
	 * 
	 * 	<p><strong>Note that the default "Color Module" for the SPAS 3.0 API is not
	 * 	the <code>SPASCK</code> class but the <code>SVGCK</code> class.</strong></p>
	 * 
	 * 	@see org.flashapi.swing.color.SVGCK
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SPASCK extends ColorModuleBase implements ColorModule {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SPASCK</code> instance.
		 * 
		 * 	@param	name	The color keyword for the color to determine from the SPAS
		 * 					3.0 "Color Module".
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An InvalidArgumentException
		 * 			if the color keyword specified by the <code>name</code> parameter does
		 * 			not exist in this "Color Module".
		 */
		public function SPASCK(name:String) {
			super(name, COLOR_PARSER, true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const A:Object = {
			aliceblue:"0xF0F8FF", antiquewhite:"0xFAEBD7", antiquewhite1:"0xFFEFDB",
			antiquewhite2:"0xEEDFCC", antiquewhite3:"0xCDC0B0", antiquewhite4:"0x8B8378",
			aquamarine:"0x7FFFD4", aquamarine2:"0x76EEC6", aquamarine4:"0x458B74",
			azure:"0xF0FFFF", azure2:"0xE0EEEE", azure3:"0xC1CDCD", azure4:"0x838B8B"
		};
		
		private static const B:Object = {
			beige:"0xF5F5DC", bisque:"0xFFE4C4", bisque2:"0xEED5B7", bisque3:"0xCDB79E",
			bisque4:"0x8B7D6B", black:"0x000000", blanchedalmond:"0xFFEBCD", blue:"0x0000FF",
			blue2:"0x0000EE", blueviolet:"0x8A2BE2", brown:"0xA52A2A", brown1:"0xFF4040",
			brown2:"0xEE3B3B", brown3:"0xCD3333", brown4:"0x8B2323", burlywood:"0xDEB887",
			burlywood1:"0xFFD39B", burlywood2:"0xEEC591", burlywood3:"0xCDAA7D",
			burlywood4:"0x8B7355"
		};
		
		private static const C:Object = {
			cadetblue:"0x5F9EA0", cadetblue1:"0x98F5FF", cadetblue2:"0x8EE5EE",
			cadetblue3:"0x7AC5CD", cadetblue4:"0x53868B", chartreuse:"0x7FFF00",
			chartreuse2:"0x76EE00", chartreuse3:"0x66CD00", chartreuse4:"0x458B00",
			chocolate:"0xD2691E", chocolate1:"0xFF7F24", chocolate2:"0xEE7621",
			chocolate3:"0xCD661D", coral:"0xFF7F50", coral1:"0xFF7256", coral2:"0xEE6A50",
			coral3:"0xCD5B45", coral4:"0x8B3E2F", cornflowerblue:"0x6495ED", cornsilk:"0xFFF8DC",
			cornsilk2:"0xEEE8CD", cornsilk3:"0xCDC8B1", cornsilk4:"0x8B8878", cyan:"0x00FFFF",
			cyan2:"0x00EEEE", cyan3:"0x00CDCD"
		};
		
		private static const D:Object = {
			darkblue:"0x00008B", darkcyan:"0x008B8B", darkgoldenrod:"0xB8860B",
			darkgoldenrod1:"0xFFB90F", darkgoldenrod2:"0xEEAD0E", darkgoldenrod3:"0xCD950C",
			darkgoldenrod4:"0x8B6508", darkgreen:"0x006400", darkgrey:"0xA9A9A9", darkkhaki:"0xBDB76B",
			darkmagenta:"0x8B008B", darkolivegreen:"0x556B2F", darkolivegreen1:"0xCAFF70",
			darkolivegreen2:"0xBCEE68", darkolivegreen3:"0xA2CD5A", darkolivegreen4:"0x6E8B3D",
			darkorange:"0xFF8C00", darkorange1:"0xFF7F00", darkorange2:"0xEE7600", darkorange3:"0xCD6600",
			darkorange4:"0x8B4500", darkorchid:"0x9932CC", darkorchid1:"0xBF3EFF", darkorchid2:"0xB23AEE",
			darkorchid3:"0x9A32CD", darkorchid4:"0x68228B", darkred:"0x8B0000", darksalmon:"0xE9967A",
			darkseagreen:"0x8FBC8F", darkseagreen1:"0xC1FFC1", darkseagreen2:"0xB4EEB4",
			darkseagreen3:"0x9BCD9B", darkseagreen4:"0x698B69", darkslateblue:"0x483D8B",
			darkslategray:"0x2F4F4F", darkslategray1:"0x97FFFF", darkslategray2:"0x8DEEEE",
			darkslategray3:"0x79CDCD", darkslategray4:"0x528B8B", darkturquoise:"0x00CED1",
			darkviolet:"0x9400D3", deeppink:"0xFF1493", deeppink2:"0xEE1289", deeppink3:"0xCD1076",
			deeppink4:"0x8B0A50", deepskyblue:"0x00BFFF", deepskyblue2:"0x00B2EE", deepskyblue3:"0x009ACD",
			deepskyblue4:"0x00688B", dimgray:"0x696969", dodgerblue:"0x1E90FF", dodgerblue2:"0x1C86EE",
			dodgerblue3:"0x1874CD", dodgerblue4:"0x104E8B"
		};
		
		private static const F:Object = {
			firebrick:"0xB22222", firebrick1:"0xFF3030", firebrick2:"0xEE2C2C", firebrick3:"0xCD2626",
			firebrick4:"0x8B1A1A", floralwhite:"0xFFFAF0", forestgreen:"0x228B22"
		};
		
		private static const G:Object = { gainsboro:"0xDCDCDC", ghostwhite:"0xF8F8FF", gold:"0xFFD700",
			gold2:"0xEEC900", gold3:"0xCDAD00", gold4:"0x8B7500", goldenrod:"0xDAA520", goldenrod1:"0xFFC125",
			goldenrod2:"0xEEB422", goldenrod3:"0xCD9B1D", goldenrod4:"0x8B6914", gray:"0xBEBEBE",
			gray1:"0x030303", gray10:"0x1A1A1A", gray11:"0x1C1C1C", gray12:"0x1F1F1F", gray13:"0x212121",
			gray14:"0x242424", gray15:"0x262626", gray16:"0x292929", gray17:"0x2B2B2B", gray18:"0x2E2E2E",
			gray19:"0x303030", gray2:"0x050505", gray20:"0x333333", gray21:"0x363636", gray22:"0x383838",
			gray23:"0x3B3B3B", gray24:"0x3D3D3D", gray25:"0x404040", gray26:"0x424242", gray27:"0x454545",
			gray28:"0x474747", gray29:"0x4A4A4A", gray3:"0x080808", gray30:"0x4D4D4D", gray31:"0x4F4F4F",
			gray32:"0x525252", gray33:"0x545454", gray34:"0x575757", gray35:"0x595959", gray36:"0x5C5C5C",
			gray37:"0x5E5E5E", gray38:"0x616161", gray39:"0x636363", gray4:"0x0A0A0A", gray40:"0x666666",
			gray42:"0x6B6B6B", gray43:"0x6E6E6E", gray44:"0x707070", gray45:"0x737373", gray46:"0x757575",
			gray47:"0x787878", gray48:"0x7A7A7A", gray49:"0x7D7D7D", gray5:"0x0D0D0D", gray50:"0x7F7F7F",
			gray51:"0x828282", gray52:"0x858585", gray53:"0x878787", gray54:"0x8A8A8A", gray55:"0x8C8C8C",
			gray56:"0x8F8F8F", gray57:"0x919191", gray58:"0x949494", gray59:"0x969696", gray6:"0x0F0F0F",
			gray60:"0x999999", gray61:"0x9C9C9C", gray62:"0x9E9E9E", gray63:"0xA1A1A1", gray64:"0xA3A3A3",
			gray65:"0xA6A6A6", gray66:"0xA8A8A8", gray67:"0xABABAB", gray68:"0xADADAD", gray69:"0xB0B0B0",
			gray7:"0x121212", gray70:"0xB3B3B3", gray71:"0xB5B5B5", gray72:"0xB8B8B8", gray73:"0xBABABA",
			gray74:"0xBDBDBD", gray75:"0xBFBFBF", gray76:"0xC2C2C2", gray77:"0xC4C4C4", gray78:"0xC7C7C7",
			gray79:"0xC9C9C9", gray8:"0x141414", gray80:"0xCCCCCC", gray81:"0xCFCFCF", gray82:"0xD1D1D1",
			gray83:"0xD4D4D4", gray84:"0xD6D6D6", gray85:"0xD9D9D9", gray86:"0xDBDBDB", gray87:"0xDEDEDE",
			gray88:"0xE0E0E0", gray89:"0xE3E3E3", gray9:"0x171717", gray90:"0xE5E5E5", gray91:"0xE8E8E8",
			gray92:"0xEBEBEB", gray93:"0xEDEDED", gray94:"0xF0F0F0", gray95:"0xF2F2F2", gray97:"0xF7F7F7",
			gray98:"0xFAFAFA", gray99:"0xFCFCFC", green:"0x00FF00", green2:"0x00EE00", green3:"0x00CD00",
			green4:"0x008B00", greenyellow:"0xADFF2F"
		};
		
		private static const H:Object = {
			honeydew:"0xF0FFF0", honeydew2:"0xE0EEE0", honeydew3:"0xC1CDC1", honeydew4:"0x838B83",
			hotpink:"0xFF69B4", hotpink1:"0xFF6EB4", hotpink2:"0xEE6AA7", hotpink3:"0xCD6090", hotpink4:"0x8B3A62"
		};
		
		private static const IK:Object = {
			indianred:"0xCD5C5C", indianred1:"0xFF6A6A", indianred2:"0xEE6363", indianred3:"0xCD5555",
			indianred4:"0x8B3A3A", ivory:"0xFFFFF0", ivory2:"0xEEEEE0", ivory3:"0xCDCDC1", ivory4:"0x8B8B83",
			khaki:"0xF0E68C", khaki1:"0xFFF68F", khaki2:"0xEEE685", khaki3:"0xCDC673", khaki4:"0x8B864E"
		};
		
		private static const L:Object = {
			lavender:"0xE6E6FA", lavenderblush:"0xFFF0F5", lavenderblush2:"0xEEE0E5", lavenderblush3:"0xCDC1C5",
			lavenderblush4:"0x8B8386", lawngreen:"0x7CFC00", lemonchiffon:"0xFFFACD", lemonchiffon2:"0xEEE9BF",
			lemonchiffon3:"0xCDC9A5", lemonchiffon4:"0x8B8970", lightsalmon:"0xFFA07A", lightblue:"0xADD8E6",
			lightblue1:"0xBFEFFF", lightblue2:"0xB2DFEE", lightblue3:"0x9AC0CD", lightblue4:"0x68838B",
			lightcoral:"0xF08080", lightcyan:"0xE0FFFF", lightcyan2:"0xD1EEEE", lightcyan3:"0xB4CDCD",
			lightcyan4:"0x7A8B8B", lightgoldenrod:"0xEEDD82", lightgoldenrod1:"0xFFEC8B",
			lightgoldenrod3:"0xCDBE70", lightgoldenrod4:"0x8B814C", lightgoldenrodyellow:"0xFAFAD2",
			lightgrey:"0xD3D3D3", lightpink:"0xFFB6C1", lightpink1:"0xFFAEB9", lightpink2:"0xEEA2AD",
			lightpink3:"0xCD8C95", lightpink4:"0x8B5F65", lightsalmon2:"0xEE9572", lightsalmon3:"0xCD8162",
			lightsalmon4:"0x8B5742", lightseagreen:"0x20B2AA", lightskyblue:"0x87CEFA", lightskyblue1:"0xB0E2FF",
			lightskyblue2:"0xA4D3EE", lightskyblue3:"0x8DB6CD", lightskyblue4:"0x607B8B", lightslateblue:"0x8470FF",
			lightslategray:"0x778899", lightsteelblue:"0xB0C4DE", lightsteelblue1:"0xCAE1FF",
			lightsteelblue2:"0xBCD2EE", lightsteelblue3:"0xA2B5CD", lightsteelblue4:"0x6E7B8B", lightyellow:"0xFFFFE0",
			lightyellow2:"0xEEEED1", lightyellow3:"0xCDCDB4", lightyellow4:"0x8B8B7A", limegreen:"0x32CD32",
			linen:"0xFAF0E6"
		};
		
		private static const MN:Object = {
			magenta:"0xFF00FF", magenta2:"0xEE00EE", magenta3:"0xCD00CD", maroon:"0xB03060", maroon1:"0xFF34B3",
			maroon2:"0xEE30A7", maroon3:"0xCD2990", maroon4:"0x8B1C62", mediumorchid:"0xBA55D3",
			mediumaquamarine:"0x66CDAA", mediumblue:"0x0000CD", mediumorchid1:"0xE066FF", mediumorchid2:"0xD15FEE",
			mediumorchid3:"0xB452CD", mediumorchid4:"0x7A378B", mediumpurple:"0x9370DB", mediumpurple1:"0xAB82FF",
			mediumpurple2:"0x9F79EE", mediumpurple3:"0x8968CD", mediumpurple4:"0x5D478B", mediumseagreen:"0x3CB371",
			mediumslateblue:"0x7B68EE", mediumspringgreen:"0x00FA9A", mediumturquoise:"0x48D1CC",
			mediumvioletred:"0xC71585", midnightblue:"0x191970", mintcream:"0xF5FFFA", mistyrose:"0xFFE4E1",
			mistyrose2:"0xEED5D2", mistyrose3:"0xCDB7B5", mistyrose4:"0x8B7D7B", moccasin:"0xFFE4B5",
			navajowhite:"0xFFDEAD", navajowhite2:"0xEECFA1", navajowhite3:"0xCDB38B", navajowhite4:"0x8B795E",
			navy:"0x000080"
		};
		
		private static const O:Object = {
			oldlace:"0xFDF5E6", olivedrab:"0x6B8E23", olivedrab1:"0xC0FF3E", olivedrab2:"0xB3EE3A",
			olivedrab4:"0x698B22", orangered:"0xFF4500", orange:"0xFFA500", orange2:"0xEE9A00",
			orange3:"0xCD8500", orange4:"0x8B5A00", orangered2:"0xEE4000", orangered3:"0xCD3700",
			orangered4:"0x8B2500", orchid:"0xDA70D6", orchid1:"0xFF83FA", orchid2:"0xEE7AE9", orchid3:"0xCD69C9",
			orchid4:"0x8B4789"
		};
		
		private static const P:Object = {
			palevioletred:"0xDB7093", palegoldenrod:"0xEEE8AA", palegreen:"0x98FB98", palegreen1:"0x9AFF9A",
			palegreen2:"0x90EE90", palegreen3:"0x7CCD7C", palegreen4:"0x548B54", paleturquoise:"0xAFEEEE",
			paleturquoise1:"0xBBFFFF", paleturquoise2:"0xAEEEEE", paleturquoise3:"0x96CDCD", paleturquoise4:"0x668B8B",
			palevioletred1:"0xFF82AB", palevioletred2:"0xEE799F", palevioletred3:"0xCD6889", palevioletred4:"0x8B475D",
			papayawhip:"0xFFEFD5", peachpuff:"0xFFDAB9", peachpuff2:"0xEECBAD", peachpuff3:"0xCDAF95",
			peachpuff4:"0x8B7765", peru:"0xCD853F", pink:"0xFFC0CB", pink1:"0xFFB5C5", pink2:"0xEEA9B8",
			pink3:"0xCD919E", pink4:"0x8B636C", plum:"0xDDA0DD", plum1:"0xFFBBFF", plum2:"0xEEAEEE", plum3:"0xCD96CD",
			plum4:"0x8B668B", powderblue:"0xB0E0E6", purple:"0xA020F0", purple1:"0x9B30FF", purple2:"0x912CEE",
			purple3:"0x7D26CD", purple4:"0x551A8B"
		};
		
		private static const R:Object = {
			red:"0xFF0000", red2:"0xEE0000", red3:"0xCD0000", rosybrown:"0xBC8F8F", rosybrown1:"0xFFC1C1",
			rosybrown2:"0xEEB4B4", rosybrown3:"0xCD9B9B", rosybrown4:"0x8B6969", royalblue:"0x4169E1",
			royalblue1:"0x4876FF", royalblue2:"0x436EEE", royalblue3:"0x3A5FCD", royalblue4:"0x27408B"
		};
		
		private static const S:Object = {
			saddlebrown:"0x8B4513", salmon:"0xFA8072", salmon1:"0xFF8C69", salmon2:"0xEE8262", salmon3:"0xCD7054",
			salmon4:"0x8B4C39", sandybrown:"0xF4A460", seagreen:"0x2E8B57", seagreen1:"0x54FF9F", seagreen2:"0x4EEE94",
			seagreen3:"0x43CD80", seashell:"0xFFF5EE", seashell2:"0xEEE5DE", seashell3:"0xCDC5BF", seashell4:"0x8B8682",
			sienna:"0xA0522D", sienna1:"0xFF8247", sienna2:"0xEE7942", sienna3:"0xCD6839", sienna4:"0x8B4726",
			skyblue:"0x87CEEB", skyblue1:"0x87CEFF", skyblue2:"0x7EC0EE", skyblue3:"0x6CA6CD", skyblue4:"0x4A708B",
			slateblue:"0x6A5ACD", slateblue2:"0x7A67EE", slateblue3:"0x6959CD", slateblue4:"0x473C8B",
			slategray:"0x708090", slategray1:"0xC6E2FF", slategray2:"0xB9D3EE", slategray3:"0x9FB6CD",
			slategray4:"0x6C7B8B", snow:"0xFFFAFA", snow2:"0xEEE9E9", snow3:"0xCDC9C9", snow4:"0x8B8989",
			springgreen:"0x00FF7F", springgreen2:"0x00EE76", springgreen3:"0x00CD66", springgreen4:"0x008B45",
			steelblue:"0x4682B4", steelblue1:"0x63B8FF", steelblue2:"0x5CACEE", steelblue3:"0x4F94CD",
			steelblue4:"0x36648B"
		};
		
		private static const T:Object = {
			tan:"0xD2B48C", tan1:"0xFFA54F", tan2:"0xEE9A49", tan4:"0x8B5A2B", thistle:"0xD8BFD8",
			thistle1:"0xFFE1FF", thistle2:"0xEED2EE", thistle3:"0xCDB5CD", thistle4:"0x8B7B8B", tomato:"0xFF6347",
			tomato2:"0xEE5C42", tomato3:"0xCD4F39", tomato4:"0x8B3626", turquoise:"0x40E0D0", turquoise1:"0x00F5FF",
			turquoise2:"0x00E5EE", turquoise3:"0x00C5CD", turquoise4:"0x00868B"
		};
		
		private static const VW:Object = {
			violet:"0xEE82EE", violetred:"0xD02090", violetred1:"0xFF3E96", violetred2:"0xEE3A8C",
			violetred3:"0xCD3278", violetred4:"0x8B2252", wheat:"0xF5DEB3", wheat1:"0xFFE7BA",
			wheat2:"0xEED8AE", wheat3:"0xCDBA96", wheat4:"0x8B7E66", white:"0xFFFFFF",
			whitesmoke:"0xF5F5F5"
		};
		
		private static const Y:Object = {
			yellow:"0xFFFF00", yellow2:"0xEEEE00", yellow3:"0xCDCD00", yellow4:"0x8B8B00", yellowgreen:"0x9ACD32"
		};
		
		private static const COLOR_PARSER:Object = {
			a:A, b:B, c:C, d:D, f:F, g:G, h:H, i:IK, k:IK, l:L, m:MN, n:MN,
			o:O, p:P, r:R, s:S, t:T, v:VW, w:VW, y:Y
		};
	}
}