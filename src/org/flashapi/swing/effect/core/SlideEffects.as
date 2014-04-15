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
	// SlideEffects.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 06/01/2009 02:10
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>FadeEffects</code> class is the base class for all sliding effects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SlideEffects extends AEM {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>SlideEffects</code> instance with the
		 * 	specified properties.
		 * 
		 * 	@param	target	The target container for this <code>SlideEffects</code>
		 * 					object.
		 * 	@param	direction	The direction of the effect
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function SlideEffects(target:Object, direction:String, duration:uint) {
			super(target, duration);
			initObj(direction);
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>direction</code> property.
		 * 
		 * 	@see #direction
		 */
		protected var $direction:String;
		/**
		 * 	Sets or gets the direction of the current effect. Possible values are:
		 * 	<ul>
		 * 		<li><code>Direction.UP</code>,</li>
		 * 		<li><code>Direction.DOWN</code>,</li>
		 * 		<li><code>Direction.LEFT</code>,</li>
		 * 		<li><code>Direction.RIGHT</code>.</li>
		 * 	</ul>
		 * 	
		 */
		public function get direction():String {
			return $direction;
		}
		public function set direction(value:String):void {
			$direction = value;
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A internal point that specifies the origin coordinates for this effect.
		 */
		protected var $origin:Point;
		
		/**
		 * 	A internal array used to store the initial properties for this effect.
		 */
		protected var $initValues:Array;
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function initialize():void {
			_mask = new Sprite();
			$container.mask = _mask;
			$origin = new Point($target.x, $target.y);
			initMove();
			$start = $initValues[0];
			$end = $initValues[1];
			doMove($initValues[0]);
		}
		
		/**
		 * 	@private
		 */
		override protected function motionStart(e:MotionEvent):void {
			drawMask();
		}
		
		/**
		 * 	@private
		 */
		override protected function motionChanged(e:MotionEvent):void {
			doMove(Number(e.value));
		}
		
		/**
		 * 	@private
		 */
		protected function drawMask():void {
			_mask.x = $target.x;
			_mask.y = $target.y;
			var f:Figure = new Figure(_mask);
			f.beginFill(0xFF0000);
			f.drawRectangle($bounds.x, $bounds.y, $bounds.width, $bounds.height);
			f.endFill();
			$container.parent.addChild(_mask);
		}
		
		/**
		 * 	@private
		 */
		protected function initMove():void {}
		
		/**
		 * 	@private
		 */
		protected function doMove(value:Number):void {
			$container.x = $target.x;
			$container.y = value;
			/*switch(_direction) {
				case Direction.UP :
				case Direction.DOWN :
					_container.x = _target.x;
					_container.y = value;
					break;
			}*/
		}
		
		/**
		 * 	@private
		 */
		override protected function move():void {}
		
		/**
		 * 	@private
		 */
		protected function resetSlide():void {
			$container.parent.removeChild(_mask);
			$container.mask = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _mask:Sprite;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(direction:String):void {
			$direction = direction;
		}
	}
}