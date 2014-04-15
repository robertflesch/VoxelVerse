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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// DataGridItemRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/06/2009 16:05
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DataGridItemRenderer</code> interface defines the basic 
	 * 	set of APIs that you must implement to create <code>DataGrid</code>
	 * 	items.
	 * 
	 * 	@see org.flashapi.swing.DefaultDataGridItemRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DataGridItemRenderer extends TextItemRenderer {
		
		/**
		 * 	Sets or gets the data field value associated with this
		 * 	<code>DataGridItemRenderer</code> object.
		 */
		function get dataField():String;
		function set dataField(value:String):void;
		
		/**
		 * 	Specifies a new color for the text used by this <code>TextItemRenderer</code>
		 * 	instance.
		 * 
		 * 	@param	color	The new text color of the <code>TextItemRenderer</code> object.
		 */
		function setFontColor(color:uint):void;
	}
}