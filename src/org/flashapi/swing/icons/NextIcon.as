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
	// NextIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/08/2009 16:19
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>NextIcon</code> class is used to draw the icon of <code>NextButton</code>
	 * 	instances.
	 * 
	 * 	@see org.flashapi.swing.media.NextButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class NextIcon extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function NextIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
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
			var unitX:Number = $rect.width / 4;
			var unitY:Number = $rect.height / 4;
			with($graphics) {
				clear();
				beginFill(c);
				moveTo(unitX, unitY);
				lineTo(unitX, 3 * unitY);
				lineTo(2 * unitX, 2 * unitY);
				lineTo(unitX, unitY);
				moveTo(2 * unitX, unitY);
				lineTo(2 * unitX, 3 * unitY);
				lineTo(3 * unitX, 2 * unitY);
				endFill();
			}
		}
	}
}