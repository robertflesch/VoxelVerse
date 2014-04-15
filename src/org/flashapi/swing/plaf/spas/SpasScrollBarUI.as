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
	// SpasScrollBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 3.0.0, 09/11/2010 11:33
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.ScrollableButtonType;
	import org.flashapi.swing.constants.ScrollableOrientation;
	import org.flashapi.swing.constants.ScrollBarCornerStyle;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.ScrollBarUI;
	
	/**
	 * 	The <code>SpasScrollBarUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>ScrollBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ScrollBar
	 * 	@see org.flashapi.swing.plaf.ScrollBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasScrollBarUI extends SpasUI implements ScrollBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasScrollBarUI(dto:LafDTO) {
			super(dto);
		}
		
		private static var _cornerStyle:String = ScrollBarCornerStyle.ROUND;
		
		/**
		 * 	Changes the corner style for all scrollbars that use the <code>SpasScrollBarUI</code>
		 * 	Look and Feel. Possible values are the constants of the <code>ScrollBarCornerStyle</code>
		 * 	class.
		 * 
		 * 	@param	cornerStyle	The corner style for all scrollbars that use the
		 * 	<code>SpasScrollBarUI</code> Look and Feel.
		 * 
		 * 	@see #getCornerStyle()
		 * 	@see org.flashapi.swing.constants.ScrollBarCornerStyle
		 */
		public static function setCornerStyle(cornerStyle:String):void {
			_cornerStyle = cornerStyle;
		}
		
		/**
		 * 	Returns the corner style defined by the <code>SpasScrollBarUI</code>
		 * 	Look and Feel. Default value is <code>ScrollBarCornerStyle.ROUND</code>.
		 * 
		 * 	@return The corner style defined by the <code>SpasScrollBarUI</code>
		 * 			Look and Feel.
		 * 
		 * 	@see #setCornerStyle()
		 * 	@see org.flashapi.swing.constants.ScrollBarCornerStyle
		 */
		public static function getCornerStyle():String {
			return _cornerStyle;
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
			var isActive:Boolean = dto.state != States.INACTIVE;
			var lineColor:uint;
			var tc:Number = isActive ? 	dto.scrollColors.scrollbarTrackColor :
										dto.scrollColors.scrollbarInactiveTrackColor;
			var c:Array;
			if (!isNaN(tc)) {
				var rgb:RGB = new RGB(tc);
				var bright:uint = rgb.brighter();
				var dark:uint = rgb.darker();
				if (isActive) {
					c = [tc, dark];
					lineColor = dark;
				} else {
					c = [bright, tc];
					lineColor = tc;
				}
			} else {
				if (isActive) {
					c = [0x7D7D7D, 0x2D2F34];
					lineColor = dto.color;
				} else {
					c = [0xDADADA, 0x9B9B9B];
					lineColor = 0x838383;
				}
			}
			var a:Array = [1, 1];
			var r:Array = [0, 250];
			var m:Matrix = new Matrix();
			var w:Number = dto.thickness;
			var len:Number = dto.length;
			m.createGradientBox (w, len, Math.PI);
			var tgt:Sprite = dto.track;
			var t:Figure = Figure.setFigure(tgt);
			var tl:Graphics = tgt.graphics;
			t.clear();
			t.beginGradientFill(GradientType.LINEAR, c, a, r, m, SpreadMethod.PAD);
			t.drawRectangle(0, 0, w, len);
			t.lineStyle(0, lineColor, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE);
			tl.moveTo(0, 0);
			tl.lineTo(0, len-1);
			tl.moveTo(w, len-1);
			tl.lineTo(w, 0);
			t.endFill();
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
			drawBackgroundButtonShape(dto.upButtonBackground, ScrollableButtonType.UP);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawDownButton():void {
			drawButtonShape(dto.downButtonContainer, ScrollableButtonType.DOWN);
			drawBackgroundButtonShape(dto.downButtonBackground, ScrollableButtonType.DOWN);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBottomRightCorner():void {
			var isActive:Boolean = dto.active;
			var tc:Number = isActive ?
				dto.scrollColors.scrollbarJoinColor : dto.scrollColors.scrollbarInactiveJoinColor;
			var color:uint;
			if (isNaN(tc)) color = isActive ? DEFAULT_COLOR : 0x818181;
			else color = uint(tc);
			var w:Number = dto.thickness;
			var f:Figure = Figure.setFigure(dto.rightCornerContainer);
			f.clear();
			f.lineStyle(1, color);
			f.beginFill(color, 1);
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
			return DEFAULT_COLOR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const SCROLLBAR_WIDTH:Number = 15;
		private static const BUTTON_LENGTH:Number = 15;
		private static const BUTTON_SHAPE_OFFSET:uint = 8;
		private static const THUMB_CURVE_HEIGHT:Number = .5;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawThumbShape():void {
			var l:Number = dto.getThumbLength();
			var w:Number = dto.thickness;
			var sch:Number = THUMB_CURVE_HEIGHT;
			var cd:Number = SCROLLBAR_WIDTH-1;
			var m:Matrix = new Matrix();
			
			var color:uint = isNaN(dto.scrollColors.scrollbarFaceColor) ?
				dto.color : dto.scrollColors.scrollbarFaceColor;
			var lineColor:uint;
			
			var c:uint = new RGB(color).darker(.65);
			
			switch(dto.state) {
				case States.OUT :
					lineColor = 0x969696;
					break;
				case States.OVER :
					lineColor = 0xFFFFFF;
					break;
				case States.PRESSED :
					color = c;
					c = new RGB(color).darker(.65);
					lineColor = 0xFFFFFF;
					break;
			}
			var o:String = dto.orientation;
			
			o == ScrollableOrientation.HORIZONTAL ?
				m.createGradientBox(w - 2, l - 2, 2 * Math.PI, 1, 1) :
				m.createGradientBox(l-2, w-2, 2*Math.PI, 1, 1);
			var g:Graphics = dto.thumb.graphics;
			g.clear();
			g.lineStyle(1, lineColor, 1, true);
			g.beginGradientFill(GradientType.LINEAR, [c, color], [1, 1], [0, 255], m);
			
			if(_cornerStyle == ScrollBarCornerStyle.ROUND) {
				g.drawRoundRect(1, 0, w-2.5, l, cd, cd);
				//g.moveTo(w/2, 0);
				g.lineStyle(0, 0, 0);
				g.beginFill(0xFFFFFF, .2);
				g.moveTo(w/2, 0);
				g.curveTo(w/2+sch, l/4, w/2, l/2);
				g.curveTo(w/2-sch, 3*l/4, w/2, l);
				switch(o) {
					case ScrollableOrientation.VERTICAL : 
						g.lineTo(w-cd/2, l);
						g.curveTo(w-1, l, w-1, l-cd/2);
						g.lineTo(w-1, cd/2);
						g.curveTo(w-1, 0, w-cd/2, 0);
						break;
					case ScrollableOrientation.HORIZONTAL :
						g.lineTo(cd/2, l);
						g.curveTo(1, l, 1, l-cd/2);
						g.lineTo(1, cd/2);
						g.curveTo(0, 1 - 1, cd/2 - 1, 0);
						break;
				}
			} else if (_cornerStyle == ScrollBarCornerStyle.SQUARE) {
				g.drawRect(1, 0, w - 2.5, l);
				//g.moveTo(w/2, 0);
				g.lineStyle(0, 0, 0);
				g.beginFill(0xFFFFFF, .2);
				g.moveTo(w/2, 0);
				g.curveTo(w/2+sch, l/4, w/2, l/2);
				g.curveTo(w / 2 - sch, 3 * l / 4, w / 2, l);
				switch(o) {
					case ScrollableOrientation.VERTICAL : 
						g.lineTo(w-cd/2, l);
						g.lineTo(w-1, l);
						g.lineTo(w-1, cd/2);
						g.lineTo(w-1, 0);
						break;
					case ScrollableOrientation.HORIZONTAL :
						g.lineTo(cd/2, l);
						g.lineTo(1, l);
						g.lineTo(1, cd/2);
						g.lineTo(0, 1 - 1);
						break;
				}
			}
			g.endFill();
		}
		
		private function drawButtonShape(btn:Sprite, direction:String):void {
			var w:Number = dto.thickness;
			var h:Number = BUTTON_LENGTH;
			var b:Figure = Figure.setFigure(btn);
			b.clear();
			b.beginFill(0, 0);
			b.drawRectangle(0, 0, w, h);
			var c:uint = isNaN(dto.scrollColors.scrollbarArrowColor) ? 0xFFFFFF : dto.scrollColors.scrollbarArrowColor;
			if(dto.state != States.INACTIVE) {
				b.beginFill(c, 1);
				switch(direction) {
					case ScrollableButtonType.UP :
						b.drawTriangle(4.5, h / 2 + 2, h / 2 + .5, 5, h - 3, h / 2 + 2);
						break
					case ScrollableButtonType.DOWN :
						b.drawTriangle(4.5, h / 2 - 1, h / 2 + .5, h - 5, h - 3, h / 2 - 1);
						break
				}
			}
			b.endFill();
		}
		
		private function drawBackgroundButtonShape(btn:Sprite, direction:String):void {
			var h:Number = BUTTON_LENGTH;
			var w:Number = dto.thickness;
			var length:Number = BUTTON_LENGTH + BUTTON_SHAPE_OFFSET;
			var bso:Number = BUTTON_SHAPE_OFFSET;
			
			var s:String = dto.state;
			var alpha:Number = s != States.INACTIVE ? .5 : .15;
			
			var color:uint = isNaN(dto.scrollColors.scrollbarFaceColor) ?
				dto.color : dto.scrollColors.scrollbarFaceColor;
			
			var lineColor:uint = 0x969696;
			
			switch(s) {
				case States.OUT :
					break;
				case States.OVER :
					color = new RGB(color).brighter(.8);
					break;
				case States.PRESSED :
					color = new RGB(color).darker(.8);
					break;
			}
			var c:Array;
			var a:Array;
			var r:Array;
			var m:Matrix;
			with(btn.graphics) {
				clear();
				if(s != States.INACTIVE) {
					c = [new RGB(color).darker(.8), color];
					a = [1, 1];
					r = [120, 130];
					m = new Matrix();
					m.createGradientBox(w+2, length, Math.PI);
					beginGradientFill(GradientType.LINEAR, c, a, r, m);
				} else beginFill(0x818181);
				lineStyle(0, lineColor, alpha);
				if(_cornerStyle == ScrollBarCornerStyle.ROUND) {
					switch(direction) {
						case ScrollableButtonType.UP : 
							moveTo(0, 0);
							lineTo(w, 0);
							lineTo(w, length);
							curveTo(w, h, w - bso, h);
							lineTo(bso, h);
							curveTo(0, h, 0, length);
							lineTo(0, length);
							lineTo(0, 0);
							break;
						case ScrollableButtonType.DOWN :
							moveTo(0, h);
							lineTo(w, h);
							lineTo(w, h-length);
							curveTo(w, 0, w - bso, 0);
							lineTo(bso, 0);
							curveTo(0, 0, 0, h-length);
							lineTo(0, h);
							break;
					}
				} else if (_cornerStyle == ScrollBarCornerStyle.SQUARE) {
					drawRect(0, 0, w, h);
				}
				endFill();
			}
		}
	}
}