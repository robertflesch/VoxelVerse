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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// WebFonts.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/12/2008 00:01
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>WebFonts</code> class is an enumeration of constant values that
	 * 	specify the list of the eleven fonts that are commonly held to be safe
	 * 	for use in Web Design.
	 * 
	 * 	@see http://en.wikipedia.org/wiki/Core_fonts_for_the_Web
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WebFonts {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new WebFonts
		 * 				instance.
		 */
		public function WebFonts() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies the "Arial" Web-safe font.
		 */
		public static const ARIAL:String = "Arial";
		
		/**
		 * 	Specifies the "Arial Black" Web-safe font.
		 */
		public static const ARIAL_BLACK:String = "Arial Black";
		
		/**
		 * 	Specifies the "Comic Sans MS" Web-safe font.
		 */
		public static const COMIC_SANS_MS:String = "Comic Sans MS";
		
		/**
		 * 	Specifies the "Courier New" Web-safe font.
		 */
		public static const COURIER_NEW:String = "Courier New";
		
		/**
		 * 	Specifies the "Georgia" Web-safe font.
		 */
		public static const GEORGIA:String = "Georgia";
		
		/**
		 * 	Specifies the "Impact" Web-safe font.
		 */
		public static const IMPACT:String = "Impact";
		
		/**
		 * 	Specifies the "Symbol" Web-safe font.
		 */
		public static const SYMBOL:String = "Symbol";
		
		/**
		 * 	Specifies the "Times New Roman" Web-safe font.
		 */
		public static const TIMES_NEW_ROMAN:String = "Times New Roman";
		
		/**
		 * 	Specifies the "Trebuchet MS" Web-safe font.
		 */
		public static const TREBUCHET_MS:String = "Trebuchet MS";
		
		/**
		 * 	Specifies the "Verdana" Web-safe font.
		 */
		public static const VERDANA:String = "Verdana";
		
		/**
		 * 	Specifies the "Webdings" Web-safe font.
		 */
		public static const WEBDINGS:String = "Webdings";
	}
}