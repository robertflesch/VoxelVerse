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
	// WindowUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/12/2008 15:24
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>WindowUI</code> interface defines the interface required to
	 * 	create <code>Window</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Window
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface WindowUI extends BorderUI {
		
		/**
		 * 	Draws the window background.
		 */
		function drawWindow():void;
		
		/**
		 * 	Draws a rectangular area that represents the window boundaries when
		 * 	it is resized and the <code>AWM.quality</code> property is set to
		 * 	<code>1</code> or less.
		 */
		function drawWindowArea():void;
		
		/**
		 * 	Draws the window background when the window is displayed using the
		 * 	"minimized" mode.
		 */
		function drawMinimizedWindow():void;
		
		/**
		 * 	Draws the window inner panel.
		 */
		function drawInnerPanel():void;
		
		/**
		 * 	Draws the window title bar.
		 */
		function drawTitleBar():void;
		
		/**
		 * 	Applies aspecific effect to the text displayed the window title bar.
		 */
		function setTextEffect():void;
		
		/**
		 * 	The <code>setButtonsPosition()</code> method is called by the window object
		 * 	to set the position of all the title bar buttons.
		 */
		function setCloseButtonPosition():void;
		
		/**
		 * 	The <code>setCloseButtonPosition()</code> method is called by the window object
		 * 	to set the position of the title bar close button.
		 */
		function setButtonsPosition():void;
		
		/**
		 * 	Draws the background of the header tray for this window.
		 */
		function drawHeaderTray():void;
		
		/**
		 * 	Draws the background of the footer tray for this window.
		 */
		function drawFooterTray():void;
		
		/** 
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns a number that represents the height of the title bar.
		 * 
		 * 	@return	The height of the title bar.
		 */
		function getTitleBarHeight():Number;
		
		/**
		 * 	Returns a number that represents the width and the height for
		 * 	all window buttons.
		 * 
		 * 	@return	The size of the window buttons.
		 */
		function getButtonSize():Number;
		
		/**
		 * 	Returns the a reference to the class used as look and feel for
		 * 	the title bar buttons. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the title bar buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference to the class used as look and feel for
		 * 	the window scroll bars. This class must implement the
		 * 	<code>ScrollBarUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the scroll bars.
		 * 
		 * 	@see org.flashapi.swing.plaf.ScrollBarUI
		 */
		function getScrollBarLaf():Class;
		
		/**
		 * 	Returns a reference to the <code>UITextFormat</code> used by the look and feel.
		 * 
		 * 	@return	The <code>UITextFormat</code> used by the look and feel
		 */
		function getTextFormat():UITextFormat;
		
		/**
		 * 	Returns a number that represents the gap between the icon and the
		 * 	text displayed on the face of the window title bar.
		 * 
		 *	@return the gap between the icon and the text displayed by the title bar.
		 */
		function getIconDelay():Number;
		
		/**
		 *	Returns the window top offset distance.<br />
		 *  The top offset distance defines the distance between the top edge of the
		 * 	window and its content area.
		 * 
		 *	@return The window top offset distance.
		 */
		function getTopOffset():Number;
		
		/**
		 *	Returns the window left offset distance.<br />
		 *  The left offset distance defines the distance between the left edge of the
		 * 	window and its content area.
		 * 
		 *	@return The window left offset distance.
		 */
		function getLeftOffset():Number;
		
		/**
		 *	Returns the window right offset distance.<br />
		 *  The right offset distance defines the distance between the right edge of the
		 * 	window and its content area.
		 * 
		 *	@return The window right offset distance.
		 */
		function getRightOffset():Number;
		
		/**
		 *	Returns the window offset distance.<br />
		 *  The bottom offset distance defines the distance between the bottom edge of the
		 * 	window and its content area.
		 * 
		 *	@return The <code>AWM</code> bottom offset distance.
		 */
		function getBottomOffset():Number;
		
		/**
		 *	Returns the window title bar top offset distance.<br />
		 *  The title bar top offset distance defines the distance between the top edge of the
		 * 	window and the text displayed by the title bar.
		 * 
		 *	@return The window title bar top offset distance.
		 */
		function getTitleBarTopOffset():Number;
		
		/**
		 *	Returns the window title bar left offset distance.<br />
		 *  The title bar left offset distance defines the distance between the left edge of the
		 * 	window and the text displayed by the title bar.
		 * 
		 *	@return The window title bar left offset distance.
		 */
		function getTitleBarLeftOffset():Number;
		
		/**
		 *	Returns the window content panel offset distance.<br />
		 *  The content panel offset distance is the distance defined by the top, left
		 * 	right and bottom offset distances and the window content panel.
		 * 
		 * 	@return	The window content panel offset distance.
		 */
		function getInnerPanelOffset():Number
		
		/**
		 * 	Returns the a reference to the class used as <code>Brush</code> by
		 * 	the close button.
		 * 
		 * 	@return The class used as <code>Brush</code> by the close button.
		 */
		function getCloseButtonBrush():Class;
		
		/**
		 * 	Returns the a reference to the class used as <code>Brush</code> by
		 * 	the minimize button.
		 * 
		 * 	@return The class used as <code>Brush</code> by the minimize button.
		 */
		function getMinimizeButtonBrush():Class;
		
		/**
		 * 	Returns the a reference to the class used as <code>Brush</code> by
		 * 	the maximize button.
		 * 
		 * 	@return The class used as <code>Brush</code> by the maximize button.
		 */
		function getMaximizeButtonBrush():Class;
		
		/**
		 * 	Returns the a reference to the class used as <code>Brush</code> by
		 * 	the restore button.
		 * 
		 * 	@return The class used as <code>Brush</code> by the restore button.
		 */
		function getRestoreButtonBrush():Class;
	}
}