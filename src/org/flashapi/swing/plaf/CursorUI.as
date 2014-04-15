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
	// CursorUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 15/02/2009 12:01
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>CursorUI</code> interface defines the interface required to
	 * 	create <code>Cursor</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.cursor.Cursor
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface CursorUI extends LookAndFeel {
		
		/**
		 * 	This method draws the "Default" cursor face.
		 */
		function drawDefaultCursor():void;
		
		/**
		 * 	This method draws the "South West" cursor face.
		 */
		function drawSWResizeCursor():void;
		
		/**
		 * 	This method draws the "South East" cursor face.
		 */
		function drawSEResizeCursor():void;
		
		/**
		 * 	This method draws the "North West" cursor face.
		 */
		function drawNWResizeCursor():void;
		
		/**
		 * 	This method draws the "North East" cursor face.
		 */
		function drawNEResizeCursor():void;
		
		/**
		 * 	This method draws the "North" cursor face.
		 */
		function drawNResizeCursor():void;
		
		/**
		 * 	This method draws the "West" cursor face.
		 */
		function drawWResizeCursor():void;
		
		/**
		 * 	This method draws the "East" cursor face.
		 */
		function drawEResizeCursor():void;
		
		/**
		 * 	This method draws the "South" cursor face.
		 */
		function drawSResizeCursor():void;
		
		/**
		 * 	This method draws the "Horizontal Divider" cursor face.
		 */
		function drawHDividerCursor():void;
	}
}