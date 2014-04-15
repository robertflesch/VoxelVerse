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
	// SpasSpinnerUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 10/11/2010 15:14
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.icons.DownIcon;
	import org.flashapi.swing.icons.UpIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SpinnerUI;
	
	/**
	 * 	The <code>SpasSpinnerUI</code> class is the SPAS 3.0 base look and feel
	 * 	for <code>AbstractSpinner</code> subclasses.
	 * 
	 * 	@see org.flashapi.swing.core.AbstractSpinner
	 * 	@see org.flashapi.swing.plaf.SpinnerUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasSpinnerUI extends SpasUI implements SpinnerUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasSpinnerUI(dto:LafDTO) {
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
		public function getButtonDelay():Number {
			return 1;
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
		public function geTextInputLaf():Class {
			return SpasTextInputUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonWidth():Number {
			return 20;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getUpArrowBrush():Class {
			return UpIcon;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getDownArrowBrush():Class {
			return DownIcon;
		}
	}
}