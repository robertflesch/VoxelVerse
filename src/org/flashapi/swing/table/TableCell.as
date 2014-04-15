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

package org.flashapi.swing.table {
	
	// -----------------------------------------------------------
	// TableCell.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 21:23
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.CellType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>TableCell</code> class represents a <code>Cell</code> instance used
	 * 	within a <code>Table</code> object.
	 * 
	 * 	@see org.flashapi.swing.Table
	 * 	@see org.flashapi.swing.table.TableHeader
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TableCell extends Cell {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>TableCell</code> object with the specified
		 * 	properties.
		 * 
		 * 	@param	borderStyle	The type of border for this <code>TableCell</code> object.
		 * 						Possible values are constants of the <code>BorderStyle</code>
		 * 						class.
		 * 	@param	type	The type of <code>TableCell</code>. Possible values are constants
		 * 					of the <code>CellType</code> class.
		 */
		public function TableCell(borderStyle:String = BorderStyle.SOLID, type:String = CellType.TEXT_NODE) {
			super(borderStyle, type);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::setSelector(Selectors.TD);
			spas_internal::isInitialized(3);
		}
	}
}