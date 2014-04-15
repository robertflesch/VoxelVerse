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

package org.flashapi.swing.fx.basicfx {
	
	// -----------------------------------------------------------
	// BlurredMove.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 08/06/2009 00:18
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import org.flashapi.swing.event.EffectEvent;
	import org.flashapi.swing.fx.FX;
	import org.flashapi.swing.fx.FXBase;
	import org.flashapi.tween.constant.EaseType;
	import org.flashapi.tween.motion.Sinusoidal;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.tween.Tween;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 */
	public class BlurredMove extends FXBase implements FX {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 * 
		 * 	@param	source
		 * 	@param	start
		 * 	@param	end
		 * 	@param	duration
		 */
		public function BlurredMove(source:DisplayObject, start:Point, end:Point, duration:uint = 250) {
			super(source);
			initObj(start, end, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function set duration(value:uint):void { _tween.duration = _duration = value; }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function render():void {
			_tween.start = [_start.x, _start.y];
			_tween.end = [_end.x, _end.y];
			_tween.play();
			this.dispatchEvent(new EffectEvent(EffectEvent.START));
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function remove():void {
			_tween.stop();
			this.dispatchEvent(new EffectEvent(EffectEvent.REMOVE));
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_tween.stop();
			removeTweenListeners();
			_tween = null;
		}
		
		/**
		 * 	
		 */
		public function reverse():void {
			_tween.reverse();
			this.dispatchEvent(new EffectEvent(EffectEvent.REVERSE));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _start:Point;
		
		/**
		 * @private
		 */
		protected var _end:Point;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _tween:Tween;
		private var _oldX:Number;
		private var _oldY:Number;
		private var _speedX:Number;
		private var _speedY:Number;
		private var _filter:BlurFilter;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private function initObj(start:Point, end:Point, duration:uint):void {
			_start = start;
			_end = end;
			_duration = duration;
			_target = src.parent;
			_filter = new BlurFilter(0, 0, 2);
			_tween = new Tween(src);
			_tween.setEasingFunction(new Sinusoidal(EaseType.BOTH));
			_tween.addEventListener(MotionEvent.UPDATE, motionChanged);
			_tween.addEventListener(MotionEvent.FINISH, motionFinish);
			_tween.duration = _duration;
		}
		
		private function motionChanged(e:MotionEvent):void {
			var obj:DisplayObject = e.listener as DisplayObject;
			var v:Array = e.value as Array;
			_oldX = obj.x;
			_oldY = obj.y;
			obj.x = v[0];
			obj.y = v[1];
			_speedX = Math.round(Math.abs((obj.x-_oldX)));
			_speedY = Math.round(Math.abs((obj.y - _oldY)));
			_filter.blurX = _speedX * 2;
			_filter.blurY = _speedY * 2;
			obj.filters = [_filter];
			this.dispatchEvent(new EffectEvent(EffectEvent.UPDATE));
		}
		
		private	function motionFinish(e:MotionEvent):void {
			var obj:DisplayObject = e.listener as DisplayObject;
			var v:Array = e.value as Array;
			obj.x = v[0];
			obj.y = v[1];
			obj.filters = [new BlurFilter(0, 0, 0)];
			this.dispatchEvent(new EffectEvent(EffectEvent.FINISH));
		}
		
		private function removeTweenListeners():void {
			_tween.removeEventListener(MotionEvent.UPDATE, motionChanged);
			_tween.removeEventListener(MotionEvent.FINISH, motionFinish);
		}
	}
}