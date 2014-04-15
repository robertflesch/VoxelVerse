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

package org.flashapi.swing.icons {
	
	// -----------------------------------------------------------
	// UpDownIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/09/2009 17:12
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.icons.core.DirectionIcon;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>UpDownIcon</code> class is used to draw the icon of
	 * 	<code>DropList</code> instances.
	 * 
	 * 	@see org.flashapi.swing.list.DropListBase
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UpDownIcon extends DirectionIcon implements StateBrush, StateIcon {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function UpDownIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter methods
		//
		//--------------------------------------------------------------------------
		
		private var _nextState:int = 0;
		/**
		 * @inheritDoc
		 */
		public function get nextState():int {
			return _nextState;
		}
		public function set nextState(value:int):void {
			_nextState = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function drawBrushShape(state:String):void {
			$direction = _nextState == 0 ? Direction.UP : Direction.DOWN;
			super.drawBrushShape(state);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$direction = Direction.UP;
		}
	}
}