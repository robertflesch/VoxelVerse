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
	// BasicBubbleHelpUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/08/2008 20:19
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.constants.AnchorPosition;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.BubbleHelpUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	
	/**
	 * 	The <code>BasicBubbleHelpUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>BubbleHelp</code> instances.
	 * 
	 * 	@see org.flashapi.swing.BubbleHelp
	 * 	@see org.flashapi.swing.plaf.BubbleHelpUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicBubbleHelpUI extends BasicUI implements BubbleHelpUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicBubbleHelpUI(dto:LafDTO) {
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
		public function drawBackground():void {
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, 4);
			if (!isNaN(dto.backgroundAlpha)) _backgroundAlpha = dto.backgroundAlpha;
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			f.lineStyle(dto.borderWidth, dto.borderColor, dto.borderAlpha, true);
			f.beginFill(dto.color, _backgroundAlpha);
			f.drawRoundedBox(0, 0, dto.width, dto.height, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawAnchor():void {
			var pt:Point = dto.controlPoint;
			var sx:Number = pt.x;
			var sy:Number = pt.y
			var o:Number = 0;
			var vert:Boolean = true;
			var s:Number = SIZE / 2;
			switch(dto.anchorPosition) {
				case AnchorPosition.BOTTOM :
					o = dto.height;
					break;
				case AnchorPosition.RIGHT :
					o = dto.width;
					break;
				case AnchorPosition.LEFT :
					vert = false;
					break;
			}
			var bw:Number = dto.borderWidth;
			var ba:Number = dto.borderAlpha;
			var bc:uint = dto.borderColor;
			with (dto.currentTarget.graphics) {
				beginFill(dto.color, _backgroundAlpha);
				lineStyle(bw, bc, ba, true);
				if(vert) {
					moveTo(sx - s, o);
					lineTo(sx + s, o);
					lineStyle(bw, bc, ba, true);
					lineTo(sx, sy);
					lineTo(sx - s, o);
				} else {
					moveTo(o, sy - s);
					lineTo(o, sy + s);
					lineStyle(bw, bc, ba, true);
					lineTo(sx, sy);
					lineTo(o, sy - s);
				}
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return 0xFEFFDD;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getAnchorSize():Number {
			return SIZE;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private const SIZE:Number = 10;
		private var _backgroundAlpha:Number = 1;
	}
}