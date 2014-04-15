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
	// KnobButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 11/04/2011 14:41
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>KnobButtonUI</code> interface defines the interface required to
	 * 	create <code>KnobButton</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.KnobButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface KnobButtonUI extends LookAndFeel {
		
		/**
		 * 	Draws the knob button face.
		 */
		function drawButton():void;
		
		/**
		 * 	Draws the knob button background track.
		 */
		function drawTrack():void;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the button default thumb color.
		 * 
		 * 	@return	The button default thumb color.
		 */
		function getThumbColor():uint;
		
		/**
		 * 	Returns the button default border color.
		 * 
		 * 	@return	The button default border color.
		 */
		function getBorderColor():uint
	}
}