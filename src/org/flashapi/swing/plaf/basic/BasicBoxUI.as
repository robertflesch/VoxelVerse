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
	// BasicBoxUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/12/2008 14:57
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.plaf.BoxUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicBoxUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Box</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Box
	 * 	@see org.flashapi.swing.plaf.BoxUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicBoxUI extends BasicUI implements BoxUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicBoxUI(dto:LafDTO) {
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
		public function getBackgroundColor():uint {
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0x999999;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderAlpha():Number {
			return 1;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDefaultRadius():Number {
			return 0;
		}
	}
}