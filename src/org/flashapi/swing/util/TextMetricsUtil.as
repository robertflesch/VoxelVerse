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
	// TextMetricsUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/05/2009 17:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextField;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>TextMetricsUtil</code> class is a utility class that defines all-static
	 * 	methods for trunctating texts displayed by <code>TextField</code> instances.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	*/
	public class TextMetricsUtil {
		
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
		 * 				TextMetricsUtil instance.
		 */
		public function TextMetricsUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public static methods
		//
		//--------------------------------------------------------------------------
		
		//http://www.frontenddeveloper.net/wiki/index.php?title=Truncate_HTMLText
		//Peter McBride 
		
		/**
		 * 	Truncates the text specified by the <code>value</code> parameter to make it 
		 * 	fit horizontally in the area defined for the <code>TextField</code>, and 
		 * 	append an ellipsis, to the text.
		 * 
		 * 	@param	value	The text that should be truncated within the specified 
		 * 					<code>TextField</code>
		 * 	@param	textField	The <code>TextField</code> that displays the truncated
		 * 						text.
		 * 	@param	maxWidth	The maximum allowed width for the text before being
		 * 						truncated.
		 * 	@param	html	Indicates whether the text specified by the <code>value</code>
		 * 					parameter has HTML tags (<code>true</code>), or not <code>false</code>.
		 * 	@param	ellipsis	The ellipsis to append to the text, if needed truncation.
		 * 						Default value is three periods (<code>...</code>)
		 * 
		 * 	@return <code>true</code> if the text needed truncation; <code>false</code>
		 * 			otherwise.
		 */
		public static function truncateToFit(value:String, textField:TextField, maxWidth:Number, html:Boolean = false, ellipsis:String = "..."):Boolean {
			initText(textField, value, html);
			var ratio:Number = textField.textWidth / maxWidth;
			var numCharsToRemove:Number = 0;
			if (ratio > 1) {
				var l:Number = value.length;
				var el:Number = ellipsis.length
				numCharsToRemove = l - (Math.floor(l / ratio) - el);
				if (!html) {
					var end:Number = l - numCharsToRemove;
					textField.text = end < 0 ? ellipsis : value.slice(0, end) + ellipsis;
				} else textField.htmlText = truncateHtmlText(value, numCharsToRemove, ellipsis);
				return true;
			}
			return false;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Truncates the HTML text specified by the <code>value</code> parameter and 
		 * 	append an ellipsis. This method is HTML safe, which means that all HTML
		 * 	tags are preserved.
		 * 
		 * 	@param	value	The HTML text that should be truncated.
		 * 	@param	numChars	The number of characters that should be removed from the
		 * 						HTML text to be truncated.
		 * 	@param	ellipsis	The ellipsis to append to the text.
		 * 						Default value is three periods (<code>...</code>)
		 * 
		 * 	@return	The resulting truncated HTML text.
		 */
		private static function truncateHtmlText(value:String, numChars:Number = 1, ellipsis:String = "..."):String {
			var copyStr:String = value;
			var testStr:String;
			var isEscCode:Boolean = false;
			var char:String;
			var numDeleted:Number = 0;
			var curIndex:Number = value.length;
			var startIndex:Number;
			var endIndex:Number;
			for (; curIndex >= 0; curIndex--) {
				startIndex = curIndex;
				endIndex = curIndex + 1;
				char = (value.charAt(curIndex));
				testStr = copyStr.slice(0, endIndex);
				if ((char == ">")) curIndex = testStr.lastIndexOf("<");
				else {
					isEscCode =  (testStr.search(ESC_TAG_PATTERN) > -1);
					if (isEscCode) startIndex = testStr.lastIndexOf("&");
					copyStr = copyStr.slice(0, startIndex) + copyStr.slice(endIndex);
					curIndex = startIndex;
					numDeleted++;
					if (numDeleted > numChars) break;
				}
			}
			copyStr = copyStr.slice(0, curIndex) + ellipsis + copyStr.slice(curIndex);
			return copyStr;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private static constants
		//
		//--------------------------------------------------------------------------
		
		private static const ESC_TAG_PATTERN:RegExp = /&#?\w{0,6};$/;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private static function initText(textField:TextField, value:String, html:Boolean):void {
			html ? textField.htmlText = value : textField.text = value;
		}
	}
}