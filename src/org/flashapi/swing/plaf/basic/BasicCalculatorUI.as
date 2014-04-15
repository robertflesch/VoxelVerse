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
	// BasicCalculatorUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 02/06/2009 11:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.CalculatorUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicCalculatorUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Calculator</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Calculator
	 * 	@see org.flashapi.swing.plaf.CalculatorUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicCalculatorUI extends BasicUI implements CalculatorUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicCalculatorUI(dto:LafDTO) {
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
		public function getTextInputLaf():Class {
			return BasicTextInputUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonLaf():Class {
			return BasicButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPanelLaf():Class {
			return BasicPanelUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOperatorColor():int {
			return -1;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getOperandColor():int {
			return -1;
		}
	}
}