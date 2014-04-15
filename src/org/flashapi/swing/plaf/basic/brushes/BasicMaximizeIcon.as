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

package org.flashapi.swing.plaf.basic.brushes {
	
	// -----------------------------------------------------------
	// BasicMaximizeIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 20/01/2009 15:08
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicMaximizeIcon</code> class renders maximizing icons used by 
	 * 	<code>AWM</code> objects for the SPAS 3.0 "flex-like" Look and Feel.
	 * 
	 * 	@see org.flashapi.swing.wtk.AWM
	 * 	@see org.flashapi.swing.plaf.WindowUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicMaximizeIcon extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function BasicMaximizeIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
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
			var color:uint = ColorStateUtil.getColor(state, $colors);
			var c:Number = 3;
			var w:Number = $rect.width - c;
			with($graphics) {
				clear();
				moveTo(c+1, c);
				lineStyle(3, color, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);
				lineTo(w-1, c);
				moveTo(w, c);
				lineStyle(1, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
				lineTo(w, w);
				lineTo(c, w);
				lineTo(c, c);
				endFill();
			}
		}
	}
}