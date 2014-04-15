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
	// MuteIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/01/2009 20:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>MuteIcon</code> class is used to draw the icon of <code>MuteButton</code>
	 * 	instances.
	 * 	
	 * 	@see org.flashapi.swing.media.MuteButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MuteIcon extends StateBrushBase implements StateBrush, StateIcon {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function MuteIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
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
			if ($rect == null) return;
			var c:uint = ColorStateUtil.getColor(state, $colors);
			var unitX:Number = $rect.width / 8;
			var unitY:Number = $rect.height / 8;
			var lw:Number = unitX / 2;
			var hlw:Number;
			with($graphics) {
				clear();
				beginFill(c);
				drawRect(2*unitX, 3 * unitY, unitX, 2 * unitY);
				moveTo(3 * unitX, 3 * unitY);
				lineTo(4 * unitX, unitY);
				lineTo(4 * unitX, 7 * unitY);
				lineTo(3 * unitX, 5 * unitY);
				lineTo(3 * unitX, 3 * unitY);
				endFill();
				lineStyle(lw, c);
				//--> (_nextState == 0) means that it is not mutted currently.
				if (_nextState == 0) {
					hlw = lw / 2;
					moveTo(6 * unitX, 2 * unitY);
					curveTo(7 * unitX, 4 * unitY, 6 * unitX, 6 * unitY);
					moveTo(5 * unitX - hlw, 2 * unitY);
					curveTo(6 * unitX - hlw, 4 * unitY, 5 * unitX - hlw, 6 * unitY);
				} else {
					lineStyle(lw, c);
					moveTo(5 * unitX, 4 * unitY);
					lineTo(6 * unitX, 4 * unitY);
				}
				endFill();
			}
		}
	}
}