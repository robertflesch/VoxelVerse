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
	// ProgressBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 19/03/2011 14:13
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ProgressBarUI</code> interface defines the interface required to
	 * 	create <code>ProgressBar</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.ProgressBar
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public interface ProgressBarUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the default border color of the look and feel.
		 * 
		 * 	@return	The default border color of this look and feel.
		 */
		function getBorderColor():uint;
		
		/**
		 * 	Returns the highlighted track default color of the look and feel.
		 * 
		 * 	@return	The highlighted track default color of this look and feel.
		 */
		function getTrackHighlightColor():uint;
		
		/**
		 * 	Returns the default track color of the look and feel.
		 * 
		 * 	@return	The default track color of this look and feel.
		 */
		function getTrackColor():uint;
		
		/**
		 * 	This method draws the value bar of the <code>ProgressBar</code> instance.
		 */
		function drawBar():void;
		
		/**
		 * 	Draws the <code>ProgressBar</code> track.
		 */
		function drawTrack():void;
		
		/**
		 * 	Draws the <code>ProgressBar</code> highlighted track.
		 */
		function drawTrackHighlight():void;
		
		/**
		 * 	Draws the <code>ProgressBar</code> border.
		 */
		function drawBorder():void;
	}
}