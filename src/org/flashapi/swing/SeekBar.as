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
	// SeekBar.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 03/11/2010 20:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.MouseWheelEventOperation;
	import org.flashapi.swing.constants.ScrollBarElements;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.Tween;
	import org.flashapi.swing.plaf.libs.SeekBarUIRef;
	import org.flashapi.swing.scroll.Scrollable;
	import org.flashapi.swing.scroll.ScrollableThumb;
	import org.flashapi.swing.scroll.SeekBarThumb;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("SeekBar.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the user moves (scrolls) the thumb whithin this
	 * 	<code>SeekBar</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ScrollEvent.SCROLL
	 */
	[Event(name = "scroll", type = "org.flashapi.swing.event.ScrollEvent")]
	
	/**
	 *  Dispatched when the user stops moving (scrolling) the thumb whithin this
	 * 	<code>SeekBar</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ScrollEvent.STOP_SCROLL
	 */
	[Event(name = "stopScroll", type = "org.flashapi.swing.event.ScrollEvent")]
	
	/**
	 *  Dispatched when the user starts moving (scrolling) the thumb whithin this
	 * 	<code>SeekBar</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ScrollEvent.START_SCROLL
	 */
	[Event(name = "startScroll", type = "org.flashapi.swing.event.ScrollEvent")]
	
	/**
	 * 	<img src="SeekBar.png" alt="SeekBar" width="18" height="18"/>
	 * 
	 * 	The <code>SeekBar</code> class creates a track control that can be used as
	 * 	seek bar for a media-player application. <code>SeekBar</code> objects are
	 * 	composed of a reactive track and a draggable thumb. The user can press the
	 * 	thumb and drag left or right to set the current progress level of the
	 * 	<code>SeekBar</code> instance; the current progress level can also be changed
	 * 	by clicking on the track.
	 * 	
	 * 	<p>The track of the <code>SeekBar</code> control is composed of a progress
	 * 	bar and a value track. Both, progress bar and value track, can be highlighted
	 * 	separately.</p>
	 * 
	 *  @includeExample SeekBarExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class SeekBar extends Scrollable implements Observer, LafRenderer, Border, ScrollableThumb, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>SeekBar</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	length	The length of the <code>SeekBar</code> instance, in pixels.
		 * 	@param	trackHeight	The height of the <code>SeekBar</code> track, in 
		 * 						pixels. If <code>NaN</code> the seek bar height is
		 * 						defined by the current Look and Feel.
		 * 						Default value is <code>NaN</code>.
		 */
		public function SeekBar(length:Number = 150, trackHeight:Number = NaN) {
			super();
			initObj(length, trackHeight);
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
		//  Border API
		//
		//--------------------------------------------------------------------------
		
		//--> Getter setter properties
		
		/**
		 *	@inheritDoc
		 */
		public function get backgroundContainer():Sprite {
			return $track;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundWidth():Number {
			return $length;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>backgroundHeight</code> property.
		 * 
		 * 	@see #backgroundHeight
		 */
		protected var $backgroundHeight:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get backgroundHeight():Number {
			return $backgroundHeight;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>bordersContainer</code> property.
		 * 
		 * 	@see #bordersContainer
		 */
		protected var $borders:Sprite;
		/**
		 *	@inheritDoc
		 */
		public function get bordersContainer():Sprite {
			return $borders;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderStyle</code> property.
		 * 
		 * 	@see #borderStyle
		 */
		protected var $borderStyle:String =  BorderStyle.SOLID;
		/**
		 *	@inheritDoc
		 */
		public function get borderStyle():String {
			return $borderStyle;
		}
		public function set borderStyle(value:String):void {
			$borderStyle = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderTopColor</code> property.
		 * 
		 * 	@see #borderTopColor
		 */
		protected var $btColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopColor():* {
			return $btColor;
		}
		public function set borderTopColor(value:*):void {
			$btColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderRightColor</code> property.
		 * 
		 * 	@see #borderRightColor
		 */
		protected var $brColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightColor():* {
			return $brColor;
		}
		public function set borderRightColor(value:*):void {
			$brColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderBottomColor</code> property.
		 * 
		 * 	@see #borderBottomColor
		 */
		protected var $bbColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomColor():* {
			return $bbColor;
		}
		public function set borderBottomColor(value:*):void {
			$bbColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderLeftColor</code> property.
		 * 
		 * 	@see #borderLeftColor
		 */
		protected var $blColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftColor():* {
			return $blColor;
		}
		public function set borderLeftColor(value:*):void {
			$blColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderShadowColor</code> property.
		 * 
		 * 	@see #borderShadowColor
		 */
		protected var $bShadowColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowColor():* {
			return $bShadowColor;
		}
		public function set borderShadowColor(value:*):void {
			$bShadowColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderHighlightColor</code> property.
		 * 
		 * 	@see #borderHighlightColor
		 */
		protected var $bHighlightColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightColor():* {
			return $bHighlightColor;
		}
		public function set borderHighlightColor(value:*):void {
			$bHighlightColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderTopOpacity</code> property.
		 * 
		 * 	@see #borderTopOpacity
		 */
		protected var $bto:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopOpacity():Number {
			return $bto;
		}
		public function set borderTopOpacity(value:Number):void {
			$bto = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderRightOpacity</code> property.
		 * 
		 * 	@see #borderRightOpacity
		 */
		protected var $bro:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightOpacity():Number {
			return $bro;
		}
		public function set borderRightOpacity(value:Number):void {
			$bro = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderBottomOpacity</code> property.
		 * 
		 * 	@see #borderBottomOpacity
		 */
		protected var $bbo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomOpacity():Number {
			return $bbo;
		}
		public function set borderBottomOpacity(value:Number):void {
			$bbo = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderLeftOpacity</code> property.
		 * 
		 * 	@see #borderLeftOpacity
		 */
		protected var $blo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftOpacity():Number {
			return $blo;
		}
		public function set borderLeftOpacity(value:Number):void {
			$blo = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderShadowOpacity</code> property.
		 * 
		 * 	@see #borderShadowOpacity
		 */
		protected var $bso:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowOpacity():Number {
			return $bso;
		}
		public function set borderShadowOpacity(value:Number):void {
			$bso = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderHighlightOpacity</code> property.
		 * 
		 * 	@see #borderHighlightOpacity
		 */
		protected var $bho:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightOpacity():Number {
			return $bho;
		}
		public function set borderHighlightOpacity(value:Number):void {
			$bho = value;
			redrawDecorator();
		}
		
		//-->Protected properties
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The internal reference to the <code>BorderDecorator</code> instance
		 * 	for this <code>SeekBar</code> object.
		 */
		protected var $borderDecorator:BorderDecorator;
		
		//--> Private methods
		private function redrawDecorator():void {
			$borderDecorator.drawBackground();
			$borderDecorator.drawBorders();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
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
		
		/*override public function get width():Number {
			return horizontal ? spas_internal::CONTAINER.height : spas_internal::CONTAINER.width;
		}*/
		
		/**
		 * @private
		 */
		override public function set value(value:Number):void {
			$value = value;
			if($displayed) setThumbPosition();
		}
		
		private var __trackHeight:Number = NaN;
		/**
		 * 	Sest or gets the height of the <code>SeekBar</code> track, in pixels.
		 * 	If <code>NaN</code> the seek bar height is defined by the current
		 * 	Look and Feel.
		 * 
		 * 	@default NaN
		 */
		public function get trackHeight():Number {
			return spas_internal::lafDTO.trackHeight;
		}
		public function set trackHeight(value:Number):void {
			__trackHeight = value;
			_thumb.height = spas_internal::lafDTO.trackHeight =
				$backgroundHeight = isNaN(value) ? lookAndFeel.getSeekBarThickness() : value;
			setRefresh();
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
			spas_internal::lafDTO.highlightColor =
				isNaN(value) ? lookAndFeel.getHighlightColor() : getColor(value);
			if (_isHighlightDrawn) {
				$displayed ? updateHighlight() : _needsHighlightUpdate = true;
			}
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			_needsHighlightUpdate = _needsProgressBarUpdate = true;
			spas_internal::lafDTO.trackLength = $length = value;
			setRefresh();
		}
		
		/**
		 * 	A reference to the <code>SeekBarThumb</code> object used by this
		 * 	<code>SeekBar</code> instance.
		 */
		public function get thumb():SeekBarThumb {
			return _thumb;
		}
		
		/**
		 *  Sets or gets the length of the scroll thumb, in pixels.
		 */
		public function get thumbLength():Number {
			return getThumbLength();
		}
		public function set thumbLength(value:Number):void {
			_thumb.width = value;
			setRefresh();
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
			_isHighlightDrawn = false;
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
		
		/**
		 * 	Clears the highlight of the progress bar within this <code>SeekBar</code>
		 * 	instance.
		 * 
		 * 	@see #drawProgressBar()
		 */
		public function clearProgressBar():void {
			lookAndFeel.clearProgressBar();
		}
		
		/**
		 * 	Highlights the progress bar of this <code>SeekBar</code> instance.
		 * 
		 * 	@param	minimum		The starting position for highlighting the progress bar.
		 * 	@param	maximum		The ending position for highlighting the progress bar.
		 * 
		 * 	@see #clearProgressBar()
		 */
		public function drawProgressBar(minimum:Number = 0, maximum:Number = 100):void {
			_progressMin = minimum;
			_progressMax = maximum;
			$displayed ? updateProgressBar() : _needsProgressBarUpdate = true;
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
			$borderDecorator.finalize();
			$borderDecorator = null;
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
			_thumb.lockLaf(lookAndFeel.getThumbLaf(), true);
		}
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			_thumb.visible = $active;
			if ($active) {
				_thumb.state = ButtonState.UP;
				getThumbBoundary();
				drawScrollTrack();
			} else {
				getThumbBoundary();
			}
			setThumbPosition();
			$width = $length;
			$height = spas_internal::uioSprite.height;
			if (_needsProgressBarUpdate) updateProgressBar();
			if (_needsHighlightUpdate) updateHighlight();
			redrawDecorator();
			drawMask();
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
			return $thumbRect.width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _highlightTrackContainer:Sprite;
		private var _progressBarContainer:Sprite;
		private var _barsContainer:Sprite;
		private var _barsMask:Shape;
		private var _sliderTween:Tween;
		private var _hilightMin:Number;
		private var _hilightMax:Number;
		private var _progressMin:Number;
		private var _progressMax:Number;
		private var _needsHighlightUpdate:Boolean = false;
		private var _isHighlightDrawn:Boolean = false;
		private var _needsProgressBarUpdate:Boolean = false;
		private var _thumb:SeekBarThumb;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(length:Number, trackHeight:Number):void {
			$length = length;
			_thumb = new SeekBarThumb(20);
			initLaf(SeekBarUIRef);
			this.trackHeight = trackHeight;
			$isScrollPressed = $hasOverOutHandler = false;
			createContainers();
			spas_internal::pressedElement = ScrollBarElements.NONE;
			spas_internal::lafDTO.active = $active = true;
			$maximum = 100;
			_hilightMax = _progressMax = $minimum = _hilightMin =
			_progressMin = spas_internal::lafDTO.trackLength =
			spas_internal::lafDTO.minimum = spas_internal::lafDTO.maximum = 0;
			_snapInterval = 10;
			this.highlightColor = NaN;
			spas_internal::setSelector(Selectors.SEEKBAR);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			createTrack();
			_barsContainer = new Sprite();
			_progressBarContainer = new Sprite();
			spas_internal::lafDTO.progressBarContainer = _progressBarContainer;
			_barsContainer.addChild(_progressBarContainer);
			_highlightTrackContainer = new Sprite();
			spas_internal::lafDTO.highlightTrackContainer = _highlightTrackContainer;
			_barsContainer.addChild(_highlightTrackContainer);
			spas_internal::uioSprite.addChild(_barsContainer);
			_barsMask = new Shape();
			spas_internal::uioSprite.addChild(_barsMask);
			_barsContainer.mask = _barsMask;
			createThumb();
			_thumb.target = $thumbContainer;
			_thumb.display();
			$borders = new Sprite();
			createBackgroundTextureManager($track);
			$borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			spas_internal::uioSprite.addChildAt($borders, 4);
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
			var v:Number =
				(($value - $minimum) / ($maximum - $minimum)) * ($length  - getThumbLength());
			v = !$decimalMode ? Math.round(v) : v;
			$thumbContainer.x = v;
		}
		
		private function stopAutoMove():void {
			spas_internal::pressedElement = ScrollBarElements.NONE;
		}
		
		private function getThumbBoundary():void {
			$thumbRect = _thumb.getBounds($thumbContainer);
			spas_internal::lafDTO.trackLength = $length;
		}
		
		private function scrollTrackOnMouseMove():void {
			var sl:Number = getThumbLength();
			var tl:Number = $length - sl;
			var value:Number = tl / ($maximum - $minimum) * _snapInterval;
			if ($mouseTracker.x - $thumbMouseOffset <= 0) $thumbContainer.x = 0;
			else if ($mouseTracker.x - $thumbMouseOffset >= tl) $thumbContainer.x = tl;
			else if ($liveDragging) $thumbContainer.x = $mouseTracker.x - $thumbMouseOffset;
			else {
				if (($mouseTracker.x - $thumbMouseOffset) % value <= 1)
					$thumbContainer.x = $mouseTracker.x - $thumbMouseOffset;
			}
			getValue();
		}
		
		private function getValue():void {
			$percentValue = $thumbContainer.x / ($length - getThumbLength());
			//var result:Number = (_maximum-_minimum)*percent/_blockIncrement+_minimum;
			var result:Number = ($maximum - $minimum) * $percentValue + $minimum;
			$value = $decimalMode ? result : Math.round(result);
		}
		
		private function thumbOverHandler(e:MouseEvent):void { 
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			if($thumbContainer.hitTestPoint(pt.x, pt.y, true)) {
				_thumb.state = $isScrollPressed ? ButtonState.DOWN : ButtonState.OVER;
			} else if(!$hasOverOutHandler) {
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = true;
			}
		}
		
		private function thumbReleaseHandler(e:MouseEvent):void {
			_thumb.state = ButtonState.OVER;
			if(!$hasOverOutHandler) {
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = true;
			}
		}
		
		private function scrolltrackOutHandler(e:MouseEvent):void { 
			_thumb.state = $isScrollPressed ? ButtonState.DOWN : ButtonState.UP;
		}
		
		private function thumbPressHandler(e:MouseEvent):void {
			if($active && $enabled) {
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
					var thumbMousePosition:Point = new Point($thumbContainer.mouseX, $thumbContainer.mouseY);
					$thumbMouseOffset = thumbMousePosition.x;
					_thumb.state = ButtonState.DOWN;
					$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, thumbMouseMoveHandler);
					$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, thumbMouseUpHandler);
					dispatchScrollEvent(ScrollEvent.START_SCROLL);
				} else {
					spas_internal::pressedElement = ScrollBarElements.TRACK;
					pt = new Point($scrollTrack.mouseX, $scrollTrack.mouseY);
					if ($allowTrackClick) {
						startAutoMove(pt);
						dispatchScrollEvent(ScrollEvent.START_SCROLL);
					}
				}
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
			getValue();
		}
		
		private function thumbMouseUpHandler(e:MouseEvent):void {
			//if(_elasticMode) setThumbPosition();
			spas_internal::pressedElement = ScrollBarElements.NONE;
			$isScrollPressed = false;
			if ($boxhelp != null) $boxhelp.remove();
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			_thumb.state =
				$thumbContainer.hitTestPoint(pt.x, pt.y, true) ? ButtonState.OVER : ButtonState.UP;
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, thumbMouseMoveHandler);
			if($active && $enabled) dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, thumbMouseUpHandler);
		}
		
		private function scrolltrackMouseMoveHandler(e:MouseEvent):void {
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			_thumb.state = $thumbContainer.hitTestPoint(pt.x, pt.y, true) ? ButtonState.OVER : ButtonState.UP;; 
		}
		
		private function startAutoMove(pt:Point):void {
			_sliderTween = new Tween($thumbContainer,
				[$thumbContainer.x, $thumbContainer.y], [pt.x, pt.y], _slideDuration);
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
			if(x <= l) mousePos = 0;
			else if (x >= $length - l) mousePos = $length - l;
			else mousePos = x - l / 2;
			$thumbContainer.x = mousePos;
			getValue();
		}
		
		private function deleteSliderMove(e:MotionEvent):void {
			var a:Array = e.value as Array;
			getSliderMovePosition(a[0], a[1]);
			getValue();
			$evtColl.removeEvent(_sliderTween, MotionEvent.UPDATE, moveSlider);
			$evtColl.removeEvent(_sliderTween, MotionEvent.FINISH, deleteSliderMove);
			dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
		}
		
		private function drawScrollTrack():void {
			with($scrollTrack.graphics){
				clear();
				beginFill(0, 0);
				drawRect(0, 0, $length, spas_internal::lafDTO.trackHeight);
				endFill();
			}
		}
		
		private function updateHighlight():void {
			_isHighlightDrawn = true;
			var w:Number = $thumbRect.width;
			spas_internal::lafDTO.minimum = _hilightMin * $length / 100;
			spas_internal::lafDTO.maximum = _hilightMax * ($length - w) / 100 + w/2;
			lookAndFeel.drawHighlight();
			_needsHighlightUpdate = false;
		}
		
		private function updateProgressBar():void {
			spas_internal::lafDTO.minimum = _progressMin * $length / 100;
			spas_internal::lafDTO.maximum = _progressMax * $length / 100;
			lookAndFeel.drawProgressBar();
			_needsProgressBarUpdate = false;
		}
		
		private function drawMask():void {
			var f:Figure = new Figure(_barsMask);
			f.clear();
			f.beginFill(0);
			f.drawRoundedBox(0, 0, $length, $backgroundHeight, $borderDecorator.topLeftCorner,
							$borderDecorator.topRightCorner, $borderDecorator.bottomRightCorner,
							$borderDecorator.bottomLeftCorner);
			f.endFill();
		}
	}
}