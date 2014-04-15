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
	// UITextFormat.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/04/2009 15:54
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFormat;
	import org.flashapi.swing.color.SVGCK;
	import org.flashapi.swing.reflect.ObjectUtil;
	
	/**
	 * 	The <code>UITextFormat</code> class is responsible for managing text format
	 * 	objects which implement the SPAS 3.0 SVG "Color Module".
	 * 
	 * 	@see org.flashapi.swing.color.ColorModule
	 * 	@see org.flashapi.swing.color.Color#colorModule
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UITextFormat extends TextFormat {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a <code>UITextFormat</code> object with the specified
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
		public function UITextFormat(
			font:String = null, size:Object = null, color:Object = null, bold:Object = null,
			italic:Object = null, underline:Object = null, url:String = null, target:String = null,
			align:String = null, leftMargin:Object = null, rightMargin:Object = null,
			indent:Object = null, leading:Object = null)
		{
			super(	font, size, color != null ? getColor(color) : color, bold, italic,
					underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Sets the text color of this <code>UITextFormat</code> object. Valid values
		 * 	are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a>
		 * 	recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a>
		 * 	section  of the document to get valid SVG color keyword names.</p>
		 *  <p>The following code shows different ways to render <code>UITextField</code>
		 * 	object with the same color:
		 * 		<listing version="3.0">
		 * 			var myTxt1:UITextField = new UITextField();
		 * 			myTxt1.color = "violet";<br />
		 * 			var myTxt2:UITextField = new UITextField();
		 * 			myTxt2.color = 0xEE82EE;<br />
		 * 			var myTxt3:UITextField = new UITextField();
		 * 			myTxt3.color = 15631086;
		 * 		</listing>
		 * 	</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		override public function set color(value:Object):void {
			super.color = getColor(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Creates a deep copy of the <code>UITextFormat</code> object with all
		 * 	properties that match to the original object properties.
		 * 
		 * 	@return	A new <code>UITextFormat</code> object which is a deep copy of
		 * 			the original.
		 */
		public function clone():UITextFormat {
			return new ObjectUtil(this, UITextFormat).clone() as UITextFormat;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */
		protected function getColor(value:*):Object {
			if (isNaN(Number(value))) {
				var c:SVGCK = new SVGCK(value);
				return c.color;
			} else return Number(value);
		}
	}
}