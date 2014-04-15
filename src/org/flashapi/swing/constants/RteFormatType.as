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
	// RteFormatType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/02/2011 01:06
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>RteFormatType</code> class is an enumeration of constant values that
	 * 	are internally used by the <code>RichTextEditor</code> class to specify the
	 * 	type of format selected by the user.
	 * 
	 * 	@see org.flashapi.swing.RichTextEditor
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class RteFormatType {
		
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
		 * 				RteFormatType instance.
		 */
		public function RteFormatType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates that the user has selected the "bold" button.
		 */
		public static const BOLD:String = "bold";
		
		/**
		 * 	Indicates that the user has selected the "italic" button.
		 */
		public static const ITALIC:String = "italic";
		
		/**
		 * 	Indicates that the user has selected the "underline" button.
		 */
		public static const UNDERLINE:String = "underline";
		
		/**
		 * 	Indicates that the user has selected the "bullet" button.
		 */
		public static const BULLET:String = "bullet";
		
		/**
		 * 	Indicates that the user has selected a font in the font list.
		 */
		public static const FONT:String = "font";
		
		/**
		 * 	Indicates that the user has selected a size in the size list.
		 */
		public static const SIZE:String = "size";
		
		/**
		 * 	Indicates that the user has selected an "align" button.
		 */
		public static const ALIGN:String = "align";
		
		/**
		 * 	Indicates that the user has selected a new color.
		 */
		public static const COLOR:String = "color";
		
		/**
		 * 	Indicates that the user has typed a new URL.
		 */
		public static const URL:String = "url";
	}
}