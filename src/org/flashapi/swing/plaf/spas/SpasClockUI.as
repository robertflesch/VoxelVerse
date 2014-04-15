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
	// SpasClockUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 09:04
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.geom.Geometry;
	import org.flashapi.swing.plaf.ClockUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>SpasClockUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>AnalogClock</code> instances.
	 * 
	 * 	@see org.flashapi.swing.AnalogClock
	 * 	@see org.flashapi.swing.plaf.ClockUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasClockUI extends SpasUI implements ClockUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasClockUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawDial():void {
			var rad:Number = dto.radius;
			var w:Number = dto.width;
			var f:Figure = Figure.setFigure(dto.currentTarget);
			var a:Number = dto.backgroundAlpha;
			var m:Matrix = MatrixUtil.getMatrix(2 * w, 2 * w, Math.PI/2, -w, -w);
			var color2:RGB = new RGB(dto.color);
			f.clear();
			f.beginGradientFill(GradientType.RADIAL, [color2.brighter(), color2.darker(.4)], [a, a], [100, 250], m);
			f.drawCircle(rad, rad, rad);
			f.endFill();
			f.beginFill(0xFFFFFF, a);
			m = MatrixUtil.getMatrix(w, w, Math.PI/4);
			f.lineStyle(1, 0, 1, true);
			f.lineGradientStyle(GradientType.LINEAR, [0, 0xAEAEAE], [a, a], [0, 250], m);
			f.drawCircle(rad, rad, rad - 6);
			f.endFill();
			f.lineStyle(0, 0, 0);
			f.beginGradientFill(GradientType.LINEAR, [0x666666, 0x666666], [.05, .2], [100, 250], m);
			f.drawCircle(rad + 1, rad + 1, rad - 9);
			f.endFill();
			var i:int = 0;
			var inset:Number;
			var sect:Number = Math.PI / 6;
			var tRad:Number = rad - 9;
			var lw:uint;
			for (; i < 12; ++i) {
				if (i % 3 == 0) {
					inset = 3;
					lw = 2;
				} else {
					inset = 2;
					lw = 1;
				}
				f.lineStyle(lw, 0x333333, 1);
				f.moveTo(rad + (tRad - inset) * Math.cos(i * sect), rad + (tRad - inset) * Math. sin(i * sect));
				f.lineTo(rad + tRad * Math.cos(i * sect), rad + tRad * Math.sin(i * sect));
			}
			f.endFill();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawHoursNeedle():void {
			drawNeedle(18);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawMinutesNeedle():void {
			drawNeedle(8);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawSecondsNeedle():void {
			with (dto.currentTarget.graphics) {
				clear();
				moveTo(0, -12);
				lineStyle(3, 0xFF0000);
				lineTo(0, -6);
				lineStyle(1, 0xFF0000);
				lineTo(0, dto.radius - 10);
				moveTo(0, 0);
				lineStyle(0, 0, 0);
				beginFill(0xFFFFFF);
				drawCircle(0, 0, 2);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getHoursPosition():Point {
			return Geometry.ORIGIN;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getMinutesPosition():Point {
			return Geometry.ORIGIN;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getSecondsPosition():Point {
			return Geometry.ORIGIN;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		private function drawNeedle(size:Number):void {
			with(Figure.setFigure(dto.currentTarget)) {
				clear();
				moveTo(3, 0);
				beginFill(0x333333);
				drawArc(3, 0, 3, 180, 0);
				lineTo(0, dto.radius - size);
				lineTo(3, 0);
				endFill();
			}
		}
	}
}