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
	// WebsafeColorPickerUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 17:49
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>WebsafeColorPickerUI</code> interface defines the interface required to
	 * 	create <code>WebsafeColorPicker</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.WebsafeColorPicker
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface WebsafeColorPickerUI extends LookAndFeel {
		
		/**
		 * 	Draws the color picker color items area.
		 */
		function drawColorArea():void;
		
		/**
		 * 	Draws the color picker color preview panel.
		 */
		function drawPreviewPanel():void;
		
		/**
		 * 	Draws the face of the color items when the mouse is outside them.
		 */
		function drawOutState():void;
		
		/**
		 * 	Draws the face of the color items when the mouse is over them.
		 */
		function drawOverState():void;
		
		/**
		 * 	Draws the face of the color items when the mouse is outside them
		 * 	and the richt button of the mouse is clicked.
		 */
		function drawPressedState():void;
		
		/**
		 * 	Draws the face of the preview color button.
		 */
		function drawPreviewColorButton():void;
		
		/**
		 * 	Returns a number that represents the distance between each color item.
		 * 
		 * 	@return	the distance between each color item.
		 */
		function getColorItemDelay():Number;
		
		/**
		 * 	Returns a number that represents the width and the height of all color items.
		 * 
		 * 	@return	the size of all color items.
		 */
		function getColorItemSize():Number;
		
		/**
		 * 	Returns a number that represents the gap between the border
		 * 	and the color picker controls.
		 * 
		 * 	@return	the gap between the border and the color picker controls.
		 */
		function getBorderDelay():Number;
		
		/**
		 * 	Returns a number that represents the width of the color picker preview area.
		 * 
		 * 	@return	the width of the color picker preview area.
		 */
		function getPreviewWidth():Number;
		
		/**
		 * 	Returns a number that represents the distance between the preview area
		 * 	and the color picker controls.
		 * 
		 * 	@return	the distance between the preview area and the color picker controls.
		 */
		function getPreviewDelay():Number;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the color picker box container. This class must implement the 
		 * 	<code>BoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the color picker box container.
		 * 
		 * 	@see org.flashapi.swing.plaf.BoxUI
		 */
		function getBoxLaf():Class;
		
		/**
		 * 	Returns the default border style of the look and feel.
		 * 	Possible values are the constants of the <code>BorderStyle</code> class.
		 * 
		 * 	@return	The default style color of this look and feel.
		 * 
		 * 	@see org.flashapi.swing.constants.BorderStyle
		 */
		function getBorderStyle():String;
		
		/**
		 * 	Returns the default background color of the look and feel.
		 * 
		 * 	@return	The default background color of this look and feel.
		 */
		function getBackgroundColor():uint;
	}
}