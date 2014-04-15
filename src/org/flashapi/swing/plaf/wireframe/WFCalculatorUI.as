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

package org.flashapi.swing.plaf.wireframe {
	
	// -----------------------------------------------------------
	// WFCalculatorUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 00:31
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.CalculatorUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>SpasCalculatorUI</code> class is the SPAS 3.0 wireframe-like  look and feel
	 * 	for <code>Calculator</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Calculator
	 * 	@see org.flashapi.swing.plaf.CalculatorUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFCalculatorUI extends WFUI implements CalculatorUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFCalculatorUI(dto:LafDTO) {
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
			return WFTextInputUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonLaf():Class {
			return WFButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getPanelLaf():Class {
			return WFPanelUI;
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