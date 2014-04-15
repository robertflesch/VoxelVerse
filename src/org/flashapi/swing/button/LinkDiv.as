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

package org.flashapi.swing.button {
	
	// -----------------------------------------------------------
	//  LinkDiv
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 21/05/2009 16:47
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * 	[This clas is under development.]
	 * 
	 * 	The <code>LinkDiv</code> class defines the appearance of the navigation
	 * 	buttons of a <code>PageNavigator</code> object.
	 * 
	 * 	@see org.flashapi.swing.PageNavigator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 **/
	public class LinkDiv extends TextField {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>LinkDiv</code> instance.
		 */
		public function LinkDiv() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The current index associated with this <code>LinkDiv</code> instance.
		 */
		public var index:uint;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>LinkDiv</code>
		 * 	instance is selected (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public var selected:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			selectable = false;
			autoSize = TextFieldAutoSize.LEFT;
			background = border = true;
		}
	}
}