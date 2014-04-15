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
	// WFScrollBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2010 16:43
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import org.flashapi.swing.constants.ScrollableButtonType;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.ScrollBarUI;
	
	/**
	 * 	The <code>WFScrollBarUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>ScrollBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ScrollBar
	 * 	@see org.flashapi.swing.plaf.ScrollBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFScrollBarUI extends WFUI implements ScrollBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFScrollBarUI(dto:LafDTO) {
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
			//var isActive:Boolean = dto.state != States.INACTIVE;
			with(Figure.setFigure(dto.track)) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR);
				beginFill(DEFAULT_BACKGROUND_COLOR);
				drawRectangle(0, 0, dto.thickness, dto.length);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawThumb():void {
			var s:Graphics = dto.thumb.graphics;
			dto.active ? drawThumbShape(s) : s.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawUpButton():void {
			drawButtonShape(dto.upButtonContainer, ScrollableButtonType.UP);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawDownButton():void {
			drawButtonShape(dto.downButtonContainer, ScrollableButtonType.DOWN);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBottomRightCorner():void {
			var w:Number = dto.thickness;
			with(Figure.setFigure(dto.rightCornerContainer)) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR);
				beginFill(DEFAULT_BACKGROUND_COLOR, 1);
				drawRectangle(0, 0, w, w);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearBottomRightCorner():void {
			dto.rightCornerContainer.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getScrollBarWidth():Number {
			return SCROLLBAR_WIDTH;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMinLength():Number {
			return 15;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const SCROLLBAR_WIDTH:Number = 15;
		private const BTN_LENGTH:Number = 15;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawThumbShape(s:Graphics):void {
			var l:Number = dto.getThumbLength();
			var w:Number = dto.thickness;
			s.clear();
			s.lineStyle(1, 0x969696, 1, true);
			s.beginFill(getShapeColor());
			s.drawRect(2, 0, w-3.5, l);
			s.endFill();
		}
		
		private function drawButtonShape(btn:Sprite, direction:String):void {
			var w:Number = BTN_LENGTH;
			var b:Figure = Figure.setFigure(btn);
			b.clear();
			b.beginFill(0,0);
			b.drawRectangle(0, 0, w, w);
			b.beginFill(getShapeColor());
			b.drawRectangle(1, 1, w-1, w-1);
			if(dto.state != States.INACTIVE) {
				b.beginFill(0, 1);
				switch(direction) {
					case ScrollableButtonType.UP :
						b.drawTriangle(4.5, w / 2 + 2, w / 2 + .5, 5, w - 3, w / 2 + 2);
						break
					case ScrollableButtonType.DOWN :
						b.drawTriangle(4.5, w / 2 - 1, w / 2 + .5, w - 5, w - 3, w / 2 - 1);
						break
				}
			}
			b.endFill();
		}
		
		private function getShapeColor():uint {
			var c:uint = 0xFFFFFF;
			switch(dto.state) {
				case States.OVER :
					c = 0xcccccc;
					break;
				case States.PRESSED :
				case States.SELECTED :
					c = 0x666666;
					break;
			}
			return c;
		}
	}
}