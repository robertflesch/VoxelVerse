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

package org.flashapi.swing.scroll {
	
	// -----------------------------------------------------------
	// Scrollable.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.1.3, 23/02/2011 23:10
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.BoxHelp;
	import org.flashapi.swing.constants.MouseWheelEventOperation;
	import org.flashapi.swing.constants.ScrollableOrientation;
	import org.flashapi.swing.constants.ScrollBarElements;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.util.ArrayList;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 *  The <code>Scrollable</code> class is the base class for all control 
	 * 	objects that enable scrolling operations.
	 * 
	 * <p><strong><code>Scrollable</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">orientation</code></td>
	 * 			<td>Sets the object orientation.</td>
	 * 			<td>Valid values are <code class="css">horizontal</code> and
	 * 			<code class="css">vertical</code></td>
	 * 			<td><code>orientation</code></td>
	 * 			<td>Properties.ORIENTATION</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Scrollable extends UIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>Scrollable</code> instance.
		 */
		public function Scrollable() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the mouse wheel unit increment for this <code>Scrollable</code>
		 * 	object. The mouse wheel unit increment is the value that is added or
		 * 	<code>Scrollable</code> only when the user activates the block increment area of the
		 * 	Scrollable object, by using the mouse wheel.
		 * 	<p>The mouse wheel scroll size must be greater than zero.</p>
		 * 
		 * 	@default 3
		 */
		public var mouseWheelScrollSize:Number = 3;
		
		/**
		 * 	Sets or gets the page scroll unit increment for this <code>Scrollable</code>
		 * 	object. The page scroll unit increment is the value that is added
		 * 	or subtracted only when the user activates the block increment area of
		 * 	the <code>Scrollable</code> object, by using the <span class="hide">scroll
		 * 	thumb or the</span> buttons.
		 * 	<p>The page scroll size must be greater than zero. </p>
		 * 
		 * 	@default 1
		 */
		public var pageScrollSize:Number = 1;
		
		/**
		 * 	Sets or gets the track scroll unit increment for this <code>Scrollable</code>
		 * 	object. The track scroll unit increment is the value that is added or
		 * 	subtracted only when the user activates the block increment area of the
		 * 	<code>Scrollable</code> object, by clicking on the scroll track.
		 * 	<p>The track scroll size must be greater than zero.</p>
		 * 
		 * 	@default 25
		 */
		public var trackScrollSize:Number = 25;
		
		/**
		 * 	@default true
		 */
		public var enableTargetScroll:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>allowTrackClick</code> property.
		 * 
		 * 	@see #allowTrackClick
		 */
		protected var $allowTrackClick:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether clicking on the 
		 * 	<code>Scrollable</code> track will move the thumb (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 	
		 * 	@default true
		 */
		public function get allowTrackClick():Boolean {
			return $allowTrackClick;
		}
		public function set allowTrackClick(value:Boolean):void {
			$allowTrackClick = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>blockIncrement</code> property.
		 * 
		 * 	@see #blockIncrement
		 */
		protected var $blockIncrement:Number = 1;
		/**
		 * 	Sets or gets the block increment value for this <code>Scrollable</code> object.
		 * 
		 * 	<p>The block increment represents the number that is added or subtracted to the
		 * 	<code>value</code> of the <code>Scrollable</code> object, if the <code>useIncremental</code>
		 * 	property is <code>true</code>.  If <code>useIncremental</code> is <code>false</code>
		 * 	(default), the added or subtracted value is computed by the <code>Scrollable</code> object
		 * 	according to the scrollable area and content metrincs. The user activates the block
		 * 	increment through a mouse or keyboard gesture received as an adjustment event.</p>
		 * 
		 * 	<p>The block increment must be greater than zero.</p>
		 * 
		 * 	@default 1
		 * 
		 * 	@see #useIncremental
		 */
		public function get blockIncrement():Number {
			return $blockIncrement;
		}
		public function set blockIncrement(value:Number):void {
			$blockIncrement = value;
		}
		
		/*
		protected var $elasticMode:Boolean = true;
		public function get elasticMode():Boolean {
			return $elasticMode;
		}
		public function set elasticMode(value:Boolean):void {
			$elasticMode = value;
		}*/
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>length</code> property.
		 * 
		 * 	@see #length
		 */
		protected var $length:Number;
		/**
		 *  Sets or gets the length of the <code>Scrollable</code> object.
		 */
		public function get length():Number {
			return $length;
		}
		public function set length(value:Number):void {
			spas_internal::lafDTO.length = $length = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>liveDragging</code> property.
		 * 
		 * 	@see #liveDragging
		 */
		protected var $liveDragging:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the thumb button
		 * 	can be dragged freely on the <code>Scrollable</code> area (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get liveDragging():Boolean {
			return $liveDragging;
		}
		public function set liveDragging(value:Boolean):void {
			$liveDragging = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>maximum</code> property.
		 * 
		 * 	@see #maximum
		 */
		protected var $maximum:Number;
		/**
		 * 	A <code>Number</code> that represents the maximum available value for the
		 * 	<code>Scrollable</code> object.
		 * 
		 * 	@see #minimum
		 */
		public function get maximum():Number {
			return $maximum;
		}
		public function set maximum(value:Number):void {
			$maximum = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>maxScrollPosition</code> property.
		 * 
		 * 	@see #maxScrollPosition
		 */
		protected var $maxScrollPosition:Number;
		/**
		 * 	A <code>Number</code> that represents the maximum scroll position of
		 * 	the <code>Scrollable</code> object.
		 * 
		 * 	@see #minScrollPosition
		 */
		public function get maxScrollPosition():Number {
			return $maxScrollPosition;
		}
		public function set maxScrollPosition(value:Number):void {
			$maxScrollPosition = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>minimum</code> property.
		 * 
		 * 	@see #minimum
		 */
		protected var $minimum:Number;
		/**
		 * 	A <code>Number</code> that represents the minimum available value for the
		 * 	<code>Scrollable</code> object.
		 * 
		 * 	@see #maximum
		 */
		public function get minimum():Number {
			return $minimum;
		}
		public function set minimum(value:Number):void {
			$minimum = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>minScrollPosition</code> property.
		 * 
		 * 	@see #minScrollPosition
		 */
		protected var $minScrollPosition:Number;
		/**
		 * 	A <code>Number</code> that represents the minimum scroll position of
		 * 	the <code>Scrollable</code> object.
		 * 
		 * 	@see #maxScrollPosition
		 */
		public function get minScrollPosition():Number {
			return $minScrollPosition;
		}
		public function set minScrollPosition(value:Number):void {
			$minScrollPosition = value;
		}
		
		/**
		 *  @private
		 */
		protected var $horizontal:Boolean;
		/**
		 * 	Sets or gets the current orientation of the <code>Scrollable</code> object.
		 * 	Posible values are <code>ScrollableOrientation.HORIZONTAL</code> or 
		 * 	<code>ScrollableOrientation.VERTICAL</code>.
		 */
		public function get orientation():String {
			return $horizontal ? ScrollableOrientation.HORIZONTAL : ScrollableOrientation.VERTICAL;
		}
		public function set orientation(value:String):void {
			getOrientation(value);
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>percentValue</code> property.
		 * 
		 * 	@see #percentValue
		 */
		protected var $percentValue:Number = 0;
		/**
		 * 	Gets or sets the current value of this <code>Scrollable</code> object,
		 * 	in percentage.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #value
		 */
		public function get percentValue():Number {
			return $percentValue;
		}
		public function set percentValue(value:Number):void {
			$percentValue = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>scrollPosition</code> property.
		 * 
		 * 	@see #scrollPosition
		 */
		protected var $scrollPosition:Number;
		/**
		 * 	A <code>Number</code> that represents the current scroll position of this
		 * 	<code>Scrollable</code> object. The value is between <code>minScrollPosition</code>
		 * 	and <code>maxScrollPosition</code> inclusively. 
		 * 	
		 * 	@see #minScrollPosition
		 * 	@see #maxScrollPosition
		 */
		public function get scrollPosition():Number {
			return $scrollPosition;
		}
		public function set scrollPosition(value:Number):void {
			$scrollPosition = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>showDataTip</code> property.
		 * 
		 * 	@see #showDataTip
		 */
		protected var $showDataTip:Boolean = false;
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>Scrollable</code> object
		 * 	shows a data tip, containing the current value of the slider,  during user
		 * 	interaction (<code>true</code>),  or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #value
		 */
		public function get showDataTip():Boolean {
			return $showDataTip;
		}
		public function set showDataTip(value:Boolean):void {
			$showDataTip = value;
			if (value && isNull($boxhelp)) $boxhelp = new BoxHelp("", 0);
			else if (!value && !isNull($boxhelp)) {
				$boxhelp.finalize();
				$boxhelp = null;
			}
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>value</code> property.
		 * 
		 * 	@see #value
		 */
		protected var $value:Number = 0;
		/**
		 * 	Gets or sets the current value of this <code>Scrollable</code> object.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #percentValue
		 */
		public function get value():Number {
			return $value;
		}
		public function set value(value:Number):void {
			$value = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>targetPath</code> property.
		 * 
		 * 	@see #targetPath
		 */
		protected var $targetPath:*;
		/**
		 * 	Gets or sets the <code>DisplayObject</code> instance that will be affected
		 * 	by scrolling actions on the <code>Scrollable</code> object.
		 */
		public function get targetPath():DisplayObject {
			return $targetPath;
		}
		public function set targetPath(value:DisplayObject):void {
			$targetPath = value;
			if (displayed) {
				initialize();
				refresh();
			}
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>useIncremental</code> property.
		 * 
		 * 	@see #useIncremental
		 */
		protected var $useIncremental:Boolean = false;
		/**
		 * 
		 * 	@default false
		 * 
		 *	@see #blockIncrement
		 */
		public function get useIncremental():Boolean {
			return $useIncremental;
		}
		public function set useIncremental(value:Boolean):void {
			$useIncremental = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>decimalMode</code> property.
		 * 
		 * 	@see #decimalMode
		 */
		protected var $decimalMode:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>value</code>
		 * 	property must be an integer (<code>false</code>), or a decimal value
		 * 	(<code>true</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #value
		 */
		public function get decimalMode():Boolean {
			return $decimalMode;
		}
		public function set decimalMode(value:Boolean):void {
			$decimalMode = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if ($displayed) {
				unload();
				manageMouseWheelEvent(MouseWheelEventOperation.REMOVE);
			}
		}
		
		/**
		 * @private
		 */
		override public function finalize():void {
			if (!isNull($boxhelp)) {
				$boxhelp.finalize();
				$boxhelp = null;
			}
			if (spas_internal::currentScrollableObject == this)
				spas_internal::currentScrollableObject = null;
			super.finalize();
			$targetPath = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>BoxHelp</code> instance which
		 * 	displays values when the <code>showDataTip</code> property is
		 * 	<code>true</code>.
		 * 
		 * 	@see #showDataTip
		 */
		protected var $boxhelp:BoxHelp;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal <code>Boolean</code> value that indicates whether an
		 * 	element within this <code>Scrollable</code> object is currently pressed
		 * 	(<code>true</code>), or not <code>false</code>.
		 */
		protected var $isScrollPressed:Boolean;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the <code>Scrollable</code>
		 * 	object has a mousewheel event listener registered (<code>true</code>), or
		 * 	not <code>false</code>.
		 */
		protected var $hasOverOutHandler:Boolean;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A convenient value to indicate the minimum position of the scrollable area
		 * 	within this <code>Scrollable</code> object.
		 * 
		 * 	@see #$maxScroll
		 */
		protected var $minScroll:Number ;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A convenient value to indicate the maximum position of the scrollable area
		 * 	within this <code>Scrollable</code> object.
		 * 
		 * 	@see #$minScroll
		 */
		protected var $maxScroll:Number;
			
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal <code>Sprite</code> object used to define the
		 * 	track hit area of this <code>Scrollable</code> object.
		 */
		protected var $scrollTrack:Sprite;
		
		/**
		 *  @private
		 */
		protected var $currentButtonType:String;
		
		/**
		 * 	A <code>Rectangle</code> object that is used to store an internal reference
		 * 	to the <code>$targetPath</code> bounds.
		 * 
		 * 	@see #$targetPath
		 */
		protected var $bounds:Rectangle;
		
		/**
		 * 	A <code>Rectangle</code> object that defines the bounds of the 
		 * 	<code>$thumbContainer</code> object.
		 * 
		 * 	@see #$mouseTracker
		 * 	@see #$thumbMouseOffset
		 * 	@see #$thumbContainer
		 */
		protected var $thumbRect:Rectangle;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Represents the offset between of the mouse position and the thumb button
		 * 	position within this <code>Scrollable</code> object.
		 * 
		 * 	@see #$mouseTracker
		 * 	@see #$thumbRect
		 */
		protected var $thumbMouseOffset:Number;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A convenient <code>Point</code> object to store the position of the mouse
		 * 	within this <code>Scrollable</code> object, relative to the stage.
		 * 
		 * 	@see #$thumbMouseOffset
		 * 	@see #$thumbRect
		 */
		protected var $mouseTracker:Point;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal <code>Sprite</code> object used to hold and draw the
		 * 	thumb button of this <code>Scrollable</code> object.
		 */
		protected var $thumbContainer:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal <code>Sprite</code> object used to hold and draw the
		 * 	track of this <code>Scrollable</code> object.
		 */
		protected var $track:Sprite;
		
		/**
		 *  @private
		 */
		spas_internal static var currentScrollableObject:Scrollable;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function createTrack():void {
			$track = new Sprite();
			spas_internal::lafDTO.track = $track;
			spas_internal::uioSprite.addChild($track);
		}
		
		/**
		 *  @private
		 */
		protected function createScrollTrack():void {
			$scrollTrack = new Sprite();
			spas_internal::uioSprite.addChild($scrollTrack);
		}
		
		/**
		 *  @private
		 */
		protected function createThumb():void {
			$thumbContainer = new Sprite();
			spas_internal::lafDTO.thumb = $thumbContainer;
			spas_internal::uioSprite.addChild($thumbContainer);
		}
		
		/**
		 *  @private
		 */
		protected function getOrientation(value:String):void {
			switch(value){
				case ScrollableOrientation.VERTICAL :
					$horizontal = false;
					break;
				case ScrollableOrientation.HORIZONTAL :
					$horizontal = true;
					break;
			}
			spas_internal::lafDTO.orientation = value;
		}
		
		/**
		 *  @private
		 */
		protected function initialize():void {}
		
		/**
		 *  @private
		 */
		protected static function setCurrentScrollable(scrollObj:Scrollable):void {
			spas_internal::currentScrollableObject = scrollObj;
			scrollObj.dispatchEvent(new ScrollEvent(ScrollEvent.SCROLLABLE_CHANGED));
		}
		
		/**
		 *  @private
		 */
		protected function manageMouseWheelEvent(action:String):void {
			var addNewListener:Boolean = (_scrollableStack.size == 0);
			switch(action) {
				case MouseWheelEventOperation.ADD :
					setCurrentScrollable(this);
					_scrollableStack.add(this);
					if (addNewListener)
						$evtColl.addEvent($stage, MouseEvent.MOUSE_WHEEL, scrollableMouseWheelHandler);
					break;
				case MouseWheelEventOperation.REMOVE :
					_scrollableStack.remove(this);
					if (_scrollableStack.size > 0) {
						var scrollObj:Scrollable =
							_scrollableStack.get(_scrollableStack.size-1) as Scrollable;
						setCurrentScrollable(scrollObj);
					} else $evtColl.removeEvent($stage, MouseEvent.MOUSE_WHEEL, scrollableMouseWheelHandler);
					break;
				
			}
		}
		
		/**
		 *  @private
		 */
		protected function getBoundaries():void {
			if (!isNull($targetPath)) {
				var rect:Rectangle = $targetPath.getBounds($targetPath);
				$bounds = new Rectangle(0, 0, rect.width + rect.x, rect.height + rect.y);
			} else $bounds = new Rectangle();
		}
		
		/**
		 *  @private
		 */
		protected function scrollableMouseWheelHandler(e:MouseEvent): void {
			if (spas_internal::currentScrollableObject.active)
				spas_internal::currentScrollableObject.mouseWheelHandler(e);
		}
		
		/**
		 *  @private
		 */
		protected function mouseWheelHandler(e:MouseEvent):void {}
		
		/**
		 *  @private
		 */
		protected function getblockIncrement():Number {
			return (spas_internal::pressedElement == ScrollBarElements.TRACK) ? 1 : $blockIncrement;
		}
		
		/**
		 *  @private
		 */
		protected function getThumbLength():Number {
			return lookAndFeel.MINIMAL_LENGTH;
		}
		
		/**
		 *  @private
		 */
		protected function getStageDelay(x:Number, y:Number):Point {
			return new Point(x - $stage.x, y - $stage.y);
		}
		
		/**
		 *  @private
		 */
		protected function dispatchScrollEvent(type:String):void {
			dispatchEvent(new ScrollEvent(type));
		}
		
		/**
		 *  @private
		 */
		spas_internal static function changeCurrentScrollable(scrollObj:Scrollable):void {
			setCurrentScrollable(scrollObj);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private static var _scrollableStack:ArrayList = new ArrayList();
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::lafDTO.active = $active = false;
			$minimum = 0;
			$maximum = 1;
		}
	}
}