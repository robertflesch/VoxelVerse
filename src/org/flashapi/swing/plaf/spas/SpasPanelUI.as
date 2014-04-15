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
	// SpasPanelUI.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 03/06/2010 16:26
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.plaf.PanelUI;
	
	/**
	 * 	The <code>SpasPanelUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>Panel</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Panel
	 * 	@see org.flashapi.swing.plaf.PanelUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasPanelUI extends SpasUI implements PanelUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasPanelUI(dto:LafDTO) {
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
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return BORDER_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPanel():void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var c:uint = dto.color;
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, CURVE_DELAY);
			var tlc:Number = cu.topLeft;
			var trc:Number = cu.topRight;
			var manager:TextureManager = dto.textureManager;
			if (manager.texture!=null) {
				manager.color = c;
				manager.setShape = function():void {
					with(manager.figure) {
						lineStyle(1, 0xFFFFFF, .5, true);
						drawRoundedBox(0, 0, w, h, tlc, trc, cu.bottomRight, cu.bottomLeft);
						drawSpasEffect(w, tlc, trc, h / 2, PANEL_CURVE_HEIGHT);
					}
				}
				manager.draw(TextureType.TEXTURE);
			} else {
				var f:Figure = Figure.setFigure(dto.currentTarget);
				var a:Number = dto.backgroundAlpha;
				var m:Matrix = MatrixUtil.getMatrix(w, h);
				var color2:RGB = new RGB(c);
				f.clear();
				f.beginGradientFill(GradientType.LINEAR, [color2.darker(), c], [a, a], [0, 250], m);
				f.lineStyle(1, dto.borderColor, .5, true);
				//p.lineGradientStyle(GradientType.LINEAR, [0x969696, 0x505050], [1, 1], [0, 250], m);
				f.drawRoundedBox(0, 0,w, h, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
				drawSpasEffect(w, tlc, trc, h / 2, PANEL_CURVE_HEIGHT);
			}
		}
		
		private function drawSpasEffect(w:Number, tlc:Number, trc:Number, curveMiddle:Number, pch:Number):void {
			with(dto.currentTarget.graphics) {
				moveTo(tlc, 0);
				lineStyle(0, 0x969696, 0);
				beginFill(0xFFFFFF, .2);
				lineTo(w-trc, 0);
				curveTo(w, 0, w, trc);
				lineTo(w, curveMiddle-pch);
				curveTo(3*w/4, curveMiddle+pch, w/2, curveMiddle);
				curveTo(w/4, curveMiddle-pch, 0, curveMiddle+pch);
				lineTo(0, tlc);
				curveTo(0, 0, tlc, 0);
				endFill();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		private const CURVE_DELAY:Number = 10;
		private const PANEL_CURVE_HEIGHT:Number = 2;
		private const BORDER_COLOR:uint = 0x969696;
	}
}