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
	// ViewportDataGridUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/04/2011 01:30
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ViewportDataGridUI</code> interface defines the interface required to
	 * 	create <code>ViewportDataGrid</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.ViewportDataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.7
	 */
	public interface ViewportDataGridUI extends BorderUI {
		
		/**
		 * 	Returns the <code>Class</code> reference that represents the Look and Feel for the
		 * 	datagrid of the <code>ViewportDataGrid</code> instance. This class must implement  
		 * 	the <code>DataGridUI</code> interface.
		 * 
		 * 	@return	The class used as look and feel for the datagrid object.
		 * 
		 * 	@see org.flashapi.swing.plaf.DataGridUI
		 */
		function getDataGridLaf():Class;
		
		/**
		 * 	Draws the header area displayed above the vertical scrollbar. The header area
		 * 	should have the same appearence as the background of the datagrid header.
		 * 
		 * 	@see org.flashapi.swing.plaf.DataGridHeaderUI
		 */
		function drawScrollBarHeader():void;
	}
}