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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// KeyObserver.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/02/2011 16:22
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * 	The <code>KeyObserver</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 visual <code>UIObject</code>.
	 * 
	 * 	@see org.flashapi.swing.managers.FocusManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface KeyObserver extends IEventDispatcher {
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Notifies to this <code>KeyObserver</code> instance that a "keyUp" event has
		 * 	been fired.
		 * 
		 * 	@param	event	The <code>KeyboardEvent</code> object that runs the
		 * 					<code>notifyKeyEvent()</code> method.
		 */
		function notifyKeyUpEvent(event:KeyboardEvent):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Notifies to this <code>KeyObserver</code> instance that a "keydown" event has
		 * 	been fired.
		 * 
		 * 	@param	event	The <code>KeyboardEvent</code> object that runs the
		 * 					<code>notifyKeyEvent()</code> method.
		 */
		function notifyKeyDownEvent(event:KeyboardEvent):void;
	}
}