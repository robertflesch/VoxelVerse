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
	// AccordionContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0, 20/02/2010 20:09
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Shape;
	import org.flashapi.swing.Accordion;
	import org.flashapi.swing.button.AccordionHeader;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.AccordionEvent;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.scroll.ScrollableArea;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>AccordionContainer</code> class creates a control object composed 
	 * 	of a header/view pair displayed within the specified <code>Accordion</code>
	 * 	object.
	 * 
	 * <p><strong><code>AccordionContainer</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scroll-policy</code></td>
	 * 			<td>Sets the scroll policy for this object.</td>
	 * 			<td>Valid values are <code class="css">both</code>, <code class="css">none</code>,
	 * 			<code class="css">vertical</code>, <code class="css">horizontal</code>,
	 * 			<code class="css">auto</code>.</td>
	 * 			<td><code>scrollPolicy</code></td>
	 * 			<td><code>Properties.SCROLL_POLICY</code></td>
	 * 		</tr>
	 * 	</table>
	 *
	 * 	@see org.flashapi.swing.plaf.AccordionUI
	 *  @see org.flashapi.swing.Accordion
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 **/
	public class AccordionContainer extends UIObject {		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>AccordionContainer</code> instance.
		 * 
		 * 	@param accordion 	The accordion that creates the <code>AccordionContainer</code>
		 * 						instance.
		 * 	@param label 		The plain text displayed by the header button. Default
		 * 						value is <code>""</code>.
		 */
		public function AccordionContainer(accordion:Accordion, label:String = "") {
			super();
			initObj(accordion, label);
		}
		
		//--------------------------------------------------------------------------
		//
		// 	Public constants
		//
		//--------------------------------------------------------------------------
		
		public static const HEADER_HEIGHT:Number = 22;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _accordion:Accordion;
		/**
		 * 	Returns a reference to the parent <code>Accordion</code> for this
		 * 	accordion container.
		 */
		public function get accordion():Accordion {
			return _accordion;
		}
		
		private var _header:AccordionHeader;
		/**
		 * 	A refence to the header button for the accordion container.
		 */
		public function get header():AccordionHeader {
			return _header;
		}
		
		/**
		 *  @private
		 */
		override public function set scaleX(value:Number):void {
			spas_internal::uioSprite.scaleX = spas_internal::viewScale[0] = value;
		}
		
		/**
		 *  @private
		 */
		override public function set scaleY(value:Number):void {
			spas_internal::uioSprite.scaleY = spas_internal::viewScale[1] = value;
		}
		
		private var _view:Canvas;
		/**
		 * 	A refence to the <code>Canvas</code> view  for the accordion container.
		 */
		public function get view():Canvas {
			return _view;
		}
		
		private var _viewHeight:Number = 0;
		/**
		 * 	The height of the view relative to the parent <code>Accordion</code> 
		 * 	view height, defined by the <code>viewHeight</code> property.
		 * 
		 * 	@default 0
		 * 
		 * 	@see org.flashapi.swing.Accordion#viewHeight
		 */
		public function get viewHeight():Number {
			return _viewHeight;
		}
		
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
		 * 	@default ScrollPolicy.BOTH
		 */
		public function get scrollPolicy():String {
			return _scrollableArea.scrollPolicy;
		}
		public function set scrollPolicy(value:String):void {
			_scrollableArea.scrollPolicy = value;
		}
		
		/**
		 * 	Sets or gets the orientation of the view layout for this accordion container.
		 * 	Possible values are the <code>LayoutOrientation</code> class constants.
		 * 
		 * 	@default LayoutOrientation.HORIZONTAL
		 */
		public function get layoutOrientation():String {
			return _view.layout.orientation;
		}
		public function set layoutOrientation(value:String):void {
			_view.layout.orientation = value;
			setRefresh();
		}
		
		/**
		 *  The <code>label</code> property specifies the plain text displayed on the
		 * 	face of the header button for this accordion container.
		 * 
		 *  @default ""
		 */
		public function get label():String {
			return _header.label;
		}
		public function set label(value:String):void {
			_header.label = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_accordion = null;
			_view.finalizeElements();
			_view.finalize();
			_view = null;
			_header.finalize();
			_header = null;
			_scrollableArea.finalize();
			_scrollableArea = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var viewScale:Array = [1, 1];
		
		/**
		 *  @private
		 */
		spas_internal var itemIndex:int;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			_view.display(0, _header.height);
			spas_internal::uioSprite.addChild(_viewMask);
			_scrollableArea.display();
			_header.display();
			_viewMask.y = _header.height;
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			drawMask();
			initScrollableArea();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		spas_internal function updateWidth():void {
			$width = _header.width = _view.width = _accordion.width;
			_view.spas_internal::updateLayout();
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		spas_internal function setViewHeight(value:Number):void {
			_viewHeight = value;
			$height = _header.height + _viewHeight;
			setRefresh();
			
		}
		
		/**
		 *  @private
		 */
		spas_internal function setViewPosition(value:Number):void {
			_view.y = value;
		}
		
		/**
		 *  @private
		 */
		spas_internal function fixLaf():void {
			fixHeaderLaf();
			fixScrollBarLaf();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(accordion:Accordion, label:String):void {
			_accordion = accordion;
			_header = new AccordionHeader(label, accordion.width, HEADER_HEIGHT);
			_view = new Canvas();
			_viewMask = new Shape();
			fixHeaderLaf();
			_header.target = _view.target = spas_internal::uioSprite;
			_header.cornerRadius = 0;
			_view.autoAdjustSize = false;
			_view.autoHeight = true;
			_view.spas_internal::uioSprite.mask = _viewMask;
			_scrollableArea = new ScrollableArea(_view.content);
			fixScrollBarLaf();
			_scrollableArea.target = _view.container;
			$evtColl.addEvent(_header, UIMouseEvent.CLICK, doDispatchEvent);
			$evtColl.addEvent(_view, LoaderEvent.COMPLETE, doViewLoadedEvent);
			spas_internal::setSelector("accordioncontainer");
		}
		
		private function doDispatchEvent(e:UIMouseEvent):void {
			var ae:AccordionEvent = new AccordionEvent(AccordionEvent.HEADER_CLICK);
			ae.spas_internal::oldItemIndex = _accordion.selectedIndex;
			ae.spas_internal::newItemIndex = spas_internal::itemIndex;
			_accordion.dispatchEvent(ae);
			_accordion.spas_internal::setSelectedAccordionContainer(this);
		}
		
		private function doViewLoadedEvent(e:LoaderEvent):void {
			if (_accordion.listItem == null) return;
			if(_accordion.listItem.item == this) {
				_accordion.spas_internal::fixSizeToContent();
				initScrollableArea();
			}
		}
		
		private function drawMask():void {
			with(_viewMask.graphics) {
				clear();
				beginFill(0xFF0000, 1);
				drawRect(0, 0, _accordion.width, _viewHeight);
				endFill();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _viewMask:Shape;
		private var _scrollableArea:ScrollableArea;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initScrollableArea():void {
			_view.x = 0;
			_view.y = _header.height;
			_scrollableArea.spas_internal::HScrollBar.value =
			_scrollableArea.spas_internal::VScrollBar.value = 0;
			_scrollableArea.resize(_accordion.width, _viewHeight);
			doReflection();
		}
		
		/**
		 *  @private
		 */
		private function fixHeaderLaf():void {
			_header.lockLaf(_accordion.lookAndFeel.getButtonLaf(), true);
		}
		
		/**
		 *  @private
		 */
		private function fixScrollBarLaf():void {
			_scrollableArea.lockLaf(_accordion.lookAndFeel.getScrollBarLaf(), true);
		}
	}
}