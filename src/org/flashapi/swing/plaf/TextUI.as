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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// TextUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 18:02
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>TextUI</code> interface defines the interface required to
	 * 	create <code>Text</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Text
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface TextUI extends LookAndFeel {
		
		/**
		 * 	Draws the text background.
		 */
		function drawBackground():void;
		
		/**
		 * 	Clears the text background.
		 */
		function clearBackground():void;
		
		/**
		 * 	Clears the text border.
		 */
		function drawBorder():void;
		
		/**
		 * 	Clears the text border.
		 */
		function clearBorder():void;
		
		/**
		 * 	Returns a reference to the <code>UITextFormat</code> used by the look and feel.
		 * 
		 * 	@return	The <code>TextFormat</code> used by the look and feel
		 * 
		 * 	@see org.flashapi.swing.text.UITextFormat
		 */
		function getTextFormat():UITextFormat;
		
		/** 
		 * 	Returns the default background color of the look and feel.
		 * 
		 * 	@return	The default background color of this look and feel.
		 */
		function getBackgroundColor():uint;
		
		/** 
		 * 	Returns the default border color of the look and feel.
		 * 
		 * 	@return	The default border color of this look and feel.
		 */
		function getBorderColor():uint;
	}
}