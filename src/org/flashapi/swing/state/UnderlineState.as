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

package org.flashapi.swing.state {
	
	// -----------------------------------------------------------
	// UnderlineState.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 11/10/2009 10:15
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 * 	The <code>UnderlineState</code> class allows to manage different states
	 * 	for <code>UIObject</code> instances that define an underlining statement
	 * 	,within a text object, for each state.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UnderlineState extends StateObjectBase implements StateObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>UnderlineState</code> object with the
		 * 	specified parameter.
		 * 
		 * 	@param	uio	The <code>IUIObject</code> instance that implement this
		 * 				<code>UnderlineState</code> object.
		 */
		public function UnderlineState(uio:IUIObject) {
			super(uio);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function set up(value:*):void {
			$up = value;
			redraw();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set over(value:*):void {
			$over = value;
			redraw();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set down(value:*):void {
			$down = value;
			redraw();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set disabled(value:*):void {
			$disabled = value;
			redraw();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set selected(value:*):void {
			$selected = value;
			redraw();
		}
	}
}