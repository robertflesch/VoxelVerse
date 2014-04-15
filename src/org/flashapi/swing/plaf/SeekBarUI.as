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
	// SeekBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 11/06/2010 14:44
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SeekBarUI</code> interface defines the interface required to
	 * 	create <code>SeekBar</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.SeekBar
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface SeekBarUI extends BorderUI {
		
		/**
		 * 	Returns the <code>Class</code> reference that represents the Look and Feel for the
		 * 	thumb of the <code>SeekBar</code> instance. This class must implement the 
		 * 	<code>ThumbUI</code> interface.
		 * 
		 * 	@return	The class used as look and feel for the thumb.
		 * 
		 * 	@see org.flashapi.swing.plaf.ThumbUI
		 */
		function getThumbLaf():Class;
		
		/**
		 * 	Draws the highlightedbar of this <code>SeekBar</code> instance.
		 */
		function drawHighlight():void;
		
		/**
		 * 	Clears the highlightedbar bar of this <code>SeekBar</code> instance.
		 */
		function clearHighlight():void;
		
		/**
		 * 	Draws the progress bar of this <code>SeekBar</code> instance.
		 */
		function drawProgressBar():void;
		
		/**
		 * 	Clears the progress bar of this <code>SeekBar</code> instance.
		 */
		function clearProgressBar():void;
		
		/**
		 * 	Returns the default thickness of the seek bar for this Look and Feel.
		 * 
		 * 	@return	The default thickness of the seek bar for this Look and Feel.
		 */
		function getSeekBarThickness():Number;
		
		//function getMinLength():Number;
		
		/**
		 * 	Returns the default color of the highlighted bar for this Look and Feel.
		 * 
		 * 	@return The default color of the highlighted bar for this Look and Feel.
		 */
		function getHighlightColor():uint;
	}
}