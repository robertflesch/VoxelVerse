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
	// ClockBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 01/06/2009 15:14
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 	The <code>ClockBase</code> class is the base class for all SPAS 3.0
	 * 	<code>Clock</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ClockBase extends UIObject implements Clock{
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ClockBase</code> instance.
		 */
		public function ClockBase() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoSynchronization</code> property.
		 * 
		 * 	@see #autoSynchronization
		 */
		protected var $autoSyncDelay:int = -1;
		/**
		 * 	@inheritDoc
		 */
		public function get autoSynchronization():int {
			return $autoSyncDelay;
		}
		public function set autoSynchronization(value:int):void {
			$autoSyncDelay = value;
			if (value > -1) $autoUpdateDelay = 0;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>onSynchronize</code> property.
		 * 
		 * 	@see #onSynchronize
		 */
		protected var $onSynchronize:Function = null;
		/**
		 * 	@inheritDoc
		 */
		public function get onSynchronize():Function {
			return $onSynchronize;
		}
		public function set onSynchronize(value:Function):void {
			$onSynchronize = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function synchronize():void {
			if ($onSynchronize != null) $onSynchronize();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function reset():void {
			setTime(0, 0, 0);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function start():void {
			if (!$timer.running) $timer.start();
		}

		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			if ($timer.running) $timer.stop();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function setTime(hour:Number, minute:Number, second:Number):void {
			if (!isNaN(hour) && hour != $hour && isValidHour(hour)) $hour = hour;
			if (!isNaN(minute) && minute != $minute && isValidMinute(minute)) $minute = minute;
			if (!isNaN(second) && second != $second && isValidSecond(second)) $second = second;
			updateTime();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getTime():Object {
			return { hours:$hour, minutes:$minute, seconds:$second };
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function setCurrentLocalTime():void {
			var now:Date = new Date();
			setTime(now.getHours(), now.getMinutes(), now.getSeconds());
		}
		
		/**
		 * 	@private
		 */
		public function updateTime():void { }
		
		/**
		 * 	@private
		 */
		override public function finalize():void { 
			$timer.stop();
			$timer = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to <code>Timer</code> object used within this
		 * 	<code>Clock</code> object.
		 */
		protected var $timer:Timer;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the hour of this <code>Clock</code> object.
		 */
		protected var $hour:Number = 0;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the minutes of this <code>Clock</code>
		 * 	object.
		 */
		protected var $minute:Number = 0;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the seconds of this <code>Clock</code>
		 * 	object.
		 */
		protected var $second:Number = 0;
		
		/**
		 *  @private
		 */
		protected var $autoUpdateDelay:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function isValidHour(h:Number):Boolean {
			return (Math.floor(h) == h && h >= 0 && h <= 23);
		}
		
		/**
		 * @private
		 */
		protected function isValidMinute(m:Number):Boolean {
			return (Math.floor(m) == m && m >= 0 && m <= 59);
		}
		
		/**
		 * @private
		 */
		protected function isValidSecond(s:Number):Boolean {
			return (Math.floor(s) == s && s >= 0 && s <= 59);
		}
		
		/**
		 * @private
		 */
		protected function createTimerEvent():void {
			$evtColl.addEvent($timer, TimerEvent.TIMER, tickHandler);
		}
		
		/**
		 * @private
		 */
		protected function tickHandler(e:TimerEvent):void {
			var h:Number = $hour;
			var m:Number = $minute;
			var s:Number = $second;
			s += 1;
			if (s > 59) {
				s = 0;
				m += 1;
				if (m > 59) {
					m = 0;
					h += 1;
					if (h > 23) h = 0;
				}
			}
			setTime(h, m, s);
			if ($autoSyncDelay > 0) {
				if ($autoUpdateDelay++ == $autoSyncDelay) {
					$autoUpdateDelay = 0;
					synchronize();
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$timer = new Timer(1000);
		}
	}
}