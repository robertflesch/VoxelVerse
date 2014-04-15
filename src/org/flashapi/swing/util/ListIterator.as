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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// ListIterator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/05/2009 18:55
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ListIterator</code> class creates <code>Iterator</code> instances
	 * 	for iterating <code>List</code> objects.
	 * 
	 * 	@see org.flashapi.swing.util.List
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ListIterator implements Iterator {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ListIterator</code> object for the 
		 * 	specified <code>List</code> instance.
		 * 
		 * 	@param	list	The <code>List</code> instance that will be iterated
		 * 					by this <code>ListIterator</code> object.
		 */
		public function ListIterator(list:List) {
			super();
			initObj(list);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function hasNext():Boolean {
			return Boolean(_list.size > _id);
		}
		
		/**
		 * @inheritDoc
		 */
		public function next():Object {
			return _list.get(_id++);
		}
		
		/**
		 * @inheritDoc
		 */
		public function reset():void {
			_id = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function finalize():void {
			_list = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _list:List;
		private var _id:uint = 0;
		
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(list:List):void {
			_list = list;
		}
	}
}