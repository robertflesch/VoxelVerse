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

package org.flashapi.swing.plaf.basic {
	
	// -----------------------------------------------------------
	// BasicSliderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/10/2009 10:10
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Point;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SliderUI;
	
	/**
	 * 	The <code>BasicSliderUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Slider</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Slider
	 * 	@see org.flashapi.swing.plaf.SliderUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicSliderUI extends BasicUI implements SliderUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicSliderUI(dto:LafDTO) {
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
		public function drawTrack():void {
			var l:Number = dto.trackLength;
			var f:Figure = Figure.setFigure(dto.track);
			f.clear();
			f.beginFill(0xFFFFFF);
			f.lineStyle(1, 0, 1, true);
			f.lineGradientStyle(GradientType.LINEAR, [0, 0x888888], [1, 1], [130, 150], MatrixUtil.getMatrix(16, l));
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
			f.beginFill(0x009DFF);
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
			return BasicLabelUI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const SLIDER_LENGTH:Number = 12;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		private function drawThumbShape():void {
			var s:String = dto.state;
			var lineColor:uint = (s==States.OUT) ? 0x838383 : 0x009DFF;
			var color:uint = (s==States.PRESSED) ? 0xD9F0FE : 0xE6E6E6;
			var f:Figure = Figure.setFigure(dto.thumb);
			f.clear();
			f.lineStyle(1, lineColor, 1, true);
			f.beginFill(color, 1);
			f.drawRoundedTriangle(0, SLIDER_LENGTH/2, SLIDER_LENGTH, 0, SLIDER_LENGTH, SLIDER_LENGTH, 5, 5);
			f.endFill();
		}
	}
}