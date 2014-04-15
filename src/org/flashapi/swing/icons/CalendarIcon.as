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
	// CalendarIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/09/2008 17:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.Brush;
	import org.flashapi.swing.brushes.BrushBase;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>CalendarIcon</code> class is the brush class used to draw calendar
	 * 	icons.
	 * 
	 * 	@see org.flashapi.swing.Calendar
	 * 
	 *  @includeExample CalendarIconExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CalendarIcon extends BrushBase implements Brush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function CalendarIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		override public function paint():void {
			var w:Number = $rect.width;
			var h:Number = $rect.height;
			var x:Number = $rect.x;
			var y:Number = $rect.y;
			var hUnit:Number = h / 4;
			var wUnit:Number = w / 4;
			var f:Figure = new Figure($target);
			var cd:Number = Math.floor(hUnit / 2);
			var rectWidth:Number = $rect.width < 30 ? 1 : 2;
			with(f) {
				clear();
				beginFill(0xFFFFFF);
				lineStyle(0, 0x999999);
				drawRoundedBox(x, y, w, h, cd, cd, 0, 0);
				endFill();
				beginGradientFill(	GradientType.LINEAR, [0xE1E1E1, 0xB0B0B0, 0x777777],
									[1, 1, 1], [0, 200, 250], MatrixUtil.getMatrix(Math.PI/2, hUnit));
				drawRoundedBox(x, y, w, hUnit, cd, cd, 0, 0);
				endFill();
				moveTo(wUnit, hUnit);
				lineStyle(0, 0x999999);
				lineTo(wUnit, h);
				moveTo(2 * wUnit, hUnit);
				lineTo(2 * wUnit, h);
				moveTo(3 * wUnit, hUnit);
				lineTo(3 * wUnit, h);
				moveTo(4 * wUnit, hUnit);
				lineTo(4 * wUnit, h); 
				moveTo(x, 2 * hUnit);
				lineTo(w, 2 * hUnit);
				moveTo(x, 3 * hUnit);
				lineTo(w, 3 * hUnit);
				endFill();
				lineStyle(rectWidth, 0xFF0000);
				drawRectangle(wUnit, 2 * hUnit, 2 * wUnit, 3 * hUnit);
				endFill();
				lineStyle(0, 0, 0);
				moveTo(0, hUnit);
				beginGradientFill(	GradientType.LINEAR, [0x666666, 0x666666], [.5, 0], [0, 200],
									MatrixUtil.getMatrix(w, h - hUnit, Math.PI / 4));
				lineTo(w, hUnit);
				lineTo(0, h);
				lineTo(0, hUnit);
				endFill();
			}
			$isPainted = true;
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function clear():void {
			$graphics.clear();
			$isPainted = false;
		}
	}
}