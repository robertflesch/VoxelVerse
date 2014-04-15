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

package org.flashapi.swing.plaf.spas.brushes {
	
	// -----------------------------------------------------------
	// SpasRestoreIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/07/2008 23:11
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>SpasRestoreIcon</code> class renders restoring icons used by 
	 * 	<code>AWM</code> objects for the SPAS 3.0 default Look and Feel.
	 * 
	 * 	@see org.flashapi.swing.wtk.AWM
	 * 	@see org.flashapi.swing.plaf.WindowUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasRestoreIcon extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function SpasRestoreIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
		}
		
		/**
		 * 	@private
		 */
		override protected function drawBrushShape(state:String):void {
			//var color:uint = BasicIconColors.getButtonStateIconColor(state, _colors);
			var color:uint = 0xFFFFFF;
			var c:Number = 3;
			var _x:Number = $rect.x + c;
			var _y:Number = $rect.y + c;
			var _w:Number = $rect.width - c;
			var _h:Number = $rect.height - c;
			with ($graphics) {
				clear();
				moveTo(_w/2, _y);
				lineStyle(2, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
				lineTo(_w-0.5, _y);
				moveTo(_w-1, _y);
				lineStyle(1, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
				lineTo(_w-1, _h/2+1);
				lineTo(_w/2+3, _h/2+1);
				
				moveTo(_x-1, _y+3);
				lineStyle(2, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
				lineTo(_w/2+2.5, _y+3);
				moveTo(_w/2+2, _y+3);
				lineStyle(1, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
				lineTo(_w/2+2, _h/2+5);
				lineTo(_x-.5, _h/2+5);
				lineTo(_x-.5, _y+3);
				endFill();
			}
		}
	}
}