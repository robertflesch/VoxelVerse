﻿////////////////////////////////////////////////////////////////////////////////
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
	// WFLabelUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/04/2011 15:44
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.LabelUI;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>WFLabelUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>Label</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Label
	 * 	@see org.flashapi.swing.plaf.LabelUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class WFLabelUI extends WFUI implements LabelUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFLabelUI(dto:LafDTO) {
			super(dto, _textFormat);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function update():void {}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextFormat():UITextFormat {
			return _textFormat;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDefaultHeight():Number {
			return 20; 
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