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
	// WFDataGridHeaderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 13:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.icons.UpDownIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.DataGridHeaderUI;
	
	/**
	 * 	The <code>WFDataGridHeaderUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>DataGridHeader</code> instances.
	 * 
	 * 	@see org.flashapi.swing.table.DataGridHeader
	 * 	@see org.flashapi.swing.plaf.DataGridHeaderUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WFDataGridHeaderUI extends WFIconColorsUI implements DataGridHeaderUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFDataGridHeaderUI(dto:LafDTO) {
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
			return WFTextUI;
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
			drawShape(dto.color);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawOutState():void {
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ? dto.colors.up : dto.color;
			drawShape(bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ? dto.colors.over : 0xcccccc;
			drawShape(bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ? dto.colors.down : 0x666666;
			drawShape(bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawSelectedState():void {
			var bntColor:uint = (dto.colors.selected != StateObjectValue.NONE) ? dto.colors.selected : 0x999999;
			drawShape(bntColor);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ? dto.colors.disabled : dto.color;
			drawShape(bntColor);
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
		
		private function drawShape(buttonColor:uint):void {
			with(dto.currentTarget.graphics) {
				clear();
				beginFill(buttonColor);
				drawRect(0, 0, dto.width, dto.height);
				endFill();
			}
		}
	}
}