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

package org.flashapi.swing.html {
	
	// -----------------------------------------------------------
	// BasicHtmlParser.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/02/2011 13:02
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.HeadingSize;
	import org.flashapi.swing.constants.HTMLFormat;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.util.XMLUtil;
	
	/**
	 * 	The <code>BasicHtmlParser</code> class is a utility class for converting XHTML
	 * 	files to the <code>TextLayout</code> markup language. Using the <code>BasicHtmlParser</code> 
	 * 	class will let you emulate the behavior of some DOM functionalities, such as
	 * 	accessing image sources through an <code>Array</code> object.
	 * 
	 * 	<p>The <code>BasicHtmlParser</code> class has been designed to be compatible
	 * 	with the Adobe <code>TextLayout</code> Framework version 2.0. The get the
	 * 	last version of the <code>TextLayout</code> Framework, go to the Adobe's
	 * 	official Text Layout Framework account on Sourceforge:
	 * 	<a href="http://sourceforge.net/adobe/tlf/home/" title="http://sourceforge.net/adobe/tlf/home/">
	 * 	http://sourceforge.net/adobe/tlf/home/</a>.</p>
	 * 
	 * 	<p>The <code>BasicHtmlParser</code> class recoginzes the following XHTML tags:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>XHTML tag</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>h1</code></td>
	 * 			<td>The first level heading; only one <code>h1</code> tag should be defined
	 * 			within a XHTML file.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h2</code>, <code>h3</code>, <code>h4</code>, <code>h5</code>,
	 * 			<code>h6</code></td>
	 * 			<td>The XHTML headings from level two to level six. Sizes are defined
	 * 			by the <code>org.flashapi.swing.constants.HeadingSize</code> class.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>img</code></td>
	 * 			<td>The XHTML image tag.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>ul</code></td>
	 * 			<td>The XHTML tag for unordered lists.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>ol</code></td>
	 * 			<td>The XHTML tag for ordered lists.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>code</code></td>
	 * 			<td>The XHTML tag for coding sample sections.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>strong</code></td>
	 * 			<td>The XHTML tag for stronger emphasis elements.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>em</code></td>
	 * 			<td>The XHTML tag for emphasis elements.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@see org.flashapi.swing.html.CssFormatResolver
	 * 	@see org.flashapi.swing.html.BasicHtmlPage
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 10
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class BasicHtmlParser {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BasicHtmlParser</code> instance.
		 */
		public function BasicHtmlParser() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _htmlFormat:String = HTMLFormat.XHTML_PAGE;
		/**
		 * 	Sets or get the type of html page that will be parsed by this <code>BasicHtmlParser</code>
		 * 	instance. The <code>htmlFormat</code> property must be set before you call
		 * 	the <code>xhtmlToTextFlowMakup()</code> property.
		 * 
		 * 	@default HTMLFormat.XHTML_PAGE
		 * 
		 * 	@see #xhtmlToTextFlowMakup()
		 */
		public function get htmlFormat():String {
			return _htmlFormat;
		}
		public function set htmlFormat(value:String):void {
			_htmlFormat = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the value of the <code>title</code> tag for the current XHTML
		 * 	page. If no XHTML page is currently defined, returns an empty string.
		 * 
		 * 	@return The value of the <code>title</code> tage for the current XHTML
		 * 			page.
		 */
		public function getTitle():String {
			return _head != null ? _head.title.toXMLString() : "";
		}
		
		/**
		 * 	Returns an <code>Array</code> that contains a collection of <code>CssReference</code>
		 * 	objects. Each <code>CssReference</code> object represents one of the links
		 * 	to a style sheet, contained within the <code>head</code> tag of the
		 * 	the current XHTML page.
		 * 
		 * 	@return A collection of all links to a style sheet available within the
		 * 			the current XHTML page.
		 * 
		 * 	@see org.flashapi.swing.html.CssReference
		 * 	@see org.flashapi.swing.html.BasicHtmlPage#autoDetectCSS
		 */
		public function getCssCollection():Array {
			var a:Array = [];
			if (_head == null) return a;
			var link:XMLList = _head.link.(@rel == "stylesheet");
			var l:int = link.length()-1;
			var node:XML;
			for (; l >= 0; l--) {
				node = link[l];
				a.push(new CssReference(node.@href, node.@media, node.@title));
			}
			return a;
		}
		
		/**
		 * 	Converts a valid XHTML file to the Text Flow Makup and retuns the resulting
		 * 	<code>XML</code> file.
		 * 
		 * 	@return	A valid Text Flow Makup <code>XML</code> file.
		 */
		public function xhtmlToTextFlowMakup():XML {
			if (_xhtml == null) return null;
			XML.ignoreComments = true;
			switch(_htmlFormat) {
				case HTMLFormat.XHTML_PAGE:
					_head = _xhtml..head;
					_markup = _xhtml..body;
					break;
				case HTMLFormat.BODY:
					_markup = <html>{_xhtml}</html>..body;
					break;
				case HTMLFormat.XML:
					_markup = <html>{_xhtml}</html>.children();
					break;
			}
			_markup.setName("TextFlow");
			_markup.@styleName = "body";
			_markup.@xmlns = 'http://ns.adobe.com/textLayout/2008';
			
			checkPTag();
			var h1:XMLList = _markup..h1;
			var l:int = h1.length();
			if (l == 1) {
				setHeadingAtt(h1, "h1", HeadingSize.H1Size);
			} else if (l > 1) throw new Error();
			checkHeadingTag("h2", HeadingSize.H2Size);
			checkHeadingTag("h3", HeadingSize.H3Size);
			checkHeadingTag("h4", HeadingSize.H4Size);
			checkHeadingTag("h5", HeadingSize.H5Size);
			checkHeadingTag("h6", HeadingSize.H6Size);
			convertListTag("ul", "list");
			convertListTag("ol", "list");
			checkCodeTag();
			checkImgTag();
			checkStrongTag();
			checkEmTag();
			
			return XML(_markup);
		}
		
		/**
		 * 	Defines a valid "XHTML 1.0 Strict" file as new source for this 
		 * 	<code>BasicHtmlParser</code> instance.
		 * 
		 * 	@param	xhtml	The XHTML source for this <code>BasicHtmlParser</code>
		 * 					instance.
		 */
		public function setSource(xhtml:XML):void {
			XML.ignoreWhitespace = true;
			_xhtml = xhtml;
			_imgNum = 0;
		}
		
		/**
		 * 	Returns the number of external images contained within the XHTML
		 * 	currently associated with this <code>BasicHtmlParser</code> instance.
		 * 
		 * 	@return	The number of external images contained within the XHTML
		 * 			associated with this <code>BasicHtmlParser</code> instance.
		 */
		public function getImagesNum():int {
			return _imgNum;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _xhtml:XML;
		private var _markup:XMLList;
		private var _head:XMLList;
		private var _imgNum:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function checkPTag():void {
			var callback:Function = function(node:XML, parent:XML):void {
				node.@styleName = composeStyleName(node, "p");
			} 
			XMLUtil.filterNodesByName(XML(_markup), "p", callback);
		}
			
		private function checkImgTag():void {
			_imgNum = 0;
			var callback:Function = function(node:XML, parent:XML):void {
				node.@src.setName("source");
				node.@styleName = composeStyleName(node, "img");
				_imgNum++;
			} 
			XMLUtil.filterNodesByName(XML(_markup), "img", callback);
		}
		
		private function checkHeadingTag(name:String, fontSize:int):void {
			var hList:XMLList = _markup.child(name);
			var l:int = hList.length() - 1;
			for (; l >= 0; l--) setHeadingAtt(hList[l], name, fontSize);
		}
		
		private function setHeadingAtt(h:*, name:String, fontSize:int):void {
			h.setName("p");
			h.@styleName = composeStyleName(h, name);
			h.@fontSize = fontSize;
			h.@fontWeight = "bold";
		}
		
		private function composeStyleName(h:*, name:String):String {
			var att:XML = h.attribute("id")[0];
			if (att != null) h.@id = "#" + att.toXMLString().toLowerCase();
			att = h.attribute("class")[0];
			var n:String;
			if (att != null) {
				n = "." + att.toXMLString().toLowerCase() + "--" + name;
				delete h.@["class"];
			} else n = name;
			return n; 
		}
		
		private function convertListTag(xhtml:String, textFlow:String):void {
			var callback:Function = function(node:XML, parent:XML):void {
				node.setName(textFlow);
				node.@styleName = composeStyleName(node, xhtml);
				if (xhtml == "ol") node.@listStyleType = "decimal";
			} 
			XMLUtil.filterNodesByName(XML(_markup), xhtml, callback);
		}
		
		private function checkCodeTag():void {
			var callback:Function = function(node:XML, parent:XML):void {
				node.setName("span");
				node.@styleName = composeStyleName(node, "code");
				node.@fontFamily = WebFonts.COURIER_NEW;
			} 
			XMLUtil.filterNodesByName(XML(_markup), "code", callback);
		}
		
		private function checkStrongTag():void {
			var callback:Function = function(node:XML, parent:XML):void {
				node.setName("span");
				node.@fontWeight = "bold";
				node.@styleName = composeStyleName(node, "strong");
			} 
			XMLUtil.filterNodesByName(XML(_markup), "strong", callback);
		}
		
		private function checkEmTag():void {
			var callback:Function = function(node:XML, parent:XML):void {
				node.setName("span");
				node.@fontStyle = "italic";
				node.@styleName = composeStyleName(node, "em");
			} 
			XMLUtil.filterNodesByName(XML(_markup), "em", callback);
		}
	}
}