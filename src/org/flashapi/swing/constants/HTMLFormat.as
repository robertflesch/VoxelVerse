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
	// HTMLFormat.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 08/03/2011 13:54
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>HTMLFormat</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>htmlFormat</code> property of the
	 * 	<code>BasicHtmlPage</code> class.
	 * 
	 * 	@see org.flashapi.swing.html.BasicHtmlPage#htmlFormat
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */	
	public class HTMLFormat {
		
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
		 * 				HTMLFormat instance.
		 */
		public function HTMLFormat() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Value that indicates that the XML object represents a valid XHTML 1.0
		 * 	strict full page.
		 */
		public static const XHTML_PAGE:String = "xhtmlPage";
		
		/**
		 * 	Value that indicates that the XML object represents the <code>body</code>
		 * 	tag of a valid XHTML 1.0 strict page.
		 */
		public static const BODY:String = "body";
		
		/*
		 * 	Value that indicates that the XML object represents a collection of
		 * 	valid XHTML 1.0 strict tags.
		 */
		public static const XML:String = "XML";
	}
}