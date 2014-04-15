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
	// SpasTextUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 01/02/2008 13:25
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.TextUI;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>SpasTextUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>Text</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Text
	 * 	@see org.flashapi.swing.plaf.TextUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasTextUI extends SpasUI implements TextUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasTextUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBackground():void {
			/*var color:uint = DEFAULT_BACKGROUND_COLOR;
			var f:Figure = Figure.setFigure(dto.backgroundDisplay);
			f.clear();
			f.beginFill(color, 1);
			f.drawRectangle(0, 0, dto.textWidth, dto.textHeight);
			f.endFill();*/
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearBackground():void {
			//dto.backgroundDisplay.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBorder():void {
			/*var color:uint = DEFAULT_BORDER_COLOR;
			var f:Figure = Figure.setFigure(dto.borderDisplay);
			f.clear();
			f.lineStyle(1, color);
			f.drawRectangle(0, 0, dto.textWidth, dto.textHeight);
			f.endFill();*/
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearBorder():void {
			//dto.borderDisplay.graphics.clear();
		}
		
		/**
		 * 	@private
		 */
		override public function drawBackFace():void {
			drawBackground();
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
		public function getBackgroundColor():uint {
			return DEFAULT_BACKGROUND_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return DEFAULT_BORDER_COLOR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textFormat:UITextFormat =
			new UITextFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR);
	}
}