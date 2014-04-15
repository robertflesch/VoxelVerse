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
	// ThumbUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 16:20
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ThumbUI</code> interface defines the interface required to
	 * 	create thumb objects look and feels.
	 * 
	 * 	@see org.flashapi.swing.AbstractThumb
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ThumbUI extends LookAndFeel {
		
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
		 * 	This method is used by the look and feel to draw the thumb
		 * 	when the mouse is not over it.
		 * 
		 * @param	dto
		 */
		function drawOutState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the thumb
		 * 	when the mouse is over it.
		 * 
		 * @param	dto
		 */
		function drawOverState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the thumb
		 * 	when the mouse is over it and the mouse left button is clicked.
		 * 
		 * @param	dto
		 */
		function drawPressedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the thumb
		 * 	when the <code>Thumb.selected</code> property is set to true.
		 * 
		 * @param	dto
		 */
		function drawSelectedState():void;
	}
}