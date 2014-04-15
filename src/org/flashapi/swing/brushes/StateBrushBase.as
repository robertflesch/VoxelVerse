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

package org.flashapi.swing.brushes {
	
	// -----------------------------------------------------------
	// StateBrushBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/05/2009 21:28
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.state.ColorState;
	
	/**
	 * 	The <code>StateBrushBase</code> class is the base class for <code>Brush</code>
	 * 	objects that can be displayed with diferent states, like buttons do.
	 * 
	 * 	<p><code>StateBrush</code> objects are useful to create drawable icons
	 * 	for button.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class StateBrushBase extends BrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function StateBrushBase(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>colors</code> property.
		 * 
		 * 	@see #colors
		 */
		protected var $colors:ColorState;
		/**
		 * 	@inheritDoc
		 */
		public function get colors():ColorState {
			return $colors;
		}
		public function set colors(value:ColorState):void {
			$colors = value;
			if ($isPainted) drawBrushShape($state);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>state</code> property.
		 * 
		 * 	@see #state
		 */
		protected var $state:String = States.OUT;
		/**
		 * 	@inheritDoc
		 */
		public function get state():String {
			return $state;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function paint():void {
			drawOutState();
			$isPainted = true;
		}
		
		/**
		 * @private
		 */
		override public function clear():void {
			$graphics.clear();
			$isPainted = false;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function drawOutState():void {
			$state = States.OUT;
			drawBrushShape($state);
		};
		
		/**
		 * 	@inheritDoc
		 */
		public function drawOverState():void {
			$state = States.OVER;
			drawBrushShape($state);
		};
		
		/**
		 * 	@inheritDoc
		 */
		public function drawPressedState():void {
			$state = States.PRESSED;
			drawBrushShape($state);
		};
		
		/**
		 * 	@inheritDoc
		 */
		public function drawSelectedState():void {
			$state = States.SELECTED;
			drawBrushShape($state);
		};
		
		/**
		 * 	@inheritDoc
		 */
		public function drawEmphasizedState():void {
			$state = States.EMPHASIZED;
			drawBrushShape($state);
		};
		
		/**
		 * 	@inheritDoc
		 */
		public function drawInactiveState():void {
			$state = States.INACTIVE;
			drawBrushShape($state);
		};
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			if ($colors != null) {
				$colors.finalize();
				$colors = null;
			}
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Developers who want to create custom <code>StateBrush</code> object have
		 * 	to override this method.
		 * 
		 *  @param	state	A <code>States</code> class constant that indicates the
		 * 					current state of the <code>StateBrush</code> object.
		 */
		protected function drawBrushShape(state:String):void {}
	}
}