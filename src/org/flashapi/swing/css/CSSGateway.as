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

package org.flashapi.swing.css {
	
	// -----------------------------------------------------------
	// CSSGateway.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 20/01/2011 13:37
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.StyleSheet;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.color.SVGCK;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.StringUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	A utility class that only defines static methods for using CSS color keywords
	 * 	within the Flash Player.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CSSGateway {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				CSSGateway instance.
		 */
		public function CSSGateway() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Converts a CSS hexadecimal color string (e.g. <code>#ffffff</code>) to a
		 * 	Flash Player valid hexadecimal color (e.g. <code>0xffffff</code>).
		 * 
		 * 	@param	value The CSS hexadecimal color to convert.
		 * 
		 * 	@return	The converted hexadecimal color.
		 */
		public static function fixColorValue(value:String):String {
			if(value.charAt() == "#") return "0x" + value.substr(1, value.length);
			return value;
		}
		
		/**
		 * 	Converts all color keyword properies of a valid CSS file and returns a new
		 * 	<code>StyleSheet</code> object compatible with the Flash Player CSS restrictions.
		 * 
		 * 	@param	styleSheet	The <code>StyleSheet</code> object to fix.
		 * 	@param	useColorModule	Indicates whether to use the SPAS 3.0 current "Color Module"
		 * 							for the color keyword conversion (<code>true</code>),
		 * 							or not (<code>false</code>). If <code>false</code>,
		 * 							the SVG "Color Module" (the <code>SVGCK</code> class)
		 * 							is used for the color keyword conversion.
		 * 
		 * 	@return	A new <code>StyleSheet</code> object compatible with the Flash Player 
		 * 			CSS restrictions.
		 */
		public static function convertForColorKeywordCompatibility(styleSheet:StyleSheet, useColorModule:Boolean = false):StyleSheet {
			var newStyle:StyleSheet = new StyleSheet();
			var i:uint = 0;
			var l:int = styleSheet.styleNames.length;
			var ruleName:String;
			var rule:Object;
			var newRule:Object;
			var item:String;
			var value:String;
			var newItem:String;
			var ck:Class = useColorModule ? Color.spas_internal::colorModuleClass : SVGCK;
			for(; i < l; ++i)  {
				ruleName = styleSheet.styleNames[i];
				rule = styleSheet.getStyle(ruleName);
				newRule = {};
				for(item in rule) {
					value = StringUtil.trim(rule[item]);
					newItem = StringUtil.trim(item);
					if (newItem == "color" && value.charAt() != "#")
						value = new ck(value).cssValue;
					newRule[newItem] = value;
				}
				newStyle.setStyle(ruleName, newRule);
			}
			return newStyle;
		}
	}
}