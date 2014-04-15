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
	// StringUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/01/2008 22:05
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>StringUtil</code> class is a utility class that defines all-static
	 * 	helper string methods.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	*/
	public class StringUtil {
		
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
		 * 				StringUtil instance.
		 */
		public function StringUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  A constant value which represents the "tab" character.
		 */
		public static const TAB:String = "\t";
		
		/**
		 *  A constant value which represents the "newline" character.
		 */
		public static const NEWLINE:String = "\n";
		
		/**
		 *  A constant value which represents the "return" character.
		 */
		public static const RETURN:String = "\r";
		
		/**
		 *  A constant value which represents the "space" character.
		 */
		public static const SPACE:String = " ";
		
		//A constant value which represents the "form feed" character.
		//---> Throw an ASDoc error;
		//public static const FORM_FEED:String = "\f";
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Removes all whitespaces from a string.
		 * 
		 *	@param value The string for which to remove all whitespaces.
		 *
		 *	@return A <code>String</code> with all whitespaces removed.
		 */
		public static function removeWhitespace(value:String):String {
			var characters:Array = value.split("");
			var i:int = 0;
			var len:int = characters.length;
			for (; i < len; ++i) {
				if (isWhitespace(characters[i])) {
					characters.splice(i, 1);
					i--;
				}
			}
			i = len - 1;
			for (; i >= 0; --i) {
				if(isWhitespace(characters[i])) characters.splice(i, 1);
			}
			return characters.join("");
		}
		
		/**
		 * 	Removes all leading and trailing whitespaces from a string.
		 * 
		 *	@param value 	The string for which to remove all leading and 
		 * 					trailing whitespaces.
		 *
		 *	@return A String with all leading and trailing whitespaces removed.
		 */
		public static function trim(value:String):String {
			var characters:Array = value.split("");
			var i:int = 0;
			var len:int = characters.length;
			for(; i < characters.length; i++) {
				if (isWhitespace(characters[i])){
					characters.splice(i, 1);
					i--;
				}
				else break;
			}
			i = len - 1;
			for(; i >= 0; i--) {
				if(isWhitespace(characters[i])) characters.splice(i, 1);
				else break;
			}
			return characters.join("");
		}
		
		/**
		 * 	Converts an ANSI coded text into an UFT-8 coded text and returns the
		 * 	new UFT-8 coded text.
		 * 
		 * 	@param	src	An ANSI text to code as an UFT-8 text.
		 * 
		 * 	@return	A text converted from ANSI to UFT-8.
		 */
		public static function ansiToUFT8(src:String):String {
			var result:String = "";
			var l:int = src.length;
			var i:uint = 0;
			var pos:int;
			for (; i < l; ++i) {
				pos = src.charCodeAt(i);
				if (pos < 128) {
					result += String.fromCharCode(pos);
				}
				else if((pos > 127) && (pos < 2048)) {
					result += String.fromCharCode((pos >> 6) | 192);
					result += String.fromCharCode((pos & 63) | 128);
				}
				else {
					result += String.fromCharCode((pos >> 12) | 224);
					result += String.fromCharCode(((pos >> 6) & 63) | 128);
					result += String.fromCharCode((pos & 63) | 128);
				}
			}
			return result;
		}
		
		//--------------------------------------------------------------------------
		//
		//  private methods
		//
		//--------------------------------------------------------------------------
		
		private static function isWhitespace(character:String):Boolean {
			return 	character == RETURN || character == NEWLINE ||
					character == "\f" || character == TAB || character == SPACE; 
		}
	}
}