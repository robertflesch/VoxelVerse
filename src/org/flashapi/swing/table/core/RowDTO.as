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

package org.flashapi.swing.table.core {
	
	// -----------------------------------------------------------
	// RowDTO.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/11/2010 17:49
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	A convenient proxy object that describes some properties of a datagrid row.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RowDTO extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>RowDTO</code> object with the specified
		 * 	default height.
		 * 
		 * 	@param	defaultHeight
		 */
		public function RowDTO(defaultHeight:Number) {
			super();
			initObj(defaultHeight)
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The height of the row associated with this <code>RowDTO</code> object,
		 * 	in pixels.
		 */
		public var height:Number;
		
		/**
		 * 	The background color of the row associated with this <code>RowDTO</code>
		 * 	object.
		 */
		public var color:Number;
		
		/**
		 * 	Indicates whether the row associated with this <code>RowDTO</code> object
		 * 	is selected (<code>true</code>), or not (<code>false</code>).
		 */
		public var selected:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(defaultHeight:Number):void {
			this.height = defaultHeight;
			this.color = NaN;
			this.selected = false;
		}
	}
}