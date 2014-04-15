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
	// SpasDropIconUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 10/11/2010 11:54
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.icons.UpDownIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.DropIconListUI;
	
	/**
	 * 	The <code>SpasDropIconUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>DropIcon</code> instances.
	 * 
	 * 	@see org.flashapi.swing.DropIcon
	 * 	@see org.flashapi.swing.plaf.DropIconListUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasDropIconUI extends SpasIconColorsUI implements DropIconListUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasDropIconUI(dto:LafDTO) {
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
		public function getButtonLaf():Class {
			return SpasButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getListLaf():Class {
			return SpasIconListBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getIcon():Class {
			return UpDownIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonTopRadius():Number {
			return 6;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonBottomRadius():Number {
			return 6;
		}
	}
}