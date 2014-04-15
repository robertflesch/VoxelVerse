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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// TextItemRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 09/05/2011 01:50
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>TextItemRenderer</code> interface defines the basic 
	 * 	set of APIs that you must implement to create <code>ItemRenderer</code>
	 * 	objects that allows access to some textfield properties.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface TextItemRenderer extends ItemRenderer {
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the
		 * 	text item renderer is boldface (<code>true</code>) or not
		 * 	(<code>false</code>). 
		 */
		function get boldFace():Boolean;
		function set boldFace(value:Boolean):void;
		
		/**
		 * 	Initializes the format of the font used by the <code>TextItemRenderer</code>
		 * 	instance with the specified <code>FontFormat</code> object.
		 * 
		 * 	@param	value	The <code>FontFormat</code> object to use for initializng
		 * 					the <code>TextItemRenderer</code> font format.
		 */
		function initFontFormat(value:FontFormat):void;
	}
}