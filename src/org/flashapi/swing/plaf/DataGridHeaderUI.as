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
	// DataGridHeaderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/12/2008 14:06
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DataGridHeaderUI</code> interface defines the interface required to
	 * 	create <code>DataGridHeader</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.table.DataGridHeader
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DataGridHeaderUI extends LookAndFeel {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>Class</code> reference that represents the Look and Feel for the
		 * 	text control of the <code>DataGridHeader</code> instance. This class must implement the 
		 * 	<code>TextUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the datagrid header text controls.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextUI
		 */
		function getTextLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as arrow icon.
		 * 	This class must implement the <code>StateBrush</code> interface.
		 * 	
		 * 	@return	The class used as arrow icon.
		 * 
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		function getIcon():Class;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 *  Draws the background of the datagrid header row.
		 */
		function drawBackground():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the mouse is not over it.
		 */
		function drawOutState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the mouse is over it.
		 */
		function drawOverState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the mouse is over it and the mouse left button is clicked.
		 */
		function drawPressedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the <code>Button.selected</code> property is set to <code>true</code>.
		 */
		function drawSelectedState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		function drawInactiveState():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		function drawInactiveIcon():void;
		
		/**
		 * 	This method is used by the look and feel to draw the header face
		 * 	when the <code>UIObject.active</code> property is set to <code>true</code>.
		 */
		function drawActiveIcon():void;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is not over the datagrid header.
		 * 
		 * 	@return	The "out" state icon color used by the look and feel
		 */
		function getOutIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the mouse is over the datagrid header.
		 * 
		 * 	@return	The "over" state icon color used by the look and feel
		 */
		function getOverIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when the mouse
		 * 	is over the datagrid header and the mouse left button is clicked.
		 * 
		 * 	@return	The "pressed" state icon color used by the look and feel
		 */
		function getPressedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the datagrid header <code>selected</code> property is set to
		 * 	<code>true</code>.
		 * 
		 * 	@return	The "selected" state icon color used by the look and feel
		 */
		function getSelectedIconColor():uint;
		
		/**
		 * 	Returns the icon color used by the look and feel when
		 * 	the datagrid header <code>inactive</code> property is set to
		 * 	<code>true</code>.
		 * 
		 * 	@return	The "inactive" state icon color used by the look and feel
		 */
		function getInactiveIconColor():uint;
	}
}