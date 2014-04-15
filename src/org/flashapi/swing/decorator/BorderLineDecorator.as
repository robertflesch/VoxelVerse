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

package org.flashapi.swing.decorator {
	
	// -----------------------------------------------------------
	// BorderLine.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version beta 1, 27/12/2008 03:15
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.border.BorderDTO;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.draw.DashedLine;
	
	/**
	 * 	The <code>BorderLineDecorator</code> class provides decoration mechanism 
	 * 	to give <code>BorderDecorator</code> instances an easy-to-implement way 
	 * 	for rendring border lines within <code>Border</code> objects.
	 * 
	 * 	@see org.flashapi.swing.decorator.BorderDecorator
	 * 	@see org.flashapi.swing.border.Border
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BorderLineDecorator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BorderLineDecorator</code> instance.
		 * 
		 * 	@param	target	The <code>Sprite</code> object used to render border lines
		 * 					within a <code>Border</code> object.
		 */
		public function BorderLineDecorator(target:Sprite) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant value which indicates that the title label is displayed on the
		 * 	top of border lines within the decorated <code>Border</code> instance.
		 */
		public static const TOP:String = "top";
		
		/**
		 * 	A constant value which indicates that the title label is displayed at the 
		 * 	bottom of border lines within the decorated <code>Border</code> instance.
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * 	A constant value which indicates that the title label is neither displayed
		 * 	on the top or at the bottom of border lines within the decorated
		 * 	<code>Border</code> instance.
		 */
		public static const NONE:String = "none";
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>BorderDTO</code> object associated to the decorated <code>Border</code>
		 * 	instance.
		 */
		public var dto:BorderDTO;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.core.IUIObject#finalize()
		 */
		public function finalize():void {
			_tgt = null;
			_dashedLine = null;
		}
		
		/**
		 * 	Clears the border lines of the decorated <code>Border</code> instance.
		 * 
		 * 	@see #drawBorders()
		 */
		public function clear():void {
			_tgt.clear();
		}
		
		/**
		 * 	Draws the border lines of the decorated <code>Border</code> instance.
		 * 	
		 * 	@param	titleMetrics	A <code>Rectangle</code> object that defines
		 * 							the bounds of the <code>Border</code> title label.	
		 * 	@param	titlePos	The position of the <code>Border</code> title label.
		 * 						Possible values are <code>BorderLineDecorator.NONE</code>,
		 * 						<code>BorderLineDecorator.TOP</code> and <code>BorderLineDecorator.BOTTOM</code>.
		 * 
		 * 	@see #clearBorders()
		 */
		public function drawBorders(titleMetrics:Rectangle, titlePos:String = NONE):void {
			_titleMetrics = titleMetrics;
			var w:Number = dto.width;
			var h:Number = dto.height;
			_cornerDelay = 0;
			var bw:Number = dto.borderWidth;
			var c1:uint = dto.btColor;
			var c2:uint = dto.brColor;
			var c3:uint = dto.bbColor;
			var c4:uint = dto.blColor;
			var a1:Number = dto.btAlpha;
			var a2:Number = dto.brAlpha;
			var a3:Number = dto.bbAlpha;
			var a4:Number = dto.blAlpha;
			var sa:Number = dto.shadowAlpha;
			var ha:Number = dto.highlightAlpha;
			switch(dto.borderStyle) {
				case BorderStyle.SOLID:
					drawSingleBorder(w, h, titlePos, [c1, c2, c3, c4], [a1, a2, a3, a4]);
					break;
				case BorderStyle.OUTSET:
					drawBeveledBorder(w, h, titlePos, [dto.highlightColor, dto.shadowColor], [ha, sa]);
					break;
				case BorderStyle.INSET:
					drawBeveledBorder(w, h, titlePos, [dto.shadowColor, dto.highlightColor], [sa, ha]);
					break;
				case BorderStyle.DOUBLE:
					drawDoubleBorder(w, h, titlePos, c1, c2, c3, c4, a1, a2, a3, a4);
					break;
				case BorderStyle.FRAME:
					drawDoubleBorder(w, h, titlePos, c1, c2, c3, c4, a1, a2, a3, a4, true);
					break;
				case BorderStyle.RIDGE:
					drawCompositeBorder(w, h, titlePos, [dto.highlightColor, dto.shadowColor], [ha, sa], -1);
					drawCompositeBorder(w, h, titlePos, [dto.shadowColor, dto.highlightColor], [sa, ha], 1);
					break;
				case BorderStyle.GROOVE:
					drawCompositeBorder(w, h, titlePos, [dto.shadowColor, dto.highlightColor], [sa, ha], -1);
					drawCompositeBorder(w, h, titlePos, [dto.highlightColor, dto.shadowColor], [ha, sa], 1);
					break;
				case BorderStyle.DASHED:
					_dashedMode = true;
					drawDashedLine(bw, c1, a1, dto.tlcr, 0, w - dto.trcr, 0, titlePos);
					drawTRC(bw, c1, c2, a1, a2);
					drawDashedLine(bw, c2, a2, w, dto.trcr, w, h - dto.brcr);
					drawBRC(bw, c2, c3, a2, a3);
					drawDashedLine(bw, c3, a3, w - dto.brcr, h, dto.blcr, h, titlePos);
					drawBLC(bw, c3, c4, a3, a4);
					drawDashedLine(bw, c4, a4, 0, h - dto.blcr, 0, dto.tlcr);
					drawTLC(bw, c4, c1, a4, a1);
					_dashedMode = false;
					break;
			}
			_tgt.endFill();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:Sprite):void {
			_tgt = target.graphics;
			_dashedLine = new DashedLine(target);
		}
		
		private function drawLine(thickness:Number, color:uint, alpha:Number, fromX:Number, fromY:Number, toX:Number, toY:Number, pos:String = NONE, orientation:int = 0):void {
			var fx:Number = 0;
			var fy:Number = 0;
			var tx:Number = 0;
			var ty:Number = 0;
			var ht:Number = thickness / 2;
			switch(orientation) {
				case 0:
					if (dto.tlcr < 1) fx = ht; if (dto.trcr < 1) tx = ht;
					break;
				case 1:
					if (dto.trcr < 1) fy = ht; if (dto.brcr < 1) ty = ht;
					break;
				case 2:
					if (dto.brcr < 1) fx = -ht; if (dto.blcr < 1) tx = -ht;
					break;
				case 3:
					if (dto.blcr < 1) fy = -ht; if (dto.tlcr < 1) ty = -ht;
					break;
			}
			_tgt.moveTo(fromX + fx, fromY + fy);
			_tgt.lineStyle(thickness, color, alpha, _hinting, LineScaleMode.NORMAL,
				CapsStyle.NONE, JointStyle.MITER, _limit);
			if (pos != NONE  && _titleMetrics) {
				if (pos == TOP) {
					_tgt.lineTo(_titleMetrics.x, fromY);
					_tgt.moveTo(_titleMetrics.x + _titleMetrics.width, fromY);
				} else if (pos == BOTTOM) {
					_tgt.lineTo(_titleMetrics.x + _titleMetrics.width, fromY);
					_tgt.moveTo(_titleMetrics.x, fromY);
				}
			}
			_tgt.lineTo(toX - tx, toY - ty);
			_tgt.endFill();
		}
		
		private function drawDashedLine(thickness:Number, color:uint, alpha:Number, fromX:Number, fromY:Number, toX:Number, toY:Number, pos:String = NONE):void {
			var from:Point = new Point(fromX, fromY);
			var to:Point = new Point(toX, toY);
			_tgt.lineStyle(thickness, color, alpha, _hinting, LineScaleMode.NORMAL,
				CapsStyle.NONE, JointStyle.MITER, _dLimit);
			if (pos != NONE && _titleMetrics) {
				if (pos == TOP) {
					to.x = _titleMetrics.x;
					_dashedLine.drawLine(from, to);
					from.x = _titleMetrics.x + _titleMetrics.width;
					to.x = toX;
					_dashedLine.drawLine(from, to);
				} else if (pos == BOTTOM) {
					to.x = _titleMetrics.x + _titleMetrics.width;
					_dashedLine.drawLine(from, to);
					from.x = _titleMetrics.x;
					to.x = toX;
					_dashedLine.drawLine(from, to);
				}
			} else _dashedLine.drawLine(from, to);
			_tgt.endFill();
		}
		
		private function drawTRC(thickness:Number, color1:uint, color2:uint, alpha1:Number, alpha2:Number):void {
			var w:Number = dto.width;
			var cd:Number = _cornerDelay;
			//trace(thickness, w - thickness / 2, w - thickness / 2);
			if (dto.trcr < 1 && !_dashedMode) {
				if (thickness <= 1) return;
				setLineStyle(thickness, color1, color2, alpha1, alpha2, 1,
					thickness, 1, w - thickness + cd, -cd);
				_tgt.moveTo(w - thickness / 2 + cd, -cd);
				_tgt.lineTo(w + thickness / 2 + cd, -cd);
				return;
			}
			setLineStyle(thickness, color1, color2, alpha1, alpha2, 0, dto.trcr, 1, w - dto.trcr, -cd);
			if (!_dashedMode) {
				_tgt.moveTo(w - dto.trcr, -cd);
				_tgt.curveTo(w + cd, -cd, w + cd, dto.trcr);
				_tgt.endFill();
			} else {
				_dashedLine.drawArc(new Point(w - dto.trcr, dto.trcr),
					-Math.PI/2, Math.PI/2, dto.trcr, _arced);
			}
		}
		
		private function setLineStyle(t:Number, c1:uint, c2:uint, a1:Number, a2:Number, ratios:uint, s:Number, delta:Number, tx:Number, ty:Number):void {
			var r:Array = ratios == 0 ? [0, 250] : [127, 127];
			(!_dashedMode) ? _tgt.lineStyle(t, c1, 1, _hinting, LineScaleMode.NORMAL,
								CapsStyle.NONE, JointStyle.MITER, _limit):
							_tgt.lineStyle(t, c1, 1, _hinting, LineScaleMode.NORMAL,
								CapsStyle.NONE, JointStyle.MITER, _dLimit);
			_tgt.lineGradientStyle(GradientType.LINEAR, [c1, c2], [a1, a2], r, getMatrix(s, delta, tx, ty));
		}
		
		private function drawBRC(thickness:Number, color1:uint, color2:uint, alpha1:Number, alpha2:Number):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var cd:Number = _cornerDelay;
			if (dto.brcr < 1 && !_dashedMode) {
				if (thickness <= 1) return;
				setLineStyle(thickness, color1, color2, alpha1, alpha2, 1, thickness, 3,
					w - thickness, h - thickness);
				_tgt.moveTo(w + cd, h - thickness / 2 + cd);
				_tgt.lineTo(w + cd, h + thickness / 2 + cd);
				return;
			}
			setLineStyle(thickness, color1, color2, alpha1, alpha2, 0, dto.brcr, 3, w - dto.brcr, h - dto.brcr);
			if (!_dashedMode) {
				_tgt.moveTo(w +cd, h - dto.brcr);
				_tgt.curveTo(w + cd, h + cd, w - dto.brcr, h + cd);
				_tgt.endFill();
			} else _dashedLine.drawArc(new Point(w - dto.brcr, h - dto.brcr), 0, Math.PI / 2, dto.brcr, _arced);
		}
		
		private function drawBLC(thickness:Number, color1:uint, color2:uint, alpha1:Number, alpha2:Number):void {
			var h:Number = dto.height;
			var cd:Number = _cornerDelay;
			if (dto.blcr < 1 && !_dashedMode) {
				if (thickness <= 1) return;
				setLineStyle(thickness, color1, color2, alpha1, alpha2, 1, thickness, 5, 0, h - thickness);
				_tgt.moveTo(-cd, h + thickness / 2 + cd);
				_tgt.lineTo(-cd, h - thickness / 2 + cd);
				return;
			}
			setLineStyle(thickness, color1, color2, alpha1, alpha2, 0, dto.blcr, 5, 0, h - dto.blcr);
			if (!_dashedMode) {
				_tgt.moveTo(dto.blcr, h + cd);
				_tgt.curveTo( -cd, h + cd, -cd, h - dto.blcr);
				_tgt.endFill();
			} else {
				_dashedLine.drawArc(new Point(dto.blcr, h - dto.blcr),
					Math.PI/2, Math.PI/2, dto.blcr, _arced);
			}
		}
		
		private function drawTLC(thickness:Number, color1:uint, color2:uint, alpha1:Number, alpha2:Number):void {
			var cd:Number = _cornerDelay;
			if (dto.tlcr < 1 && !_dashedMode) {
				if (thickness <= 1) return;
				setLineStyle(thickness, color1, color2, alpha1, alpha2, 1, thickness, 7, 0, 0);
				_tgt.moveTo(-thickness / 2 -cd, -cd);
				_tgt.lineTo(thickness / 2 -cd, -cd);
				return;
			}
			setLineStyle(thickness, color1, color2, alpha1, alpha2, 0, dto.tlcr, 7, 0, 0);
			if (!_dashedMode) {
				_tgt.moveTo( -cd, dto.tlcr);
				_tgt.curveTo(-cd, -cd, dto.tlcr, -cd);
				_tgt.endFill();
			} else _dashedLine.drawArc(new Point(dto.tlcr, dto.tlcr), Math.PI, Math.PI/2, dto.tlcr, _arced);
		}
		
		private function getMatrix(w:Number, delta:Number, tx:Number = 0, ty:Number = 0):Matrix {
			var m:Matrix = new Matrix();
			m.createGradientBox(w, w, delta * Math.PI / 4 , tx, ty);
			return m;
		}
		
		private function drawSingleBorder(w:Number, h:Number, pos:String, colors:Array, alphas:Array):void {
			var bw:Number = dto.borderWidth;
			var a0:Number = alphas[0];
			var a1:Number = alphas[1];
			var a2:Number = alphas[2];
			var a3:Number = alphas[3];
			drawLine(bw, colors[0], a0, dto.tlcr, 0, w - dto.trcr, 0, pos);
			drawTRC(bw, colors[0], colors[1], a0, a1);
			drawLine(bw, colors[1], a1, w, dto.trcr, w, h - dto.brcr, NONE, 1);
			drawBRC(bw, colors[1], colors[2], a1, a2);
			drawLine(bw, colors[2], a2, w - dto.brcr, h, dto.blcr, h, pos, 2);
			drawBLC(bw, colors[2], colors[3], a2, a3);
			drawLine(bw, colors[3], a3, 0, h - dto.blcr, 0, dto.tlcr, NONE, 3);
			drawTLC(bw, colors[3], colors[0], a3, a0);
		}
		
		private function drawBeveledBorder(w:Number, h:Number, pos:String, colors:Array, alphas:Array):void {
			var bw:Number = dto.borderWidth;
			var c0:uint = colors[0];
			var c1:uint = colors[1];
			var a0:Number = alphas[0];
			var a1:Number = alphas[1];
			drawLine(bw, c0, a0, dto.tlcr, 0, w - dto.trcr, 0, pos);
			drawTRC(bw, c0, c1, a0, a1);
			drawLine(bw, c1, a1, w, dto.trcr, w, h - dto.brcr, NONE, 1);
			drawBRC(bw, c1, c1, a1, a1);
			drawLine(bw, c1, a1, w - dto.brcr, h, dto.blcr, h, pos, 2);
			drawBLC(bw, c1, c0, a1, a0);
			drawLine(bw, c0, a0, 0, h - dto.blcr, 0, dto.tlcr, NONE, 3);
			drawTLC(bw, c0, c0, a0, a0);
		}
		
		private function drawCompositeBorder(w:Number, h:Number, pos:String, colors:Array, alphas:Array, delta:int):void {
			var bw:Number = Math.round(dto.borderWidth / 2);
			var d:Number = bw * delta / 2;
			_cornerDelay = d;
			var d1:Number = dto.tlcr < 1 ? d : 0;
			var d2:Number = dto.trcr < 1 ? d : 0;
			var d3:Number = dto.brcr < 1 ? d : 0;
			var d4:Number = dto.blcr < 1 ? d : 0;
			var a0:Number = alphas[0];
			var a1:Number = alphas[1];
			var c0:uint = colors[0];
			var c1:uint = colors[1];
			drawLine(bw, c0, a0, dto.tlcr + d1, d, w - dto.trcr - d2, d, pos);
			drawTRC(bw, c1, c0, a1, a0);
			drawLine(bw, c1, a1, w - d, dto.trcr + d2, w - d, h - dto.brcr - d3, NONE, 1);
			drawBRC(bw, c0, c0, a0, a0);
			drawLine(bw, c1, a1, w - dto.brcr - d3, h - d, dto.blcr + d4, h - d, pos, 2);
			drawBLC(bw, c0, c1, a0, a1);
			drawLine(bw, c0, a0, d, h - dto.blcr - d4, d, dto.tlcr + d1, NONE, 3);
			drawTLC(bw, c1, c1, a1, a1);
		}
		
		private function drawDoubleBorder(w:Number, h:Number, titlePos:String, c1:uint, c2:uint, c3:uint, c4:uint, a1:Number, a2:Number, a3:Number, a4:Number, isFramed:Boolean = false):void {
			var bw:Number = dto.borderWidth;
			if(bw < 2) drawSingleBorder(w, h, titlePos, [c1, c2, c3, c4], [a1, a2, a3, a4]);
			else {
				var d:Number = Math.round(bw / 3);
				var d1:Number = dto.tlcr >= 1 ? 0 : d;
				var d2:Number = dto.trcr >= 1 ? 0 : d;
				var d3:Number = dto.brcr >= 1 ? 0 : d;
				var d4:Number = dto.blcr >= 1 ? 0 : d;
				var dif:Number = isFramed ? d / 2 : d;
				_cornerDelay = d;
				drawLine(d, c1, a1, dto.tlcr - d1, -d, w - dto.trcr + d2, -d, titlePos);
				drawTRC(dif, c1, c2, a1, a2);
				drawLine(d, c2, a2, w + d, dto.trcr - d2, w + d, h - dto.brcr + d3, NONE, 1);
				drawBRC(dif, c2, c3, a2, a3);
				drawLine(d, c3, a3, w - dto.brcr + d3, h + d, dto.blcr - d4, h + d, titlePos, 2);
				drawBLC(dif, c3, c4, a3, a4);
				drawLine(d, c4, a4, -d, h - dto.blcr + d4, -d, dto.tlcr - d1, NONE, 3);
				drawTLC(dif, c4, c1, a4, a1);
				_cornerDelay = -dif;
				drawLine(d, c1, a1, dto.tlcr + d1, d, w - dto.trcr - d2, d, titlePos);
				drawTRC(d, c1, c2, a1, a2);
				drawLine(d, c2, a2, w - d, dto.trcr + d2, w - d, h - dto.brcr - d3, NONE, 1);
				drawBRC(d, c2, c3, a2, a3);
				drawLine(d, c3, a3, w - dto.brcr - d3, h - d, dto.blcr + d4, h - d, titlePos, 2);
				drawBLC(d, c3, c4, a3, a4);
				drawLine(d, c4, a4, d, h - dto.blcr - d4, d, dto.tlcr + d1, NONE, 3);
				drawTLC(d, c4, c1, a4, a1);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _tgt:Graphics;
		private var _titleMetrics:Rectangle;
		private var _cornerDelay:Number;
		private var _dashedLine:DashedLine;
		private var _dashedMode:Boolean = false;
		private var _hinting:Boolean = true;
		private var _limit:Number = 127;
		private var _dLimit:Number = 0;
		private var _arced:Boolean = true;
		//private var _hasDoubleBorder:Boolean = false;
	}
}