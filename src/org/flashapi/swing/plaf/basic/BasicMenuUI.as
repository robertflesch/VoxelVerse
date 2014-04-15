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
	// BasicMenuUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 20/01/2009 15:19
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.effect.ScaleIn;
	import org.flashapi.swing.icons.CheckIcon;
	import org.flashapi.swing.icons.RadioIcon;
	import org.flashapi.swing.icons.RightIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.MenuUI;
	
	/**
	 * 	The <code>BasicMenuUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Menu</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Menu
	 * 	@see org.flashapi.swing.plaf.MenuUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicMenuUI extends BasicRadioIconColorsUI implements MenuUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicMenuUI(dto:LafDTO) {
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
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0x888888;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getStartEffect():Class {
			return ScaleIn;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRadioIconBrush():Class {
			return RadioIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getCheckIconBrush():Class {
			return CheckIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getRightArrowBrush():Class {
			return RightIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSelectableItemLaf():Class {
			return BasicSelectableItemUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSeparatorLaf():Class {
			return BasicSeparatorUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBoxLaf():Class {
			return BasicBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderStyle():String {
			return BorderStyle.SOLID;
		}
	}
}