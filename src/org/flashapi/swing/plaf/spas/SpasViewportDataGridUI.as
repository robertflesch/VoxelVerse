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
	// SpasViewportDataGridUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/04/2011 01:27
	* @see http://www.flashapi.org/
	*/

	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.ViewportDataGridUI;
	
	/**
	 * 	The <code>SpasViewportDataGridUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>ViewportDataGrid</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ViewportDataGrid
	 * 	@see org.flashapi.swing.plaf.ViewportDataGridUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.7
	 */
	public class SpasViewportDataGridUI extends SpasUI implements ViewportDataGridUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasViewportDataGridUI(dto:LafDTO) {
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
		public function getBackgroundColor():uint {
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return DEFAULT_BORDER_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderAlpha():Number {
			return 1;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDataGridLaf():Class {
			return SpasDataGridUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawScrollBarHeader():void {
			var c:uint = dto.headerColor;
			var w:Number = dto.headerWidth;
			var h:Number = dto.headerHeight;
			var bch:Number = 1;
			var middle:Number = h/2;
			var tgt:Sprite = dto.currentTarget;
			var m:Matrix = MatrixUtil.getMatrix(w, h);
			/*var manager:TextureManager = dto.textureManager;
			if (manager.texture) {
				manager.setShape = function():void {
					with(manager.figure) {
						drawRectangle(0, 0, w, h);
						drawSpasEffect(tgt, w, lineColor1, middle, bch);
					}
				}
				manager.draw(TextureType.TEXTURE);
			} else {*/
				var f:Figure = Figure.setFigure(tgt);
				var color2:RGB = new RGB(c);
				f.clear();
				f.beginGradientFill(GradientType.LINEAR, [color2.darker(), c], [1, 1], [0, 250], m);
				f.drawRectangle(0, 0, w, h);
				f.endFill();
				drawSpasEffect(tgt, w,middle, bch);
			//}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
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