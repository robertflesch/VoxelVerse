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

package org.flashapi.tween {
	
	// -----------------------------------------------------------
	// TweenSequencer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/05/2011 00:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flashapi.tween.constant.TweenSquencerAction;
	import org.flashapi.tween.core.SequentialTween;
	
	/**
	 * 	The <code>TweenSequencer</code> class allows developers to easilly work 
	 * 	with and control several <code>SequentialTween</code> instances from a  
	 * 	centralized controller object.
	 * 
	 *  @includeExample TweenSequencerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 10
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TweenSequencer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>TweenSequencer</code> instance.
		 */
		public function TweenSequencer() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a <code>SequentialTween</code> object to this <code>TweenSequencer</code>
		 * 	instance.
		 * 
		 * 	@param	tween 	The <code>SequentialTween</code> object to add to this 
		 * 					<code>TweenSequencer</code> instance.
		 * 
		 * 	@see #removeTween()
		 * 	@see #removeAllTweens()
		 */
		public function addTween(tween:SequentialTween):void {
			_stack.splice(0, 0, tween);
		}
		
		/**
		 * 	Removes a <code>SequentialTween</code> object from this <code>TweenSequencer</code>
		 * 	instance.
		 * 
		 * 	@param	tween 	The <code>SequentialTween</code> object to remove from  
		 * 					this <code>TweenSequencer</code> instance.
		 * 
		 * 	@see #addTween()
		 * 	@see #removeAllTweens()
		 */
		public function removeTween(tween:SequentialTween):void {
			var id:int = _stack.indexOf(tween);
			_stack.splice(id, 1);
		}
		
		/**
		 * 	Removes all registered <code>SequentialTween</code> objects from this
		 * 	<code>TweenSequencer</code> instance.
		 * 
		 * 	@see #addTween()
		 * 	@see #removeTween()
		 */
		public function removeAllTweens():void {
			while(_stack.length > 0) {
				_stack.pop();
			}
		}
		
		/**
		 * 	Plays all <code>SequentialTween</code> objects registered within this
		 * 	<code>TweenSequencer</code> instance. If the <code>delay</code> parameter
		 * 	is <code>-1</code>, all <code>SequentialTween</code> objects start playing 
		 * 	at the same time (parallel animation). If greater than <code>0</code>, 
		 * 	all <code>SequentialTween</code> objects start playing sequentially, and 
		 * 	<code>delay</code> parameter indicates the start offset of the sequence
		 * 	(sequencial animation).
		 * 	
		 * 	@param	delay	The value of the starting delay for playing the sequence.
		 * 					Default value is <code>-1</code>.
		 * 
		 * 	@see #reverseAllTweens()
		 * 	@see #stopAllTweens()
		 * 	@see #pauseAllTweens()
		 * 	@see #resetAllTweens()
		 */
		public function playAllTweens(delay:int = -1):void {
			delay > 0 ? doTimerAction(delay, TweenSquencerAction.PLAY) :
				doAction(TweenSquencerAction.PLAY);
		}
		
		/**
		 * 	Reverses all <code>SequentialTween</code> objects registered within this
		 * 	<code>TweenSequencer</code> instance. If the <code>delay</code> parameter
		 * 	is <code>-1</code>, all <code>SequentialTween</code> objects start playing 
		 * 	at the same time (parallel animation). If greater than <code>0</code>, all
		 * 	<code>SequentialTween</code> objects start playing sequentially, and 
		 * 	<code>delay</code> parameter indicates the start offset of the sequence
		 * 	(sequencial animation).
		 * 
		 * 	@param	delay	The value of the starting delay for the playing sequence.
		 * 
		 * 	@see #playAllTweens()
		 * 	@see #stopAllTweens()
		 * 	@see #pauseAllTweens()
		 * 	@see #resetAllTweens()
		 */
		public function reverseAllTweens(delay:int = -1):void {
			delay > 0 ? doTimerAction(delay, TweenSquencerAction.REVERSE) :
				doAction(TweenSquencerAction.REVERSE);
		}
		
		/**
		 * 	Pauses all <code>SequentialTween</code> objects registered within this
		 * 	<code>TweenSequencer</code> instance.
		 * 
		 * 	@param	delay 	[Not implemented yet.]
		 * 
		 * 	@see #playAllTweens()
		 * 	@see #reverseAllTweens()
		 * 	@see #stopAllTweens()
		 * 	@see #resetAllTweens()
		 */
		public function pauseAllTweens(delay:int = -1):void {
			doAction(TweenSquencerAction.PAUSE);
		}
		
		/**
		 * 	Stops all <code>SequentialTween</code> objects registered within this
		 * 	<code>TweenSequencer</code> 	instance.
		 * 
		 * 	@param	delay 	[Not implemented yet.]
		 * 
		 * 	@see #playAllTweens()
		 * 	@see #reverseAllTweens()
		 * 	@see #pauseAllTweens()
		 * 	@see #resetAllTweens()
		 */
		public function stopAllTweens(delay:int = -1):void {
			doAction(TweenSquencerAction.STOP);
		}
		
		/**
		 * 	Resets all <code>SequentialTween</code> objects registered within this
		 * 	<code>TweenSequencer</code> instance.
		 * 
		 * 	@see #playAllTweens()
		 * 	@see #reverseAllTweens()
		 * 	@see #pauseAllTweens()
		 * 	@see #stopAllTweens()
		 */
		public function resetAllTweens():void {
			doAction(TweenSquencerAction.RESET);
		}
		
		/**
		 * 	Plays all <code>SequentialTween</code> objects for which the class name 
		 * 	matches with the <code>className</code> parameter.
		 * 
		 * 	@param	className	The class name for the <code>SequentialTween</code> 
		 * 						objects to play.
		 * 	@param	delay 		[Not implemented yet.]
		 * 
		 * 	@see #reverseTweensByClassName()
		 * 	@see #pauseTweensByClassName()
		 * 	@see #stopTweensByClassName()
		 * 	@see #resetTweensByClassName()
		 */
		public function playTweensByClassName(className:String, delay:int = -1):void {
			doActionByClassName(className, TweenSquencerAction.PLAY);
		}
		
		/**
		 * 	Reverses all <code>SequentialTween</code> objects for which the class name 
		 * 	matches with the <code>className</code> parameter.
		 * 
		 * 	@param	className	The class name for the <code>SequentialTween</code> 
		 * 						objects to reverse.
		 * 	@param	delay 		[Not implemented yet.]
		 * 
		 * 	@see #playTweensByClassName()
		 * 	@see #pauseTweensByClassName()
		 * 	@see #stopTweensByClassName()
		 * 	@see #resetTweensByClassName()
		 */
		public function reverseTweensByClassName(className:String, delay:int = -1):void {
			doActionByClassName(className, TweenSquencerAction.REVERSE);
		}
		
		/**
		 * 	Pauses all <code>SequentialTween</code> objects for which the class name 
		 * 	matches with the <code>className</code> parameter.
		 * 
		 * 	@param	className	The class name for the <code>SequentialTween</code> 
		 * 						objects to pause.
		 * 	@param	delay 		[Not implemented yet.]
		 * 
		 * 	@see #playTweensByClassName()
		 * 	@see #reverseTweensByClassName()
		 * 	@see #stopTweensByClassName()
		 * 	@see #resetTweensByClassName()
		 */
		public function pauseTweensByClassName(className:String, delay:int = -1):void {
			doActionByClassName(className, TweenSquencerAction.PAUSE);
		}
		
		/**
		 * 	Stops all <code>SequentialTween</code> objects for which the class name 
		 * 	matches with the <code>className</code> parameter.
		 * 
		 * 	@param	className	The class name for the <code>SequentialTween</code> 
		 * 						objects to stop.
		 * 	@param	delay 		[Not implemented yet.]
		 * 
		 * 	@see #playTweensByClassName()
		 * 	@see #reverseTweensByClassName()
		 * 	@see #pauseTweensByClassName()
		 * 	@see #resetTweensByClassName()
		 */
		public function stopTweensByClassName(className:String, delay:int = -1):void {
			doActionByClassName(className, TweenSquencerAction.STOP);
		}
		
		/**
		 * 	Resets all <code>SequentialTween</code> objects for which the class name 
		 * 	matches with the <code>className</code> parameter.
		 * 
		 * 	@param	className	The class name for the <code>SequentialTween</code> 
		 * 						objects to reset.
		 * 
		 * 	@see #playTweensByClassName()
		 * 	@see #reverseTweensByClassName()
		 * 	@see #pauseTweensByClassName()
		 * 	@see #stopTweensByClassName()
		 */
		public function resetTweensByClassName(className:String):void {
			doActionByClassName(className, TweenSquencerAction.RESET);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _stack:Array;
		
		/**
		 * 	@private
		 */
		private var _timer:Timer;
		
		/**
		 * 	@private
		 */
		private var _currentId:int;
		
		/**
		 * 	@private
		 */
		private var _currentAction:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_stack = [];
			_currentId = 0;
			_currentAction = "";
		}
		
		private function doActionByClassName(name:String, action:String):void {
			var t:SequentialTween;
			var i:int = _stack.length - 1;
			for (; i >= 0; i--) {
				t = _stack[i];
				if (t.className == name) {
					t[action]();
				}
			}
		}
		
		private function doAction(action:String):void {
			var t:SequentialTween;
			var i:int = _stack.length - 1;
			for (; i >= 0; i--) {
				t = _stack[i];
				t[action]();
			}
		}
		
		private function doTimerAction(delay:uint, action:String):void {
			_currentAction = action;
			_currentId = _stack.length - 1;
			_timer.delay = delay;
			if (!_timer.running) _timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void {
			var t:SequentialTween;
			if (_currentId >= 0) {
				t = _stack[_currentId];
				t[_currentAction]();
				_currentId--;
			} else _timer.stop();
		}
	}
}