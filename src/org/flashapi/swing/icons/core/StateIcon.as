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

package org.flashapi.swing.icons.core {
	
	// -----------------------------------------------------------
	// StateIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/01/2009 02:58
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>StateIcon</code> interface defines the basic set of APIs that you
	 * 	must implement to create icons which can display different shapes according
	 * 	to specific states.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface StateIcon {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter proterties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the next state that will be rendered by this
		 * 	<code>StateIcon</code> object.
		 */
		function get nextState():int;
		function set nextState(value:int):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Draws the icon with the shape related to the specified state.
		 */
		function paint():void;
		
		/**
		 * 	Clears the icon.
		 */
		function clear():void;
	}
}