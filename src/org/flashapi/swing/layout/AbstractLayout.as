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

package org.flashapi.swing.layout {

	// -----------------------------------------------------------
	// AbstractLayout.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 23/02/2010 00:03
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flashapi.swing.constants.LayoutHorizontalAlignment;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.LayoutVerticalAlignment;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.LayoutEvent;
	import org.flashapi.swing.util.ArrayUtil;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.tween.motion.Linear;
	import org.flashapi.tween.Tween;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched once the processing the objects layout is finished and no more 
	 * 	actions are performed by this <code>Layout</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.LayoutEvent.LAYOUT_FINISHED
	 */
	[Event(name = "layoutFinished", type = "org.flashapi.swing.event.LayoutEvent")]
	
	/**
	 * 	The <code>AbstractLayout</code> class provides generic support for all
	 * 	<code>Layout</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractLayout extends EventDispatcher{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractLayout</code> instance.
		 */		
		public function AbstractLayout() {
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
		 * 	Stores the internal value for the <code>animated</code> property.
		 * 
		 * 	@see #animated
		 */
		protected var $animated:Boolean = false;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#animated
		 */
		public function get animated():Boolean {
			return $animated;
		}
		public function set animated(value:Boolean):void { 
			$animated = value;
			//--> TODO: Objects in virtualChoords must be deleted after effect processing
			if ($virtualChoords != null) {
				for each(var obj:* in $virtualChoords) delete $virtualChoords[obj];
			}
			else if ($virtualChoords == null && value) $virtualChoords = new Dictionary(true);
			else $virtualChoords = null;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoSizeDuration</code> property.
		 * 
		 * 	@see #autoSizeDuration
		 */
		protected var $autoSizeDuration:uint = 250;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#autoSizeDuration
		 */
		public function get autoSizeDuration():uint {
			return $autoSizeDuration;
		}
		public function set autoSizeDuration(value:uint):void {
			$autoSizeDuration = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoSizeAnimated</code> property.
		 * 
		 * 	@see #autoSizeAnimated
		 */
		protected var $autoSizeAnimated:Boolean = false;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#autoSizeAnimated
		 */
		public function get autoSizeAnimated():Boolean {
			return $autoSizeAnimated;
		}
		public function set autoSizeAnimated(value:Boolean):void {
			$autoSizeAnimated = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoSizeEasingFunction</code> property.
		 * 
		 * 	@see #autoSizeEasingFunction
		 */
		protected var $autoSizeEasingFunc:Easing;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#autoSizeEasingFunction
		 */
		public function set autoSizeEasingFunction(value:Easing):void {
			$autoSizeEasingFunc = value;
		}
		public function get autoSizeEasingFunction():Easing {
			return $autoSizeEasingFunc;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>duration</code> property.
		 * 
		 * 	@see #duration
		 */
		protected var $duration:uint = 500;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#duration
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
		 * 	@copy org.flashapi.swing.layout.Layout#easingFunction
		 */
		public function get easingFunction():Easing {
			return $easingFunction;
		}
		public function set easingFunction(value:Easing):void {
			$easingFunction = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>elementsListLength</code> property.
		 * 
		 * 	@see #elementsListLength
		 */
		protected var $elementsList:Array;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#elementsListLength
		 */
		public function get elementsListLength():int {
			return $elementsList.length;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>hasElementListChanged</code> property.
		 * 
		 * 	@see #hasElementListChanged
		 */
		protected var $hasListChanged:Boolean = false;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#hasElementListChanged
		 */
		public function get hasElementListChanged():Boolean {
			return $hasListChanged;
		}
		public function set hasElementListChanged(value:Boolean):void {
			$hasListChanged = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>horizontalAlignment</code> property.
		 * 
		 * 	@see #horizontalAlignment
		 */
		protected var $hAlignment:String = LayoutHorizontalAlignment.LEFT;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#horizontalAlignment
		 */
		public function get horizontalAlignment():String {
			return $hAlignment;
		}
		public function set horizontalAlignment(value:String):void {
			$hAlignment = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>isRendering</code> property.
		 * 
		 * 	@see #isRendering
		 */
		protected var $isRendering:Boolean = false;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#isRendering
		 */
		public function get isRendering():Boolean {
			return $isRendering;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>layoutWidth</code> property.
		 * 
		 * 	@see #layoutWidth
		 */
		protected var $layoutWidth:Number = 0;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#layoutWidth
		 */
		public function get layoutWidth():Number {
			return $layoutWidth;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>layoutHeight</code> property.
		 * 
		 * 	@see #layoutHeight
		 */
		protected var $layoutHeight:Number = 0;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#layoutHeight
		 */
		public function get layoutHeight():Number {
			return $layoutHeight;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>orientation</code> property.
		 * 
		 * 	@see #orientation
		 */
		protected var $orientation:String = LayoutOrientation.HORIZONTAL
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#orientation
		 */
		public function get orientation():String {
			return $orientation;
		}
		public function set orientation(value:String):void {
			$orientation = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>verticalAlignment</code> property.
		 * 
		 * 	@see #verticalAlignment
		 */
		protected var $vAlignment:String = LayoutVerticalAlignment.TOP;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#verticalAlignment
		 */
		public function get verticalAlignment():String {
			return $vAlignment;
		}
		public function set verticalAlignment(value:String):void {
			$vAlignment = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#addAllObjects()
		 */
		public function addAllObjects(collection:Array):void {
			var l:uint = collection.length;
			$elementsList = [];
			for(var i:uint = 0; i < l; i++) $elementsList.push(collection[i]);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value of the container associated with this <code>Layout</code>
		 * 	object.
		 * 
		 * 	@see #setTarget()
		 *
		 */
		protected var $target:UIContainer;
		/**
		 * 
		 * 	@copy org.flashapi.swing.layout.Layout#setTarget()
		 */
		public function setTarget(target:UIContainer):void {
			$target = target;
		}
		
		
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#addObject()
		 */
		public function addObject(obj:*):void {
			$elementsList.push(obj);
		}
		
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#removeObject()
		 */
		public function removeObject(obj:*):void {
			$elementsList.splice($elementsList.indexOf(obj), 1);
		}
		
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#clear()
		 */
		public function clear():void {
			$elementsList = [];
		}
		
		/**
		 * 	@private
		 */
		protected var $horizontalOrientation:String;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#setHorizontalOrientation()
		 */
		public function setHorizontalOrientation(value:String):void {
			$horizontalOrientation = value;
		}
		
		/**
		 * 	@private
		 */
		protected var $verticalOrientation:String;
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#setVerticalOrientation()
		 */
		public function setVerticalOrientation(value:String):void {
			$verticalOrientation = value;
		}
		
		/**
		 * 	@copy org.flashapi.swing.layout.Layout#swapElementsAt()
		 */
		public function swapElementsAt(index1:int, index2:int):void {
			ArrayUtil.swapValuesAt($elementsList, index1, index2);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An internal reference to the <code>Tween</code> instance that is used to
		 * 	set horizontal properties during rendering of animated layouts.
		 * 
		 * 	@see #$tweenY
		 */
		protected var $tweenX:Tween = null;
		
		/**
		 * 	An internal reference to the <code>Tween</code> instance that is used to
		 * 	set vertical properties during rendering of animated layouts.
		 * 
		 * 	@see #$tweenX
		 */
		protected var $tweenY:Tween = null;
		
		/**
		 * 	Stores an internal set of coordinates, relative to the final positions of
		 * 	each child elements, to perform animated layouts.
		 */
		protected var $virtualChoords:Dictionary = null;
		
		/**
		 * 	@private
		 */
		spas_internal var bounds:Rectangle;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function playAnimation():void {
			$target.spas_internal::invalidateChangeEvent = $target.spas_internal::deactivateMetricsChanges = true;
			if ($autoSizeAnimated) playAutosizeAnimation();
			else {
				if ($animated) playLayoutAnimation();
			}
		}
		
		/**
		 * 	@private
		 */
		protected function playAutosizeAnimation():void {
			if ($tweenX != null) finalizeTweens();
			$tweenX = new Tween($target, $target.width, $layoutWidth, $autoSizeDuration);
			$tweenY = new Tween($target, $target.height, $layoutHeight, $autoSizeDuration);
			$tweenX.setEasingFunction($autoSizeEasingFunc);
			$tweenY.setEasingFunction($autoSizeEasingFunc);
			//Tween.interval = $tweenInterval;
			$target.eventCollector.addEvent($tweenX, MotionEvent.UPDATE, updateLayoutSize);
			$target.eventCollector.addEvent($tweenY, MotionEvent.UPDATE, updateLayoutSize);
			$target.eventCollector.addEvent($tweenX, MotionEvent.FINISH, onLayoutSizeFinished);
			$target.eventCollector.addEvent($tweenY, MotionEvent.FINISH, onLayoutSizeFinished);
			$tweenX.play();
			$tweenY.play();
		}
		
		/**
		 * 	@private
		 */
		protected function updateLayoutSize(e:MotionEvent):void {
			var prop:String = e.target == $tweenX ? "width" : "height";
			$target[prop] = e.value;
		}
		
		/**
		 * 	@private
		 */
		protected function onLayoutSizeFinished(e:MotionEvent):void {
			if(!$tweenX.isPlaying && !$tweenY.isPlaying) {
				$target.eventCollector.removeEvent($tweenX, MotionEvent.UPDATE, updateLayoutSize);
				$target.eventCollector.removeEvent($tweenY, MotionEvent.UPDATE, updateLayoutSize);
				$target.eventCollector.removeEvent($tweenX, MotionEvent.FINISH, onLayoutSizeFinished);
				$target.eventCollector.removeEvent($tweenY, MotionEvent.FINISH, onLayoutSizeFinished);
				finalizeTweens();
				$target.width = $layoutWidth;
				$target.height = $layoutHeight;
				if ($animated) playLayoutAnimation();
				else {
					$target.spas_internal::invalidateChangeEvent = $target.spas_internal::deactivateMetricsChanges = false;
					dispatchFinishedEvent();
				}
			}
		}
		
		/**
		 * 	@private
		 */
		protected function playLayoutAnimation():void {
			if ($tweenX != null) finalizeTweens();
			var startX:Array = [];
			var startY:Array = [];
			var endX:Array = [];
			var endY:Array = [];
			//var i:int = _elementsList.length - 1;
			//for (; i >= 0; i--) {
			var i:int = 0;
			var l:int = $elementsList.length;
			var obj:*;
			for (; i < l; i++) {
				obj = $elementsList[i];
				startX.push(obj.x);
				endX.push($virtualChoords[obj].x);
				startY.push(obj.y);
				endY.push($virtualChoords[obj].y);
			}
			obj = null;
			$tweenX = new Tween($elementsList, startX, endX, $duration);
			$tweenY = new Tween($elementsList, startY, endY, $duration);
			$tweenX.setEasingFunction($easingFunction);
			$tweenY.setEasingFunction($easingFunction);
			//Tween.interval = $tweenInterval;
			$target.eventCollector.addEvent($tweenX, MotionEvent.UPDATE, updateLayoutMotion);
			$target.eventCollector.addEvent($tweenY, MotionEvent.UPDATE, updateLayoutMotion);
			$target.eventCollector.addEvent($tweenX, MotionEvent.FINISH, onLayoutMotionFinished);
			$target.eventCollector.addEvent($tweenY, MotionEvent.FINISH, onLayoutMotionFinished);
			$tweenX.play();
			$tweenY.play();
		}
		
		/**
		 * 	@private
		 */
		protected function updateLayoutMotion(e:MotionEvent):void {
			var i:int = $elementsList.length - 1;
			var v:Number;
			var prop:String;
			for (; i >= 0; i--) {
				var t:Tween = e.target as Tween;
				if (t.end[i] == undefined) return;
				v = e.value[i];
				prop = t == $tweenX ? "x" : "y";
				$elementsList[i][prop] = v;
			}
		}
		
		/**
		 * 	@private
		 */
		protected function onLayoutMotionFinished(e:MotionEvent):void {
			if (!$tweenX.isPlaying && !$tweenY.isPlaying) {
				$target.eventCollector.removeEvent($tweenX, MotionEvent.UPDATE, updateLayoutMotion);
				$target.eventCollector.removeEvent($tweenY, MotionEvent.UPDATE, updateLayoutMotion);
				$target.eventCollector.removeEvent($tweenX, MotionEvent.FINISH, onLayoutMotionFinished);
				$target.eventCollector.removeEvent($tweenY, MotionEvent.FINISH, onLayoutMotionFinished);
				$target.spas_internal::invalidateChangeEvent =
				$target.spas_internal::deactivateMetricsChanges = false;
				dispatchFinishedEvent();
				finalizeTweens();
			}
		}
		
		/**
		 * 	@private
		 */
		protected function finalizeTweens():void {
			$tweenX.stop();
			$tweenX = null;
			$tweenY.stop();
			$tweenY = null;
		}
		
		/**
		 * 	@private
		 */
		protected function hasBoundsChanged(b:Rectangle):Boolean {
			var changed:Boolean;
			if (spas_internal::bounds == null && b == null) changed = setNewBounds(b, false);
			else if (spas_internal::bounds == null) changed = setNewBounds(b, true);
			else if (spas_internal::bounds.equals(b)) changed = setNewBounds(b, false);
			else changed = setNewBounds(b, true);
			return changed;
		}
		
		/**
		 * 	@private
		 */
		protected function dispatchFinishedEvent():void {
			$isRendering = false;
			dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_FINISHED));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$elementsList = [];
			$easingFunction = new Linear();
			$autoSizeEasingFunc = new Linear();
		}
		
		private function setNewBounds(b:Rectangle, flag:Boolean = true):Boolean {
			if (flag) spas_internal::bounds = b;
			return flag;
		}
	}
}