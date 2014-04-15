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
	// WFComboBoxUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 13:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.icons.UpDownIcon;
	import org.flashapi.swing.plaf.ComboBoxUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>WFComboBoxUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>ComboBox</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ComboBox
	 * 	@see org.flashapi.swing.plaf.ComboBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFComboBoxUI extends WFIconColorsUI implements ComboBoxUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFComboBoxUI(dto:LafDTO) {
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
		public function getIcon():Class {
			return UpDownIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonPosition():Point {
			var x:Number = dto.buttonPosition == DropButtonPosition.RIGHT ? dto.width - 22 : 0;
			return new Point(x, 0);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			drawComboBoxShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void {
			drawComboBoxShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void {
			drawComboBoxShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getListLaf():Class {
			return WFListBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public  function getTextInputLaf():Class {
			return WFTextInputUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextFormat():UITextFormat {
			return _textFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getGrayTintColor():uint {
			return 0xACA899;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonDelay():Number {
			return 2;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextPadding():Number {
			return 4;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/*private var _buttonLength:Number = 18;
		private var _defaultHeight:Number = 24;*/
		private var _textFormat:UITextFormat =
			new UITextFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_BUTTON_FONT_COLOR, true);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawComboBoxShape():void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			with(dto.currentTarget.graphics) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR, 1, true);
				beginFill(DEFAULT_BACKGROUND_COLOR);
				drawRect(0, 0, w, h);
				endFill();
			}
		}
	}
}