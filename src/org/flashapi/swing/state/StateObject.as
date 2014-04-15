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

package org.flashapi.swing.state {
	
	// -----------------------------------------------------------
	// StateObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 24/02/2009 23:57
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>StateObject</code> defines the basic set of APIs that you
	 * 	must implement to create objects that allow to manage different states
	 * 	of a <code>UIObject</code> instance, for the specified type of properties.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface StateObject {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the value for the specified properties when the current state of the
		 * 	<code>UIObject</code> defined to "up".
		 * 
		 * 	@default StateObjectValue.NONE
		 */
		function get up():*;
		function set up(value:*):void;
		
		/**
		 * 	Sets the value for the specified properties when the current state of the
		 * 	<code>UIObject</code> defined to "over".
		 * 
		 * 	@default StateObjectValue.NONE
		 */
		function get over():*;
		function set over(value:*):void;
		
		/**
		 * 	Sets the value for the specified properties when the current state of the
		 * 	<code>UIObject</code> defined to "down".
		 * 
		 * 	@default StateObjectValue.NONE
		 */
		function get down():*;
		function set down(value:*):void;
		
		/**
		 * 	Sets the value for the specified properties when the current state of the
		 * 	<code>UIObject</code> defined to "disabled".
		 * 
		 * 	@default StateObjectValue.NONE
		 */
		function get disabled():*;
		function set disabled(value:*):void;
		
		/**
		 * 	Sets the value for the specified properties when the current state of the
		 * 	<code>UIObject</code> defined to "selected".
		 * 
		 * 	@default StateObjectValue.NONE
		 */
		function get selected():*;
		function set selected(value:*):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Finalizes this <code>StateObject</code> instance. Then, you must set the 
		 * 	<code>StateObject</code> to <code>null</code> to make it elligible for
		 * 	garbage collection.
		 */
		function finalize():void;
	}
}