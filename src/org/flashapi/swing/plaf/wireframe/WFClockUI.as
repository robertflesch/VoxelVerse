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

package org.flashapi.swing.plaf.wireframe {
	
	// -----------------------------------------------------------
	// WFClockUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 01:48
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.geom.Geometry;
	import org.flashapi.swing.plaf.ClockUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>WFClockUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>AnalogClock</code> instances.
	 * 
	 * 	@see org.flashapi.swing.AnalogClock
	 * 	@see org.flashapi.swing.plaf.ClockUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFClockUI extends WFUI implements ClockUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFClockUI(dto:LafDTO) {
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
			//var w:Number = dto.width;
			var i:int = 0;
			var inset:Number;
			var sect:Number = Math.PI / 6;
			var tRad:Number = rad - 9;
			var lw:uint;
			with(dto.currentTarget.graphics) {
				clear();
				lineStyle(DEFAULT_BORDER_COLOR);
				beginFill(DEFAULT_BACKGROUND_COLOR);
				drawCircle(rad, rad, rad);
				endFill();
				for (; i < 12; ++i) {
					if (i % 3 == 0) {
						inset = 3;
						lw = 2;
					} else {
						inset = 2;
						lw = 1;
					}
					lineStyle(lw, 0, 1);
					moveTo(rad + (tRad - inset) * Math.cos(i * sect), rad + (tRad - inset) * Math. sin(i * sect));
					lineTo(rad + tRad * Math.cos(i * sect), rad + tRad * Math.sin(i * sect));
				}
				endFill();
			}
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
			with(dto.currentTarget.graphics) {
				clear();
				moveTo(-1, 0);
				beginFill(0x333333);
				drawRect(0, 0, 2, dto.radius - size);
				endFill();
			}
		}
	}
}