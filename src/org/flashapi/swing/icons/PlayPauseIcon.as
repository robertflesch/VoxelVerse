﻿////////////////////////////////////////////////////////////////////////////////
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
	// PlayPauseIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/01/2009 01:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>PlayPauseIcon</code> class is used to draw the icon of 
	 * 	<code>PlayPauseButton</code> instances.
	 * 
	 * 	@see  org.flashapi.swing.media.PlayPauseButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PlayPauseIcon extends StateBrushBase implements StateBrush, StateIcon {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function PlayPauseIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
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
			var unitY:Number = $rect.height / 6;
			var h:Number = unitX / 2;
			with($graphics) {
				clear();
				beginFill(c);
				//--> (_nextState == 0) means that it is not paused currently.
				if (_nextState == 0) {
					moveTo(h + 3 * unitX, unitY);
					lineTo(h + 5 * unitX, 3 * unitY);
					lineTo(h + 3 * unitX, 5 * unitY);
					lineTo(h + 3 * unitX, unitY);
				} else {
					drawRect(3 * unitX, unitY, unitX, 4 * unitY);
					drawRect(5 * unitX - h, unitY, unitX, 4 * unitY);
				}
				endFill();
			}
		}
	}
}