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
	// SliderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.2.0, 10/11/2010 16:37
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SliderUI</code> interface defines the interface required to
	 * 	create <code>Slider</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Slider
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface SliderUI extends LookAndFeel {
		
		/**
		 * 	Draws the slider track.
		 */
		function drawTrack():void;
		
		/**
		 * 	This method is used by the look and feel to draw each tick of the slider.
		 */
		function drawTick():void;
		
		/**
		 * 	This method is used by the look and feel to clear all the ticks of the slider.
		 */
		function clearTicks():void;
		
		/**
		 * 	Draws the slider thumb button.
		 */
		function drawThumb():void;
		
		/**
		 * 	This method is used by the look and feel to draw the slider highlight track.
		 */
		function drawHighlight():void;
		
		/**
		 * 	This method is used by the look and feel to clear the slider highlight track.
		 */
		function clearHighlight():void;
		
		/**
		 * 	Returns the width of the slider for the current look and feel.
		 * 
		 * 	@return	the width of the slider, in pixels.
		 */
		function getSliderWidth():Number;
		
		/**
		 * 	Returns the minimal size of the slider for the current look and feel.
		 * 
		 * 	@return	the minimal size of the slider, in pixels.
		 */
		function getMinLength():Number;
		
		/**
		 * 	Returns the size of the slider for the current look and feel.
		 * 
		 * 	@return	the minimal size of the slider, in pixels.
		 */
		function getSliderLength():Number;
		
		/**
		 * 	Returns a number that represents the gap between the track and the
		 * 	ticks displayed on the face of the slider.
		 * 
		 *	@return the gap between the track and the ticks displayed on the face of the slider.
		 */
		function getTickDelay():Number;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the slider ticks labels.
		 * 	This class must implement the <code>LabelUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the slider ticks labels.
		 * 
		 * 	@see org.flashapi.swing.plaf.LabelUI
		 */
		function getLabelLaf():Class;
	}
}