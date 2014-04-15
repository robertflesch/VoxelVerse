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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// TabListItem.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 27/04/2009 02:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.TabButton;
	import org.flashapi.swing.Canvas;
	
	/**
	 * 	The <code>TabListItem</code> class create item objects that specifies the
	 * 	<code>item</code> property of <code>ListItem</code> objects used by and
	 * 	accessible from the <code>TabbedPane</code> API. The wrapped items allows
	 * 	acces to a <code>TabButton</code> reference and its associated <code>Canvas</code>
	 * 	container.
	 * 
	 * 	@see org.flashapi.swing.TabbedPane
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TabListItem {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>TabListItem</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	tabButton	The <code>TabButton</code> instance associated
		 * 						with this <code>TabListItem</code> object.
		 * 	@param	view		The <code>Canvas</code> instance associated
		 * 						with this <code>TabListItem</code> object.
		 */
		public function TabListItem(tabButton:TabButton, view:Canvas) {
			super();
			initObj(tabButton, view);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _tabButton:TabButton;
		/**
		 * 	Returns a reference to the <code>TabButton</code> instance associated
		 * 	with this <code>TabListItem</code> object.
		 */
		public function get tabButton():TabButton {
			return _tabButton;
		}
		
		private var _view:Canvas;
		/**
		 * 	Returns a reference to the <code>Canvas</code> instance associated
		 * 	with this <code>TabListItem</code> object.
		 */
		public function get view():Canvas {
			return _view;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all subprocess will
		 * 	be killed for this tablist item. After calling this function you have to 
		 * 	set the tablist item to <code>null</code> to make it elligible for garbage
		 * 	collection.
		 */
		public function finalize():void {
			_view = null;
			_tabButton = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(tabButton:TabButton, view:Canvas):void {
			_tabButton = tabButton;
			_view = view;
		}
	}
}