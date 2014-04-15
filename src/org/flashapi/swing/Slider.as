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
	// Slider.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 22:06
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.flashapi.swing.constants.MouseWheelEventOperation;
	import org.flashapi.swing.constants.ScrollBarElements;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.Tween;
	import org.flashapi.swing.plaf.libs.SliderUIRef;
	import org.flashapi.swing.scroll.Scrollable;
	import org.flashapi.swing.scroll.ScrollableThumb;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Slider.png")]
	
	/**
	 * 	<img src="Slider.png" alt="Slider" width="18" height="18"/>
	 * 
	 * 	The <code>Slider</code> class lets users select a value by moving a slider
	 * 	thumb between the end points of the slider track. The current value of the
	 * 	slider is determined by the relative location of the thumb between the end
	 * 	points of the slider, corresponding to the <code>minimum</code> and 
	 * 	<code>maximum</code> values.
	 * 
	 * 	<p>The slider may allows a continuous range of values between its
	 * 	<code>minimum</code> and <code>maximum</code> values, or it may be restricted
	 * 	to values at concrete intervals between these values. It may show tick marks
	 * 	at specified intervals along the track. These tick marks are independent
	 * 	of the allowed values for this <code>Slider</code> instance.
	 * 	</p>
	 * 
	 *  @includeExample SliderExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Slider extends Scrollable implements Observer, LafRenderer, ScrollableThumb, Initializable {
		
		//TODO: It seams that autoWidth, autoHeight or autoSize are not implemented on Slider objects (06/06/2008 12:12)
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Slider</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	length	The length of the <code>Slider</code> instance, in pixels.
		 * 	@param	orientation	The orientation of the <code>Separator</code> instance.
		 * 						Valid values are <code>ScrollableOrientation.VERTICAL</code>
		 * 						or <code>ScrollableOrientation.HORIZONTAL</code>.
		 * 						Default value is <code>ScrollableOrientation.VERTICAL</code>.
		 */
		public function Slider(length:Number = 150, orientation:String = "vertical") {
			super();
			initObj(length, orientation);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _labels:Array = null;
		/**
		 * 	An <code>Array</code> of strings used as labels for this <code>Slider</code>
		 * 	instance. Labels are positioned at the beginning of the track, and spaced
		 * 	evenly between the beginning of the track and the end of the track.
		 * 
		 * 	@default null
		 */
		public function get labels():Array {
			return _labels;
		}
		public function set labels(value:Array):void {
			_labels = value;
			setLabels();
			setRefresh();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get thumbLength():Number {
			return getThumbLength();
		}
		
		private var _showTicks:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether the ticks within this
		 * 	<code>Slider</code> instance (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get showTicks():Boolean {
			return _showTicks;
		}
		public function set showTicks(value:Boolean):void {
			_showTicks = value;
			_hasTicksToUpdate = true;
			setRefresh();
		}
		
		private var _slideDuration:Number = 300;
		/**
		 * 	@inheritDoc
		 */
		public function get slideDuration():Number {
			return _slideDuration;
		}
		public function set slideDuration(value:Number):void {
			_slideDuration = value;
		}
		
		private var _snapInterval:Number;
		/**
		 * 	@inheritDoc
		 */
		public function get snapInterval():Number {
			return _snapInterval;
		}
		public function set snapInterval(value:Number):void {
			_snapInterval = value;
		}
		
		private var _tickColor:Number = 0x000000;
		/**
		 * 	Sets or gets the color of all ticks slider displayed within this
		 * 	<code>Slider</code> instance, in pixels.  Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 * 	@default 0x000000
		 */
		public function get tickColor():* {
			return _tickColor;
		}
		public function set tickColor(value:*):void {
			_tickColor = getColor(value);
			_hasTicksToUpdate = true;
			setRefresh();
		}
		
		private var _tickInterval:Number = 10;
		/**
		 *  Sets or gets the spacing of the tick marks relative to the length of this
		 * 	<code>Slider</code> instance, in pixels. For example, if <code>tickInterval</code>
		 * 	is <code>1</code>, <code>minimum</code> is <code>0</code> and
		 * 	<code>maximum</code> is <code>10</code>, then a tick mark is placed at
		 * 	each 1/10th interval along the slider.
		 *
		 * 	@default 10
		 */
		public function get tickInterval():Number {
			return _tickInterval;
		}
		public function set tickInterval(value:Number):void {
			_tickInterval = value;
			_hasTicksToUpdate = true;
			setRefresh();
		}
		
		private var _tickThickness:Number = 1;
		/**
		 * 	Sets or gets the thickness of all ticks slider displayed within this
		 * 	<code>Slider</code> instance, in pixels.
		 *
		 * 	@default 1
		 */
		public function get tickThickness():Number {
			return _tickThickness;
		}
		public function set tickThickness(value:Number):void {
			_tickThickness = value;
			_hasTicksToUpdate = true;
			setRefresh();
		}
		
		private var _tickWidth:Number = 4;
		/**
		 * 	Sets or gets the width of all ticks slider displayed within this
		 * 	<code>Slider</code> instance, in pixels.
		 * 
		 * 	@default 4
		 */
		public function get tickWidth():Number {
			return _tickWidth;
		}
		public function set tickWidth(value:Number):void {
			_tickWidth = value;
			_hasTicksToUpdate = true;
			setRefresh();
		}
		
		private var _trackLength:Number;
		/**
		 * 	Returns the length of the track for this <code>Slider</code> instance,
		 * 	in pixels.
		 */
		public function get trackLength():Number {
			return _trackLength;
		}
		
		/**
		 * @private
		 */
		override public function get width():Number {
			return $horizontal ? spas_internal::uioSprite.height :
				spas_internal::uioSprite.width;
		}
		/**
		 * @private
		 */
		override public function set value(value:Number):void {
			$value = value;
			if($displayed) setThumbPosition();
		}
		
		/**
		 * @private
		 */
		override public function set length(value:Number):void {
			_hasLabelToUpdate = _hasTicksToUpdate = true;
			super.length = value;
		}
		
		/**
		 * @private
		 */
		override public function set orientation(value:String):void {
			_hasLabelToUpdate = _hasTicksToUpdate = true;
			super.orientation = value;
		}
		
		private var __highlightColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get highlightColor():* {
			return __highlightColor;
		}
		public function set highlightColor(value:*):void {
			__highlightColor = value;
			/*spas_internal::lafDTO.highlightColor =
				isNaN(value) ? lookAndFeel.getHighlightColor() : getColor(value);
			if (_isHighlightDrawn) {
				$displayed ? updateHighlight() : _needsHighlightUpdate = true;
			}*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function clearHighlight():void {
			lookAndFeel.clearHighlight();
		}
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!displayed) {
				createUIObject(x, y);
				manageMouseWheelEvent(MouseWheelEventOperation.ADD);
				doStartEffect();
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function drawHighlight(minimum:Number = 0, maximum:Number = 100):void {
			_hilightMin = minimum;
			_hilightMax = maximum;
			$displayed ? updateHighlight() : _needsHighlightUpdate = true;
		}
		
		private var _tweenEasing:Easing = null;
		/**
		 * 	@inheritDoc
		 */
		public function setEasingFunction(value:Easing):void {
			_tweenEasing = value;
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			if (_sliderTween != null) _sliderTween.finalize();
			_labelContainer.finalize();
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
		override protected function setSpecificLafChanges():void {
			fixLabelsLaf();
		}
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			if ($active) {
				spas_internal::lafDTO.state = States.OUT;
				lookAndFeel.drawThumb();
				getThumbBoundary();
				drawSlider();
				drawScrollTrack();
			} else {
				spas_internal::lafDTO.state = States.INACTIVE;
				lookAndFeel.drawThumb();
				getThumbBoundary();
				drawSlider();
			}
			if(_hasTicksToUpdate) drawTicks();
			if(_hasLabelToUpdate) layoutLabels();
			setSliderPositions();
			setThumbPosition();
			$width = $length;
			$height = spas_internal::uioSprite.height;
			_hasLabelToUpdate = _hasTicksToUpdate = false;
			if (_needsHighlightUpdate) updateHighlight();
			setEffects();
		}
		
		/**
		 * @private
		 */
		override protected function mouseWheelHandler(e:MouseEvent):void{
			//e.delta>0 ? negativeThumbPosition(mouseWheelScrollSize) : positiveThumbPosition(mouseWheelScrollSize);
			if($active && $enabled) dispatchScrollEvent(ScrollEvent.SCROLL);
		}
		
		/**
		 * @private
		 */
		override protected function getThumbLength():Number {
			return $horizontal ? $thumbRect.width : $thumbRect.height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _ticksContainer:Sprite;
		private var _highlightTrackContainer:Sprite;
		
		//private var _tickOfset:Number = 4;
		private var _sliderTween:Tween;
		private var _labelThickness:Number = 0;
		private var _labelContainer:Canvas;
		private var _hasLabelToUpdate:Boolean;
		private var _hasTicksToUpdate:Boolean;
		private var _hilightMin:Number;
		private var _hilightMax:Number;
		private var _needsHighlightUpdate:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(length:Number, orientation:String):void {
			$length = length;
			getOrientation(orientation);
			$isScrollPressed = $hasOverOutHandler = _needsHighlightUpdate = false;
			createContainers();
			initLaf(SliderUIRef);
			spas_internal::pressedElement = ScrollBarElements.NONE;
			spas_internal::lafDTO.active = $active = _hasLabelToUpdate = _hasTicksToUpdate = true;
			spas_internal::lafDTO.tickStart = new Point();
			spas_internal::lafDTO.tickEnd = new Point();
			$minimum = 0;
			$maximum = 100;
			_snapInterval = 10;
			spas_internal::lafDTO.trackLength = spas_internal::lafDTO.minimum =
				spas_internal::lafDTO.maximum = 0;
			spas_internal::setSelector(Selectors.SLIDER);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			_ticksContainer = new Sprite();
			spas_internal::lafDTO.ticksContainer = _ticksContainer;
			spas_internal::uioSprite.addChild(_ticksContainer);
			_labelContainer = new Canvas(0, 0);
			_labelContainer.autoAdjustSize = false;
			_labelContainer.autoSize = true;
			_labelContainer.layout = new AbsoluteLayout();
			_labelContainer.target = spas_internal::uioSprite;
			_labelContainer.display();
			createTrack();
			_highlightTrackContainer = new Sprite();
			spas_internal::lafDTO.highlightTrackContainer = _highlightTrackContainer;
			spas_internal::uioSprite.addChild(_highlightTrackContainer);
			createThumb();
			createScrollTrack();
			setThumbBehaviour();
		}
		
		private function setThumbBehaviour():void {
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_OVER, thumbOverHandler);
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_DOWN, thumbPressHandler);
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_OUT, scrolltrackOutHandler);
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_UP, thumbReleaseHandler);
		}
		
		private function setThumbPosition():void {
			var v:Number = (($value - $minimum) / ($maximum - $minimum)) * _trackLength;
			v = !$decimalMode ? Math.round(v) : v;
			$horizontal ? $thumbContainer.x = v + getThumbLength() : $thumbContainer.y = v;
		}
		
		private function stopAutoMove():void {
			spas_internal::pressedElement = ScrollBarElements.NONE;
		}
		
		private function getThumbBoundary():void {
			$thumbRect = $thumbContainer.getBounds($thumbContainer);
			spas_internal::lafDTO.trackLength = _trackLength = $length-getThumbLength();
		}
		
		private function setSliderPositions():void {
			var td:Number = lookAndFeel.getTickDelay();
			var sl:Number = getThumbLength() / 2;
			var pos:Number;
			if ($horizontal) {
				$thumbContainer.rotation = $track.rotation =
					_highlightTrackContainer.rotation = _ticksContainer.rotation = 90;
				_ticksContainer.x = $track.x = _highlightTrackContainer.x = $length - sl;
				_labelContainer.x = sl;
				//_ticksContainer.x = _length;
				_ticksContainer.y = _labelThickness;
				pos = _labelThickness + _ticksContainer.height + td;
				$thumbContainer.y = $scrollTrack.y = $track.y = _highlightTrackContainer.y = pos;
				$thumbContainer.x = getThumbLength();
			} else {
				_labelContainer.rotation = 90;
				_ticksContainer.y = $track.y = _highlightTrackContainer.y = sl;
				$thumbContainer.rotation = $track.rotation =
					_ticksContainer.rotation = $scrollTrack.y = _labelContainer.y = 0;
				_ticksContainer.x = _labelThickness;
				pos = _ticksContainer.x + _ticksContainer.width + td;
				$thumbContainer.x = $scrollTrack.x = $track.x = _highlightTrackContainer.x = pos;
			}
		}
		
		private function scrollTrackOnMouseMove():void {
			var value:Number = (_trackLength) / ($maximum - $minimum) * _snapInterval;
			switch($horizontal) {
				case false :
					if($mouseTracker.y-$thumbMouseOffset <= 0) $thumbContainer.y = 0;
					else if ($mouseTracker.y - $thumbMouseOffset + getThumbLength() >= $length) {
						$thumbContainer.y = _trackLength;
					}else if ($liveDragging) {
						$thumbContainer.y = $mouseTracker.y-$thumbMouseOffset;
					} else {
						if (($mouseTracker.y - $thumbMouseOffset) % value <= 1) {
							$thumbContainer.y = $mouseTracker.y - $thumbMouseOffset;
						}
					}
					break;
				case true :
					if($mouseTracker.x-$thumbMouseOffset <= 0) $thumbContainer.x = getThumbLength();
					else if ($mouseTracker.x - $thumbMouseOffset >= _trackLength) {
						$thumbContainer.x = $length;
					} else if ($liveDragging) {
						$thumbContainer.x = $mouseTracker.x - $thumbMouseOffset + getThumbLength();
					} else {
						if (($mouseTracker.x - $thumbMouseOffset) % value <= 1) {
							$thumbContainer.x = $mouseTracker.x - $thumbMouseOffset + getThumbLength();
						}
					}
					break;
			}
			getValue();
		}
		
		private function getValue():void {
			$percentValue = $horizontal ?
				($thumbContainer.x - getThumbLength()) / _trackLength :
				$thumbContainer.y / _trackLength;
			//var result:Number = (_maximum-_minimum)*percent/_blockIncrement+_minimum;
			var result:Number = ($maximum - $minimum) * $percentValue + $minimum;
			$value = $decimalMode ? result : Math.round(result);
		}
		
		private function drawSlider():void {
			lookAndFeel.drawTrack();
		}
		
		private function thumbOverHandler(e:MouseEvent):void { 
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			if($thumbContainer.hitTestPoint(pt.x, pt.y, true)) {
				spas_internal::lafDTO.state = $isScrollPressed ? States.PRESSED : States.OVER;
				lookAndFeel.drawThumb();
			} else if(!$hasOverOutHandler) {
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = true;
			}
		}
		
		private function thumbReleaseHandler(e:MouseEvent):void {
			spas_internal::lafDTO.state = States.OVER;
			lookAndFeel.drawThumb();
			if(!$hasOverOutHandler) {
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = true;
			}
		}
		
		private function scrolltrackOutHandler(e:MouseEvent):void { 
			spas_internal::lafDTO.state = $isScrollPressed ? States.PRESSED : States.OUT;
			lookAndFeel.drawThumb();
		}
		
		private function thumbPressHandler(e:MouseEvent):void {
			setCurrentScrollable(this);
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			if($thumbContainer.hitTestPoint(pt.x, pt.y, true)) {
				$isScrollPressed = true;
				spas_internal::pressedElement = ScrollBarElements.THUMB;
				if ($boxhelp != null) {
					$boxhelp.label = String($value);
					$boxhelp.display();
				}
				$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = false;
				spas_internal::currentScrollableObject = this;
				var thumbMousePosition:Point =
					new Point($thumbContainer.mouseX, $thumbContainer.mouseY);
				$thumbMouseOffset = $horizontal ?
					getThumbLength() - thumbMousePosition.y : thumbMousePosition.y;
				spas_internal::lafDTO.state = States.PRESSED;
				lookAndFeel.drawThumb();
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, thumbMouseMoveHandler);
				$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, thumbMouseUpHandler);
			} else {
				spas_internal::pressedElement = ScrollBarElements.TRACK;
				pt = new Point($scrollTrack.mouseX, $scrollTrack.mouseY);
				if($allowTrackClick) startAutoMove(pt);
			}
		}
		
		private function thumbMouseMoveHandler(e:MouseEvent):void {
			$mouseTracker = $scrollTrack.globalToLocal(new Point(e.stageX, e.stageY));
			scrollTrackOnMouseMove();
			if ($boxhelp != null) {
				$boxhelp.label = String($value);
				$boxhelp.move(0, 0);
			}
			if($active && $enabled) dispatchScrollEvent(ScrollEvent.SCROLL);
			//_value = horizontal ? (_thumbContainer.x-thumbRect.height)/(_length-thumbRect.height) : _thumbContainer.y/(_length-thumbRect.height);
			//getValue();
		}
		
		private function thumbMouseUpHandler(e:MouseEvent):void {
			//if(_elasticMode) setThumbPosition();
			spas_internal::pressedElement = ScrollBarElements.NONE;
			$isScrollPressed = false;
			if ($boxhelp != null) $boxhelp.remove();
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			spas_internal::lafDTO.state =
				$thumbContainer.hitTestPoint(pt.x, pt.y, true) ? States.OVER : States.OUT;
			lookAndFeel.drawThumb();
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, thumbMouseMoveHandler);
			if($active && $enabled) dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, thumbMouseUpHandler);
		}
		
		private function scrolltrackMouseMoveHandler(e:MouseEvent):void {
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			spas_internal::lafDTO.state =
				$thumbContainer.hitTestPoint(pt.x, pt.y, true) ? States.OVER : States.OUT;
			lookAndFeel.drawThumb();
		}
		
		private function startAutoMove(pt:Point):void {
			_sliderTween = new Tween($thumbContainer,
							[$thumbContainer.x, $thumbContainer.y],
							[pt.x, pt.y], _slideDuration);
			$evtColl.addEvent(_sliderTween, MotionEvent.UPDATE, moveSlider);
			$evtColl.addEvent(_sliderTween, MotionEvent.FINISH, deleteSliderMove);
			if(_tweenEasing!=null) _sliderTween.setEasingFunction(_tweenEasing);
			_sliderTween.play();
		}
		
		private function moveSlider(e:MotionEvent):void {
			getSliderMovePosition(e.value[0], e.value[1]);
			if($active && $enabled) dispatchScrollEvent(ScrollEvent.SCROLL);
		}
		
		private function getSliderMovePosition(x:Number, y:Number):void {
			var mousePos:Number;
			var l:Number = getThumbLength();
			if($horizontal) {
				if(x <= l) mousePos = l;
				else if(x >= $length-l) mousePos = $length;
				else mousePos = x+l/2;
				$thumbContainer.x = mousePos;
			} else {
				if(y <= l/2) mousePos = 0;
				else if(y >= $length-l) mousePos = $length-l;
				else mousePos = y-l/2;
				$thumbContainer.y = mousePos;
			}
			getValue();
		}
		
		private function deleteSliderMove(e:MotionEvent):void {
			var a:Array = e.value as Array;
			getSliderMovePosition(a[0], a[1]);
			getValue();
			$evtColl.removeEvent(_sliderTween, MotionEvent.UPDATE, moveSlider);
			$evtColl.removeEvent(_sliderTween, MotionEvent.FINISH, deleteSliderMove);
		}
		
		private function drawScrollTrack():void {
			var w:Number = lookAndFeel.getSliderWidth();
			var s:Figure = Figure.setFigure($scrollTrack);
			s.clear();
			s.beginFill(0, 0);
			$horizontal ? s.drawRectangle(0, 0, $length, w) : s.drawRectangle(0, 0, w, $length);
			s.endFill();
		}
		
		private function drawTicks():void {
			lookAndFeel.clearTicks();
			var ti:Number;
			if (_labels != null) {
				var div:int = _labels.length > 2 ? _labels.length-1 : 2;
				ti = _trackLength / div;
			} else ti = _tickInterval;
			if(_showTicks && ti > 0) {
				var d:Number = 0;
				var tickOff:Number = _tickThickness / 2;
				spas_internal::lafDTO.tickThickness =
					_tickThickness; spas_internal::lafDTO.tickColor = _tickColor;
				do {
					spas_internal::lafDTO.tickStart.y =
						spas_internal::lafDTO.tickEnd.y = d + tickOff;
					spas_internal::lafDTO.tickEnd.x = _tickWidth;
					lookAndFeel.drawTick();
					d += ti;
				} while(d < $length)
			}
		}
		
		private function setLabels():void {
			if (_labels != null) {
				_labelContainer.removeElements();
				_labelThickness = 0;
				var len:int = _labels.length;
				var l:Label;
				var i:int = 0;
				var s:String;
				for (; i < len; ++i) {
					s = _labels[i] is String ? _labels[i] : _labels[i].toString();
					l = new Label(s);
					l.lockLaf(lookAndFeel.getLabelLaf(), true);
					l.autoSize = true;
					_labelContainer.addElement(l);
					l.rotation = $horizontal ? 0 : -90;
					if($horizontal) _labelThickness = l.height;
					else {
						if (l.width > _labelThickness) _labelThickness = l.width;
					}
				}
				_hasLabelToUpdate = true;
			} else _hasLabelToUpdate = false;
			_hasTicksToUpdate = true;
		}
		
		private function layoutLabels():void {
			if(_labels != null && !isNaN(_trackLength)) {
				var labelSpacing:Number = 2;
				var len:uint = _labels.length;
				var labelPos:Number;
				var left:Number = _trackLength;
				var curLabel:Label;
				var i:int = len-1;
				for (; i >= 0; i--) {
					curLabel = _labelContainer.getObjectAt(i) as Label;
					if($horizontal) {
						labelPos = curLabel.width / 2;
						if (i == 0) labelPos = Math.min(labelPos, _trackLength / (len > 1 ? 2 : 1));
						else if (i == (len - 1)) {
							labelPos = Math.max(labelPos, curLabel.width - _trackLength / 2);
						}
						curLabel.move(left - labelPos, 0);
					} else {
						var yPos:Number = (labelSpacing + (labelSpacing > 0 ? 0 : -curLabel.width));
						curLabel.move(left, yPos);
					}
					left -= _trackLength / (len - 1);
				}
			}
		}
		
		private function fixLabelsLaf():void {
			var labels:Array = _labelContainer.getElements();
			if (labels.length > 0) {
				var l:int = labels.length - 1;
				for (; l >= 0; l--) labels[l].lockLaf(lookAndFeel.getLabelLaf(), true);
			}
			_hasLabelToUpdate = _hasTicksToUpdate = true;
		}
		
		private function updateHighlight():void {
			spas_internal::lafDTO.minimum = _hilightMin * _trackLength / 100;
			spas_internal::lafDTO.maximum = _hilightMax * _trackLength / 100;
			lookAndFeel.drawHighlight();
			_needsHighlightUpdate = false;
		}
	}
}