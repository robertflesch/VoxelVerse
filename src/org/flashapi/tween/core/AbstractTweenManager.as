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
	// AbstractTweenManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/05/2011 20:31
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>AbstractTweenManager</code> class is the root class that must be
	 * 	decorated by all-static classes to create tween managers.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractTweenManager {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>AbstractTweenManager</code> instance 
		 * 					with the specified parameters.
		 * 
		 * 	@param	tweenStack	Defines the internal stack for storing <code>ITween</code>
		 * 						objects. Must be an <code>Array</code> or a <code>Vector</code>
		 * 						instance.
		 */
		public function AbstractTweenManager(tweenStack:Object) {
			super();
			initObj(tweenStack);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the interval value between each update of <code>ITween</code>
		 * 	objects managed by this <code>AbstractTweenManager</code> instance, in
		 * 	milliseconds.
		 * 
		 * 	@default 10
		 * 
		 * 	@return 	The interval value between each update of <code>ITween</code>
		 * 				objects
		 * 
		 * 	@see #setInterval()
		 */
		public function getInterval():uint {
			return _interval;
		}
		
		/**
		 * 	Sets the interval value between each update of <code>ITween</code>
		 * 	objects managed by this <code>AbstractTweenManager</code> instance, in
		 * 	milliseconds.
		 * 
		 * 	@param	value 	An interger that represents the new interval between 
		 * 					each update of <code>ITween</code> objects, in milliseconds.
		 * 
		 * 	@see #getInterval()
		 */
		public function setInterval(value:uint):void {
			_interval = value;
			if (_timer != -1) {
				deleteTimer();
				createTimer();
			}
		}
		
		/**
		 * 	Stops and removes all active <code>ITween</code> objects from this 
		 * 	<code>AbstractTweenManager</code> instance.
		 */
		public function rescue():void {
			deleteTimer();
			while(_tweensStack.length > 0) {
				_tweensStack.pop();
			}
		}
		
		/**
		 * 	Removes an <code>ITween</code> object from this <code>AbstractTweenManager</code>
		 * 	instance.
		 * 
		 * 	@param	tween	The <code>ITween</code> object to remove from this
		 * 					<code>AbstractTweenManager</code> instance.
		 * 
		 * 	@see #addTween()
		 */
		public function removeTween(tween:ITween):void {
			//trace("removeFromPlayingStack", tween.id, _tweensStack.length);
			var id:int = _tweensStack.indexOf(tween);
			_tweensStack.splice(id, 1);
			if (_tweensStack.length < 1 && _timer != -1) deleteTimer();
		}
		
		/**
		 * 	Adds an <code>ITween</code> object to this <code>AbstractTweenManager</code>
		 * 	instance.
		 * 
		 * 	@param	tween	The <code>ITween</code> object to add to this
		 * 					<code>AbstractTweenManager</code> instance.
		 * 
		 * 	@see #removeTween()
		 */
		public function addTween(tween:ITween):void {
			var id:int = _tweensStack.indexOf(tween);
			if (id != -1) return;
			_tweensStack.push(tween);
			tween.dispatchEvent(new MotionEvent(MotionEvent.START));
			if(_timer == -1) createTimer();
		}
		
		/**
		 * 	Returns a number that represents the current time at which all <code>ITween</code>
		 * 	objects are updated. This value is passed as the <code>currentTime</code>
		 * 	parameter of the <code>org.flashapi.tween.core.ITween.update()</code>
		 * 	method.
		 * 
		 * 	@return		The current time at which all <code>ITween</code> objects
		 * 				are updated.
		 */
		public function getGlobalTime():Number {
			return _globalTime;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _interval:uint;
		
		/**
		 * 	@private
		 */
		private var _timer:int;
		
		/**
		 * 	@private
		 */
		private var _tweensStack:Object;
		
		/**
		 * 	@private
		 * 
		 * 	_globalTime ensure that all tweens refer to the same current time value
		 * 	when update event is fired:
		 */
		private var _globalTime:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private function initObj(stack:Object):void {
			_tweensStack = stack;
			_interval = 10;
			_globalTime = 0;
			_timer = -1;
		}
		
		/**
		 * 	@private
		 */
		private function timerCallback():void {
			setGlobalTime();
			var i:int = _tweensStack.length - 1;
			for (; i >= 0; i--) _tweensStack[i].update(_globalTime);
		}
		
		/**
		 * 	@private
		 */
		private function createTimer():void {
			setGlobalTime();
			_timer = flash.utils.setInterval(timerCallback, _interval);
		}
		
		/**
		 * 	@private
		 */
		private function deleteTimer():void {
			clearInterval(_timer);
			_timer = -1;
		}
		
		/**
		 * 	@private
		 */
		private function setGlobalTime():void {
			_globalTime = getTimer();
		}
	}
}