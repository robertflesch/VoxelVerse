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

package org.flashapi.swing.containers {
	
	// -----------------------------------------------------------
	// MainContainer.as
	// -----------------------------------------------------------

	/**
	*  @author Pascal ECHEMANN
	*  @version 1.0.2, 18/06/2009 21:40
	*  @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.Application;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.ScrollPolicy;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.ApplicationEvent;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.scroll.ScrollableArea;
	import org.flashapi.swing.UIManager;
	import org.flashapi.swing.util.Observable;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 *	The <code>MainContainer</code> class provides a unique container to display
	 * 	elements added to the <code>Application</code> document class. There is only
	 * 	one <code>MainContainer</code> instance created at once.
	 * 	
	 * 	<p>If you try to instanciate this class, it will throw a
	 * 	<code>DeniedConstructorAccessException</code> error.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	*/
	public class MainContainer extends UIContainer implements IMainContainer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>MainContainer</code> instance.
		 */
		public function MainContainer() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set name(value:String):void {}
		
		private var _stageWidth:Number;
		/**
		 *  Returns the width of the <code>Stage</code>, in pixels.
		 */
		public function get stageWidth():Number {
			return _stageWidth;
		}
		
		private var _stageHeight:Number;
		/**
		 *  Returns the height of the <code>Stage</code>, in pixels.
		 */
		public function get stageHeight():Number {
			return _stageHeight;
		}
		
		/**
		 *  @private
		 */
		override public function get x():Number {
			return $content.x;
		}
		override public function set x(value:Number):void { }
		
		/**
		 *  @private
		 */
		override public function get y():Number {
			return $content.y;
		}
		override public function set y(value:Number):void { }
		
		/**
		 * 	Sets or gets the <code>paddingTop</code> property of the container
		 * 	scrollable area.
		 * 
		 * 	@see org.flashapi.swing.scroll.ScrollableArea
		 * 	@see #scrollPaddingRight
		 * 	@see #scrollPaddingBottom
		 * 	@see #scrollPaddingLeft
		 */
		public function get scrollPaddingTop():Number {
			return spas_internal::scrollableArea.paddingTop;
		}
		public function set scrollPaddingTop(value:Number):void {
			spas_internal::scrollableArea.paddingTop = value;
		}
		
		/**
		 * 	Sets or gets the <code>paddingTop</code> property of the container
		 * 	scrollable area.
		 * 
		 * 	@see org.flashapi.swing.scroll.ScrollableArea
		 * 	@see #scrollPaddingTop
		 * 	@see #scrollPaddingBottom
		 * 	@see #scrollPaddingLeft
		 */
		public function get scrollPaddingRight():Number {
			return spas_internal::scrollableArea.paddingRight;
		}
		public function set scrollPaddingRight(value:Number):void {
			spas_internal::scrollableArea.paddingRight = value;
		}
		
		/**
		 * 	Sets or gets the <code>paddingTop</code> property of the container
		 * 	scrollable area.
		 * 
		 * 	@see org.flashapi.swing.scroll.ScrollableArea
		 * 	@see #scrollPaddingRight
		 * 	@see #scrollPaddingTop
		 * 	@see #scrollPaddingLeft
		 */
		public function get scrollPaddingBottom():Number {
			return spas_internal::scrollableArea.paddingBottom;
		}
		public function set scrollPaddingBottom(value:Number):void {
			spas_internal::scrollableArea.paddingBottom = value;
		}
		
		/**
		 * 	Sets or gets the <code>paddingTop</code> property of the container
		 * 	scrollable area.
		 * 
		 * 	@see org.flashapi.swing.scroll.ScrollableArea
		 * 	@see #scrollPaddingRight
		 * 	@see #scrollPaddingBottom
		 * 	@see #scrollPaddingTop
		 */
		public function get scrollPaddingLeft():Number {
			return spas_internal::scrollableArea.paddingLeft;
		}
		public function set scrollPaddingLeft(value:Number):void {
			spas_internal::scrollableArea.paddingLeft = value;
		}
		
		private var _scrollPolicy:String = ScrollPolicy.AUTO;
		/**
		 * 	The <code>scrollPolicy</code> property controls the display of scroll bars.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>ScrollPolicy.AUTO</code>: configures the container to include
		 * 		scroll bars only when necessary,</li>
		 * 		<li><code>ScrollPolicy.BOTH</code>: displays both, vertical and
		 * 		horizontal scroll bars,</li>
		 * 		<li><code>ScrollPolicy.VERTICAL</code>: displays only the vertical
		 * 		scroll bars,</li>
		 * 		<li><code>ScrollPolicy.HORIZONTAL</code>: displays only the horizontal
		 * 		scroll bars,</li>
		 * 		<li><code>ScrollPolicy.NONE</code>: deactivates both, vertical and
		 * 		horizontal scroll bars.</li>
		 * 	</ul>
		 * 	
		 * 	@default ScrollPolicy.AUTO
		 */
		public function get scrollPolicy():String {
			return _scrollPolicy;
		}
		public function set scrollPolicy(value:String):void {
			_scrollPolicy = value;
			redraw();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@inheritDoc
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			$displayed = true;
			move(0, 0);
			spas_internal::scrollableArea.resize($stage.stageWidth, $stage.stageHeight);
			spas_internal::scrollableArea.display();
			//refresh();
		}
		
		/**
		 * 	Returns a rectangle that defines the area of the <code>MainContainer</code>.
		 * 	instance.
		 * 	<p>The <code>MainContainer.getBounds()</code> method is similar to the
		 * 	<code>MainContainer.getRect()</code> method.</p>
		 * 
		 * 	@param	The display object that defines the coordinate system to use.
		 * 
		 *	@return The rectangle that defines the area of the main container relative 
		 * 			to the <code>targetCoordinateSpace</code> coordinate system.
		 * 
		 * 	@see #getRect()
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		/**
		 * 	Returns a rectangle that defines the area of the <code>MainContainer</code>.
		 * 	instance.
		 * 	<p>The <code>MainContainer.getRect()</code> method is similar to the
		 * 	<code>MainContainer.getBounds()</code> method.</p>
		 * 
		 * 	@param	The display object that defines the coordinate system to use.
		 * 
		 *	@return The rectangle that defines the area of the main container relative 
		 * 			to the <code>targetCoordinateSpace</code> coordinate system.
		 * 
		 * 	@see #getBounds()
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		/**
		 *	@private
		 */
		override public function redraw():void {
			spas_internal::drawScrollBounds();
			//fixSize();
			//var sw:Number = spas_internal::scrollableArea.lookAndFeel.getScrollBarWidth();
			//var scrollBarDelayW:Number = spas_internal::scrollableArea.isVScrollBarActive ? sw : 0;
			//var scrollBarDelayH:Number = spas_internal::scrollableArea.isHScrollBarActive ? sw : 0;
			var w:Number = _scrollBounds.width;
			var h:Number = _scrollBounds.height;
			if(_scrollPolicy == ScrollPolicy.AUTO) { 
				var scPolicy:uint = 0;
				if (w > _stageWidth) scPolicy = 1;
				if (h > _stageHeight) scPolicy += 2;
				switch(scPolicy) {
					case 0 :
						spas_internal::scrollableArea.scrollPolicy = ScrollPolicy.NONE;
						break;
					case 1 :
						spas_internal::scrollableArea.scrollPolicy = ScrollPolicy.HORIZONTAL;
						break;
					case 2 :
						spas_internal::scrollableArea.scrollPolicy = ScrollPolicy.VERTICAL;
						break;
					case 3 :
						spas_internal::scrollableArea.scrollPolicy = ScrollPolicy.BOTH;
						break;
				}
			} else spas_internal::scrollableArea.scrollPolicy = _scrollPolicy;
			switch(spas_internal::scrollableArea.isHScrollBarActive){
				case true : 
					switch(_document.horizontalAlignment) {
						case HorizontalAlignment.LEFT :
							$content.x = $mrgL;
							break;
						case HorizontalAlignment.CENTER :
							$content.x = w < _stageWidth ? (_stageWidth - w) / 2 + $mrgL : $mrgL;
							break;
						case HorizontalAlignment.RIGHT :
							$content.x = w < _stageWidth ? _stageWidth - w + $mrgL : $mrgL;
							break;
					}
					break;
				case false : 
					switch(_document.horizontalAlignment) {
						case HorizontalAlignment.LEFT :
							$content.x = $mrgL;
							break;
						case HorizontalAlignment.CENTER :
							$content.x = w < _stageWidth ? (_stageWidth - w) / 2 + $mrgL : $mrgL;
							break;
						case HorizontalAlignment.RIGHT :
							$content.x = w < _stageWidth ? _stageWidth - w + $mrgL : $mrgL;
							break;
					}
					break;
			}
			switch(spas_internal::scrollableArea.isVScrollBarActive) {
				case true : 
					switch(_document.verticalAlignment) {
						case VerticalAlignment.TOP :
							$content.y = $mrgT;
							break;
						case VerticalAlignment.MIDDLE :
							$content.y = h < _stageHeight ? (_stageHeight - h) / 2 + $mrgT : $mrgT;
							break;
						case VerticalAlignment.BOTTOM :
							$content.y = h < _stageHeight ? _stageHeight - h + $mrgT : $mrgT;
							break;
					}
					break;
				case false : 
					switch(_document.verticalAlignment) {
						case VerticalAlignment.TOP :
							$content.y = $mrgT;
							break;
						case VerticalAlignment.MIDDLE :
							$content.y = h < _stageHeight ? (_stageHeight - h) / 2 + $mrgT : $mrgT;
							break;
						case VerticalAlignment.BOTTOM :
							$content.y = h < _stageHeight ? _stageHeight - h + $mrgT : $mrgT;
							break;
					}
					break;
			}
			setBackgroundPosition();
			$textureManager.width = _stageWidth;
			$textureManager.height = _stageHeight;
			if($textureManager.texture!=null) $textureManager.draw(TextureType.TEXTURE);
			else if($gradientMode) $textureManager.draw(TextureType.GRADIENT);
			else $textureManager.draw();
			//_fixSize = true;
			if($fixToParentWidth) $width = $stage.stageWidth;
			if ($fixToParentHeight) $height = $stage.stageHeight;
			var e:ApplicationEvent = new ApplicationEvent(ApplicationEvent.UPDATE);
			this.dispatchEvent(e);
			_document.dispatchEvent(e);
		}
		
		/**
		 *	@private
		 */
		override public function update(o:Observable, arg:*):void {
			changeLaf();
		}
		
		/**
		 *	@private
		 */
		override public function get height():Number {
			return $fixToParentHeight ? $stage.stageHeight : _scrollBounds.height;
		}
		
		/**
		 *	@private
		 */
		override public function get width():Number {
			return $fixToParentWidth ?  $stage.stageWidth : _scrollBounds.width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var scrollableArea:ScrollableArea;
		
		//spas_internal var validHeight:Number = 0;
		//spas_internal var validWidth:Number = 0;
		
		/**
		 *  @private
		 */
		spas_internal var body:Shape;
		
		/**
		 *  @private
		 */
		spas_internal var backgroundCanvas:Canvas;
		
		/**
		 *  @private
		 */
		spas_internal var backgroundPosition:Point = null;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			redraw();
		}
		
		/**
		 *  @private
		 */
		spas_internal function drawScrollBounds():void {
			_stageWidth = $stage.stageWidth;
			_stageHeight = $stage.stageHeight;
			
			var w:Number = $fixToParentWidth ? spas_internal::getExplicitSize().width : $width;
			var h:Number = $fixToParentHeight ? spas_internal::getExplicitSize().height : $height;
			
			var f:Figure = Figure.setFigure(_scrollBounds);
			f.clear();
			f.beginFill(0x0000FF, 0);
			f.drawRectangle(0, 0, $mrgL + w + $mrgR, $mrgT + h + $mrgB);
			f.endFill();
			spas_internal::scrollableArea.resize(_stageWidth, _stageHeight);
		}
		
		/**
		 *  @private
		 */
		spas_internal function getContentMetrics():Rectangle {
			return _scrollBounds.getBounds(null);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _scrollBounds:Shape;
		private var _document:Application = UIManager.document;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if(!_document.spas_internal::enableMainContainerAcces) new DeniedConstructorAccess(this);
			else _document.spas_internal::enableMainContainerAcces = false;
			_scrollBounds = new Shape();
			spas_internal::body = new Shape();
			spas_internal::backgroundCanvas = new Canvas();
			spas_internal::body.visible = false;
			$parent = $target = $stage;
			$horizontalGap = $verticalGap = $padL = $padT = $padR = $padB = $mrgL = $mrgT = $mrgR = $mrgB = 0; 
			createContainers();
			createScrollabeArea();
			createTextureManager(spas_internal::body);
			$textureManager.color = 0x333333;
			$textureManager.gradientProperties.colors = [0x222222, 0xCCCCCC];
			displayMainContainer();
			
			$fixToParentHeight = $fixToParentWidth = true;
			$autoHeight = true;
			$autoWidth = true;
			
			spas_internal::uioSprite.name = "MainContainer";
			spas_internal::uioSprite.contextMenu = UIManager.spas_internal::mainMenu;
			$evtColl.addOneShotEvent(this, Event.ADDED, addedToStageHandler);
			//initLaf(BasicWindowUI);
		}
		
		private function createContainers():void {
			spas_internal::body.cacheAsBitmap = _scrollBounds.cacheAsBitmap = true;
			spas_internal::uioSprite.addChild(spas_internal::body);
			spas_internal::backgroundCanvas.target = spas_internal::uioSprite;
			spas_internal::backgroundCanvas.display();
			spas_internal::uioSprite.addChild($content);
			spas_internal::uioSprite.addChild(_scrollBounds);
		}
		
		private function createScrollabeArea():void {
			spas_internal::scrollableArea = new ScrollableArea(_scrollBounds);
			spas_internal::scrollableArea.target = $stage;
			spas_internal::scrollableArea.spas_internal::VScrollBar.addEventListener(ScrollEvent.SCROLL, doVerticalScroll);
			spas_internal::scrollableArea.spas_internal::HScrollBar.addEventListener(ScrollEvent.SCROLL, doHorizontalScroll);
		}
		
		private function doVerticalScroll(e:ScrollEvent):void {
			if(spas_internal::scrollableArea.isVScrollBarActive) {
				$content.y = _scrollBounds.y + $mrgT;
				if (spas_internal::backgroundPosition != null) return;
				if(!isNaN(spas_internal::backgroundCanvas.height)) spas_internal::backgroundCanvas.y = _scrollBounds.y;
			}
		}
		
		private function doHorizontalScroll(e:ScrollEvent):void {
			if(spas_internal::scrollableArea.isHScrollBarActive) {
				$content.x =  _scrollBounds.x + $mrgL;
				if (spas_internal::backgroundPosition != null) return;
				if(!isNaN(spas_internal::backgroundCanvas.width)) spas_internal::backgroundCanvas.x = _scrollBounds.x;
			}
		}
		
		/*private function fixSize():void {
			_paddingHeight = _mrgT + _mrgB;
			_paddingWidth = _mrgL + _mrgR;
			__width = _mrgL + _scrollBounds.width + _mrgR; 
			__height = _mrgT + _scrollBounds.height + _mrgB;
		}*/
		
		private function setBackgroundPosition():void {
			if (spas_internal::backgroundPosition != null) {
				spas_internal::backgroundCanvas.x = spas_internal::backgroundPosition.x;
				spas_internal::backgroundCanvas.y = spas_internal::backgroundPosition.y;
			} else {
				spas_internal::backgroundCanvas.x = $content.x - $mrgL;
				spas_internal::backgroundCanvas.y = $content.y - $mrgT;
			}
			
		}
		
		private function addedToStageHandler(e:Event):void {
			redraw();
		}
	}
}