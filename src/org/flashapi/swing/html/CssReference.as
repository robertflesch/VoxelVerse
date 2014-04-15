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
	// CssReference.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/03/2011 15:15
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	<code>CssReference</code> objects contains a representation of style sheet
	 * 	references specified by the <code>link</code> tags of a XHTML document.
	 * 
	 * 	@see org.flashapi.swing.html.BasicHtmlParser#getCssCollection()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class CssReference {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>CssReference</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param	href	Specifies an URI that acts as the base URI for this
		 * 					<code>CssReference</code>.
		 * 	@param	media	Specifies the intended destination medium for style information.
		 * 	@param	title	Offers advisory information about this <code>CssReference</code>.
		 */
		public function CssReference(href:String, media:String = "screen", title:String = "") {
			super();
			initObj(href, media, title);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies the intended destination medium for style information.
		 */
		public var media:String;
		
		/**
		 * 	Offers advisory information about this <code>CssReference</code>.
		 */
		public var title:String;
		
		/**
		 * 	Specifies an absolute URI that acts as the base URI for this <code>CssReference</code>.
		 */
		public var href:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(href:String, media:String, title:String):void {
			this.media = media;
			this.title = title;
			this.href = href;
		}
	}
}