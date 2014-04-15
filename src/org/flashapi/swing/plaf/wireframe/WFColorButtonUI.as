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
	// WFColorButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 02:04
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.plaf.ColorButtonUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>WFColorButtonUI</code> class is the SPAS 3.0 wireframe-like  look and feel
	 * 	for <code>ColorButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ColorButton
	 * 	@see org.flashapi.swing.plaf.ColorButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFColorButtonUI extends WFUI implements ColorButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFColorButtonUI(dto:LafDTO) { 
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
		public function drawOutState():void {
			var bntColor:uint = (dto.colors.up != StateObjectValue.NONE) ? dto.colors.up : dto.color;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var bntColor:uint = (dto.colors.over != StateObjectValue.NONE) ? dto.colors.over : 0xcccccc;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var bntColor:uint = (dto.colors.down != StateObjectValue.NONE) ? dto.colors.down : 0x666666;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			var bntColor:uint = (dto.colors.selected != StateObjectValue.NONE) ? dto.colors.selected : 0x999999;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var bntColor:uint = (dto.colors.disabled != StateObjectValue.NONE) ? dto.colors.disabled : dto.color;
			drawButtonShape(bntColor);
		}
		
		/**
		 *  @private
		 */
		override public function drawBackFace():void {
			drawOutState();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(buttonColor:uint):void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			with(dto.container.graphics) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR);
				beginFill(buttonColor, 1);
				drawRect(0, 0, w, h);
				endFill();
				beginFill(dto.selectedColor, 1);
				drawRect(4, 4, w-8, h-8);
				endFill();
			}
		}
	}
}