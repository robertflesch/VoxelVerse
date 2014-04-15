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

package org.flashapi.swing.color {
	
	// -----------------------------------------------------------
	// JavaCK.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/01/2008 03:04
	* @see http://www.flashapi.org/
	*/
	
	/**
	 *  The <code>JavaCK</code> class is the "Color Module" for the Java color
	 * 	keywords table.
	 * 
	 * 	@see http://java.sun.com/j2se/1.4.2/docs/api/java/awt/Color.html
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class JavaCK extends ColorModuleBase implements ColorModule {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>JavaCK</code> instance.
		 * 
		 * 	@param	name	The color keyword for the color to determine from the Java
		 * 					"Color Module".
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An InvalidArgumentException
		 * 			if the color keyword specified by the <code>name</code> parameter does
		 * 			not exist in this "Color Module".
		 */
		public function JavaCK(name:String) {
			super(name, COLOR_TABLE, false);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const COLOR_TABLE:Object = {
			black:"0x000000", blue:"0x0000FF", cyan:"0x00FFFF", darkgray:"0x404040",
			gray:"0x807D80", green:"0x00FF00", lightGray:"0x808080", magenta:"0xFF00FF",
			orange:"0xFFC800", pink:"0xFFAFAF", red:"0xFF0000", white:"0xFFFFFF",
			yellow:"0xFFFF00"
		};
	}
}