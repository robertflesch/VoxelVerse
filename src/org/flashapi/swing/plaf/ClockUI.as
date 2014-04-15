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
	// ClockUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2009 16:45
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	
	/**
	 * 	The <code>ClockUI</code> interface defines the interface required to
	 * 	create <code>AnalogClock</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.AnalogClock
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ClockUI extends LookAndFeel {
		
		/**
		 * 	Draws the clock dial.
		 */
		function drawDial():void;
		
		/**
		 * 	Draws the clock hours needle.
		 */
		function drawHoursNeedle():void;
		
		/**
		 * 	Draws the clock minutes needle.
		 */
		function drawMinutesNeedle():void;
		
		/**
		 * 	Draws the clock seconds needle.
		 */
		function drawSecondsNeedle():void;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the coordinates of the hours needle origin point.
		 * 
		 * 	@return A point that represents the hours needle origin.
		 */
		function getHoursPosition():Point;
		
		/**
		 * 	Returns the coordinates of the minutes needle origin point.
		 * 
		 * 	@return A point that represents the minutes needle origin.
		 */
		function getMinutesPosition():Point;
		
		/**
		 * 	Returns the coordinates of the seconds needle origin point.
		 * 
		 * 	@return A point that represents the seconds needle origin.
		 */
		function getSecondsPosition():Point;
	}
}