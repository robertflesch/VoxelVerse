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
	// TextureType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/07/2007 13:19
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>TextureType</code> class is an enumeration of constant values 
	 * 	that you can use to determine the type of gradient of 
	 * 	<code>TextureManager</code> objects.
	 * 
	 * 	@see org.flashapi.swing.managers.TextureManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class TextureType {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new TextureType
		 * 				instance.
		 */
		public function TextureType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>TextureManager</code> uses a plain color to draw the associated
		 *	object.
		 */
		public static const PLAIN:String = "plain";
		
		/**
		 * 	The <code>TextureManager</code> uses a texture pattern to draw the 
		 *	associated object.
		 */
		public static const TEXTURE:String = "texture";
		
		/**
		 * 	The <code>TextureManager</code> uses a set of gradient colors to draw 
		 *	the associated object.
		 */
		public static const GRADIENT:String = "gradient";
		
		/**
		 * 	No method is currently defined by the <code>TextureManager</code> to draw 
		 *	the associated object. This resets the <code>TextureManager</code> object.
		 */
		public static const NONE:String = "none";
	}
}