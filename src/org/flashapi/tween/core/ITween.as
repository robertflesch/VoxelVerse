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

package org.flashapi.tween.core {
	
	// -----------------------------------------------------------
	// ITween.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/05/2011 22:44
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	
	/**
	 * 	The <code>ITween</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 interpolation classes.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ITween extends IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Final value(s) of the animation. Either a number or an array of numbers.
		 * 	If a number is passed, the <code>ITween</code> interpolates between this
		 * 	number and the number passed in the <code>start</code> property. If an
		 * 	array of numbers is passed, each number in the array is interpolated.
		 * 
		 * 	<p><strong>The type of this property must match the type of the 
		 * 	<code>start</code> property.</strong></p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #start
		 */
		function get end():*;
		function set end(value:*):void;
		
		/**
		 * 	Initial value(s) of the animation. Either a number or an array of numbers.
		 * 	If a number is passed, the <code>ITween</code> interpolates between this
		 * 	number and the number passed in the <code>end</code> property. If an
		 * 	array of numbers is passed, each number in the array is interpolated.
		 * 
		 * 	<p><strong>The type of this property must match the type of the 
		 * 	<code>end</code> property.</strong></p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #end
		 */
		function get start():*;
		function set start(value:*):void;
		
		/**
		 * 	Sets or gets the duration of the animation, in milliseconds.
		 * 
		 * 	@default 500
		 */
		function get duration():uint;
		function set duration(value:uint):void;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether
		 * 	the <code>ITween</code> animation is currently playing 
		 * 	(<code>true</code>), or not(<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get isPlaying():Boolean;
		
		/**
		 * 	Sets or gets the current position of the playhead within the
		 * 	<code>ITween</code> animation.
		 * 	
		 * 	@default 0
		 */
		function get position():uint;
		function set position(value:uint):void;
		
		/**
		 * 	Sets or gets the object that is notified at each interval of the
		 * 	animation by this <code>ITween</code> object.
		 * 
		 * 	@default null
		 */
		function get target():Object;
		function set target(value:Object):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Frees the memory used by this <code>ITween</code> instance.
		 */
		function finalize():void;
		
		/**
		 * 	Calculates an interpolated value for a numerical property of animation.
		 * 
		 * 	@param	currentTime	The current time of the interpolation relative to
		 * 						the starting time of the Flash animation. Using 
		 * 						this property ensure that all <code>ITween</code>
		 * 						objects refer to the same current time value when
		 * 						<code>update()</code> functions are run.
		 */
		function update(currentTime:uint):void;
	}
}