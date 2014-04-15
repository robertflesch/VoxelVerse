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
	// Clock.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/03/2009 22:51
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>Clock</code> interface defines the basic set of APIs that you must
	 * 	implement to create SPAS 3.0 objects that are able to display specified
	 * 	dates.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Clock extends Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the time duration in seconds between two calls to the
		 * 	<code>synchronize()</code> function. If <code>autoSynchronization</code>
		 * 	is set to <code>-1</code>, the <code>synchronize()</code> function is not
		 * 	automatically called and the <code>Clock</code> object is not synchronized.
		 * 
		 * 	@default -1
		 * 
		 * 	@see #onSynchronize
		 * 	@see #synchronise()
		 */
		function get autoSynchronization():int;
		function set autoSynchronization(value:int):void;
		
		/**
		 * 	Specifies the function used to synchronize the clock when the 
		 * 	<code>synchronize()</code> method is called.
		 * 
		 * 	@default null
		 * 
		 * 	@see #autoSynchronization
		 * 	@see #synchronize()
		 */
		function get onSynchronize():Function;
		function set onSynchronize(value:Function):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Synchronizes the clock by calling the funtion defined by the <code>onSynchronize</code>
		 * 	property if it is not <code>null</code>.
		 * 
		 * 	@see #onSynchronize
		 * 	@see #autoSynchronization
		 */
		function synchronize():void;
		
		/**
		 * Resets the time of the <code>Clock</code> object to 12 midnight.
		 */
		function reset():void;
		
		/**
		 * Starts the clock ticking.
		 */
		function start():void;

		/**
		 * Stops the clock ticking.
		 */
		function stop():void;
		
		/**
		 * Changes the time of the <code>Clock</code> object.
		 *
		 * @param   hour	The hour for specifying the new time.
		 * @param   minute	The minutes for specifying the new time.
		 * @param   second	The seconds for specifying the new time.
		 */
		function setTime(hour:Number, minute:Number, second:Number):void;
		
		/**
		 * 	Returns an object that contains the time properties for this
		 * 	<code>Clock</code> object. The properties for the returned object are:
		 * 	<ul>
		 * 		<li><code>hours</code></li>,
		 * 		<li><code>minutes</code></li>,
		 * 		<li><code>seconds</code></li>.
		 * 	</ul>
		 * 
		 * 	@return	An object that contains the time properties for this
		 * 			<code>Clock</code> object.
		 */
		function getTime():Object;
		
		/**
		 * 	Sets the time of the <code>Clock</code> object by using the local
		 * 	machine time. 
		 */
		function setCurrentLocalTime():void;
		
		/**
		 * @private
		 */
		function updateTime():void;
	}
}