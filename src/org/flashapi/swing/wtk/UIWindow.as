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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// UIWindow.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1 20/08/2009 12:31
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>WTK</code> (for Windowing ToolKit) interface defines the basic
	 * 	set of APIs that you must implement to create SPAS 3.0 resizable windows.
	 * 
	 * 	@see org.flashapi.swing.Window
	 * 	@see org.flashapi.swing.wtk.AWM
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface UIWindow extends WTK {
		
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	A <code>Boolean</code> value that indicates whether the window uses the
		 * 	chromeless mode to be displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	<p>When chromeless mode is activated, the chrome of the wondows is not
		 * 	rendered and only the content frame is displayed.</p>
		 * 
		 * 	@default false
		 */
		function get chromelessMode():Boolean;
		function set chromelessMode(value:Boolean):void;
		
		/**
		 * 	Sets or gets the operation that executes by default when the user minimizes  
		 * 	the <code>UIWindow</code> instance. Valid values are:
		 * 		<ul>
		 * 			<li><code>MinimizableProperties.DO_NOTHING_ON_CALL</code>,</li>
		 * 			<li><code>MinimizableProperties.MINIMIZE_ON_CALL</code>.</li>
		 * 		</ul>
		 * 
		 * 	@default	MinimizableProperties.MINIMIZE_ON_CALL
		 */
		function get defaultMinimizeOperation():String;
		function set defaultMinimizeOperation(value:String):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the window can be
		 * 	displayed in full screen mode (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		function get enabledFullScreen():Boolean;
		function set enabledFullScreen(value:Boolean):void;
		
		/**
		 * 	Returns a reference to the window maximizing button.
		 * 
		 * 	@see org.flashapi.swing.wtk.WindowButton
		 * 
		 * 	@see #minimizeButton
		 * 	@see #showMaximizeButton
		 * 	@see #showMinimizeButton
		 */
		function get maximizeButton():WindowButton;
		
		/**
		 * 	Returns a reference to the window minimizing button.
		 * 
		 * 	@see org.flashapi.swing.wtk.WindowButton
		 * 
		 * 	@see #maximizeButton
		 * 	@see #showMaximizeButton
		 * 	@see #showMinimizeButton
		 */
		function get minimizeButton():WindowButton;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the maximizing
		 * 	button is displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #maximizeButton
		 * 	@see #minimizeButton
		 * 	@see #showMinimizeButton
		 */
		function get showMaximizeButton():Boolean;
		function set showMaximizeButton(value:Boolean):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the minimizing
		 * 	button is displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #maximizeButton
		 * 	@see #minimizeButton
		 * 	@see #showMaximizeButton
		 */
		function get showMinimizeButton():Boolean;
		function set showMinimizeButton(value:Boolean):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the window
		 * 	can be resized (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		function get resizable():Boolean;
		function set resizable(value:Boolean):void;
		
		/**
		 * 	Sets the current state of the window. Possible values are:
		 * 	<ul>
		 * 		<li><code>WindowState.NORMAL</code>,</li>
		 * 		<li><code>WindowState.MAXIMIZED</code>,</li>
		 * 		<li><code>WindowState.MINIMIZED</code>.</li>
		 * 	</ul>
		 * 
		 * 
		 * 	@default WindowState.NORMAL
		 */
		function set state(value:String):void;
	}
}