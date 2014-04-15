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
	// AccordionUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 09/11/2010 11:08
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>AccordionUI</code> interface defines the interface required to
	 * 	create <code>Accordion</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Accordion
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface AccordionUI extends LookAndFeel {
		
		/**
		 * 	Draws the accordion background.
		 */
		function drawBackground():void;
		
		/**
		 * 	Draws the accordion border.
		 */
		function drawBorder():void;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for the header
		 * 	buttons. This class must implement the <code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the accordion header buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns a reference to the class used as look and feel for
		 * 	the accordion containers scrollbars. This class must implement the
		 * 	<code>ScrollableAreaUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the accordion containers scrollbars.
		 * 
		 * 	@see org.flashapi.swing.plaf.ScrollableAreaUI
		 */
		function getScrollBarLaf():Class;
		
		/** 
		 * 	Returns the default border color of the look and feel.
		 * 
		 * 	@return	The default border color of this look and feel.
		 */
		function getBorderColor():uint;
		
		/** 
		 * 	Returns the default opacity value of the border for this look and feel.
		 * 
		 * 	@return	The default opacity value of the border for this look and feel.
		 */
		function getBorderAlpha():Number;
	}
}