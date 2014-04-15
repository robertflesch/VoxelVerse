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
	// WFBubbleHelpUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 00:21
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.constants.AnchorPosition;
	import org.flashapi.swing.plaf.BubbleHelpUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>WFBubbleHelpUI</code> class is the SPAS 3.0 wireframe-like  look and feel
	 * 	for <code>BubbleHelp</code> instances.
	 * 
	 * 	@see org.flashapi.swing.BubbleHelp
	 * 	@see org.flashapi.swing.plaf.BubbleHelpUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFBubbleHelpUI extends WFUI implements BubbleHelpUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFBubbleHelpUI(dto:LafDTO) {
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
			with (dto.currentTarget.graphics) {
				clear();
				lineStyle(1, 0, 1, true);
				beginFill(0xffffff, 1);
				drawRect(0, 0, dto.width, dto.height);
				endFill();
			}
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
				case AnchorPosition.LEFT :
					vert = false;
					break;
			}
			with (dto.currentTarget.graphics) {
				beginFill(0xffffff, 1);
				lineStyle(1, 0xffffff, 1, true);
				if(vert) {
					moveTo(sx - s, o);
					lineTo(sx + s, o);
					lineStyle(1, 0, 1, true);
					lineTo(sx, sy);
					lineTo(sx - s, o);
				} else {
					moveTo(o, sy - s);
					lineTo(o, sy + s);
					lineStyle(1, 0, 1, true);
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
			return DEFAULT_COLOR;
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
		public function getAnchorSize():Number {
			return SIZE;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private const SIZE:Number = 10;
	}
}