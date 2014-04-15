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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// FontFormat.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/08/2008 17:48
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>FontFormat</code> class represents the character formatting information
	 * 	used by the <code>UITextFormat</code> instances. <code>FontFormat</code> objects
	 * 	are typically used by <code>LookAndFeel</code> and <code>Skinable</code> objects
	 * 	to define <code>UITextFormat</code> properties to be used by a <code>UIObject</code>
	 * 	instance.
	 * 
	 * 	@see org.flashapi.swing.text.UITextFormat
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FontFormat {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a <code>FontFormat</code> object with the specified
		 * 	parameters.
		 * 
		 * 	@param	font	The name of a font for text as a string.
		 * 	@param	size	An integer that indicates the point size.
		 * 	@param	color	The color of text using this font format.
		 * 	@param	bold	A Boolean value that indicates whether the text is boldface.
		 * 	@param	italic	A Boolean value that indicates whether the text is italicized.
		 * 	@param	underline	A Boolean value that indicates whether the text is
		 * 						underlined.
		 * 	@param	url		The URL to which the text in this font format hyperlinks.
		 * 	@param	target	The target window where the hyperlink is displayed.
		 * 	@param	align	The alignment of the paragraph, as a <code>TextFormatAlign</code>
		 * 					value.
		 * 	@param	leftMargin	 Indicates the left margin of the paragraph, in pixels.
		 * 	@param	rightMargin	 Indicates the right margin of the paragraph, in pixels.
		 * 	@param	indent	 	An integer that indicates the indentation from the left
		 * 						margin to the first character in the paragraph.
		 * 	@param	leading		A number that indicates the amount of leading vertical
		 * 						space between lines.
		 */
		public function FontFormat(
			font:String = "Arial", size:Object = null, color:Object = null,
			bold:Object = null, italic:Object = null, underline:Object = null,
			url:String = null, target:String = null, align:String = null,
			leftMargin:Object = null, rightMargin:Object = null, indent:Object = null,
			leading:Object = null)
		{
			super();
			initObj(	font, size, color, bold, italic, underline, url, target,
						align, leftMargin, rightMargin, indent, leading);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates the alignment of the paragraph.
		 * 	Valid values are the <code>TextFormatAlign</code> class constants.
		 * 
		 * 	@default TextFormatAlign.LEFT
		 */
		public var align:String;
		
		/**
		 * 	Indicates the block indentation of a text, in pixels. Block indentation
		 * 	is applied to an entire block of text; that is, to all lines of the text.
		 * 	In contrast, normal indentation (<code>FontFormat.indent</code>) affects
		 * 	only the first line of each paragraph. If <code>null</code>, the
		 * 	<code>FontFormat</code> object does not specify block indentation (block
		 * 	indentation is <code>0</code>).
		 * 
		 * 	@default null
		 */
		public var blockIndent:Object
		
		/**
		 * 	Specifies whether the text is boldface (<code>true</code>), or not
		 * 	(<code>false</code>). The default value is (<code>null</code>), which means
		 * 	no boldface is used.
		 * 
		 * 	@default null
		 */
		public var bold:Object;
		
		/**
		 * 	Indicates that the text is part of a bulleted list. In a bulleted list,
		 * 	each paragraph of text is indented. To the left of the first line of
		 * 	each paragraph, a bullet symbol is displayed.
		 * 	The default value is <code>null</code>, which means no bulleted list
		 * 	is used.
		 * 
		 * 	@default null
		 */
		public var bullet:Object;
		
		/**
		 * 	Indicates the color of the text.
		 * 	Valid values are same values that can be used within the current SPAS 3.0 "Color
		 * 	Module". The default value is <code>null</code>, which means that Flash Player
		 * 	uses the color black (<code>0x000000</code>).
		 * 
		 * 	@default null
		 * 
		 * 	@see  org.flashapi.swing.color.ColorModule
		 */
		public var color:Object;
		
		/**
		 * 	The name of the font for text in this font format, as a string. The 
		 * 	default value is <code>WebFonts.ARIAL</code>, which means that SPAS 3.0
		 * 	uses Arial font for the text.
		 * 
		 * 	@default WebFonts.ARIAL
		 */
		public var font:String;
		
		/**
		 * 	Indicates the indentation from the left margin to the first character
		 * 	in the paragraph. The default value is <code>null</code>, which
		 * 	indicates that no indentation is used.
		 * 
		 * 	@default null
		 */
		public var indent:Object;
		
		/**
		 * 	Indicates whether text in this font format is italicized.
		 * 	The default value is <code>null</code>, which means no italics are used. 
		 * 
		 * 	@default null
		 */
		public var italic:Object;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether kerning is enabled
		 * 	(<code>true</code>), or disabled (<code>false</code>).
		 * 	The default value is <code>null</code>, which means that kerning is not
		 * 	enabled.
		 * 
		 * 	@default null
		 */
		public var kerning:Object;
		
		/**
		 * 	An integer representing the amount of vertical space (called leading) between
		 * 	lines. The default value is <code>null</code>, which indicates that the amount
		 * 	of leading used is <code>0</code>.
		 * 
		 * 	@default null
		 */
		public var leading:Object;
		
		/**
		 * 	The left margin of the paragraph, in pixels.
		 * 	The default value is <code>null</code>, which indicates that the left margin
		 * 	is <code>0</code> pixels. 
		 * 
		 * 	@default null
		 */
		public var leftMargin:Object;
		
		/**
		 * 	An integer representing the amount of space that is uniformly distributed
		 * 	between all characters. The value specifies the number of pixels that are
		 * 	added to the advance after each character. The default value is <code>null</code>,
		 * 	which means that <code>0</code> pixels of letter spacing is used.
		 * 
		 * 	@default null
		 */
		public var letterSpacing:Object;
		
		/**
		 * 	The right margin of the paragraph, in pixels.
		 * 	The default value is <code>null</code>, which indicates that the right margin
		 * 	is <code>0</code> pixels.
		 * 
		 * 	@default null
		 */
		public var rightMargin:Object;
		
		/**
		 * 	The point size of text in this font format.
		 * 	The default value is <code>null</code>, which means that a point size
		 * 	of <code>12</code> is used. 
		 * 
		 * 	@default null
		 */
		public var size:Object;
		
		/**
		 * 	Specifies custom tab stops as an array of non-negative integers.
		 * 	Each tab stop is specified in pixels. If custom tab stops are not specified
		 * 	(<code>null</code>), the default tab stop is <code>4</code> (average character
		 * 	width). 
		 * 
		 * 	@default null
		 */
		public var tabStops:Array;
		
		/**
		 * 	Indicates the target window where the hyperlink is displayed.
		 * 	If the <code>UITextFormat.url</code> property is an empty string or
		 * 	<code>null</code>, you can get or set this property, but it will not
		 * 	have any effect. 
		 * 
		 * 	@default null
		 */
		public var target:String;
		
		/**
		 * 	Indicates whether the text that uses this font format is underlined
		 * 	(<code>true</code>), or not (<code>false</code>). The default value is
		 * 	<code>null</code>, which indicates that underlining is not used.
		 * 
		 * 	@default null
		 */
		public var underline:Object;
		
		/**
		 * 	Indicates the target URL for the text in this font format.
		 * 	The default value is <code>null</code>, which indicates that the
		 * 	text does not have a hyperlink.
		 * 
		 * 	<p><strong>Note: </strong>The text with the assigned font format
		 * 	must be set with the <code>htmlText</code> property for the hyperlink
		 * 	to work.</p>
		 * 
		 * 	@default null
		 */
		public var url:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(font:String, size:Object, color:Object, bold:Object,
			italic:Object, underline:Object, url:String, target:String, align:String,
			leftMargin:Object, rightMargin:Object, indent:Object, leading:Object):void {
			this.font = font;
			this.size = size;
			this.color = color;
			this.bold = bold;
			this.italic = italic;
			this.underline = underline;
			this.url = url;
			this.target = target;
			this.align = align;
			this.leftMargin = leftMargin;
			this.rightMargin = rightMargin;
			this.indent = indent;
			this.leading = leading;
		}
	}
}