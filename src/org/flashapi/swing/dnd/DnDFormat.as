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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DnDFormat.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/08/2009 15:29
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	An convenient object that defines a drop format for a Drag and Drop
	 * 	operation. <code>DnDFormat</code> are composed of a pair format/data 
	 * 	values.
	 * 
	 * 	@see org.flashapi.swing.core.UIObject#addDropFormat()
	 * 	@see org.flashapi.swing.core.UIObject#hasDropFormat()
	 * 	@see org.flashapi.swing.core.UIObject#removeDropFormat()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DnDFormat {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DnDFormat</code> instance.
		 * 
		 * 	@param	format	A <code>String</code> that defines the format for this
		 * 					<code>DnDFormat</code> object.
		 * 	@param	data	The data for this <code>DnDFormat</code> object.
		 */
		public function DnDFormat(format:String, data:* = null) {
			super();
			initObj(format, data);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The data for this <code>DnDFormat</code> object.
		 */
		public var data:*;
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _format:String;
		/**
		 * 	Sets or gets the format for this <code>DnDFormat</code> object.
		 */
		public function get format():String {
			return _format;
		}
		public function set format(value:String):void {
			_format = value;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(format:String, data:*):void {
			_format = format;
			this.data = data;
		}
	}
}