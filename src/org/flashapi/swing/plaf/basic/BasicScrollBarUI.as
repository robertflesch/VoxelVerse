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
	// BasicScrollBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/01/2008 21:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import org.flashapi.swing.constants.ScrollableButtonType;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.ScrollBarUI;
	
	/**
	 * 	The <code>BasicScrollBarUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>ScrollBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ScrollBar
	 * 	@see org.flashapi.swing.plaf.ScrollBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicScrollBarUI extends BasicUI implements ScrollBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicScrollBarUI(dto:LafDTO) {
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
			var w:Number = dto.thickness;
			var isActive:Boolean = dto.state != States.INACTIVE;
			var lineColor:uint = isActive ? 0x777777 : 0x838383;
			var c:Array = isActive ? [0xA7A7A7, 0x939393] : [0xDADADA, 0x9B9B9B];
			var a:Array = [1, 1];
			var r:Array = [0, 250];
			var m:Matrix = new Matrix();
			var len:Number = dto.length;
			m.createGradientBox (w, len, Math.PI);
			var tgt:Sprite = dto.track;
			var f:Figure = Figure.setFigure(tgt);
			//var tl:Graphics = tgt.graphics;
			f.clear();
			f.beginGradientFill(GradientType.LINEAR, c, a, r, m, SpreadMethod.PAD);
			f.lineStyle(0, lineColor, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE);
			f.drawRectangle(0, 0, w, len);
			/*t.lineStyle(0, lineColor, 1, true, "normal", "none");
			tl.moveTo(0, 0);
			tl.lineTo(0, len);
			tl.moveTo(w, len);
			tl.lineTo(w, 0);*/
			f.endFill();
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
			var color:uint = dto.active ? 0x777777 : 0xB7BABC;
			var f:Figure = Figure.setFigure(dto.rightCornerContainer);
			var w:Number = dto.thickness;
			f.clear();
			f.beginFill(color, 1);
			f.lineStyle(0, 0x838383, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE);
			f.drawRectangle(0, 0, w, w);
			f.endFill();
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
			return 0xB6B9BB;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const SCROLLBAR_WIDTH:Number = 15;
		private const BUTTON_LENGTH:Number = 15;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawThumbShape():void {
			var l:Number = dto.getThumbLength();
			var s:String = dto.state;
			var lineColor:uint = (s==States.OUT) ? 0x838383 : 0x009DFF;
			var color:uint = (s==States.PRESSED) ? 0xD9F0FE : 0xE6E6E6;
			var bevel:uint = 2;
			var delay:Number = 1.5;
			var w:Number = dto.thickness;
			with(dto.thumb.graphics){
				clear();
				lineStyle(1, lineColor, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
				beginFill(color, 1);
				moveTo(.5, .5);
				lineTo(w-delay-bevel, .5);
				lineTo(w-delay, bevel+.5);
				lineTo(w-delay, l-bevel-.5);
				lineTo(w-delay-bevel, l-.5);
				lineTo(.5, l-.5);
				lineTo(.5, .5);
				moveTo(delay+2, l/2-3);
				lineTo(w-2-bevel, l/2-3);
				moveTo(delay+2, l/2);
				lineTo(w-2-bevel, l/2);
				moveTo(delay+2, l/2+3);
				lineTo(w-2-bevel, l/2+3);
				endFill();
			}
		}
		
		private function drawButtonShape(btn:Sprite, direction:String):void {
			var w:Number = BUTTON_LENGTH;
			var t:Number = dto.thickness;
			var s:String = dto.state;
			var color:uint = (s==States.PRESSED) ? 0xA1DAFE : 0x939393;
			var d:Array;
			switch(s) {
				case States.OUT :
					d = [0xB7BABC, 0x5B5D5B];
					break;
				case States.OVER :
					d = [0x009CFE, 0x0075BF];
					break;
				case States.PRESSED :
					d = [0x009CFE, 0x0075BF];
					break;
				case States.INACTIVE :
					d = [0xA3A3A3, 0x808080];
					break;
			}
			var a:Array = [1, 1];
			var r:Array = [0, 250];
			var m:Matrix = new Matrix();
			m.createGradientBox (w, w, Math.PI/2);
			var f:Figure = Figure.setFigure(btn);
			f.clear();
			f.beginGradientFill(GradientType.LINEAR, [0xFDFDFD, color], a, r, m, SpreadMethod.PAD);
			f.lineStyle(1, 0xB7BABC, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
			f.lineGradientStyle(GradientType.LINEAR, d, a, r, m);
			f.drawRectangle(.5, .5, t-.5, w-.5);
			if(s != States.INACTIVE) {
				f.beginFill(0, 1);
				f.lineStyle(0, 0);
				switch(direction) {
					case ScrollableButtonType.UP :
						f.drawTriangle(4.5, w / 2 + 2, w / 2 + .5, 5, w - 3, w / 2 + 2);
						break;
					case ScrollableButtonType.DOWN :
						f.drawTriangle(4.5, w / 2 - 1, w / 2 + .5, w - 5, w - 3, w / 2 - 1);
						break;
				}
			}
			f.endFill();
		}
	}
}