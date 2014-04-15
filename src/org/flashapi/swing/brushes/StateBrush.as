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


package org.flashapi.swing.brushes {
	
	// -----------------------------------------------------------
	// StateBrush.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/05/2009 21:27
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.state.ColorState;
	
	/**
	 * 	The <code>StateBrush</code> interfaces specifies methods and properties to draw brush objects
	 * 	which implement a "state" mechanism. The "state" mechanism is used for example,
	 * 	by the <code>ABM</code> class to describe the interractions between mouse and buttons.
	 * 	<p><code>StateBrush</code> objects are often used to draw button icons.</p>
	 * 
	 * 	@see org.flashapi.swing.button.core.ABM
	 * 	@see org.flashapi.swing.state.StateObject
	 * 	@see org.flashapi.swing.state.ColorState
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface StateBrush extends Brush {
		
		/**
		 * 	A <code>ColorState</code> object. The colors property sets and gets the color of the
		 * 	<code>StateBrush</code> object for each state. <code>ColorState</code> instances
		 * 	define four different states:
		 * <ul>
		 * 		<li><code>ColorState.disabled</code></li>
		 * 		<li><code>ColorState.down</code></li>
		 * 		<li><code>ColorState.over</code></li>
		 *  	<li><code>ColorState.up</code></li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are
		 * 	the same as valid values for the <code>Brush.color()</code> property.
		 * 	The default value for each state is <code>none</code>. To unset a color state
		 * 	value, use the <code>none</code> value.</p>
		 *  
		 *  @see org.flashapi.swing.draw.Brush#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		function get colors():ColorState;
		function set colors(value:ColorState):void;
		
		/**
		 * 	Indicates the current state of the <code>Brush</code>. Possible values are:
		 * <ul>
		 * 		<li><code>States.OUT</code></li>
		 * 		<li><code>States.OVER</code></li>
		 * 		<li><code>States.PRESSED</code></li>
		 *  	<li><code>States.SELECTED</code></li>
		 * 		<li><code>States.EMPHASIZED</code></li>
		 * 		<li><code>States.INACTIVE</code></li>
		 * 	</ul>
		 * 
		 * 	@default States.OUT
		 */
		function get state():String;
		
		/**
		 * 	Specifies the state of <code>StateBrush</code> object that is being drawn
		 * 	when state is "out".
		 */
		function drawOutState():void ;
		
		/**
		 * 	Specifies the state of <code>StateBrush</code> object that is being drawn
		 * 	when state is "over".
		 */
		function drawOverState():void;
		
		/**
		 * 	Specifies the state of <code>StateBrush</code> object that is being drawn
		 * 	when state is "pressed".
		 */
		function drawPressedState():void;
		
		/**
		 * 	Specifies the state of <code>StateBrush</code> object that is being drawn
		 * 	when state is "selected".
		 */
		function drawSelectedState():void;
		
		/**
		 * 	Specifies the state of <code>StateBrush</code> object that is being drawn
		 * 	when state is "emphasized".
		 */
		function drawEmphasizedState():void;
		
		/**
		 * 	Specifies the state of <code>StateBrush</code> object that is being drawn
		 * 	when state is "inactive".
		 */
		function drawInactiveState():void;
	}
}