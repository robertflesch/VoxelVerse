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
	// ButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 09/11/2010 10:35
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>ButtonUI</code> interface defines the interface required to
	 * 	create <code>Button</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ButtonUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the default border color of the look and feel.
		 * 
		 * 	@return	The default border color of this look and feel.
		 */
		function getBorderColor():uint;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the mouse is not over it.
		 */
		function drawOutState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the mouse is over it.
		 */
		function drawOverState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the mouse is over it and the mouse left button is clicked.
		 */
		function drawPressedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the <code>Button.selected</code> property is set to <code>true</code>.
		 */
		function drawSelectedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		function drawInactiveState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		function drawInactiveIcon():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the <code>UIObject.active</code> property is set to <code>true</code>.
		 */
		function drawActiveIcon():void;
		
		/**
		 * 	This method is used by the look and feel to draw the button face
		 * 	when the <code>Button.dotted</code> property is set to <code>true</code>.
		 */
		function drawDottedLine():void;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	when the mouse is not over the button.
		 * 
		 * 	@return	The "up" state <code>FontFormat</code> used by the look and feel.
		 */
		function getUpFontFormat():FontFormat;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	when the mouse is over the button.
		 * 
		 * 	@return	The "over" state <code>FontFormat</code> used by the look and feel.
		 */
		function getOverFontFormat():FontFormat;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	when the mouse is over the button and the mouse left button is clicked.
		 * 
		 * 	@return	The "down" state <code>FontFormat</code> used by the look and feel.
		 */
		function getDownFontFormat():FontFormat;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	when the button <code>selected</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "selected" state <code>FontFormat</code> used by the look and feel.
		 */
		function getSelectedFontFormat():FontFormat;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	when the the button is disabled.
		 * 
		 * 	@return	The "disabled" state <code>FontFormat</code> used by the look and feel.
		 */
		function getDisabledFontFormat():FontFormat;
		
		/**
		 * 	Returns an integer that represents the grey tint color applied to 
		 * 	the button text when the <code>Button.greyTint</code> property
		 * 	is set to <code>true</code>.
		 * 	
		 * 	@return  The value for the button grey tint color.
		 */
		function getGrayTintColor():uint;
		
		/**
		 * 	Returns a number that represents the gap between the icon and the
		 * 	text displayed on the button face.
		 * 
		 *	@return The gap between the icon and the text displayed on the button face.
		 */
		function getIconDelay():Number;
		
		/**
		 *	Returns the button top offset distance.<br />
		 *  The top offset distance defines the distance between the top edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button top offset distance.
		 */
		function getTopOffset():Number;
		
		/**
		 *	Returns the button left offset distance.<br />
		 *  The left offset distance defines the distance between the left edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button left offset distance.
		 */
		function getLeftOffset():Number;
		
		/**
		 *	Returns the button right offset distance.<br />
		 *  The right offset distance defines the distance between the right edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button right offset distance.
		 */
		function getRightOffset():Number;
		
		/**
		 *	Returns the button bottom offset distance.<br />
		 *  The bottom offset distance defines the distance between the bottom edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button bottom offset distance.
		 */
		function getBottomOffset():Number;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is not over the button.
		 * 
		 * 	@return	The "out" state icon color used by the look and feel
		 */
		function getOutIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the button.
		 * 
		 * 	@return	The "over" state icon color used by the look and feel
		 */
		function getOverIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the button and the mouse left button is clicked.
		 * 
		 * 	@return	The "pressed" state icon color used by the look and feel
		 */
		function getPressedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the button <code>selected</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "selected" state icon color used by the look and feel
		 */
		function getSelectedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the button <code>inactive</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "inactive" state icon color used by the look and feel
		 */
		function getInactiveIconColor():uint;
	}
}