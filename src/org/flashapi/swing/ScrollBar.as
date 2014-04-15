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
	// ScrollBar.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.4.0, 16/11/2011 12:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	import org.flashapi.swing.constants.MouseWheelEventOperation;
	import org.flashapi.swing.constants.ScrollableButtonType;
	import org.flashapi.swing.constants.ScrollBarElements;
	import org.flashapi.swing.constants.ScrollTargetPolicy;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.plaf.libs.ScrollBarUIRef;
	import org.flashapi.swing.scroll.ColorizableScrollbar;
	import org.flashapi.swing.scroll.ColorizableScrollbarDTO;
	import org.flashapi.swing.scroll.Scrollable;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>DisplayObject</code> specified by the <code>targetPath</code>
	 * 	property is scrolled due to mouse or 	keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ScrollEvent.SCROLL
	 */
	[Event(name = "scroll", type = "org.flashapi.swing.event.ScrollEvent")]
	
	/**
	 *  Dispatched when scrolling of <code>DisplayObject</code> specified by the
	 * 	<code>targetPath</code> is stopped.
	 *
	 *  @eventType org.flashapi.swing.event.ScrollEvent.STOP_SCROLL
	 */
	[Event(name = "scroll", type = "org.flashapi.swing.event.ScrollEvent")]
	
	[IconFile("ScrollBar.png")]
	
	/**
	 * 	<img src="ScrollBar.png" alt="ScrollBar" width="18" height="18"/>
	 * 
	 * 	A <code>ScrollBar</code> consists of two arrow buttons, a track between them,
	 * 	and a variable-size thumb. The thumb can move by clicking on either of the
	 * 	two arrow buttons, dragging the scroll 	thumb along the track, or clicking on the track.
	 * 
	 * 	<p>To create scroll bars with the same behavior as a Java <code>JScrollBar</code>,
	 * 	the <code>targetPath</code> parameter must be <code>null</code>.</p>
	 * 
	 * 	<p>For a list of CSS properties supported by <code>ColorizableScrollbar</code> 
	 * 	objects see: <a href="scroll/ColorizableScrollbar.html"
	 * 	title="org.flashapi.swing.scroll.ColorizableScrollbar">
	 * 	<code>org.flashapi.swing.scroll.ColorizableScrollbar</code></a>.</p>
	 * 
	 *  @includeExample ScrollBarExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScrollBar extends Scrollable implements Observer, LafRenderer, ColorizableScrollbar, Initializable {
		
		//--> TODO: To implement the enableTargetScroll property
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ScrollBar</code> instance with the
		 * 					specified properties.
		 * 
		 *  @param	targetPath		The <code>DisplayObject</code> that will be
		 * 							controlled by the scroll bar.
		 *  @param	length			The length of the scroll bar, in pixels.
		 *  @param	orientation		A <code>ScrollableOrientation</code> class constant
		 * 							that indicates whether the scroll bar is displayed
		 * 							vertically (<code>ScrollableOrientation.VERTICAL</code>),
		 * 							or horizontally (<code>ScrollableOrientation.HORIZONTAL</code>).
		 * 							Default value is <code>ScrollableOrientation.VERTICAL</code>.
		 *  @param	thickness		The thickness of the scroll bar, in pixels. Default
		 * 							value is <code>NaN</code>.
		 * 							If <code>NaN</code>, the thickness of the <code>ScrollBar</code>
		 * 							instance is defined by the current Look and Feel.
		 */
		public function ScrollBar(targetPath:DisplayObject = null, length:Number = 100, orientation:String = "vertical", thickness:Number = NaN) {
			super();
			initObj(targetPath, length, orientation, thickness);
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
		
		private var _bottomRightCorner:Boolean = false;
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A <code>Boolean</code> value that indicates whether the bottom right-hand
		 * 	square corner is visible (<code>true</code>), or not (<code>false</code>).
		 * 	The the bottom right-hand square corner represent the square which is
		 * 	displayed at the bottom right-hand corner when a control uses both,
		 * 	vertical and horizontal scroll bars (e.g. <code>ScrollableArea</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see org.flashapi.swing.scroll.ScrollableArea
		 * 	@see #rigthCornerContainer
		 */
		public function get showBottomRightCorner():Boolean {
			return _bottomRightCorner;
		}
		public function set showBottomRightCorner(value:Boolean):void {
			_bottomRightCorner = value;
			switch(value){
				case true :
					lookAndFeel.drawBottomRightCorner();
					break;
				case false :
					lookAndFeel.clearBottomRightCorner();
					break;
			}
		}
		
		private var _thumbWidth:Number = 50;
		/**
		 * 	Sets or gets the length of the scroll bar thumb, in pixels. Use this
		 * 	property to programmatically set the thumb size when the <code>lockThumbSize</code>
		 * 	property is <code>true</code>.
		 * 
		 * 	@default 50
		 * 
		 * 	@see #lockThumbSize
		 */
		public function get thumbLength():Number {
			return getThumbLength();
		}
		public function set thumbLength(value:Number):void { 
			_thumbWidth = value;
			if (isNull($targetPath) || _lockThumbSize) setRefresh();
		}
		
		private var _lockThumbSize:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the size of the scroll
		 * 	bar thumb is automatically computed by the <code>ScrollBar</code> class
		 * (<code>true</code>), or not (<code>false</code>). If <code>false</code>, 
		 * 	you can programmatically set the thumb size by using the <code>thumbLength</code>
		 * 	property.
		 * 	
		 * 	@default false
		 * 
		 * 	@see #thumbLength
		 */
		public function get lockThumbSize():Boolean {
			return _lockThumbSize;
		}
		public function set lockThumbSize(value:Boolean):void { 
			_lockThumbSize = value;
			if (isNull($targetPath) || _lockThumbSize) setRefresh();
		}
		
		private var _showDownButton:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether 'down arrow' button
		 * 	is visible (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #showUpButton
		 */
		public function get showDownButton():Boolean {
			return _showDownButton;
		}
		public function set showDownButton(value:Boolean):void {
			_showDownButton = _downButton.visible =
			_downButtonBackground.visible = value;
			setRefresh();
		}
		
		private var _showUpButton:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether 'up arrow' button
		 * 	is visible (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #showDownButton
		 */
		public function get showUpButton():Boolean {
			return _showUpButton;
		}
		public function set showUpButton(value:Boolean):void {
			_showUpButton = _upButton.visible =
			_upButtonBackground.visible = value;
			setRefresh();
		}
		
		private var _thickness:Number = NaN;
		/**
		 * 	Sets or gets the thickness of the scroll bar, in pixels. If 
		 * 	<code>NaN</code>, the thickness is defined by the current Look and Feel.
		 * 
		 * 	@default NaN
		 */
		public function get thickness():Number { 
			return isNaN(_thickness) ? lookAndFeel.getScrollBarWidth() : _thickness;
		}
		public function set thickness(value:Number):void {
			_thickness = value;
			setThickness();
			setRefresh();
			this.dispatchScrollEvent(ScrollEvent.THICKNESS_CHANGED);
		}
		
		/**
		 * @private
		 */
		override public function set value(value:Number):void {
			$value = value;
			var n:Number = ($value - $minimum) / ($maximum - $minimum);
			if ($displayed) {
				if (isNull($targetPath)) {
					if (isNull($thumbRect)) return;
					else updateThumbPos(n);
				} else {
					updateThumbPos(n);
					_scrollText ? setTextPosition() : setContentPathPosition();
				}
			}
		}
		
		/**
		 * @private
		 */
		override public function get width():Number {
			return $horizontal ? spas_internal::uioSprite.height : spas_internal::uioSprite.width;
		}
		
		private var _scrollTargetPolicy:String = ScrollTargetPolicy.DISABLE_IF_NULL;
		/**
		 * 	Sets or gets the behavior of the scroll bar when the <code>targetPath</code>
		 * 	property is <code>null</code>. Possible values are the <code>ScrollTargetPolicy</code>
		 * 	constants:
		 * 	<ul>
		 * 		<li>if <code>ScrollTargetPolicy.ENABLE_IF_NULL</code>, the <code>ScrollBar</code>
		 * 		instance remains active, event if the  <code>targetPath</code> parameter is
		 * 		<code>null</code>.</li>
		 * 		<li>if <code>ScrollTargetPolicy.DISABLE_IF_NULL</code>, the <code>ScrollBar</code> 
		 * 		instance is not active when the <code>targetPath</code> parameter is <code>null</code>.
		 * 		</li>
		 * 	</ul>
		 * 
		 * 	@default ScrollTargetPolicy.DISABLE_IF_NULL
		 */
		public function get scrollTargetPolicy():String {
			return _scrollTargetPolicy;
		}
		public function set scrollTargetPolicy(value:String):void {
			_scrollTargetPolicy = value;
			setRefresh();
		}
		
		/**
		 * 	Returns a number that represents the real size of the "up arrow" button.
		 * 	Use this property to programmatically compute the size of the scroll bar
		 * 	thumb when the <code>lockThumbSize</code> property is <code>true</code>.
		 * 
		 * 	<p>The <code>upButtonSize</code> property changes each time you set a new
		 * 	Look and Feel for <code>Scrollbar</code> instances.</p>
		 * 
		 * 	@see #downButtonSize
		 */
		public function get upButtonSize():Number {
			return _upBtnRect.height;
		}
		
		/**
		 * 	Returns a number that represents the real size of the "down arrow" button.
		 * 	Use this property to programmatically compute the size of the scroll bar
		 * 	thumb when the <code>lockThumbSize</code> property is <code>true</code>.
		 * 
		 * 	<p>The <code>upButtonSize</code> property changes each time you set a new
		 * 	Look and Feel for <code>Scrollbar</code> instances.</p>
		 * 
		 * 	@see #upButtonSize
		 */
		public function get downButtonSize():Number {
			return _downBtnRect.height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  ColorizableScrollbar API
		//
		//--------------------------------------------------------------------------
		
		private var _scrollbarArrowColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarArrowColor():* {
			return _scrollbarArrowColor;
		}
		public function set scrollbarArrowColor(value:*):void{
			_scrollbarArrowColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarBaseColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarBaseColor():* {
			return _scrollbarBaseColor;
		}
		public function set scrollbarBaseColor(value:*):void{
			_scrollbarBaseColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarFaceColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarFaceColor():* {
			return _scrollbarFaceColor;
		}
		public function set scrollbarFaceColor(value:*):void{
			_scrollbarFaceColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarHighlightColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarHighlightColor():* {
			return _scrollbarHighlightColor;
		}
		public function set scrollbarHighlightColor(value:*):void{
			_scrollbarHighlightColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarShadowColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarShadowColor():* {
			return _scrollbarShadowColor;
		}
		public function set scrollbarShadowColor(value:*):void{
			_scrollbarShadowColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarTrackColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarTrackColor():* {
			return _scrollbarTrackColor;
		}
		public function set scrollbarTrackColor(value:*):void{
			_scrollbarTrackColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarJoinColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarJoinColor():* {
			return _scrollbarJoinColor;
		}
		public function set scrollbarJoinColor(value:*):void{
			_scrollbarJoinColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarInactiveJoinColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarInactiveJoinColor():* {
			return _scrollbarInactiveJoinColor;
		}
		public function set scrollbarInactiveJoinColor(value:*):void{
			_scrollbarInactiveJoinColor = getColor(value);
			setRefresh();
		}
		
		private var _scrollbarInactiveTrackColor:* = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get scrollbarInactiveTrackColor():* {
			return _scrollbarInactiveTrackColor;
		}
		public function set scrollbarInactiveTrackColor(value:*):void{
			_scrollbarInactiveTrackColor = getColor(value);
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!displayed) {
				createUIObject(x, y);
				doStartEffect();
				manageMouseWheelEvent(MouseWheelEventOperation.ADD);
			}
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoMove);
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function initialize():void {
			getScrollText();
			switch(_scrollText) {
				case true :
					$horizontal ? $targetPath.scrollH = 0 : $targetPath.scrollV = 1;
					setThumbPosition();
					break;
				case false :
					$horizontal ? $thumbContainer.x = $minScroll + $thumbRect.height : $thumbContainer.y = $minScroll;
					if (!isNull($targetPath)) setContentPathPosition();
					break;
			}
		}
		
		/**
		 * @private
		 */
		override protected function getThumbLength():Number {
			if (isNull($targetPath) || _lockThumbSize) return _thumbWidth;
			var targetSize:Number;
			switch(_scrollText) {
				case false :
					targetSize = $horizontal ? $bounds.width : $bounds.height;
					break;
				case true :
					targetSize = $horizontal ? $targetPath.textWidth : $targetPath.textHeight;
					break;
			}
			var thumbSize:Number = Math.round(($maxScroll) * $length / targetSize);
			var minLength:Number = lookAndFeel.getMinLength();
			return (thumbSize < minLength) ? minLength : thumbSize;
		}
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			getBoundaries();
			getScrollbarActivation();
			if ($active) {
				drawScrollBar(States.OUT);
				setScrollAreaValues();
				lookAndFeel.drawThumb();
				getThumbBoundary();
				drawScrollTrack();
			} else {
				drawScrollBar(States.INACTIVE);
				lookAndFeel.drawThumb();
				getThumbBoundary();
				//lookAndFeel.drawUpButton()
				//lookAndFeel.drawUpButton();
			}
			setPositions();
			spas_internal::uioSprite.visible = getScrollbarVisibility();
			setEffects();
		}
		
		/**
		 * @private
		 */
		override protected function mouseWheelHandler(e:MouseEvent):void {
			if (!_scrollText) e.delta > 0 ?
				negativeThumbPosition(mouseWheelScrollSize) :
				positiveThumbPosition(mouseWheelScrollSize);
			dispatchScrollEvent(ScrollEvent.SCROLL);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _scrollText:Boolean;
		private var _isScrollBarVisible:Boolean;
		private var _origin:Point;
		private var _timer:Timer;
		private var _upBtnRect:Rectangle;
		private var _downBtnRect:Rectangle;
		private var _csDTO:ColorizableScrollbarDTO;
		
		private var _upButton:Sprite;
		private var _upButtonBackground:Sprite;
		private var _downButton:Sprite;
		private var _downButtonBackground:Sprite;
		private var _rightCorner:Sprite;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(targetPath:DisplayObject, length:Number, orientation:String, thickness:Number):void {
			$targetPath = targetPath;
			spas_internal::lafDTO.length = $length = length;
			$minScroll = $maxScroll = 0;
			_thickness = thickness;
			initLaf(ScrollBarUIRef);
			_timer = new Timer(200, 1);
			setThickness();
			getOrientation(orientation);
			$isScrollPressed = $hasOverOutHandler = false;
			_isScrollBarVisible = true;
			if (!isNull(targetPath)) _origin = new Point($targetPath.x, $targetPath.y);
			else _origin = new Point();
			getScrollText();
			createContainers();
			_csDTO = new ColorizableScrollbarDTO(this);
			spas_internal::lafDTO.scrollColors = _csDTO;
			spas_internal::lafDTO.state = States.OUT;
			spas_internal::lafDTO.getThumbLength = this.getThumbLength;
			spas_internal::pressedElement = ScrollBarElements.NONE;
			spas_internal::setSelector(Selectors.SCROLLBAR);
			spas_internal::isInitialized(1);
		}
		
		private function getScrollText():void {
			_scrollText = ($targetPath is TextField);
			if(_scrollText) $evtColl.addEvent($targetPath, Event.SCROLL, setOnTextScrollPosition);
		}
		
		private function setOnTextScrollPosition(e:Event):void {
			if($displayed) {
				if (this != spas_internal::currentScrollableObject)
					spas_internal::currentScrollableObject = this;
				setThumbPosition();
			}
		}
		
		private function createContainers():void {
			_rightCorner = new Sprite();
			spas_internal::lafDTO.rightCornerContainer = _rightCorner;
			spas_internal::uioSprite.addChild(_rightCorner);
			createTrack();
			createThumb();
			createScrollTrack();
			_upButtonBackground = new Sprite();
			spas_internal::lafDTO.upButtonBackground = _upButtonBackground;
			spas_internal::uioSprite.addChild(_upButtonBackground);
			_downButtonBackground = new Sprite();
			spas_internal::lafDTO.downButtonBackground = _downButtonBackground;
			spas_internal::uioSprite.addChild(_downButtonBackground);
			_upButton = new Sprite();
			spas_internal::lafDTO.upButtonContainer = _upButton;
			spas_internal::uioSprite.addChild(_upButton);
			_downButton = new Sprite();
			spas_internal::lafDTO.downButtonContainer = _downButton;
			spas_internal::uioSprite.addChild(_downButton);
			setButtonsBehaviour();
		}
		
		private function setButtonsBehaviour():void {
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_OVER, thumbOverHandler);
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_DOWN, thumbPressHandler);
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_OUT, scrolltrackOutHandler);
			$evtColl.addEvent($scrollTrack, MouseEvent.MOUSE_UP, thumbReleaseHandler);
			$evtColl.addEvent(_upButton, MouseEvent.MOUSE_OVER, upButtonOverHandler);
			$evtColl.addEvent(_upButton, MouseEvent.MOUSE_OUT, upButtonOutHandler);
			$evtColl.addEvent(_upButton, MouseEvent.MOUSE_DOWN, upButtonPressHandler);
			$evtColl.addEvent(_upButton, MouseEvent.MOUSE_UP, upButtonReleaseHandler);
			$evtColl.addEvent(_downButton, MouseEvent.MOUSE_OVER, downButtonOverHandler);
			$evtColl.addEvent(_downButton, MouseEvent.MOUSE_OUT, downButtonOutHandler);
			$evtColl.addEvent(_downButton, MouseEvent.MOUSE_DOWN, downButtonPressHandler);
			$evtColl.addEvent(_downButton, MouseEvent.MOUSE_UP, downButtonReleaseHandler);
		}
		
		private function thumbOverHandler(e:MouseEvent):void { 
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			if($thumbContainer.hitTestPoint(pt.x, pt.y, true)) {
				spas_internal::lafDTO.state = $isScrollPressed ? States.PRESSED : States.OVER;
				lookAndFeel.drawThumb()
			} else if(!$hasOverOutHandler) {
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = true;
			}
		}
		
		private function thumbReleaseHandler(e:MouseEvent):void {
			stopAutoMove();
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
				$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, scrolltrackMouseMoveHandler);
				$hasOverOutHandler = false;
				spas_internal::currentScrollableObject = this;
				var thumbMousePosition:Point = new Point($thumbContainer.mouseX, $thumbContainer.mouseY);
				$thumbMouseOffset = $horizontal ? _downBtnRect.height-thumbMousePosition.y : thumbMousePosition.y;
				spas_internal::lafDTO.state = States.PRESSED;
				lookAndFeel.drawThumb();
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, thumbMouseMoveHandler);
				$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, thumbMouseUpHandler);
			} else {
				spas_internal::pressedElement = ScrollBarElements.TRACK;
				if($allowTrackClick) {
					pt = new Point($scrollTrack.mouseX, $scrollTrack.mouseY);
					switch($horizontal) {
						case false :
							pt.y < $thumbContainer.y ? trackMoveUp() : trackMoveDown();
							break;
						case true :
							pt.x < $thumbContainer.x ?  trackMoveUp() : trackMoveDown();
							break;
					}
					startAutoMove();
				}
			}
		}
		
		private function thumbMouseMoveHandler(e:MouseEvent):void {
			$mouseTracker = $scrollTrack.globalToLocal(new Point(e.stageX, e.stageY));
			scrollTrackOnMouseMove();
			if(!isNull($targetPath)) !_scrollText ? setContentPathPosition() : setTextPosition();
			//_value = horizontal ? (_thumbContainer.x-minScroll-thumbRect.height)/(_length-thumbRect.height-2*minScroll) : (_thumbContainer.y-minScroll)/(maxScroll-thumbRect.height);
			getValue();
			if ($active && $enabled) dispatchScrollEvent(ScrollEvent.SCROLL);
			if (isNull($targetPath)) e.updateAfterEvent();
		}
		
		private function getValue():void {
			var trh:Number = $thumbRect.height;
			var pos:Number = $horizontal ?
				($thumbContainer.x - $minScroll - trh) / ($length - trh - 2 * $minScroll) :
				($thumbContainer.y - $minScroll) / ($maxScroll - trh);
			var result:Number = ($maximum - $minimum) * pos + $minimum;
			$value = $decimalMode ? result : Math.round(result);
		}
		
		private function thumbMouseUpHandler(e:MouseEvent):void {
			//if ($elasticMode) setThumbPosition();
			spas_internal::pressedElement = ScrollBarElements.NONE;
			$isScrollPressed = false;
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			spas_internal::lafDTO.state = $thumbContainer.hitTestPoint(pt.x, pt.y, true) ? States.OVER : States.OUT;
			lookAndFeel.drawThumb();
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, thumbMouseMoveHandler);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, thumbMouseUpHandler);
			/*$value = $horizontal ?
				($thumbContainer.x - $minScroll - $thumbRect.height) / ($length - $thumbRect.height - 2 * $minScroll) :
				($thumbContainer.y - $minScroll) / ($maxScroll - $thumbRect.height);*/
			getValue();
			if($active && $enabled) dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
		}
		
		private function scrolltrackMouseMoveHandler(e:MouseEvent):void {
			var pt:Point = getStageDelay(e.stageX, e.stageY);
			spas_internal::lafDTO.state = $thumbContainer.hitTestPoint(pt.x, pt.y, true) ?
				States.OVER : States.OUT;
			lookAndFeel.drawThumb();
		}
		
		private function upButtonOverHandler(e:MouseEvent):void {
			if (!$isScrollPressed && $active) {
				spas_internal::lafDTO.state = States.OVER;
				lookAndFeel.drawUpButton();
			}
		}
		
		private function upButtonOutHandler(e:MouseEvent):void {
			if (!$isScrollPressed && $active) {
				spas_internal::lafDTO.state = States.OUT;
				lookAndFeel.drawUpButton();
			}
		}
		
		private function upButtonPressHandler(e:MouseEvent):void {
			spas_internal::pressedElement = ScrollBarElements.UP_BUTTON;
			setCurrentScrollable(this);
			if ($active) {
				spas_internal::lafDTO.state = States.PRESSED;
				moveUp();
				lookAndFeel.drawUpButton();
				startAutoMove();
				addReleaseOutsideHandler();
			}
		}
		
		private function upButtonReleaseHandler(e:MouseEvent):void {
			if ($active) {
				spas_internal::lafDTO.state = States.OVER;
				lookAndFeel.drawUpButton();
				stopAutoMove();
				dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
			}
		}
		
		private function downButtonOverHandler(e:MouseEvent):void {
			if (!$isScrollPressed && $active) {
				spas_internal::lafDTO.state = States.OVER;
				lookAndFeel.drawDownButton();
			}
		}
		
		private function downButtonOutHandler(e:MouseEvent):void {
			if (!$isScrollPressed && $active) {
				spas_internal::lafDTO.state = States.OUT;
				lookAndFeel.drawDownButton();
			}
		}
		
		private function downButtonPressHandler(e:MouseEvent):void {
			spas_internal::pressedElement = ScrollBarElements.DOWN_BUTTON;
			setCurrentScrollable(this);
			if ($active) {
				spas_internal::lafDTO.state = States.PRESSED;
				moveDown();
				lookAndFeel.drawDownButton();
				startAutoMove();
				addReleaseOutsideHandler();
			}
		}
		
		private function downButtonReleaseHandler(e:MouseEvent):void {
			if ($active) {
				spas_internal::lafDTO.state = States.OVER;
				lookAndFeel.drawDownButton();
				stopAutoMove();
				dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
			}
		}
		
		private function addReleaseOutsideHandler():void {
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, onButtonsReleaseOutside);
			dispatchScrollEvent(ScrollEvent.STOP_SCROLL);
		}
		
		private function onButtonsReleaseOutside(e:MouseEvent):void {
			stopAutoMove();
		}
		
		private function moveUp():void {
			switch(_scrollText) {
				case true :
					negativeTextPosition(pageScrollSize);
					break;
				case false :
					negativeThumbPosition(pageScrollSize);
					break;
			}
		}
		
		private function moveDown():void {
			switch(_scrollText) {
				case true :
					positiveTextPosition(pageScrollSize);
					break;
				case false :
					positiveThumbPosition(pageScrollSize);
					break;
			}
		}
		
		private function trackMoveUp():void {
			switch($horizontal) {
				case false :
					_scrollText ? 	negativeTextPosition(trackScrollSize) :
									negativeThumbPosition(trackScrollSize);
					break;
				case true :
					_scrollText ? 	negativeTextPosition(trackScrollSize) :
									negativeThumbPosition(trackScrollSize);
					break;
			}
		}
		
		private function trackMoveDown():void {
			switch($horizontal) {
				case false :
					_scrollText ? 	positiveTextPosition(trackScrollSize) :
									positiveThumbPosition(trackScrollSize);
					break;
				case true :
					_scrollText ? 	positiveTextPosition(trackScrollSize) :
									positiveThumbPosition(trackScrollSize);
					break;
			}
		}
		
		private function positiveTextPosition(factor:Number):void {
			$currentButtonType = ScrollableButtonType.DOWN;
			var value:Number = factor*getblockIncrement();
			if (!$horizontal) {
				if ($targetPath.scrollV < $targetPath.maxScrollV) $targetPath.scrollV += value;
			} else {
				if ($targetPath.scrollH < $targetPath.maxScrollH ) $targetPath.scrollH += value;
			}
			setThumbPosition();
		}
		
		private function negativeTextPosition(factor:Number):void {
			$currentButtonType = ScrollableButtonType.UP;
			var value:Number = factor*getblockIncrement();
			if (!$horizontal) {
				if ($targetPath.scrollV > 1) $targetPath.scrollV -= value;
			} else {
				if ($targetPath.scrollH > 0) $targetPath.scrollH -= value;
			}
			setThumbPosition();
		}
		
		private function positiveThumbPosition(factor:Number):void {
			$currentButtonType = ScrollableButtonType.DOWN;
			if(!$useIncremental) {
				var value:Number =
					getblockIncrement() * ($maxScroll - getThumbLength()) / $length * factor;
				switch($horizontal) { 
					case false :
						if ($thumbContainer.y + $thumbRect.height + value-$minScroll < $maxScroll)
							$thumbContainer.y += value;
						else $thumbContainer.y = $maxScroll + $minScroll - $thumbRect.height;
						break;
					case true :
						if ($thumbContainer.x + value-$minScroll < $maxScroll)
							$thumbContainer.x += value;
						else $thumbContainer.x = $maxScroll + $minScroll;
						break;
				}
				if (!isNull($targetPath)) setContentPathPosition();
				else getValue();
			}else {
				var nextVal:Number = $value + getblockIncrement();
				$value = nextVal <= $maximum ? nextVal : $maximum;
				setThumbPosition();
				//if (!isNull($targetPath)) setContentPathPosition();
			}
			dispatchScrollEvent(ScrollEvent.SCROLL);
		}
		
		private	function negativeThumbPosition(factor:Number):void {
			$currentButtonType = ScrollableButtonType.UP;
			if(!$useIncremental) {
				var value:Number =
					getblockIncrement() * ($maxScroll - getThumbLength()) / $length * factor;
				switch($horizontal) { 
					case false :
						if($thumbContainer.y-value > $minScroll) $thumbContainer.y -= value;
						else $thumbContainer.y = $minScroll;
						break;
					case true :
						if ($thumbContainer.x - $thumbRect.height - value > $minScroll) $thumbContainer.x -= value;
						else $thumbContainer.x = $minScroll + $thumbRect.height;
						break;
				}
				if (!isNull($targetPath)) setContentPathPosition();
				else getValue();
			} else {
				var prevVal:Number = $value - getblockIncrement();
				$value = prevVal >= $minimum ? prevVal : $minimum;
				setThumbPosition();
				//if (!isNull($targetPath)) setContentPathPosition();
			}
			dispatchScrollEvent(ScrollEvent.SCROLL);
		}
		
		private function setAutoMove(e:TimerEvent):void {
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoMove);
			$evtColl.addEvent(_timer, TimerEvent.TIMER, setDelayedMove);
			_timer.repeatCount = 0, _timer.delay = 10;
			_timer.start();
		}
		
		private function setDelayedMove(e:TimerEvent):void {
			switch($currentButtonType) {
				case ScrollableButtonType.UP :
					spas_internal::pressedElement == ScrollBarElements.TRACK ?
					trackMoveUp() : moveUp();
					break;
				case ScrollableButtonType.DOWN :
					spas_internal::pressedElement == ScrollBarElements.TRACK ?
					trackMoveDown() : moveDown();
					break;
			}
		}
		
		private function startAutoMove():void {
			$evtColl.addEvent(_timer, TimerEvent.TIMER, setAutoMove);
			_timer.start();
		}
		
		private function stopAutoMove():void {
			spas_internal::pressedElement = ScrollBarElements.NONE;
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoMove);
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setDelayedMove);
			_timer.repeatCount = 1, _timer.delay = 200;
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, onButtonsReleaseOutside);
		}
		
		private function setContentPathPosition():void {
			var nextValue:Number;
			switch($horizontal) {
				case false :
					nextValue =
						_origin.y - ($bounds.height - $length) * ($thumbContainer.y - $minScroll) / ($maxScroll - $thumbRect.height);
					if (!enableTargetScroll) return;
					if (pageScrollSize <= 1 || $thumbContainer.y == $minScroll ||
						$thumbContainer.y == $maxScroll + $minScroll - $thumbRect.height) {
						$targetPath.y = nextValue;
					}
					else if (Math.abs($targetPath.y - nextValue) >= pageScrollSize)
						$targetPath.y = nextValue;
					break;
				case true :
					nextValue =
						_origin.x - ($bounds.width - $length) * ($thumbContainer.x - $thumbRect.height - $minScroll) / ($maxScroll - $thumbRect.height);
					if (!enableTargetScroll) return;
					if (pageScrollSize <= 1 || $thumbContainer.x == $maxScroll + $minScroll
						|| $thumbContainer.x == $minScroll + $thumbRect.height) {
							$targetPath.x = nextValue;
						}
					else if (Math.abs($targetPath.x - nextValue) >= pageScrollSize)
						$targetPath.x = nextValue;
					break;
			}
		}
		
		private function setTextPosition():void {
			switch($horizontal) {
				case false :
					$targetPath.scrollV = 
						($thumbContainer.y - $minScroll) / ($maxScroll - $thumbRect.height) * ($targetPath.maxScrollV) + 1;
					break;
				case true :
					$targetPath.scrollH =
						($thumbContainer.x - $minScroll - $thumbRect.height) / ($maxScroll - $thumbRect.height) * $targetPath.maxScrollH;
					break;
			}
		}
		
		private function getButtonsBoundary():void {
			_upBtnRect = _showUpButton ?
				_upButton.getBounds(_upButton) : new Rectangle(0, 0, 0, 0);
			_downBtnRect = _showDownButton ?
				_downButton.getBounds(_downButton) : new Rectangle(0, 0, 0, 0);
		}
		
		private function getThumbBoundary():void {
			$thumbRect = $thumbContainer.getBounds($thumbContainer);
		}
		
		private function setScrollBarPositions():void {
			switch($horizontal) {
				case false :
					_downButton.y = _downButtonBackground.y =
						$length - _downBtnRect.height;
					_rightCorner.y = $length;
					break;
				case true :
					var t:Number = this.thickness;
					$thumbContainer.rotation = $track.rotation = 90;
					_upButtonBackground.rotation = _upButton.rotation =
					_downButtonBackground.rotation = _downButton.rotation =
					_rightCorner.rotation = -90;
					_upButtonBackground.y = _upButton.y = _downButtonBackground.y =
						_downButton.y = _rightCorner.y = t;
					$track.x = $length; _downButtonBackground.x = _downButton.x =
						$length - _downBtnRect.height;
					_rightCorner.x = $length;
					break;
			}
		}
		
		private function scrollTrackOnMouseMove():void {
			//if(!_liveDragging || _elasticMode) var value:Number = getblockIncrement() * (maxScroll - getThumbLength()) / _length * pageScrollSize;
			var value:Number =
				getblockIncrement() * ($maxScroll - getThumbLength()) / $length * pageScrollSize;
			switch($horizontal) {
				case false :
					if($mouseTracker.y-$thumbMouseOffset <= $minScroll) $thumbContainer.y = $minScroll;
					else if ($mouseTracker.y - $thumbMouseOffset + $thumbRect.height - $minScroll >= $maxScroll)
						$thumbContainer.y = $maxScroll+$minScroll-$thumbRect.height;
					else if (pageScrollSize <= 1 || $liveDragging)
						$thumbContainer.y = $mouseTracker.y-$thumbMouseOffset;
					else {
						if (($mouseTracker.y - $thumbMouseOffset) % value <= 1)
							$thumbContainer.y = $mouseTracker.y - $thumbMouseOffset;
					}
					break;
				case true :
					if ($mouseTracker.x - $thumbMouseOffset - $thumbRect.height <= 0)
						$thumbContainer.x = $thumbRect.height+$minScroll;
					else if ($mouseTracker.x - $thumbMouseOffset >= $maxScroll)
						$thumbContainer.x = $maxScroll+$minScroll;
					else if (pageScrollSize <= 1 || $liveDragging)
						$thumbContainer.x = $mouseTracker.x-$thumbMouseOffset+$minScroll;
					else {
						if (($mouseTracker.x - $thumbMouseOffset) % value <= 1)
							$thumbContainer.x =  $mouseTracker.x - $thumbMouseOffset + $minScroll;
						}
					break;
			}
		}
		
		private function setThumbPosition():void {
			var n:Number;
			if(_scrollText) {
				switch($horizontal) {
					case false :
						$thumbContainer.y =
							$minScroll + ($maxScroll - $thumbRect.height) * ($targetPath.scrollV - 1) / ($targetPath.maxScrollV - 1);
						break;
					case true :
						$thumbContainer.x =
							$minScroll + ($maxScroll - $thumbRect.height) * ($targetPath.scrollH) / ($targetPath.maxScrollH ) + $thumbRect.height;
						break;
				}
			} else if (!isNull($targetPath)) {
				n = $maxScroll - $thumbRect.height;
				switch($horizontal) {
					case false :
						$thumbContainer.y =
							Math.floor((_origin.y - $targetPath.y) / ($bounds.height - $length) * n) + _upBtnRect.height;
						break;
					case true :
						$thumbContainer.x =
							Math.floor((_origin.x - $targetPath.x) / ($bounds.width - $length) * n) + $thumbRect.height + _upBtnRect.height;
						break;
				}
			} else {
				// TODO this behavior for incremental and non incremental modes
				//n = ($maxScroll - $thumbRect.height) * $value ;
				n = ($maxScroll - $thumbRect.height) * $value / ($maximum - $minimum);
				switch($horizontal) {
					case false :
						$thumbContainer.y = n + _upBtnRect.height;
						break;
					case true :
						$thumbContainer.x = n + $thumbRect.height + _upBtnRect.height;
						break;
				}
			}
		}
		
		private function drawScrollBar(value:String):void {
			spas_internal::lafDTO.state = value;
			lookAndFeel.drawTrack();
			lookAndFeel.drawUpButton();
			lookAndFeel.drawDownButton();
			getButtonsBoundary();
			setScrollBarPositions();
		}
		
		private function drawScrollTrack():void {
			var s:Figure = Figure.setFigure($scrollTrack);
			var w:Number = isNaN(_thickness) ? lookAndFeel.getScrollBarWidth() : _thickness;
			s.clear();
			s.beginFill(0, 0);
			$horizontal ? 	s.drawRectangle(_upBtnRect.height, 0, $length - _downBtnRect.height, w) :
							s.drawRectangle(0, _upBtnRect.height, w, $length-_downBtnRect.height);
			s.endFill();
		}
		
		private function setScrollAreaValues():void {
			$minScroll = _upBtnRect.height;
			$maxScroll = $length - _upBtnRect.height - _downBtnRect.height;
			//--> First call to the setScrollAreaValues() method:
			if(isNull($targetPath) && !isNull($thumbRect)) {
				if ($horizontal) {
					if ($thumbContainer.x - $thumbRect.height - value < $minScroll)
						$thumbContainer.x = $minScroll + $thumbRect.height;
				} else {
					if ($thumbContainer.y < $minScroll) $thumbContainer.y = $minScroll;
				}
			}
		}
		
		private function getScrollbarActivation():void {
			if (isNull($targetPath)) {
				switch(_scrollTargetPolicy) {
					case ScrollTargetPolicy.ENABLE_IF_NULL :
						spas_internal::lafDTO.active = $active = true;
						break;
					case ScrollTargetPolicy.DISABLE_IF_NULL :
						spas_internal::lafDTO.active = $active = false;
						break;
				}
				return;
			}
			switch (_scrollText) {
				case true :
					if($horizontal) $active = !($targetPath.textWidth < $bounds.width && $targetPath.scrollH==0);
					else $active = !($targetPath.textHeight < $bounds.height && $targetPath.maxScrollV == 1);
					break;
				case false :
					$active = $horizontal ? ($bounds.width > $length) : ($bounds.height > $length);
					break;
			}
			spas_internal::lafDTO.active = $active;
		}
		
		private function getScrollbarVisibility():Boolean {
			switch($horizontal) {
				case true :
					_isScrollBarVisible =
						($length >= _upBtnRect.width + _downBtnRect.width + $thumbRect.width) ?
						true : false;
					break;
				case false :
					_isScrollBarVisible =
						($length >= _upBtnRect.height + _downBtnRect.height + $thumbRect.height) ?
						true : false;
					break;
			}
			return _isScrollBarVisible;
		}
		
		private function setPositions():void {
			if (isNull($targetPath)) {
				setThumbPosition();
				return;
			}
			var newPosition:Point =
				new Point($bounds.width-$length+$targetPath.x-_origin.x, $bounds.height-$length+$targetPath.y-_origin.y);
			switch($horizontal) {
				case false :
					if(newPosition.y < 0 && $targetPath.y < _origin.y) $targetPath.y -= newPosition.y;
					else if($targetPath.y >= _origin.y) $targetPath.y = _origin.y;
					if($bounds.height <= $length) $targetPath.y = _origin.y;
					break;
				case true :
					if (newPosition.x < 0 && $targetPath.x < _origin.x) $targetPath.x -= newPosition.x;
					else if ($targetPath.x >= _origin.x) $targetPath.x = _origin.x;
					if ($bounds.width <= $length) $targetPath.x = _origin.x;
					break;
			}
			setThumbPosition();
		}
		
		private function setThickness():void {
			spas_internal::lafDTO.thickness = isNaN(_thickness) ?
				lookAndFeel.getScrollBarWidth() : _thickness;
		}
		
		private function updateThumbPos(v:Number):void {
			var trh:Number = $thumbRect.height;
			$horizontal ?
				$thumbContainer.x = v * ($length - trh - 2 * $minScroll) + $minScroll + trh :
				$thumbContainer.y = v * ($maxScroll - trh) + $minScroll;
		}
		
	}
}