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
	// UIGarbageCollector.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 26/10/2009 08:45
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Finalizable;
	
	/**
	 * 	The <code>UIGarbageCollector</code> class provides a fast and easy way to 
	 * 	delete collections of <code>Finalizable</code> objects.
 	 * 
	 * 	<p><strong>Note: </strong> No assumptions are made about the order of this collection 
	 * 	(if any), or whether it may contain duplicate elements.</p>
	 * 
	 * 	@see org.flashapi.swing.core.Finalizable
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UIGarbageCollector {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>UIGarbageCollector</code> instance.
		 */
		public function UIGarbageCollector() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a <code>Finalizable</code> object to this <code>UIGarbageCollector</code>
		 * 	object.
		 * 
		 * 	@param	uio A <code>Finalizable</code> object to add to this
		 * 				<code>UIGarbageCollector</code> object.
		 */
		public function add(uio:Finalizable):void {
			_stack.push(uio);
		}
		
		/**
		 * 	Removes all <code>Finalizable</code> objects registered within this
		 * 	<code>UIGarbageCollector</code> object.
		 */
		public function clear():void {
			_stack = [];
		}
		
		/**
		 * 	Finalizes all <code>Finalizable</code> objects registered within this
		 * 	<code>UIGarbageCollector</code> object. Then, set finalized objects
		 * 	to <code>null</code> to make them elligible for garbage collection.
		 */
		public function finalizeAll():void {
			for each(var uio:Finalizable in _stack) {
				uio.finalize();
				uio = null;
			}
			clear();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			clear();
		}
	}
}