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
	// DatePickerUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/07/2008 10:58
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFormat;
	
	/**
	 * 	The <code>DatePickerUI</code> interface defines the interface required to
	 * 	create <code>DatePicker</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.DatePicker
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DatePickerUI extends LookAndFeel {
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the default titlebar color of the look and feel.
		 * 
		 * 	@return	The default titlebar color of this look and feel.
		 */
		function getTitleBarColor():uint;
		
		/**
		 * 	Return the height of the datepicker titlebar, in pixels.
		 * 
		 * 	@return	the height of the datepicker titlebar.
		 */
		function getTitleBarHeight():Number;
		
		/**
		 * 	Return the padding value for each row into the <code>DatePicker</code> instance.
		 * 
		 * 	@return	the padding value for each row, in pixels.
		 */
		function getRowPadding():Number;
		
		/**
		 * 	Return the padding value for each line into the <code>DatePicker</code> instance.
		 * 
		 * 	@return	the padding value for each line, in pixels.
		 */
		function getLinePadding():Number;
		
		/**
		 * 	Return the padding value between the titlebar and the date controls of 
		 * 	the <code>DatePicker</code> instance.
		 * 
		 * 	@return		the padding value between the titlebar and  the date controls.
		 */
		function getTitleBarPadding():Number;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the datepicker buttons. This class must implement the <code>ButtonUI</code>
		 * 	interface.
		 * 
		 * 	@return The class used as look and feel for the datepicker buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as brush for
		 * 	the datepicker next button. This class must implement the <code>StateBrush</code>
		 * 	interface.
		 * 
		 * 	@return The class used as brush for the datepicker next button.
		 * 
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		function getNextButtonBrush():Class;
		
		/**
		 * 	Returns the a reference of the class used as brush for the 
		 * 	datepicker previous button. This class must implement the <code>StateBrush</code>
		 * 	interface.
		 * 
		 * 	@return The class used as brush for the l previous button.
		 * 
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		function getPreviousButtonBrush():Class;
		
		/**
		 * 	Return the size of the datepicker buttons, in pixels.
		 * 	These buttons are square.
		 * 
		 * 	@return	the size of the datepicker buttons.
		 */
		function getButtonSize():Number;
		
		/**
		 * 	Return the size of the datepicker days selector buttons, in pixels.
		 * 	These buttons are square.
		 * 
		 * 	@return	the size of the datepicker days selector buttons.
		 */
		function getDayButtonSize():Number;
		
		/**
		 * 	Return the size of the datepicker years selector buttons, in pixels.
		 * 	These buttons are square.
		 * 
		 * 	@return	the size of the datepicker years selector buttons.
		 */
		function getYearButtonSize():Number;
		
		/**
		 * 	Returns a reference to the <code>TextFormat</code> used by the look and feel
		 * 	for the datepicker titlebar.
		 * 
		 * 	@return	The title <code>TextFormat</code> used by the look and feel
		 */
		function getTitleTextFormat():TextFormat;
		
		/**
		 * 	Returns a reference to the <code>TextFormat</code> used by the look and feel
		 * 	to display day names into the datepicker week bar.
		 * 
		 * 	@return	The day names <code>TextFormat</code> used by the look and feel
		 */
		function getWeekTextFormat():TextFormat;
		
		/**
		 * 	Returns a reference to the <code>TextFormat</code> used by the look and feel
		 * 	for the datepicker day buttons.
		 * 
		 * 	@return	The day buttons <code>TextFormat</code> used by the look and feel
		 */
		function getDayTextFormat():TextFormat;
		
		/**
		 * 	Returns a reference to the <code>TextFormat</code> used by the look and 
		 * 	feel for the datepicker disabled day buttons.
		 * 
		 * 	@return	The disabled day buttons <code>TextFormat</code> used by the look
		 * 	and feel
		 */
		function getDisabledDayTextFormat():TextFormat;
		
		/**
		 * 	Draws the titlebar of the <code>DatePicker</code> instance that uses this look and feel.
		 */
		function drawTitleBar():void;
		
		/**
		 * 	Draws the background of the <code>DatePicker</code> instance that uses this look and feel.
		 */
		function drawBackground():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the mouse is
		 * 	outside the button.
		 */
		function drawOutState():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the mouse is
		 * 	over the button.
		 */
		function drawOverState():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the button is
		 * 	clicked.
		 */
		function drawSelectedState():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the button
		 * 	represents the current date.
		 */
		function drawTodayOutState():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the mouse is
		 * 	over the button that represents the current date.
		 */
		function drawTodayOverState():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the button
		 * 	that represents the current date is selected.
		 */
		function drawTodaySelectedState():void;
		
		/**
		 * 	This method draws the face of a datepicker buttons when the button is
		 * 	deactivated.
		 */
		function drawInactiveState():void;
		
		/**
		 * 
		 */
		function drawNextYearOutState():void;
		
		/**
		 * 
		 */
		function drawPreviousYearOutState():void;
	}
}