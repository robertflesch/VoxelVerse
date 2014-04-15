////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product. If you have received this file from a source
//  other than BANANA TREE DESIGN, then your use, modification, or distribution
//  of this file requires the prior written permission of BANANA TREE DESIGN
//  and Pascal ECHEMANN.
//
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing.plaf.spas.media {

	// -----------------------------------------------------------
	// SpasMediaTextUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/01/2009 19:00
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.spas.SpasTextUI;
	import org.flashapi.swing.plaf.TextUI;
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>SpasMediaTextUI</code> class is the SPAS 3.0 default look and feel
	 * 	for text media objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasMediaTextUI extends SpasTextUI implements TextUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasMediaTextUI(dto:LafDTO) {
			super(dto);
		}
		
		/**
		 *  @inheritDoc 
		 */
		override public function getTextFormat():UITextFormat {
			return _textFormat;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textFormat:UITextFormat = new UITextFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, 0xFFFFFF, true);
	}
}