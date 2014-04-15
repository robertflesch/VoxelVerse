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
	// SpasSeekBarThumbUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/11/2010 16:22
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.plaf.ThumbUI;
	
	/**
	 * 	The <code>SpasSeekBarThumbUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>SeekBarThumb</code> instances.
	 * 
	 * 	@see org.flashapi.swing.scroll.SeekBarThumb
	 * 	@see org.flashapi.swing.plaf.ThumbUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasSeekBarThumbUI extends SpasIconColorsUI implements ThumbUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasSeekBarThumbUI(dto:LafDTO) {
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
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ? dto.colors.up : dto.color;
			var lineColor1:uint = 0x888888;//0x969696
			var lineColor2:int = 0x505050;//0x505050
			if (dto.borderColors.up != StateObjectValue.NONE) {
				lineColor1 = dto.borderColors.up;
				lineColor2 = -1;
			}
			drawShape(bntColor, lineColor1, lineColor2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ?
				dto.colors.over : dto.color;
			var lineColor:uint = (dto.borderColors.over != StateObjectValue.NONE) ?
				dto.borderColors.over : 0xFFFFFF;
			drawShape(bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ?
				dto.colors.down : new RGB(dto.color).darker();
			var lineColor:uint = (dto.borderColors.down != StateObjectValue.NONE) ?
				dto.borderColors.down : 0x505050;
			drawShape(bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			var bntColor:uint = (dto.colors.selected != StateObjectValue.NONE) ?
				dto.colors.selected : new RGB(dto.color).darker();
			var lineColor:uint = (dto.borderColors.selected != StateObjectValue.NONE) ? 
				dto.borderColors.selected : 0x505050;
			drawShape(bntColor, lineColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ?
				dto.colors.disabled : new RGB(dto.color).brighter();
			var lineColor:uint = (dto.borderColors.disabled != StateObjectValue.NONE) ?
				dto.borderColors.disabled : getGrayTintColor();
			drawShape(bntColor, lineColor);
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
		public function getGrayTintColor():uint {
			return 0xACA899;
		}
		
		/**
		 * 	@private
		 */
		//override public function drawBackFace(target:Sprite):void {  }
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawShape(buttonColor:uint, lineColor1:uint, lineColor2:int = -1):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var state:String = dto.state;
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, 4);
			var bw:Number = dto.borderWidth;
			var tgt:Sprite = dto.target;
			var middle:Number = h / 2;
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			/*var manager:TextureManager = dto.textureManager;
			if (manager.texture != null) {
				var ct:ColorTransform;
				switch(state) {
					case ButtonState.UP : break;
					case ButtonState.OVER :
						ct = new ColorTransform();
						ct.redOffset = ct.blueOffset = ct.greenOffset = 50; break;
					case ButtonState.DOWN :case ButtonState.SELECTED:
						ct = new ColorTransform()
						ct.redOffset = ct.blueOffset = ct.greenOffset = -50; break;
				}
				manager.colorTransform = ct;
				manager.setShape = function():void {
					with(manager.figure) {
						lineStyle(bw, lineColor1, 1, true);
						if (lineColor2 != -1) lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
						drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
						drawSpasEffect(target, w, lineColor1, cu, middle);
					}
				}
				manager.draw(TextureType.TEXTURE);
			} else {*/
				var color2:RGB = new RGB(buttonColor);
				var f:Figure = Figure.setFigure(tgt);
				f.clear();
				f.lineStyle(bw, lineColor1, 1, true);
				if (lineColor2 != -1) f.lineGradientStyle(GradientType.LINEAR, [lineColor1, lineColor2], [1, 1], [0, 250], m);
				
				f.beginGradientFill(GradientType.LINEAR, [color2.darker(), buttonColor], [1, 1], [0, 250], m);
				f.drawRoundedBox(0, 0, w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
				f.endFill();
				drawSpasEffect(tgt, w, lineColor1, cu, middle);
			/*}*/
			
		}
		
		private function drawSpasEffect(target:Sprite, w:Number, lineColor1:uint, cu:LafDTOCornerUtil, middle:Number):void {
			with(target.graphics) {
				moveTo(cu.topLeft, 0);
				lineStyle(0, lineColor1, 0);
				beginFill(0xFFFFFF, .2);
				lineTo(w-cu.topRight, 0);
				curveTo(w, 0, w, cu.topRight);
				lineTo(w, middle);
				lineTo(0, middle);
				lineTo(0, cu.topLeft);
				curveTo(0, 0, cu.topLeft, 0);
				endFill();
			}
		}
	}	
}