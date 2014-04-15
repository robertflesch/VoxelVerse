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
	// ScrollBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/10/2009 08:59
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ScrollBarUI</code> interface defines the interface required to
	 * 	create <code>ScrollBar</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.ScrollBar
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ScrollBarUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Draws the scrollBar track.
		 */
		function drawTrack():void;
		
		/**
		 * 	Draws the scrollBar thumb.
		 */
		function drawThumb():void;
		
		/**
		 * 	Draws the scrollBar up button.
		 */
		function drawUpButton():void;
		
		/**
		 * 	Draws the scrollBar down button.
		 */
		function drawDownButton():void;
		
		/**
		 * 	Draws the scrollBar bottom right corner.
		 */
		function drawBottomRightCorner():void;
		
		/**
		 * 	Removes the scrollBar bottom right corner.
		 */
		function clearBottomRightCorner():void;
		
		/**
		 * 	Returns the width of the scrollBar for the current look and feel.
		 * 
		 * 	@return	the width of the scrollBar, in pixels.
		 */
		function getScrollBarWidth():Number;
		
		/**
		 * 	Returns the minimal size of the scrollBar for the current look and feel.
		 * 
		 * 	@return	the minimal size of the scrollBar, in pixels.
		 */
		function getMinLength():Number;
	}
}