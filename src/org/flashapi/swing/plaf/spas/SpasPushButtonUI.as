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
	// SpasPushButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/02/2011 00:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.ButtonUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.text.FontFormat;
	
	/**
	 * 	The <code>SpasPushButtonUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>PushButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.PushButton
	 * 	@see org.flashapi.swing.plaf.ButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasPushButtonUI extends SpasIconColorsUI implements ButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasPushButtonUI(dto:LafDTO) {
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
		public function drawOutState():void {
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ?
				dto.colors.up : dto.color;
			var lineColor1:uint = 0x888888;//0x969696
			var lineColor2:int = 0x505050;//0x505050
			if (dto.borderColors.up != StateObjectValue.NONE){
				lineColor1 = dto.borderColors.up;
				lineColor2 = -1;
			}
			drawButtonShape(ButtonState.UP, bntColor, lineColor1, lineColor2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ?
				dto.colors.over : dto.color;
			var lineColor:uint = (dto.borderColors.over != StateObjectValue.NONE) ?
				dto.borderColors.over : 0xFFFFFF;
			drawButtonShape(ButtonState.OVER, bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ?
				dto.colors.down : new RGB(dto.color).darker();
			var lineColor:uint = (dto.borderColors.down != StateObjectValue.NONE) ?
				dto.borderColors.down : 0x505050;
			drawButtonShape(ButtonState.DOWN, bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			var bntColor:uint = (dto.colors.selected != StateObjectValue.NONE) ?
				dto.colors.selected : new RGB(dto.color).darker();
			var lineColor:uint = (dto.borderColors.selected != StateObjectValue.NONE) ?
				dto.borderColors.selected : 0x505050;
			drawButtonShape(ButtonState.SELECTED, bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ?
				dto.colors.disabled : new RGB(dto.color).brighter();
			var lineColor:uint = (dto.borderColors.disabled != StateObjectValue.NONE) ?
				dto.borderColors.disabled : getGrayTintColor();
			drawButtonShape(ButtonState.DISABLED, bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveIcon():void {
			var it:Transform = dto.icon.transform;
            it.colorTransform = new ColorTransform(.2, .2, .2, .2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawActiveIcon():void {
			var it:Transform = dto.icon.transform;
            it.colorTransform = new ColorTransform(1, 1, 1, 1);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawDottedLine():void {
			/*if(dashedLine==null) dashedLine = new DashedLine(dto, 1, 2);
			dashedLine.lineStyle(0, 0x777777, 1, true);
			dashedLine.drawRectangle(new Point(2, 2), new Point(dto.width-2, dto.height-2));
			dashedLine.endFill();*/
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getUpFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOverFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDownFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectedFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDisabledFontFormat():FontFormat {
			return _fontFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getGrayTintColor():uint {
			return 0xACA899;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getIconDelay():Number {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTopOffset():Number {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getLeftOffset():Number {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRightOffset():Number {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBottomOffset():Number {
			return 0;
		}
		
		/**
		 * 	@private
		 */
		override public function drawBackFace():void {
			drawOutState();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fontFormat:FontFormat = new FontFormat();
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(state:String, buttonColor:uint, lineColor1:uint, lineColor2:int = -1):void {
			var r:Number = dto.radius;
			var tgt:Sprite = dto.currentTarget;
			var manager:TextureManager = dto.textureManager;
			var m:Matrix = MatrixUtil.getMatrix(2*r, 2*r);
			var bw:Number = dto.borderWidth;
			if (manager.texture) {
				var ct:ColorTransform;
				switch(state) {
					case ButtonState.UP :
						break;
					case ButtonState.OVER :
						ct = new ColorTransform();
						ct.redOffset = ct.blueOffset = ct.greenOffset = 50;
						break;
					case ButtonState.DOWN :
					case ButtonState.SELECTED:
						ct = new ColorTransform();
						ct.redOffset = ct.blueOffset = ct.greenOffset = -50;
						break;
				}
				manager.colorTransform = ct;
				manager.setShape = function():void {
					with(manager.figure) {
						lineStyle(bw, lineColor1, 1, true);
						if (lineColor2 != -1) lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
						drawCircle(r, r, r);
						drawSpasEffect(tgt, 2.5*r/3, r);
					}
				}
				manager.draw(TextureType.TEXTURE);
			} else {
				var color1:uint = state == ButtonState.OVER ?
					new RGB(buttonColor).brighter() : buttonColor;
				var color2:uint = new RGB(buttonColor).darker();
				with(tgt.graphics) {
					clear();
					lineStyle(bw, lineColor1, 1, true);
					if (lineColor2 != -1) {
						lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
					}
					beginGradientFill(GradientType.RADIAL, [color1, color2], [1, 1], [0, 250], m);
					drawCircle(r, r, r);
					endFill();
				}
				drawSpasEffect(tgt, 2.5*r/3, r);
			}
		}
		
		private function drawSpasEffect(tgt:Sprite, r:Number, offset:Number):void {
			var m:Matrix = MatrixUtil.getMatrix(2*r, r, Math.PI / 2);
			with (tgt.graphics) {
				lineStyle(0, 0, 0);
				beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [1, 0], [0, 120], m);
				drawCircle(offset, r+3, r);
				endFill();
			}
		}
	}	
}