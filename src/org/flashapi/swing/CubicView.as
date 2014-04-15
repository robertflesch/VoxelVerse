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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// CubicView.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 18/06/2009 19:56
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.CubicViewEvent;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.fx.basicfx.DistortFX;
	import org.flashapi.tween.motion.Linear;
	import org.flashapi.tween.Tween;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("CubicView.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the 3D effect is finished, after a new view has been
	 * 	selected.
	 *
	 *  @eventType org.flashapi.swing.event.CubicViewEvent.EFFECT_FINISHED
	 */
	[Event(name = "effectFinished", type = "org.flashapi.swing.event.CubicViewEvent")]
	
	/**
	 * 	<img src="CubicView.png" alt="CubicView" width="18" height="18"/>
	 * 
	 *  The <code>CubicView</code> class creates a container for a group of <code>Container</code>
	 * 	objects, that extends the <code>MultiView</code> container capabilities.
	 * 
	 * 	<p>The <code>CubicView</code> class uses a 3D rotating cube effect as transition,
	 * 	to go from the current view to the next selected one of this multiview object.</p>
	 * 	
	 * 	<p>Contrary to others 3D rotating cube effects, the <code>CubicView</code> class
	 * 	does not defines the six sides of a virtual cube. That means you can add as many
	 * 	views as you want to the multiview object, and select the order you want them
	 * 	to be displayed.</p>
	 * 
	 * 	<p><strong><code>CubicView</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">direction</code></td>
	 * 			<td>Indicates direction of the 3D effect transition.</td>
	 * 			<td>Recognized values are <code class="css">up</code>, <code class="css">down</code>
	 * 			<code class="css">left</code> or <code class="css">right</code>.</td>
	 * 			<td><code>direction</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 *  @includeExample CubicViewExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CubicView extends MultiView implements Observer, Border, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>CubicView</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	viewNum	The number of views whithin this <code>CubicView</code>
		 * 					instance.
		 * 	@param	width	The width of the <code>CubicView</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>CubicView</code> instance, in
		 *					pixels.
		 * 	@param	borderStyle	The sytle of the border for this <code>CubicView</code>
		 * 						instance. Default value is <code>BorderStyle.NONE</code>.
		 */
		public function CubicView(viewNum:uint = 0, width:Number = 200, height:Number = 200, borderStyle:String = "none") {
			super(0, width, height, borderStyle);
			initObj(viewNum);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 3;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _direction:String = Direction.DOWN;
		/**
		 * 	Sets or gets the direction of the 3D cube transition for this <code>CubicView</code>
		 * 	instance. Posible values are:
		 * 	<ul>
		 * 		<li><code>Direction.UP</code>,</li>
		 * 		<li><code>Direction.DOWN</code>,</li>
		 * 		<li><code>Direction.LEFT</code>,</li>
		 * 		<li><code>Direction.RIGHT</code>.</li>
		 * 	</ul>
		 * 
		 * 	@default Direction.DOWN
		 * 
		 * 	@see #duration
		 * 	@see #easingFunction
		 */
		public function get direction():String {
			return _direction;
		}
		public function set direction(value:String):void {
			_direction = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>duration</code> property.
		 * 
		 * 	@see #duration
		 */
		protected var $duration:uint = 350;
		/**
		 * 	Sets or gets the duration of the transition used by the 3D cube effect
		 * 	for this <code>CubicView</code> instance.
		 * 
		 * 	@default 350
		 * 
		 * 	@see #direction
		 * 	@see #easingFunction
		 */
		public function get duration():uint {
			return $duration;
		}
		public function set duration(value:uint):void {
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
		 * 	Sets or gets the easing function used by the 3D cube transition effect.
		 * 
		 * 	@default A <code>Linear</code> easing function.
		 * 
		 * 	@see #direction
		 * 	@see #duration
		 */
		public function get easingFunction():Easing {
			return $easingFunction;
		}
		public function set easingFunction(value:Easing):void {
			$easingFunction = value;
		}
		
		private var _smooth:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the cubic effect is 
		 * 	rendered by using a nearest-neighbor algorithm and look pixelated
		 * 	(<code>true</code>), or not (<code>false</code>). Rendering by using the
		 * 	nearest neighbor algorithm is usually faster.
		 * 
		 * 	@default false
		 */
		public function get smooth():Boolean {
			return _smooth;
		}
		public function set smooth(value:Boolean):void {
			_smooth = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			if (_tween != null) {
				_tween.stop();
				deleteEffect();
			}
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function activeView(view:Canvas):void {
			if ($currentView != null) deactiveView($currentView);
			view.invalidateLayout = false;
			view.move($padL, $padT);
			view.visible = true;
			view.resize($width - $padL - $padR, height - $padT - $padB);
			view.forceLayout();
			if ($displayed) {
				assignBitmapEffect();
				_distortIn = new DistortFX(_effectContIn, _bitmap.bitmapData.clone(), 1, 1, _smooth);
				_bitmap.bitmapData.dispose();
				createCubicEffect();
			}
			$currentView = view;
		}
		
		/**
		 *  @private
		*/
		override protected function deactiveView(view:Canvas):void {
			if ($displayed) {
				assignBitmapEffect();
				_distortOut = new DistortFX(_effectContOut, _bitmap.bitmapData.clone(), 1, 1, _smooth);
			}
			view.invalidateLayout = true;
			view.visible = false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _effectCont:Sprite;
		private var _effectContIn:Sprite;
		private var _effectContOut:Sprite;
		private var _tween:Tween;
		private var _bitmap:Bitmap;
		private var _bmpData:BitmapData;
		private var _distortIn:DistortFX;
		private var _distortOut:DistortFX;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(viewNum:uint):void {
			createEffect();
			initViews(viewNum);
			spas_internal::setSelector(Selectors.CUBIC_VIEW); 
			spas_internal::isInitialized(3);
		}
		
		private function createCubicEffect():void {
			moveEffectCont();
			if (!$parent.contains(_effectCont)) $parent.addChild(_effectCont);
			//var unscaledPos:Array = [0, 0, _width, 0, _width, _height, 0, _height];
			var start:Array;
			var end:Array;
			switch(_direction) {
				case Direction.LEFT :
					start = [	0, 0, $width, 0, $width, $height, 0, $height, 
								$width, 0, $width, $height/2, $width, $height/2, $width, $height];
					end = [	0, $height/2, 0, 0, 0, $height, 0, $height/2,
							0, 0, $width, 0, $width, $height, 0, $height];
					break;
				case Direction.RIGHT : 
					start = [	0, 0, $width, 0, $width, $height, 0, $height, 
								0, $height/2, 0, 0, 0, $height, 0, $height/2];
					end = [	$width, 0, $width, $height/2, $width, $height/2, $width, $height,
							0, 0, $width, 0, $width, $height, 0, $height];
					break;
				case Direction.UP : 
					start = [	0, 0, $width, 0, $width, $height, 0, $height, 
								0, $height, $width, $height, $width/2, $height, $width/2, $height];
					end = [	$width/2,0, $width/2, 0, $width, 0, 0, 0,
							0, 0, $width, 0, $width, $height, 0, $height];
					break;
				case Direction.DOWN : 
					start = [	0, 0, $width, 0, $width, $height, 0, $height, 
								$width/2,0, $width/2, 0, $width, 0, 0, 0];
					end = [	0, $height, $width, $height, $width/2, $height, $width/2, $height,
							0, 0, $width, 0, $width, $height, 0, $height];
					break;
			}
			_tween = new Tween(_effectCont, start, end, $duration);
			_tween.setEasingFunction($easingFunction);
			$evtColl.addEvent(_tween, MotionEvent.START, initEffect);
			$evtColl.addEvent(_tween, MotionEvent.UPDATE, doEffect);
			$evtColl.addEvent(_tween, MotionEvent.FINISH, deleteEffect);
			_tween.play();
		}
		
		private function initEffect(e:MotionEvent):void {
			spas_internal::uioSprite.visible = false;
			$evtColl.removeEvent(_tween, MotionEvent.START, initEffect);
		}
		
		private function doEffect(e:MotionEvent):void {
			var pts:Array = e.value as Array;
			_distortIn.setChoordTransform(pts[8], pts[9], pts[10], pts[11], pts[12], pts[13], pts[14], pts[15]);
			if(_distortOut) _distortOut.setChoordTransform(pts[0], pts[1], pts[2], pts[3], pts[4], pts[5], pts[6], pts[7]);
		}
		
		private function deleteEffect(e:MotionEvent = null):void {
			spas_internal::uioSprite.visible = true;
			$evtColl.removeEvent(_tween, MotionEvent.UPDATE, doEffect);
			$evtColl.removeEvent(_tween, MotionEvent.FINISH, deleteEffect);
			if (_distortIn) _distortIn.finalize();
			if (_distortOut) _distortOut.finalize();
			if($parent.contains(_effectCont)) $parent.removeChild(_effectCont);
			_tween.stop();
			_tween.finalize();
			_tween = null;
			this.dispatchEvent(new CubicViewEvent(CubicViewEvent.EFFECT_FINISHED));
		}
		
		private function moveEffectCont():void {
			_effectCont.x = this.x;
			_effectCont.y = this.y;
		}
		
		private function assignBitmapEffect():void {
			_bmpData = new BitmapData($width, $height, true, 0x00000000);
			_bmpData.draw(spas_internal::uioSprite);
			_bitmap.bitmapData = _bmpData.clone();
			_bmpData.dispose();
		}
		
		private function createEffect():void {
			$easingFunction = new Linear();
			_effectCont = new Sprite();
			_bitmap = new Bitmap();
			_effectContIn = new Sprite();
			_effectContOut = new Sprite();
			_effectCont.cacheAsBitmap = _effectContIn.cacheAsBitmap =
				_effectContOut.cacheAsBitmap = true;
			_effectCont.addChild(_effectContOut);
			_effectCont.addChild(_effectContIn);
		}
	}
}