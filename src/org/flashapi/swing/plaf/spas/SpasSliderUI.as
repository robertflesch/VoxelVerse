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
	// SpasSliderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.2.0, 10/11/2010 16:37
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SliderUI;
	
	/**
	 * 	The <code>SpasSliderUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>PageNavigator</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Slider
	 * 	@see org.flashapi.swing.plaf.SliderUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasSliderUI extends SpasUI implements SliderUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasSliderUI(dto:LafDTO) {
			super(dto);
			var rgb:RGB = new RGB(DEFAULT_COLOR);
			_brightColor = rgb.brighter(.6);
			_darkColor = rgb.darker(.8);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTrack():void {
			var f:Figure = Figure.setFigure(dto.track);
			var m:Matrix = new Matrix();
			var l:Number = dto.trackLength;
			m.createGradientBox(16, l, 2*Math.PI, 0, 0);
			f.clear();
			f.beginFill(0xFFFFFF);
			f.lineStyle(1, _darkColor, 1, true);
			f.lineGradientStyle(GradientType.LINEAR, [_darkColor, DEFAULT_COLOR], [1, 1], [130, 150], m);
			f.drawRectangle(8, 0, 10, l);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTick():void {
			var from:Point = dto.tickStart;
			var to:Point = dto.tickEnd;
			with(dto.ticksContainer.graphics) {
				lineStyle(dto.tickThickness, dto.tickColor, 1);
				moveTo(from.x, from.y);
				lineTo(to.x, to.y);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearTicks():void {
			dto.ticksContainer.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawThumb():void {
			dto.active ? drawThumbShape() : dto.thumb.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawHighlight():void {
			var f:Figure = Figure.setFigure(dto.highlightTrackContainer);
			f.clear();
			f.beginFill(0x3399FF);
			f.drawRectangle(8.5, dto.minimum+.5, 9.5, dto.maximum-.5);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearHighlight():void {
			dto.highlightTrackContainer.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSliderWidth():Number {
			return 20;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMinLength():Number {
			return 12;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSliderLength():Number {
			return SLIDER_LENGTH;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTickDelay():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getLabelLaf():Class {
			return SpasLabelUI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const SLIDER_LENGTH:Number = 14;
		private var _brightColor:uint;
		private var _darkColor:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		private function drawThumbShape():void {
			//var sl:Number = SLIDER_LENGTH / 2;
			//var lineColor:uint = (state==States.OUT) ? _darkColor : _brightColor;
			var color:uint = (dto.state==States.PRESSED) ? _darkColor : DEFAULT_COLOR;
			var m:Matrix = new Matrix();
			m.createGradientBox(SLIDER_LENGTH, SLIDER_LENGTH);
			var f:Figure = Figure.setFigure(dto.thumb);
			f.clear();
			f.lineStyle(1, _darkColor, 1, true);
			f.beginGradientFill(GradientType.RADIAL, [_brightColor, color], [1, 1], [0, 250], m);
			f.drawRoundedTriangle(0, SLIDER_LENGTH/2, SLIDER_LENGTH, 0, SLIDER_LENGTH, SLIDER_LENGTH, 5, 5);
			f.endFill();
		}
	}
}