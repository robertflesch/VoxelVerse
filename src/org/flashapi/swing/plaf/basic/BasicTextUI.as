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
	// BasicTextUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 18:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.TextUI;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>BasicTextUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Accordion</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Text
	 * 	@see org.flashapi.swing.plaf.TextUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicTextUI extends BasicUI implements TextUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicTextUI(dto:LafDTO) {
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
		public function drawBackground():void {}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearBackground():void {}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBorder():void {}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearBorder():void {}
		
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
			return BACKGROUND_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return BORDER_COLOR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textFormat:UITextFormat = new UITextFormat(WebFonts.VERDANA, 12);
		private const BACKGROUND_COLOR:uint = 0xFFFFFF;
		private const BORDER_COLOR:uint = 0x999999;
	}
}