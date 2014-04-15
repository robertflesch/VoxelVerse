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
	// TextAlign.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/08/2007 23:26
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>TextAlign</code> class is an enumeration of constant values that
	 * 	you can use to set the <code>textAlign</code> property of the <code>ATM</code>
	 * 	class.
	 * 
	 * 	@see org.flashapi.swing.text.ATM#textAlign
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class TextAlign {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new TextAlign
		 * 				instance.
		 */
		public function TextAlign() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Aligns text to the left within the text object.
		 */
		public static const LEFT:String = "left";
		
		/**
		 * 	Aligns text to the right within the text object.
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * 	Centers the text in the text object.
		 */
		public static const CENTER:String = "center";
		
		/**
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const JUSTIFY:String = "justify";
		
		/**
		 * 	<p><strong>Not implemented yet.</strong></p>
		 */
		public static const NONE:String = "none";
	}
}