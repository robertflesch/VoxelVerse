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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// MediaRessourceManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/01/2009 15:44
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.media.MediaRessourceUser;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>MediaRessourceManager</code> class is an all-static class which
	 * 	is responsible for managing resources shared between <code>MediaRessourceUser</code>
	 * 	objects within the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.media.MediaRessourceUser
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MediaRessourceManager {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A <code>DeniedConstructorAccessException</code> if you attemp 
		 * 				to create a new <code>MediaRessourceManager</code> instance.
		 */
		public function MediaRessourceManager() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private static var _precision:Number = 10;
		/**
		 * 	Sets or gets the time interval between <code>MediaRessourceManager</code>
		 * 	updates.
		 * 
		 * 	@default 10
		 */
		public static function get precision():Number {
			return _precision;
		}
		public static function set precision(value:Number):void {
			_precision = value;
			_timer.delay = _precision;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected static properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function removeFromMediaStack(value:MediaRessourceUser):void {
			var id:int = _mediaStack.indexOf(value);
			if (id == -1) return;
			_mediaStack.splice(id, 1);
			stopTimer();
		}
		
		/**
		 * 	@private
		 */
		spas_internal static function addToMediaStack(value:MediaRessourceUser):void {
			_mediaStack.push(value);
			startTimer();
		}
		
		/**
		 * 	@private
		 */
		spas_internal static function hasRegistredUser(value:MediaRessourceUser):Boolean {
			var id:int = _mediaStack.indexOf(value);
			return id >= 0 ? true : false;
		}
		
		/**
		 * 	@private
		 */
		spas_internal static function resetMediaStack():void {
			_mediaStack = [];
			stopTimer();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static function timerHandler(e:TimerEvent):void {
			var i:int = _mediaStack.length - 1;
			var u:MediaRessourceUser;
			for (; i >= 0; i--) {
				u = _mediaStack[i];
				u.updateAfterEvent();
			}
		}
		
		private static function startTimer():void {
			if (_mediaStack.length > 0 && !_timer.running) {
				_evtColl.addEvent(_timer, TimerEvent.TIMER, timerHandler);
				_timer.start();
			}
		}
		
		private static function stopTimer():void {
			if(_mediaStack.length == 0) {
				_evtColl.removeEvent(_timer, TimerEvent.TIMER, timerHandler);
				_timer.stop();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private static methods
		//
		//--------------------------------------------------------------------------
		
		private static var _timer:Timer = new Timer(_precision);
		private static var _evtColl:EventCollector = new EventCollector();
		private static var _mediaStack:Array = [];
	}
}