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
	// DividerButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/09/2008 15:12
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	
	/**
	 * 	The <code>DividerButtonUI</code> interface defines the interface required to
	 * 	create <code>DividedBoxButton</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.button.core.DividedBoxButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DividerButtonUI extends LookAndFeel {
		
		/**
		 * 	This method is used by the look and feel to draw the divider button
		 * 	when the mouse is not over it.
		 */
		function drawOutState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the divider button
		 * 	when the mouse is over it.
		 */
		function drawOverState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the divider button
		 * 	when the mouse is over it and the mouse left button is clicked.
		 */
		function drawPressedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the divider button
		 * 	when the <code>Button.selected</code> property is set to <code>true</code>.
		 */
		function drawSelectedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the divider button
		 * 	when the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		function drawInactiveState():void;
		
		/**
		 * 
		 * 	@param target The Sprite object used by the look and feel to draw the button separator line.
		 */
		function drawSeparator(target:Sprite, width:Number, height:Number):void;
		
		/**
		 * 
		 * 	@param target The Sprite object used by the look and feel to clear the button separator line.
		 */
		function clearSeparator(target:Sprite):void;
	}
}