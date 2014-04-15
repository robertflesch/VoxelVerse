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
	// FontFormatUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/08/2008 15:23
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFormat;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>FontFormatUtil</code> class is a utility class that defines 
	 * 	all-static methods for working with <code>FontFormat</code> objects.
	 * 
	 * 	@see org.flashapi.swing.text.FontFormat
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FontFormatUtil {
		
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
		 * 				FontFormatUtil instance.
		 */
		public function FontFormatUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Make a copy of all properties of a SPAS 3.0 <code>FontFormat</code> object 
		 * 	to an ActionScript <code>TextFormat</code> object.
		 * 
		 * 	@param	textFormat	The <code>TextFormat</code> which will receive all
		 * 						copied properties.
		 * 	@param	format	The <code>FontFormat</code> object to be copied.
		 */
		public static function copy(textFormat:TextFormat, format:FontFormat):void {
			textFormat.align = format.align;
			textFormat.blockIndent = format.blockIndent;
			textFormat.bold = format.bold;
			textFormat.bullet = format.bullet;
			textFormat.color = format.color;
			textFormat.font = format.font;
			textFormat.indent = format.indent;
			textFormat.italic = format.italic;
			textFormat.kerning = format.kerning;
			textFormat.leading = format.leading;
			textFormat.leftMargin = format.leftMargin;
			textFormat.letterSpacing = format.letterSpacing;
			textFormat.rightMargin = format.rightMargin;
			textFormat.size = format.size;
			textFormat.tabStops = format.tabStops;
			textFormat.target = format.target;
			textFormat.underline = format.underline;
			textFormat.url = format.url;
		}
	}
}