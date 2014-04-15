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
	// StateObjectBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/06/2009 10:02
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>StateObjectBase</code> class is the base class for all
	 * 	<code>StateObject</code> isnatnces.
	 * 
	 * 	@see org.flashapi.swing.state.StateObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class StateObjectBase extends Object {
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>StateObjectBase</code> object with the
		 * 	specified parameter.
		 * 
		 * 	@param	uio	The <code>IUIObject</code> instance that implement this
		 * 				<code>StateObjectBase</code> object.
		 */	
		public function StateObjectBase(uio:IUIObject) { 
			super();
			initObj(uio);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>up</code> property.
		 * 
		 * 	@see #up
		 */
		protected var $up:*;
		/**
		 * 	@copy org.flashapi.swing.state.StateObject#up
		 */
		public function get up():* {
			return $up;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>over</code> property.
		 * 
		 * 	@see #over
		 */
		protected var $over:*;
		/**
		 * 	@copy org.flashapi.swing.state.StateObject#over
		 */
		public function get over():* {
			return $over;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>down</code> property.
		 * 
		 * 	@see #down
		 */
		protected var $down:*;
		/**
		 * 	@copy org.flashapi.swing.state.StateObject#down
		 */
		public function get down():* {
			return $down;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>disabled</code> property.
		 * 
		 * 	@see #disabled
		 */
		protected var $disabled:*;
		/**
		 * 	@copy org.flashapi.swing.state.StateObject#disabled
		 */
		public function get disabled():* {
			return $disabled;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selected</code> property.
		 * 
		 * 	@see #selected
		 */
		protected var $selected:Object;
		/**
		 * 	@copy org.flashapi.swing.state.StateObject#selected
		 */
		public function get selected():* {
			return $selected;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.state.StateObject#finalize()
		 */
		public function finalize():void {
			$uio = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Stores an internal reference to the <code>IUIObject</code> instance for
		 * 	which to manage propeties for each state.
		 */
		protected var $uio:IUIObject;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function redraw():void {
			if ($uio.displayed) $uio.redraw();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(uio:IUIObject):void {
			$uio = uio;
			$up = $over = $down = $disabled = $selected = StateObjectValue.NONE;
		}
	}
}