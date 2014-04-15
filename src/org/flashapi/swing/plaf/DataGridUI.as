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
	// DataGridUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/01/2009 00:47
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>DataGridUI</code> interface defines the interface required to
	 * 	create <code>DataGrid</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DataGridUI extends BorderUI {
		
		/**
		 * 	Returns the default color of the datagrid highlighted rows for this Look and Feel.
		 * 
		 * 	@return	The default color of the datagrid highlighted rows for this Look and Feel.
		 */
		function getRowBrightColor():uint;
		
		/**
		 * 	Returns the default color of the datagrid darked rows for this Look and Feel.
		 * 
		 * 	@return	The default color of the datagrid darked rows for this Look and Feel.
		 */
		function getRowDarkColor():uint;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	for the items of the datagrid headers.
		 * 
		 * 	@return	The datagrid items <code>FontFormat</code> used by the look and feel.
		 */
		function getDefautFontFormat():FontFormat;
		
		/**
		 * 	Returns a reference to the <code>FontFormat</code> used by the look and feel
		 * 	for the texts of the datagrid headers.
		 * 
		 * 	@return	The datagrid headers <code>FontFormat</code> used by the look and feel.
		 */
		function getDefautHeaderFontFormat():FontFormat;
		
		/**
		 * 	Returns the <code>Class</code> reference that represents the Look and Feel for the
		 * 	scroll bar of the <code>DataGrid</code> instance. This class must implement the 
		 * 	<code>ScrollBarUI</code> interface.
		 * 
		 * 	@return	The class used as look and feel for the datagrid scroll bar.
		 * 
		 * 	@see org.flashapi.swing.plaf.ScrollBarUI
		 */
		function getScrollBarLaf():Class;
		
		/**
		 * 	Returns the <code>Class</code> reference that represents the Look and Feel for the
		 * 	header of the <code>DataGrid</code> instance. This class must implement the 
		 * 	<code>DataGridHeaderUI</code> interface.
		 * 
		 * 	@return	The class used as look and feel for the datagrid headers.
		 * 
		 * 	@see org.flashapi.swing.plaf.DataGridHeaderUI
		 */
		function getHeaderLaf():Class;
	}
}