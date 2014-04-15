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
	// AEM.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 06/03/2010 23:33
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.effect.Effect;
	import org.flashapi.swing.event.EffectEvent;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.exceptions.EffectException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.Tween;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>AEM</code> class (for Abstract Effect Methods) is the base class
	 * 	for all effects that can be used as displa or remove effects within the
	 * 	<code>UIObject</code> class.
	 * 
	 * 	<p>Typically, effects designed to be used by the <code>UIObject.display()</code>
	 * 	methods are named by adding a "IN" suffix to the name; effects designed to be
	 * 	used by the <code>UIObject.remove()</code> methods are named by adding a "OUT"
	 * 	suffix.</p>
	 * 
	 * 	@see org.flashapi.swing.core.UIObject#displayEffect
	 * 	@see org.flashapi.swing.core.UIObject#display()
	 * 	@see org.flashapi.swing.core.UIObject#removeEffect
	 * 	@see org.flashapi.swing.core.UIObject#remove()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AEM extends EventDispatcher implements Effect {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  Constructor. Creates e new <code>AEM</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	target	The target container for this effect.
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function AEM(target:Object, duration:uint = 500) {
			super();
			initObj(target, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the <code>Sprite</code> container used
		 * 	to render the effect.
		 * 
		 * 	@see #container
		 */
		protected var $container:Sprite;
		/**
		 * 	Returns a reference to the sprite used to render the effect.
		 */
		public function get container():Sprite {
			return $container;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>duration</code> property.
		 * 
		 * 	@see #duration
		 */
		protected var $duration:uint;
		/**
		 * 	@inheritDoc
		 */
		public function get duration():uint {
			return $duration;
		}
		public function set duration(value:uint):void {
			if ($tween.isPlaying) {
				throw new EffectException(Locale.spas_internal::ERRORS.AEM_EFFECT_DURATION_ERROR);
			}
			$duration = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>easingFunction</code> property.
		 * 
		 * 	@see #easingFunction
		 */
		protected var $easingFunction:Easing;
		/**
		 * 	@inheritDoc
		 */
		public function get easingFunction():Easing  {
			return $easingFunction;
		}
		public function set easingFunction(value:Easing):void {
			$easingFunction = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the <code>tween</code> instance.
		 * 
		 * 	@see #tween
		 */
		protected var $tween:Tween;
		/**
		 * 	@inheritDoc
		 */
		public function get tween():Tween  {
			return $tween;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function render():void {
			initBitmap();
			refresh();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function pause():void {
			if (!_isPlaying) return;
			_isPaused = true;
			$tween.pause();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resume():void {
			if (!_isPaused) return;
			_isPaused = false;
			$tween.resume();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function play():void {
			if (_isPlaying) return;
			_isPlaying = true;
			$bounds = $target.getBounds(null);
			initialize();
			render();
			move();
			$parent = $target.parent;
			if(!$parent.contains($container)) $parent.addChild($container);
			$tween.start = $start;
			$tween.end = $end;
			$tween.duration = $duration;
			//_tween.delay = _delay;
			$tween.play();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function reset():void {
			$tween.reset();
			_isPlaying = false;
			this.play();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			if (!_isPlaying) return;
			$tween.stop();
			deleteEffect();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			$finalized = true;
			//$tween.stop();
			$start = null;
			$end = null;
			$initialValue = null;
			$evtColl.finalize();
			$evtColl = null;
			deleteEffect();
			if ($bitmap != null) {
				$bitmap.dispose();
				$bitmap = null;
			}
			$bounds = null;
			$container = null;
			$tween.finalize();
			$tween = null;
			$parent = null;
			$target = null;
			_matrix = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The parent container for this <code>Effect</code> object.
		 */
		protected var $parent:*;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The target container for this <code>Effect</code> object.
		 */
		protected var $target:*;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal object that contains all needed information when starting
		 * 	this <code>Effect</code> object.
		 */
		protected var $start:Object;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal object that contains all needed information when finishing
		 * 	this <code>Effect</code> object.
		 */
		protected var $end:Object;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal object that contains all needed information to initialize
		 * 	this <code>Effect</code> object.
		 */
		protected var $initialValue:Object;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>EventCollector</code> instance for this <code>Effect</code>
		 * 	object.
		 */
		protected var $evtColl:EventCollector;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>BitmapData</code> instance for this <code>Effect</code>
		 * 	object.
		 */
		protected var $bitmap:BitmapData = null;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Rectangle</code> value that defines the bounds within
		 * 	to render this effect.
		 */
		protected var $bounds:Rectangle;
		
		/**
		 * 	@private
		 * 	[Deprecated]
		 */
		protected var $finalized:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the target
		 * 	must visible when the effect is finished (<code>true</code>), or not
		 * 	(<code>false</code>).
		 */
		protected var $restoreVisibility:Boolean = true;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the
		 * 	<code>BitmapData</code> representation of the target container must bee
		 * 	redrawn (<code>true</code>), or not (<code>false</code>).
		 */
		protected var $needsBitmapRefresh:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _matrix:Matrix;
		
		/**
		 * 	@private
		 */
		private var _isPlaying:Boolean = false;
		
		/**
		 * 	@private
		 */
		private var _isPaused:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function initialize():void { }
		
		/**
		 * 	@private
		 */
		protected function motionStart(e:MotionEvent):void {}
		
		/**
		 * 	@private
		 */
		protected function motionChanged(e:MotionEvent):void { }
		
		/**
		 * 	@private
		 */
		protected function motionFinish(e:MotionEvent):void {
			if ($finalized) return;
			deleteEffect();
			dispatchEvent(new EffectEvent(EffectEvent.FINISH));
		}
		
		/**
		 * 	@private
		 */
		protected function refresh():void {
			with($container.graphics) {
				clear();
				beginBitmapFill($bitmap, _matrix, true, false);
				drawRect($bounds.x, $bounds.y, $bounds.width, $bounds.height);
				endFill();
			}
		}
		
		/**
		 * 	@private
		 */
		protected function move():void {
			$container.x = $target.x;
			$container.y = $target.y;
		}
		
		/**
		 * 	@private
		 */
		protected function initBitmap():void {
			if (!$needsBitmapRefresh) return;
			$bitmap = new BitmapData($bounds.width - $bounds.x, $bounds.height - $bounds.y, true, 0);
			$target is UIObject ? $bitmap.draw($target.spas_internal::uioSprite, _matrix) : $bitmap.draw($target as IBitmapDrawable, _matrix);
			$needsBitmapRefresh = false;
		}
		
		/**
		 * 	@private
		 */
		protected function deleteEffect():void {
			_isPlaying = false;
			$needsBitmapRefresh = true;
			if ($parent == null) return;
			if (!$parent.contains($container)) return;
			$target.visible = $restoreVisibility;
			$parent.removeChild($container);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private function onMotionStart(e:MotionEvent):void {
			motionStart(e);
		}
		
		/**
		 * 	@private
		 */
		private function onMotionChanged(e:MotionEvent):void {
			motionChanged(e);
		}
		
		/**
		 * 	@private
		 */
		private function onMotionFinish(e:MotionEvent):void {
			motionFinish(e);
		}
		
		private function initObj(target:Object, duration:uint):void {
			$target = target;
			$duration = duration;
			_matrix = new Matrix();
			$evtColl = new EventCollector();
			$container = new Sprite()
			$tween = new Tween();
			$evtColl.addEvent($tween, MotionEvent.FINISH, onMotionFinish);
			$evtColl.addEvent($tween, MotionEvent.UPDATE, onMotionChanged);
			$evtColl.addEvent($tween, MotionEvent.START, onMotionStart);
		}
	}
}