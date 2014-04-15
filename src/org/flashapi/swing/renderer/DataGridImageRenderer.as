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
	// DataGridImageRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/03/2011 14:53
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DataGridImageRenderer</code> class defines the default image item
	 * 	renderer for a <code>DataGrid</code> object.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class DataGridImageRenderer extends AbstractDataGridRenderer implements DataGridItemRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DataGridImageRenderer</code> object
		 * 	with the specified parameters.
		 * 
		 * 	@param	width	The width of the <code>DataGridImageRenderer</code>
		 * 					object, in pixels.
		 * 	@param	height	The height of the <code>DataGridImageRenderer</code>
		 * 					object, in pixels.
		 */
		public function DataGridImageRenderer(width:Number = 20, height:Number = 20) {
			super(width, height);
			//spas_internal::setSelector("DataGridImageRenderer");
		}
		
		//--------------------------------------------------------------------------
		//
		//  ItemRenderer API : public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		override public function updateItem(info:Object):void {
			this.invalidateRefresh = true;
			this.removeElements();
			this.invalidateRefresh = false;
			this.addElement(info);
		}
	}
}