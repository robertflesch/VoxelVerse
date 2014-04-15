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
	// DataFormat.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 02/04/2009 13:25
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DataFormat</code> class is an enumeration of constant values that
	 * 	you can use to indicate the type of data that are manipulated, for example
	 * 	for loading external assets.
	 * 
	 * 	@see org.flashapi.swing.net.DataLoader
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class DataFormat {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new DataFormat
		 * 				instance.
		 */
		public function DataFormat() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that data object is received as text.
		 */
		public static const TEXT:String = "text";
		
		/**
		 * 	Specifies that data object is received as a CSS file.
		 */
		public static const CSS:String = "css";
		
		/**
		 * 	Specifies that data object is received as a HTML file.
		 */
		public static const HTML:String = "html";
		
		/**
		 * 	Specifies that downloaded data is received as graphic that must be
		 * 	added to the browser cash.
		 */
		public static const CACHED_GRAPHIC:String = "cachedGraphic";
		
		/**
		 * 	Specifies that data object is received as graphic.
		 */
		public static const GRAPHIC:String = "graphic";
		
		/**
		 * 	Specifies that data object is received as a XML file.
		 */
		public static const XML:String = "xml";
		
		/**
		 * 	Specifies that data object is received as a list of variables.
		 */
		public static const VARIABLES:String = "variables";
		
		/**
		 * 	Specifies that data object is received as a CSV file.
		 */
		public static const CSV:String = "csv";
		
		/**
		 * 	Specifies that data object is received as object.
		 */
		public static const OBJECT:String = "object";
		
		/**
		 * 	Specifies that data object is received as JSON object.
		 */
		public static const JSON:String = "json";
		
		/**
		 * 	Specifies that data object is received as bitmap object.
		 */
		public static const BITMAP:String = "bitmap";
		
		/**
		 * 	Specifies that data object is received as bitmapdata object.
		 */
		public static const BITMAP_DATA:String = "bitmapdata";
		
		/**
		 * 	Specifies that data object is received as a SWF file.
		 */
		public static const SWF:String = "swf";
		
		/**
		 * 	Specifies that data object is received as a FONT file.
		 */
		public static const FONT:String = "font";
	}
}