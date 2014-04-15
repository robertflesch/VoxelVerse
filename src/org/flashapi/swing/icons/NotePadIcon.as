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
	// NotePadIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/04/2008 14:56
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.Brush;
	import org.flashapi.swing.brushes.BrushBase;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>NotePadIcon</code> class is the brush class used to draw notepad
	 * 	icons.
	 * 
	 *  @includeExample NotePadIconExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class NotePadIcon extends BrushBase implements Brush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function NotePadIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
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
			var i:int = 1;
			var unit:Number = w / 16;
			//---> bar unit
			var buLeft:Number = (w - (2 * unit)) / 8;
			var buRight:Number = (w - (3 * unit)) / 8;
			//---> bordLineWidth
			var blw:Number = 1 + (1 - 1 / unit);
			//trace(blw);
			with($graphics) {
				clear();
				moveTo(2 * unit, 2 * unit);
				beginFill(0xFFFFFF);
				drawShape(w, unit);
				beginFill(0xFFFFFF, 0);
				lineStyle(1, 0x54D359, 1, true, LineScaleMode.NORMAL, CapsStyle.ROUND);
				moveTo((w-2*unit) / 2 + 1, 2 * unit);
				lineTo((w-2*unit) / 2 + 1, w - 2 * unit);
				for (; i < 8; i++) {
					moveTo(2 * unit + blw, 2 * unit + i * buLeft);
					lineTo(w - 3 * unit - blw, unit + i * buRight);
				}
				moveTo(2 * unit, 2 * unit);
				lineStyle(blw, 0x6262B8, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
				lineGradientStyle(GradientType.LINEAR, [0x6262B8, 0x6190EB], [1, 1], [0, 250], MatrixUtil.getMatrix(w, h, Math.PI));
				drawShape(w, unit);
				lineStyle(blw, 0x00FFFF, .3, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
				beginGradientFill(GradientType.LINEAR, [0x7CCDFF, 0x6190EB], [.6, .8], [0, 250], MatrixUtil.getMatrix(w, h, Math.PI/2));
				moveTo(2 * unit, 2 * unit);
				lineTo(2 * (w / 3 + unit), unit);
				lineTo(w - unit, w - 5 * unit);
				lineTo(w / 3 - unit, w - 2 * unit);
				lineTo(2 * unit, 2 * unit);
				
				/*lineStyle(2*blw, 0xE5D301, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
				moveTo((w-2*unit) / 2 + 1 -unit, unit);
				curveTo((w - 2 * unit) / 2 + 1, w - 2 * unit, (w-2*unit) / 2 + 1, unit);*/
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
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawShape(w:Number, unit:Number):void {
			with ($graphics) {
				lineTo(2 * unit, w);
				lineTo(2 * (w / 3 + unit), w - 3 * unit);
				lineTo(2 * (w / 3 + unit), unit);
				lineTo(2 * unit, 2 * unit);
			}
		}
	}
}