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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// CalculatorUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 02/06/2009 11:44
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>CalculatorUI</code> interface defines the interface required to
	 * 	create <code>Calculator</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Calculator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface CalculatorUI extends LookAndFeel {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the calculator text input. This class must implement the
		 * 	<code>TextInputUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the calculator text input.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextInputUI
		 */
		function getTextInputLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the calculator buttons. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the calculator buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the calculator panel. This class must implement the <code>PanelUI</code>
		 * 	interface.
		 * 
		 * 	@return The class used as look and feel for the calculator panel.
		 * 
		 * 	@see org.flashapi.swing.plaf.PanelUI
		 */
		function getPanelLaf():Class;
		
		/**
		 * 
		 * 	@default -1
		 * 
		 * 	@return
		 */
		function getOperatorColor():int;
		
		/**
		 * 
		 * 	@default -1
		 * 
		 * 	@return
		 */
		function getOperandColor():int;
	}
}