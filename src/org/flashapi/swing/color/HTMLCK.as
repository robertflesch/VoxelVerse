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
	// HTMLCK.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/01/2008 02:21
	* @see http://www.flashapi.org/
	*/
	
	/**
	 *  The <code>HTMLCK</code> class is the "Color Module" for the HTML4 color
	 * 	keywords table.
	 * 
	 * 	@see http://www.w3.org/TR/css3-color/#html4
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class HTMLCK extends ColorModuleBase implements ColorModule {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>HTMLCK</code> instance.
		 * 
		 * 	@param	name	The color keyword for the color to determine from the HTML4
		 * 					"Color Module".
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An InvalidArgumentException
		 * 			if the color keyword specified by the <code>name</code> parameter does
		 * 			not exist in this "Color Module".
		 */
		public function HTMLCK(name:String) {
			super(name, COLOR_TABLE, false);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const COLOR_TABLE:Object = {
			black:"0x000000", silver:"0xC0C0C0", gray:"0x808080", white:"0xFFFFFF",
			maroon:"0x800000", red:"0xFF0000", purple:"0x800080", fuchsia:"0xFF00FF",
			green:"0x008000", lime:"0x00FF00", olive:"0x808000", yellow:"0xFFFF00",
			navy:"0x000080", blue:"0x0000FF", teal:"0x008080", aqua:"0x00FFFF"
		};
	}
}