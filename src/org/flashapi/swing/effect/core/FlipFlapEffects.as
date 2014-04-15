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

package org.flashapi.swing.effect.core {
	
	// -----------------------------------------------------------
	// FlipFlapEffects.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 25/01/2009 20:41
	* @see http://www.flashapi.org/
	*/

	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flashapi.swing.constants.Quality;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.fx.basicfx.DistortFX;
	import org.flashapi.tween.Tween;
	
	/**
	 * 	The <code>FlipFlapEffects</code> class is the base class for all flipping
	 * 	effects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FlipFlapEffects extends AEM {
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>FlipFlapEffects</code> instance with the
		 * 	specified properties.
		 * 
		 * 	@param	target	The target container for this <code>FlipFlapEffects</code>
		 * 					object.
		 * 	@param	duration	The effect duration, in milliseconds.
		 * 	@param	constructor
		 */
		public function FlipFlapEffects(target:Object, duration:uint, constructor:Object) {
			super(target, duration);
			initObj(constructor);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function createBackFaceContainer():void {
			_guideLineA = [$bounds.x, $bounds.y, $bounds.width, $bounds.y,
				$bounds.width, $bounds.height, $bounds.x, $bounds.height];
			_guideLineB = [$bounds.width, $bounds.height, $bounds.width,
				$bounds.y, $bounds.x, $bounds.y, $bounds.x, $bounds.height];
			_guideLineC = [$bounds.width, $bounds.height, $bounds.x, $bounds.height,
				$bounds.x, $bounds.y, $bounds.width, $bounds.x];
			_guideLineD = [$bounds.x, $bounds.x, $bounds.x, $bounds.height,
				$bounds.width, $bounds.height, $bounds.width, $bounds.x];
			_frontDistort = new DistortFX($container, $container, 1, 1, false);
			$container.cacheAsBitmap = true;
			$container.graphics.clear();
			if(_quality==Quality.BEST) {
				var bf:Sprite = $target.drawBackface();
				_backfaceContainer = new Sprite();
				_backfaceContainer.x = $container.x;
				_backfaceContainer.y = $container.y;
				_backfaceContainer.cacheAsBitmap = true;
				_backface = new DistortFX(_backfaceContainer, bf, 1, 1, false);
				$target.parent.addChild(_backfaceContainer);
			}
			initFlipFlapTween(_guideLineA, _guideLineB, guideLine1Finish);
		}
		
		/**
		 * 	@private
		 */
		protected function guideLine1Finish(e:MotionEvent):void {
			removeFlipFlapEvents(guideLine1Finish);
			initFlipFlapTween(_guideLineB, _guideLineC, guideLine2Finish);
			_flipFlapTween.play();
		}
		
		/**
		 * 	@private
		 */
		protected function guideLine2Finish(e:MotionEvent):void {
			removeFlipFlapEvents(guideLine2Finish);
			initFlipFlapTween(_guideLineC, _guideLineD, guideLine3Finish);
			_flipFlapTween.play();
		}
		
		/**
		 * 	@private
		 */
		protected function guideLine3Finish(e:MotionEvent):void {
			removeFlipFlapEvents(guideLine3Finish);
			initFlipFlapTween(_guideLineD, _guideLineA, guideLine4Finish);
			_flipFlapTween.play();
		}
		
		/**
		 * 	@private
		 */
		protected function guideLine4Finish(e:MotionEvent):void {
			removeFlipFlapEvents(guideLine4Finish);
			initFlipFlapTween(_guideLineD, _guideLineA, guideLine4Finish);
			_isFlipFlapTweenFinished = true;
			if(_isMainTweenFinished) onFinish(e);
		}
		
		/**
		 * 	@private
		 */
		protected function guideLineChanged(e:MotionEvent):void {
			setTransform(e.value as Array);
		}
		
		/**
		 * 	@private
		 */
		protected function setTransform(value:Array):void  {
			if(_flipFlapTween.position >= _flipFlapTween.duration/2 && !_interverted){
				if (_quality == Quality.BEST ) {
					$container.parent.swapChildren($container, _backfaceContainer);
					_interverted = true;
				}
			}
			_frontDistort.setTransform(new Point(value[0], value[1]), new Point(value[2], value[3]),
				new Point(value[4], value[5]), new Point(value[6], value[7]));
			_frontDistort.render();
			$container.scaleX = $container.scaleY = _scaleValue;
			if(_quality == Quality.BEST) {
				_backface.setTransform(new Point(value[0], value[1]),
					new Point(value[2], value[3]), new Point(value[4],
						value[5]), new Point(value[6], value[7]));
				_backface.render();
				_backfaceContainer.scaleX = _backfaceContainer.scaleY = _scaleValue;
			}
		}
		
		/**
		 * 	@private
		 */
		override protected function motionStart(e:MotionEvent):void { 
			//UIManager.stage.frameRate = 800;
			createBackFaceContainer();
			_flipFlapTween.play();
		}
		
		/**
		 * 	@private
		 */
		override protected function motionChanged(e:MotionEvent):void {
			_scaleValue = e.value as Number
		}
		
		/**
		 * 	@private
		 */
		override protected	function motionFinish(e:MotionEvent):void {
			_frontDistort.remove();
			if (_quality == Quality.BEST) _backface.remove();
			_isMainTweenFinished = true;
			if(_isFlipFlapTweenFinished) onFinish(e);
			super.motionFinish(e);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _backface:DistortFX;
		private var _backfaceContainer:Sprite;
		private var _frontDistort:DistortFX;
		private var _flipFlapTween:Tween;
		private var _guideLineA:Array;
		private var _guideLineB:Array;
		private var _guideLineC:Array;
		private var _guideLineD:Array;
		private var _interverted:Boolean;
		private var _isMainTweenFinished:Boolean;
		private var _isFlipFlapTweenFinished:Boolean;
		private var _quality:String;
		private var _scaleValue:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(constructor:Object):void {
			_quality = constructor.quality;
			_isMainTweenFinished = _isFlipFlapTweenFinished = false;
			//_delay = 50;
		}
		
		private function onFinish(e:MotionEvent):void {
			super.motionFinish(e);
		}
		
		private function initFlipFlapTween(guideLine1:Array, guideLine2:Array, func:Function):void {
			_interverted = false;
			_flipFlapTween = new Tween($target, guideLine1, guideLine2, $duration/4);
			//_flipFlapTween.delay = 5;
			$evtColl.addEvent(_flipFlapTween, MotionEvent.UPDATE, guideLineChanged);
			$evtColl.addEvent(_flipFlapTween, MotionEvent.FINISH, func);
		}
		
		private function removeFlipFlapEvents(func:Function):void {
			$evtColl.removeEvent(_flipFlapTween, MotionEvent.FINISH, func);
			$evtColl.removeEvent(_flipFlapTween, MotionEvent.UPDATE, guideLineChanged);
		}
	}
}