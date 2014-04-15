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
	// BasicDividerButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/06/2008 12:09
	* @see http://www.flashapi.org/
	*/

	import flash.display.Sprite;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.DividerButtonUI;
	
	/**
	 * 	The <code>BasicDividerButtonUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>DividedBoxButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.button.core.DividedBoxButton
	 * 	@see org.flashapi.swing.plaf.DividerButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicDividerButtonUI extends BasicUI implements DividerButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicDividerButtonUI(dto:LafDTO) {
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
			var color:uint = (dto.colors.up!=StateObjectValue.NONE) ? dto.colors.up : 0x333333;
			drawButtonShape(color);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var color:uint = (dto.colors.over!=StateObjectValue.NONE) ? dto.colors.over : 0x009DFF;
			drawButtonShape(color);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var color:uint = (dto.colors.down!=StateObjectValue.NONE) ? dto.colors.down : 0xFFFFFF;
			drawButtonShape(color);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void {
			var color:uint = (dto.colors.selected!=StateObjectValue.NONE) ? dto.colors.selected : 0xFFFFFF;
			drawButtonShape(color);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void {
			var color:uint = (dto.colors.disabled!=StateObjectValue.NONE) ? dto.colors.disabled : 0xCCCCCC;
			drawButtonShape(color);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSeparator(target:Sprite, width:Number, height:Number):void {
			with (target.graphics) {
				clear();
				beginFill(0x333333, .5);
				drawRect(0, 0, width, height);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearSeparator(target:Sprite):void {
			target.graphics.clear();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawButtonShape(color:uint):void {
			with (dto.currentTarget.graphics) {
				clear();
				lineStyle(1, color);
				moveTo(0, 0);
				lineTo(0, 20);
				moveTo(3, 0);
				lineTo(3, 20);
				moveTo(6, 0);
				lineTo(6, 20);
				endFill();
			}
		}
	}
}