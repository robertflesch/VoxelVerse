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
	// SpasMuteButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/01/2009 00:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.icons.MuteIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.DrawableIconButtonUI;
	import org.flashapi.swing.plaf.spas.SpasButtonUI;
	
	/**
	 * 	The <code>SpasMuteButtonUI</code> class is the SPAS 3.0 default look and feel
	 * 	for mute button objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasMuteButtonUI extends SpasButtonUI implements DrawableIconButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasMuteButtonUI(dto:LafDTO) {
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
		public function getDefaultIcon():Class {
			return MuteIcon;
		}
	}
}