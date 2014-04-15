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
	// BoxHelpUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 17:34
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFormat;
	
	/**
	 * 	The <code>BoxHelpUI</code> interface defines the interface required to
	 * 	create <code>BoxHelp</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.BoxHelp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface BoxHelpUI extends LookAndFeel {
		
		/**
		 * 	The method used by the look and feel to clear the boxhelp background.
		 */
		function clearBoxHelp():void;
		
		/**
		 * 	The method used by the look and feel to draw the boxhelp background.
		 */
		function drawBoxHelp():void;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the internal offset of the <code>BoxHelp</code> textfield
		 * 	<code>x</code> position.
		 * 
		 * 	@return the offset of the <code>BoxHelp</code> textfield
		 * 			<code>x</code> position.
		 */
		function getHorizontalOffset():Number;
		
		/**
		 * 	Returns the internal offset of the <code>BoxHelp</code> textfield
		 * 	<code>y</code> position.
		 * 
		 * 	@return the offset of the <code>BoxHelp</code> textfield
		 * 			<code>y</code> position.
		 */
		function getVerticalOffset():Number;
		
		/**
		 * 	Returns a reference to the <code>TextFormat</code> used by the
		 * 	look and feel.
		 * 
		 * 	@return	the <code>TextFormat</code> used by the look and feel
		 */
		function getTextFormat():TextFormat;
		
		/**
		 * 	Returns the position of the <code>BoxHelp</code> instance compared
		 * 	to the <code>x</code> mouse position.
		 * 
		 * 	@return 	the <code>x</code> position of the <code>BoxHelp</code>
		 * 				compared to the <code>x</code> mouse position.
		 */
		function getXMouseOffset():Number;
		
		/**
		 * 	Returns the position of the <code>BoxHelp</code> instance compared
		 * 	to the <code>y</code> mouse position.
		 * 
		 * 	@return 	the <code>y</code> position of the <code>BoxHelp</code>
		 * 				compared to the <code>y</code> mouse position.
		 */
		function getYMouseOffset():Number;
	}
}