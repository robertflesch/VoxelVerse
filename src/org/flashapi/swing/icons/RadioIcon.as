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
	// RadioIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/01/2009 17:59
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>RadioIcon</code> class is used to draw radio-button-like icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RadioIcon extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function RadioIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
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
			var c:uint = ColorStateUtil.getColor(state, $colors);
			var _w:Number = $rect.width / 2;
			var _h:Number = $rect.height / 2;
			$graphics.lineStyle(0, c);
			$graphics.beginFill(c);
			$graphics.drawCircle(_w, _h, 2.5 * $factor);
			$graphics.endFill();	
		}
	}
}