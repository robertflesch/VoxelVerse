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
	// TweenBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 29/05/2011 18:21
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	import org.flashapi.tween.constant.TweenExceptionType;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.tween.exception.TweenException;
	import org.flashapi.tween.motion.Linear;
	
	use namespace beetween;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched each time the <code>play()</code> or <code>reverse()</code> 
	 * 	methods are called.
	 *
	 *  @eventType org.flashapi.tween.event.MotionEvent.START
	 */
	[Event(name = "start", type = "org.flashapi.tween.event.MotionEvent")]
	
	/**
	 *  Dispatched each time the <code>stop()</code> method is called.
	 *
	 *  @eventType org.flashapi.tween.event.MotionEvent.STOP
	 */
	[Event(name = "stop", type = "org.flashapi.tween.event.MotionEvent")]
	
	/**
	 *  Dispatched each time the <code>ITween</code> object is updated and the  
	 * 	new interpolated values are accessible.
	 *
	 *  @eventType org.flashapi.tween.event.MotionEvent.UPDATE
	 */
	[Event(name = "update", type = "org.flashapi.tween.event.MotionEvent")]
	
	/**
	 *  Dispatched after the <code>ITween</code> animation is finished and the 
	 * 	finale interpolated values are accessible.
	 *
	 *  @eventType org.flashapi.tween.event.MotionEvent.FINISH
	 */
	[Event(name = "finish", type = "org.flashapi.tween.event.MotionEvent")]
	
	/**
	 * 	The <code>TweenBase</code> class is the base class for both <code>Tween</code>
	 * 	and <code>BTween</code> classes.
	 * 
	 * 	@see org.flashapi.tween.Tween
	 * 	@see org.flashapi.tween.BTween
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TweenBase extends EventDispatcher implements SequentialTween {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>TweenBase</code> instance with the 
		 * 					specified parameters.
		 * 
		 * 	@param	managerRef
		 * 	@param	target	The object that is notified at each interval of the
		 * 					animation. 
		 * 	@param	start	The initial value(s) of the animation. Either a number or
		 * 					an array of numbers. If a number is passed, the animation
		 * 					interpolates between this number and the number passed in
		 * 					the <code>end</code> parameter. If an array of numbers is
		 * 					passed, each number in the array is interpolated.
		 * 	@param	end		The final value(s) of the animation. The type of the
		 * 					<code>end</code> parameter must match the type of the
		 * 					<code>start</code> parameter.
		 * 	@param	duration	The duration of the animation, in milliseconds.
		 */
		public function TweenBase(managerRef:Object, target:Object = null, start:* = null, end:* = null, duration:uint = 500) {
			super();
			initObj(managerRef, target, start, end, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _end:*;
		/**
		 * 	@inheritDoc
		 */
		public function get end():* {
			return _end;
		}
		public function set end(value:*):void {
			_end = __endObj = value;
		}
		
		/**
		 * 	@private
		 */
		private var _start:*;
		/**
		 * 	@inheritDoc
		 */
		public function get start():* {
			return _start;
		}
		public function set start(value:*):void {
			_start = __startObj = value;
		}
		
		/**
		 * 	@private
		 */
		private var _duration:uint;
		/**
		 * 	@inheritDoc
		 */
		public function get duration():uint {
			return _duration;
		}
		public function set duration(value:uint):void {
			_duration = value;
		}
		
		/**
		 * 	@private
		 */
		private var _isPlaying:Boolean;
		/**
		 * 	@inheritDoc
		 */
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		/**
		 * 	@private
		 */
		private var _position:Number;
		/**
		 * 	@inheritDoc
		 */
		public function get position():uint {
			return _position;
		}
		public function set position(value:uint):void {
			_starTime = _manager.beetween::getGlobalTime() - value;
		}
		
		/**
		 * 	@private
		 */
		private var _target:Object;
		/**
		 * 	@inheritDoc
		 */
		public function get target():Object {
			return _target;
		}
		public function set target(value:Object):void {
			_target = value;
		}
		
		/**
		 * 	@private
		 */
		private var _id:String;
		/**
		 * 	@inheritDoc
		 */
		public function get id():String {
			return _id;
		}
		public function set id(value:String):void {
			_id = value;
		}
		
		/**
		 * 	@private
		 */
		private var _className:String;
		/**
		 * 	@inheritDoc
		 */
		public function get className():String {
			return _className;
		}
		public function set className(value:String):void {
			_className = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function pause():void {
			_isPlaying = false;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function play():void {
			if (_isPlaying) return;
			checkArrayData();
			setParameters(__startObj, __endObj);
			_starTime = getTimer();
			_isPlaying = true;
			_manager.beetween::addTween(this);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function reset():void{
			//_isPlaying = true;
			setParameters(__startObj, __endObj);
			_starTime = getTimer();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resume():void{
			_isPlaying = true;
			_starTime = _manager.beetween::getGlobalTime() - _position;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function reverse():void {
			checkArrayData();
			setParameters(__endObj, __startObj);
			_starTime = getTimer();
			_isPlaying = true;
			_manager.beetween::addTween(this);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			interuptTween(MotionEvent.STOP);
		}
		
		/**
		 * 	The <code>setEasingFunction</code> allows to change the <code>Easing</code>
		 * 	object that is used by the <code>Tween</code> object to interpolate
		 * 	values at each update of the animation.
		 * 	
		 * 	<p>All <code>Easing</code> object functions follow the function signature
		 * 	popularized by Robert Penner: 
		 * 	<a href="http://www.robertpenner.com/easing/">www.robertpenner.com/easing/</a>.</p>
		 * 
		 * 	<p>If no <code>Easing</code> object is specified, an easing function based
		 * 	on the <code>Linear()</code> class is used by default.</p>
		 * 
		 * 	<p>All <code>Easing</code> classes are in the <code>org.flashapi.tween.effect</code>
		 * 	package.</p>
		 * 
		 * 	@param	value	the <code>Easing</code> object that is used by the <code>Tween</code>
		 * 					object to interpolate values at each interval of the animation.
		 */
		public function setEasingFunction(value:Easing):void {
			_equation = value.equation;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_isPlaying = false;
			_manager.beetween::removeTween(this);
			__endObj = null;
			__startObj = null;
			_end = null;
			_start = null;
			_target = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function update(currentTime:uint):void {
			if (!_isPlaying) return;
			_position = currentTime - _starTime;
			if (_position >= _duration) {
				_position = _duration;
				interuptTween(MotionEvent.FINISH);
			} else {
				dispatchEvent(getMotionEvent(MotionEvent.UPDATE));					
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _usesArrayData:Boolean;
		
		/**
		 * 	@private
		 */
		private var _starTime:Number;
		
		/**
		 * 	@private
		 */
		private var __endObj:*;
		
		/**
		 * 	@private
		 */
		private var __startObj:*;
		
		/**
		 * 	@private
		 */
		private var _equation:Function;
		
		/**
		 * 	@private
		 */
		private var _manager:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private function initObj(managerRef:Object, target:Object, start:*, end:*, duration:uint):void {
			_manager = managerRef;
			_manager.beetween::init();
			_target = target;
			_start = __startObj = start;
			_end = __endObj = end;
			_duration = duration;
			_position = 0;
			_equation = new Linear().equation;
			_isPlaying = _usesArrayData = false;
			_id = _className = "";
		}
		
		/**
		 * 	@private
		 */
		private function checkArrayData():void {
			_usesArrayData = false;
			var i:uint = 0;
			if (__startObj == null) ++i;
			if (__endObj == null) ++i;
			if (i == 0) {
				if (__startObj is Array) {
					if (!(__endObj is Array)) {
						throw new TweenException(TweenExceptionType.DATA_TYPE_MISMATCH);
					}
					if (__startObj.length != __endObj.length) {
						throw new TweenException(TweenExceptionType.DATA_LENGTH_MISMATCH);
					}
					_usesArrayData = true;
				}
			} else if (i == 1) {
				throw new TweenException(TweenExceptionType.NULL_DATA_EXCEPTION);
			}
		}
		
		/**
		 * 	@private
		 */
		private function getCurrentValue():Object {
			if (_usesArrayData) {
				var arr:Array = [];
				var i:int = _start.length - 1;
				for (; i >= 0; --i) arr[i] = _equation(_position, _start[i], _end[i] - _start[i], _duration);
				return arr;
			} else return _equation(_position, _start, Number(_end) - Number(_start), _duration);
		}
		
		/**
		 * 	@private
		 */
		private function setParameters(from:*, to:*):void {
			_start = from;
			_end = to;
		}
		
		/**
		 * 	@private
		 */
		private function interuptTween(evtType:String):void {
			_isPlaying = false;
			_manager.beetween::removeTween(this);
			this.dispatchEvent(getMotionEvent(evtType));
		}
		
		/**
		 * 	@private
		 */
		private function getMotionEvent(type:String):MotionEvent {
			var e:MotionEvent = new MotionEvent(type);
			e.value = getCurrentValue();
			e.listener = _target;
			return e;
		}
	}
}