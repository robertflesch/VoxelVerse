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
	// SpasWebsafeColorPickerUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 10/11/2010 17:49
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.WebsafeColorPickerUI;
	
	/**
	 * 	The <code>SpasWebsafeColorPickerUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>WebsafeColorPicker</code> instances.
	 * 
	 * 	@see org.flashapi.swing.WebsafeColorPicker
	 * 	@see org.flashapi.swing.plaf.WebsafeColorPickerUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasWebsafeColorPickerUI extends SpasUI implements WebsafeColorPickerUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasWebsafeColorPickerUI(dto:LafDTO) {
			super(dto);
			var rgb:RGB = new RGB(DEFAULT_COLOR);
			_darkColor = rgb.darker(.1);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function drawColorArea():void {
			var f:Figure = new Figure(dto.colorArea);
			f.clear();
			f.beginFill(_darkColor);
			f.drawRectangle(0, 0, dto.colorAreaWidth, dto.colorAreaHeight);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPreviewPanel():void {
			var d:Number = COLOR_ITEM_DELAY;
			var f:Figure = new Figure(dto.selectedColorPanel);
			f.clear();
			f.beginFill(_darkColor);
			f.drawRectangle(0, 0, PREVIEW_WIDTH+2*d, 4*ITEM_SIZE+d);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			var f:Figure = new Figure(dto.currentButton);
			f.clear();
			f.beginFill(dto.currentButtonColor);
			f.drawRectangle(0, 0, ITEM_SIZE, ITEM_SIZE);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			var f:Figure = new Figure(dto.currentButton);
			f.clear();
			f.lineStyle(1, 0xFFFFFF);
			f.beginFill(dto.currentButtonColor);
			f.drawRectangle(0, 0, ITEM_SIZE, ITEM_SIZE);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			var f:Figure = new Figure(dto.currentButton);
			f.clear();
			f.lineStyle(2, 0xFFFFFF);
			f.beginFill(dto.currentButtonColor);
			f.drawRectangle(0, 0, ITEM_SIZE, ITEM_SIZE);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPreviewColorButton():void {
			var f:Figure = new Figure(dto.currentPreviewButton);
			f.clear();
			f.beginFill(dto.currentPreviewColor);
			f.drawRectangle(0, 0, PREVIEW_WIDTH, 2*ITEM_SIZE);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColorItemDelay():Number {
			return COLOR_ITEM_DELAY;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColorItemSize():Number {
			return ITEM_SIZE;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderDelay():Number {
			return 4;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPreviewWidth():Number {
			return PREVIEW_WIDTH;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPreviewDelay():Number {
			return 5;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBoxLaf():Class {
			return SpasBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderStyle():String {
			return BorderStyle.OUTSET;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBackgroundColor():uint {
			return DEFAULT_COLOR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const COLOR_ITEM_DELAY:Number = 1;
		private const ITEM_SIZE:Number = 10;
		private const PREVIEW_WIDTH:Number = 70;
		private var _darkColor:uint;
	}
}