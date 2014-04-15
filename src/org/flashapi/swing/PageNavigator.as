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
	//  PageNavigator.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version beta 3.2, 17/03/2010 20:57
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.button.LinkDiv;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.event.PageNavigatorEvent;
	import org.flashapi.swing.localization.pagenav.PageNavLocaleUs;
	import org.flashapi.tween.Tween;
	import org.flashapi.swing.plaf.libs.PageNavigatorUIRef;
	import org.flashapi.swing.util.DisplayListUtil;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("PageNavigator.png")]
	
	/**
	 * 	<img src="PageNavigator.png" alt="PageNavigator" width="18" height="18"/>
	 * 
	 * 	[This clas is under development.]
	 * 
	 * 	The <code>PageNavigator</code> class creates a HTML-like multipage navigation
	 * 	menu. <code>PageNavigator</code> are composed of several elements:
	 * 	<ul>
	 * 		<li>A First Page button that allows the user to directly navigate to the 
	 * 		first page of the <code>PageNavigator</code> instance.</li>
	 * 		<li>A Last Page button that allows the user to directly navigate to the 
	 * 		last page of the <code>PageNavigator</code> instance.</li>
	 * 		<li>A Previous Page button that allows the user to navigate to the 
	 * 		previous index page, within the <code>PageNavigator</code> instance,
	 * 		depending on the current index.</li>
	 * 		<li>A Next Page button that allows the user to navigate to the 
	 * 		next index page, within the <code>PageNavigator</code> instance,
	 * 		depending on the current index.</li>
	 * 		<li>A group of Div buttons that allows the user to select a specific
	 * 		index within the <code>PageNavigator</code> instance.</li>
	 * 	</ul>
	 * 
	 * 	<p>
	 * 		The following figure illustrates all of the elements a <code>PageNavigator</code>
	 * 		control:
	 *	</p>
	 * 	<p><img src = "../../../doc-images/page_navigator.gif" alt="SPAS 3.0 PageNavigator
	 * 	Organization." /></p>
	 * 
	 * 	<p>Pages within a <code>PageNavigator</code> instance are one-based index.
	 * 	If the <code>PageNavigator</code> is not large enought to display all Div buttons,
	 * 	buttons that cannot be displayed within the <code>PageNavigator</code> bounds
	 * 	are hidden. Hidden Div buttons are automatically displayed when the user clicks
	 * 	on the Previous Page or Next Page buttons. When a hidden Div button is displayed,
	 * 	the more far visible Div button from the displayed one is removed.</p>
	 * 
	 *  @includeExample PageNavigatorExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PageNavigator extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>PageNavigator</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param	totalPages		The number of pages to be managed by this 
		 * 							<code>PageNavigator</code> instance.
		 * 	@param	visiblePages	The number of pages that are displayed at the 
		 * 							same time within this <code>PageNavigator</code>
		 * 							instance.
		 * 	@param	startIndex		The index of the first page displayed within this 
		 * 							<code>PageNavigator</code> instance.
		 */
		public function PageNavigator(totalPages:uint = 0, visiblePages:uint = 5, startIndex:uint = 1) {
			super();
			initObj(totalPages, visiblePages, startIndex);
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
		
		/**
		 * @private
		 */
		override public function get index():int {
			return _currentIndex;
		}
		
		private var _labels:Array;
		/**
		 * 	Sets or gets the labels displayed on the face of the first, previous, next
		 * 	and last buttons. You pass an <code>Array</code> instance that contains the
		 * 	labels in this order to set the new text values. The globalization API for
		 * 	the labels of the <code>PageNavigator</code> class are contained whithin the
		 * 	<code>org.flahsapi.swing.localization.pagenavig</code> package.
		 */
		public function get labels():Array {
			return _labels;
		}
		public function set labels(value:Array):void {
			_labels = value;
			var i:uint = 0;
			var ld:LinkDiv;
			for (; i < 4; ++i) {
				ld = i < 2 ? _leftBtnCont.getChildAt(i) as LinkDiv : _rightBtnCont.getChildAt(i-2) as LinkDiv;
				ld.text = _labels[i];
			}
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Initializes this <code>PageNavigator</code> instance.
		 * 
		 * 	@param	totalPages		The number of pages to be managed by this
		 * 							<code>PageNavigator</code> instance.
		 * 	@param	visiblePages	The number of pages that are displayed at the 
		 * 							same time within this <code>PageNavigator</code>
		 * 							instance.
		 * 	@param	startIndex		The index of the  first page displayed within this 
		 * 							<code>PageNavigator</code> instance.
		 */
		public function init(totalPages:uint = 0, visiblePages:uint = 5, startIndex:uint = 1):void {
			_totalPages = totalPages;
			_visiblePages = visiblePages;
			_startIndex = startIndex;
			createLinks();
			setRefresh();
		}
		
		/**
		 * 	Resets this <code>PageNavigator</code> instance.
		 */
		public function reset():void {
			_totalPages = 0;
			_visiblePages = 5;
			_startIndex = 1;
			createLinks();
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_tween.finalize();
			_tween = null;
			_linkEvtColl.finalize();
			_linkEvtColl = null;
			_dlu.removeAllChildren();
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
		override protected function refresh():void {
			drawMask();
			fixPositions();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private static const BORDER_OFFSET:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _linkEvtColl:EventCollector;
		private var _linkCont:Sprite;
		private var _leftBtnCont:Sprite;
		private var _rightBtnCont:Sprite;
		private var _mask:Shape;
		private var _dlu:DisplayListUtil;
		private var _totalPages:uint;
		private var _visiblePages:uint;
		private var _startIndex:uint;
		private var _linksOffset:Number = 1;
		private var _btnOffset:Number = 8;
		private var _tween:Tween;
		private var _currentIndex:uint = 1;
		private var _fmt:TextFormat;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(totalPages:uint, visiblePages:uint, startIndex:uint):void {
			initLaf(PageNavigatorUIRef);
			_linkEvtColl = new EventCollector();
			_fmt = new TextFormat(WebFonts.ARIAL, 12, null, null, null, null, null, null, TextAlign.CENTER, 2, 2);
			_labels = 	[PageNavLocaleUs.FIRST_LABEL, PageNavLocaleUs.PREV_LABEL,
						PageNavLocaleUs.NEXT_LABEL, PageNavLocaleUs.LAST_LABEL];
			createContainers();
			createButtons();
			_totalPages = totalPages;
			_visiblePages = visiblePages;
			_startIndex = startIndex;
			createLinks();
			createTween();
			spas_internal::setSelector(Selectors.PAGE_NAVIGATOR);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			_linkCont = new Sprite();
			spas_internal::uioSprite.addChild(_linkCont);
			_leftBtnCont = new Sprite();
			_mask = new Shape();
			spas_internal::uioSprite.addChild(_mask);
			_rightBtnCont = new Sprite();
			_linkCont.mask = _mask;
			spas_internal::uioSprite.addChild(_leftBtnCont);
			spas_internal::uioSprite.addChild(_rightBtnCont);
			_dlu = new DisplayListUtil(_linkCont);
		}
		
		private function fixPositions():void {
			var off:Number = _btnOffset + PageNavigator.BORDER_OFFSET;
			_mask.x = _leftBtnCont.width + off;
			_rightBtnCont.x = _mask.x + _mask.width + off;
			var newPos:Number = _linkCont.getChildAt(_startIndex - 1).x;
			_tween.start = _linkCont.x = _mask.x - newPos;
			$width = _rightBtnCont.x + _rightBtnCont.width;
			$height = _rightBtnCont.height;
		}
		
		private function drawMask():void {
			var li:Number = _startIndex + _visiblePages - 1;
			if (li > _totalPages) li = _totalPages;
			var lnk:DisplayObject = _linkCont.getChildAt(li - 1);
			var firstLnk:DisplayObject =  _linkCont.getChildAt(_startIndex - 1);
			var w:Number = lnk.x + lnk.width + PageNavigator.BORDER_OFFSET - firstLnk.x;
			with (_mask.graphics) {
				clear();
				beginFill(0, .5);
				drawRect(0, 0, w, 20);
				endFill();
			}
		}
		
		private function createButtons():void {
			var i:int = 0;
			var prevPos:Number = 0;
			var ld:LinkDiv;
			var l:int = _labels.length;
			for (; i < l; ++i) {
				ld = new LinkDiv();
				ld.defaultTextFormat = _fmt;
				ld.backgroundColor = 0xcccccc;
				ld.borderColor = lookAndFeel.getBorderColor();
				ld.text = _labels[i];
				ld.index = i;
				ld.x = prevPos;
				i < 2 ? _leftBtnCont.addChild(ld) : _rightBtnCont.addChild(ld);
				i == 1 ? prevPos = 0 : prevPos += _linksOffset + ld.width + PageNavigator.BORDER_OFFSET;
				$evtColl.addEvent(ld, MouseEvent.CLICK, btnClickHandler);
				$evtColl.addEvent(ld, MouseEvent.MOUSE_OVER, linkOverHandler);
				$evtColl.addEvent(ld, MouseEvent.MOUSE_OUT, linkOutHandler);
				$evtColl.addEvent(ld, MouseEvent.MOUSE_DOWN, linkPressHandler);
				$evtColl.addEvent(ld, MouseEvent.MOUSE_UP, linkReleaseHandler);
			}
		}
		
		private function createTween():void {
			_tween = new Tween(_linkCont, 0, 0);
			$evtColl.addEvent(_tween, MotionEvent.UPDATE, moveLinkCont);
			$evtColl.addEvent(_tween, MotionEvent.FINISH, refreshNavigator);
		}
		
		private function moveLinkCont(e:MotionEvent):void {
			_linkCont.x = Number(e.value);
		}
		
		private function refreshNavigator(e:MotionEvent):void {
			setRefresh();
		}
		
		private function setSelectedLink(oldIndex:uint):void {
			var ld:LinkDiv = _linkCont.getChildAt(oldIndex - 1) as LinkDiv;
			ld.backgroundColor = 0xcccccc;
			ld.selected = false;
			ld = _linkCont.getChildAt(_currentIndex - 1) as LinkDiv;
			ld.backgroundColor = 0xB2E1FF;
			ld.selected = true;
			dispatchEvent(new PageNavigatorEvent(PageNavigatorEvent.PAGE_CHANGED));
		}
		
		private function createLinks():void {
			_linkEvtColl.removeAllEvents();
			_dlu.removeAllChildren();
			var i:int = 1;
			var ld:LinkDiv;
			var prevPos:Number = 0;
			for (; i <= _totalPages; ++i) {
				ld = new LinkDiv();
				ld.defaultTextFormat = _fmt;
				ld.backgroundColor = 0xcccccc;
				ld.borderColor = lookAndFeel.getBorderColor();
				ld.text = String(i);
				ld.index = i;
				ld.x = prevPos;
				_dlu.addChild(ld);
				prevPos += _linksOffset + ld.width + PageNavigator.BORDER_OFFSET;
				_linkEvtColl.addEvent(ld, MouseEvent.CLICK, linkClickHandler);
				_linkEvtColl.addEvent(ld, MouseEvent.MOUSE_OVER, linkOverHandler);
				_linkEvtColl.addEvent(ld, MouseEvent.MOUSE_OUT, linkOutHandler);
				_linkEvtColl.addEvent(ld, MouseEvent.MOUSE_DOWN, linkPressHandler);
				_linkEvtColl.addEvent(ld, MouseEvent.MOUSE_UP, linkReleaseHandler);
			}
			spas_internal::setIndex(_startIndex);
		}
		
		private function btnClickHandler(e:MouseEvent):void {
			if (_tween.isPlaying) return;
			var oldIndex:uint = _currentIndex;
			var btnIndex:uint = e.target.index;
			switch(btnIndex) {
				case 0:
					_currentIndex = 1;
					break;
				case 1:
					if (_currentIndex > 1) _currentIndex--;
					break;
				case 2:
					if (_currentIndex < _totalPages) _currentIndex++;
					break;
				case 3:
					_currentIndex = _totalPages;
					break;
			}
			setSelectedLink(oldIndex);
			if (oldIndex == _currentIndex) return;
			else {
				var di:DisplayObject;
				var odi:DisplayObject;
				if (_currentIndex > oldIndex) {
					if (_startIndex + _visiblePages < _currentIndex + 1) {
						oldIndex = _startIndex + _visiblePages - 1;
						di = _linkCont.getChildAt(_currentIndex - 1);
						odi = _linkCont.getChildAt(oldIndex - 1);
						btnIndex == 3 ? 
							_startIndex = _currentIndex - _visiblePages + 1 : _startIndex++;
						updateTween(_linkCont.x  - (di.x + di.width - odi.x - odi.width));
					}
				} else {
					if (_currentIndex < _startIndex) {
						oldIndex = _startIndex;
						btnIndex == 0 ? _startIndex = 1 : _startIndex--;
						di = _linkCont.getChildAt(_currentIndex - 1);
						odi = _linkCont.getChildAt(oldIndex - 1);
						updateTween(_linkCont.x + odi.x - di.x);
					}
				}
			}
		}
		
		private function updateTween(end:*):void {
			_tween.end = end;
			_tween.play();
		}
		
		private function linkOverHandler(e:MouseEvent):void {
			e.target.backgroundColor = 0xffffff;
		}
		
		private function linkOutHandler(e:MouseEvent):void {
			var tgt:* = e.target;
			tgt.backgroundColor = tgt.selected ? 0xB2E1FF : 0xcccccc;
		}
		
		private function linkReleaseHandler(e:MouseEvent):void {
			e.target.backgroundColor = 0xffffff;
		}
		
		private function linkPressHandler(e:MouseEvent):void {
			e.target.backgroundColor = 0x666666;
		}
		
		private function linkClickHandler(e:MouseEvent):void {
			var oldIndex:uint = _currentIndex;
			_currentIndex = e.target.index;
			dispatchEvent(new PageNavigatorEvent(PageNavigatorEvent.ITEM_CLICKED));
			if (oldIndex == _currentIndex) return;
			setSelectedLink(oldIndex);
		}
	}
}