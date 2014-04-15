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
	// SpasDataGridHeaderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 10:27
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
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.icons.UpDownIcon;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.DataGridHeaderUI;
	
	/**
	 * 	The <code>SpasDataGridHeaderUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>DataGridHeader</code> instances.
	 * 
	 * 	@see org.flashapi.swing.table.DataGridHeader
	 * 	@see org.flashapi.swing.plaf.DataGridHeaderUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasDataGridHeaderUI extends SpasIconColorsUI implements DataGridHeaderUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasDataGridHeaderUI(dto:LafDTO) {
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
		public function getTextLaf():Class {
			return SpasTextUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getIcon():Class {
			return UpDownIcon;
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
		public function drawBackground():void {
			drawShape(ButtonState.UP, dto.color);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawOutState():void {
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ? dto.colors.up : dto.color;
			drawShape(ButtonState.UP, bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ?
				dto.colors.over :  new RGB(dto.color).darker(.8);
			drawShape(ButtonState.UP, bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ?
				dto.colors.down :  new RGB(dto.color).darker();
			drawShape(ButtonState.UP, bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawSelectedState():void {
			drawPressedState();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ?
				dto.colors.disabled : new RGB(dto.color).brighter();
			drawShape(ButtonState.UP, bntColor);
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
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawShape(state:String, buttonColor:uint):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var bch:Number = 1;
			var middle:Number = h/2;
			var tgt:Sprite = dto.currentTarget;
			var manager:TextureManager = dto.textureManager;
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			if (manager.texture) {
				var ct:ColorTransform;
				switch(state) {
					case ButtonState.UP :
						break;
					case ButtonState.OVER :
						ct = new ColorTransform();
						ct.redOffset = ct.blueOffset = ct.greenOffset = 50;
						break;
					case ButtonState.DOWN :case ButtonState.SELECTED:
						ct = new ColorTransform();
						ct.redOffset = ct.blueOffset = ct.greenOffset = -50;
						break;
				}
				manager.colorTransform = ct;
				manager.setShape = function():void {
					with(manager.figure) {
						drawRectangle(0, 0, w, h);
						drawSpasEffect(tgt, w, lineColor1, middle, bch);
					}
				}
				manager.draw(TextureType.TEXTURE);
			} else {
				var f:Figure = Figure.setFigure(tgt);
				var color2:RGB = new RGB(buttonColor);
				f.clear();
				f.beginGradientFill(GradientType.LINEAR, [color2.darker(), buttonColor], [1, 1], [0, 250], m);
				f.drawRectangle(0, 0, w, h);
				f.endFill();
				drawSpasEffect(tgt, w,middle, bch);
			}
		}
		
		private function drawSpasEffect(tgt:Sprite, w:Number, middle:Number, bch:Number):void {
			with(tgt.graphics) {
				moveTo(0, 0);
				beginFill(0xFFFFFF, .2);
				lineTo(w, 0);
				lineTo(w, middle);
				curveTo(3*w/4, middle+bch, w/2, middle);
				curveTo(w/4, middle-bch, 0, middle);
				lineTo(0, 0);
				endFill();
			}
		}
	}
}