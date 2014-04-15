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

package org.flashapi.swing.plaf.spas {
	
	// -----------------------------------------------------------
	// SpasKnobButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/04/2010 22:57
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.KnobButtonUI;
	
	/**
	 * 	The <code>SpasKnobButtonUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>KnobButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.KnobButton
	 * 	@see org.flashapi.swing.plaf.KnobButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasKnobButtonUI extends SpasUI implements KnobButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasKnobButtonUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function drawButton():void {
			var pt:Point = dto.origin;
			var c:uint = dto.color;
			var r:Number = dto.radius;
			var halfRad:Number = r/2;
			var m:Matrix = MatrixUtil.getMatrix(r,r);
			var color2:RGB = new RGB(c);
			with (dto.currentTarget.graphics) {
				clear();
				lineStyle(0, 0, 0);
				beginGradientFill(GradientType.LINEAR, [color2.darker(), c], _a, _ratios, m);
				drawCircle(pt.x, pt.y, r-11);
				endFill();
				lineStyle(0, 0x969696, .5);
				m.createGradientBox(8, 8, 0, pt.x-4, halfRad - 3);
				beginGradientFill(GradientType.RADIAL, [0xffffff, dto.thumbColor, 0],
					[.8, 1, 1], [0, 230, 250], m);
				drawCircle(pt.x, pt.y - halfRad, 5);
				endFill();
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function drawTrack():void {
			var pt:Point = dto.origin;
			var c:uint = dto.color;
			var r:Number = dto.radius;
			var m:Matrix = MatrixUtil.getMatrix(r,r);
			var color2:RGB = new RGB(c);
			var ba:Number = dto.backgroundAlpha;
			var lm:Matrix = new Matrix();
			var quarter:Number = Math.PI / 4;
			var a:Array = [.5, .5];
			var bo:Number = isNaN(dto.borderAlpha) ? 1 : dto.borderAlpha;
			with (dto.currentTarget.graphics) {
				clear();
				beginGradientFill(GradientType.LINEAR, [c, color2.darker()], [ba, ba], _ratios, m);
				lineStyle(dto.borderWidth, dto.borderColor, bo, true);
				drawCircle(pt.x, pt.y, r);
				endFill();
				lm.createGradientBox(r, r, quarter, pt.x, pt.y);
				lineStyle(2, 0x969696, .5, true);
				lineGradientStyle(GradientType.LINEAR, _lineColors, a, _ratios, lm);
				drawCircle(pt.x, pt.y, r - 8);
				lm.createGradientBox(r, r, 5*quarter, pt.x, pt.y);
				lineGradientStyle(GradientType.LINEAR, _lineColors, a, _ratios, lm);
				drawCircle(pt.x, pt.y, r - 10);
				endFill();
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getThumbColor():uint {
			return 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getBorderColor():uint {
			return 0x666666;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _a:Array = [1, 1];
		private var _ratios:Array = [0, 250];
		private var _lineColors:Array = [0x333333, 0x969696];
	}
}