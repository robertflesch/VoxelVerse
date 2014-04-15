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
	//  Accordion.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.4, 14/03/2010 18:42
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flashapi.swing.button.AccordionHeader;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.containers.AccordionContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.AccordionEvent;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.exceptions.NullPointerException;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.libs.AccordionUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.tween.Tween;
	
	use namespace spas_internal;
	
	[IconFile("Accordion.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>Accordion</code> changes value due to mouse or
	 * 	keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name="listChanged", type="org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>Accordion</code> instance has finished using
	 * 	the data provided by the <code>DataProvider</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name="dataProviderFinished", type="org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the <code>Accordion</code> instance has finished using
	 * 	the data provided by the <code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name="xmlQueryFinished", type="org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched each time a header button is clicked within the <code>Accordion</code>
	 * 	instance.
	 *
	 *  @eventType org.flashapi.swing.event.AccordionEvent.HEADER_CLICK
	 */
	[Event(name="headerClick", type="org.flashapi.swing.event.AccordionEvent")]
	
	/**
	 *  Dispatched each time the animation between two states of the <code>Accordion</code>
	 * 	instance is complette. This event is fired only when the <code>useAnimation</code> 
	 * 	property is <code>true</code>.
	 *
	 *  @eventType org.flashapi.swing.event.AccordionEvent.ANIMATION_FINISH
	 */
	[Event(name="animationFinish", type="org.flashapi.swing.event.AccordionEvent")]
	
	/**
	 * 	<img src="Accordion.png" alt="Accordion" width="18" height="18"/>
	 * 	
	 *  An <code>Accordion</code> navigator container has a collection of child
	 * 	containers, but only one of them at a time is visible.
	 *  
	 *  It creates and manages navigator buttons (header), which you use to navigate
	 *  between the child views.
	 * 
	 *  There is one navigator button associated with each view container,
	 *  and each navigator button belongs to the <code>Accordion</code> container.
	 * 
	 *  When the user clicks a navigator button, the associated view is displayed.
	 *  The transition to the new view uses an animation to make it clear to
	 *  the user that one view is disappearing and a different one is appearing.
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to an <code>Accordion</code> instance.
	 * 	Each item of the <code>DataProvider</code> object have to contain the following
	 * 	properties:
	 * 	</p>
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value</code> parameter for the
	 * 			<code>Accordion.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter for the
	 * 			<code>Accordion.addItem()</code> method,</li>
	 * 		<li><code>element:<em>untyped</em></code>; the <code>value</code> parameter for the
	 * 			<code>Accordion.addItem()</code> method,</li>
	 * 		<li><code>type:String</code>; the <code>type</code> parameter for the
	 * 			<code>Accordion.addItem()</code> method.</li>
	 * 	</ul>
	 * 
	 * 	<p>You also can assign a <code>XMLQuery</code> object to an <code>Accordion</code>
	 * 	instance.</p>
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="Accordion" urlPath="my_URLPath"&gt;
	 *			&lt;item element="element_url" label="label" type="type" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 	<p>The following table lists the attributes you can specify, their data types, and
	 * 	their purposes:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Must be <code>"Accordion"</code>; if you set the <code>XMLQuery.strictMode</code>
	 * 			to <code>true</code> you must specifie this attribute.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>Accordion.urlPath</code> property.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.element</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI for elements used for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.label</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used as label for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.type</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the type used as the <code>type</code> property for this item.
	 * 			Default value is <code>graphic</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string used as the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to an
	 * 		<code>Accordion</code> instance:</p>
	 * 	<p>
	 * 		- using the <code>Accordion.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var a:Accordion = new Accordion();
	 * 
	 * 			var li1:ListItem = a.addItem("Label 1", myData1);
	 * 			li1.item.view.addElement("picture_01.jpg");
	 * 
	 * 			var li2:ListItem = a.addItem("Label 2", myData2);
	 * 			li2.item.view.addElement("picture_02.jpg");
	 * 
	 * 			var li3:ListItem = a.addItem("Label 3", myData3);
	 * 			li3.item.view.addElement("picture_03.jpg");
	 * 
	 * 			var li4:ListItem = a.addItem("Label 4", myData4);
	 * 			li4.item.view.addElement("picture_04.jpg");
	 * 
	 * 			a.display();
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>Accordion.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var a:Accordion = new Accordion();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 
	 * 			dp.addAll(  { label:"Label 1", element:"picture_01.jpg", data:myData1 },
	 * 						{ label:"Label 2", element:"picture_02.jpg", data:myData2 },
	 * 						{ label:"Label 3", element:"picture_03.jpg", data:myData3 },
	 * 						{ label:"Label 4", element:"picture_04.jpg", data:myData4 });
	 * 			a.dataProvider = dp;
	 * 
	 * 			a.display();
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>Accordion.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item element="url_1.jpg" label="Label 1" data="myData1" /&gt;
	 *								&lt;item element="url_2.jpg" label="Label 2" data="myData2" /&gt;
	 *								&lt;item element="url_3.jpg" label="Label 3" data="myData3" /&gt;
	 * 								&lt;item element="url_4.jpg" label="Label 4" data="myData4" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var a:Accordion = new Accordion();
	 * 			a.xmlQuery = request;
	 * 
	 * 			a.display();
	 * 		</listing>
	 * 	</p>
	 * 
	 *  @includeExample AccordionExample.as
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.list.ALM#xmlQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 * 	@see org.flashapi.swing.plaf.AccordionUI
	 *  @see org.flashapi.swing.containers.AccordionContainer
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Accordion extends ALM implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>Accordion</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param width 	The width of the accordion, in pixels. Default value is
		 * 					<code>300</code> px.
		 * 	@param height 	The height of the accordion, in pixels. Default value is
		 * 					<code>200</code> px.
		 */
		public function Accordion(width:Number = 300, height:Number = 200) {
			super();
			initObj(width, height);
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
		
		private var _useAnimation:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether the accordion uses
		 * 	a tween-based animation (<code>true</code>), or not (<code>false</code>),
		 * 	to render a transition effect when the current view changes.
		 * 
		 * 	<p>The transition effect can be set by the <code>setEasingFunction()</code>
		 * 	method.</p>
		 * 
		 * 	@default true
		 * 
		 * 	@see #setEasingFunction()
		 * 
		 */
		public function get useAnimation():Boolean {
			return _useAnimation;
		}
		public function set useAnimation(value:Boolean):void {
			_useAnimation = value;
		}
		
		/**
		 *  @private
		 */
		override public function set active(value:Boolean):void {
			$active = value;
			updateItemList();
			fixDisplayContainer($selectedIndex);
		}
		
		/**
		 *  @private
		 */
		override public function set enabled(value:Boolean):void {
			$enabled = value;
			updateItemList();
			fixDisplayContainer($selectedIndex);
		}
		
		private var _highLight:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether the current accordion container
		 * 	is highlighted (<code>true</code>), or not (<code>false</code>).
		 * 	If highlighted, current accordion container header always appears selected.
		 * 
		 * 	@default true
		 * 
		 * 	@see org.flashapi.swing.containers.AccordionContainer#header
		 */
		public function get highLight():Boolean {
			return _highLight;
		}
		public function set highLight(value:Boolean):void {
			_highLight = value;
			if($listItem != null)$listItem.item.header.selected = value;
		}
		
		private var _resizeToContent:Boolean = false;
		/**
		 * 	A <code>Boolean</code> that indicates whether this <code>Accordion</code>
		 * 	instance will automatically be resized to fit the size of the current view
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get resizeToContent():Boolean {
			return _resizeToContent;
		}
		public function set resizeToContent(value:Boolean):void { 
			_resizeToContent = value;
			if(value && $objList.size > 0) spas_internal::fixSizeToContent();
		}
		
		private var _selectedView:Canvas = null;
		/**
		 * 	A reference to the currently visible container view. Default value is a
		 * 	reference to the first container view available whithin this <code>Accordion</code>
		 * 	instance. If there are no containers defined for this <code>Accordion</code>
		 * 	instance, the <code>selectedView</code> property is <code>null</code>.
		 * 
		 * 	@default null
		 * 
		 *  @throws org.flashapi.swing.exceptions.NullPointerException A
		 * 			<code>NullPointerException</code> if you try to pass a <code>null</code>
		 * 			reference to the <code>selectedView</code> property.
		 * 
		 * 	@see org.flashapi.swing.containers.AccordionContainer#view
		 */
		public function get selectedView():Canvas {
			return _selectedView;
		}
		public function set selectedView(value:Canvas):void {
			if(value == null) throw new NullPointerException();
			_selectedView = value;
			var it:Iterator = $objList.iterator;
			var ac:AccordionContainer;
			while(it.hasNext()) { 
				ac = it.next().item;
				if(ac.view == value) {
					spas_internal::setSelectedAccordionContainer(ac);
					break;
				}
			}
			it.reset();
		}
		
		/**
		 * 	Displays the accordion container corresponding to the <code>ListItem</code>
		 * 	instance set by this property.
		 * 
		 *  @throws org.flashapi.swing.exceptions.NullPointerException
		 * 			<code>NullPointerException</code> if you try to pass a <code>null</code>
		 * 			reference to the <code>selectedItem</code> property.
		 * 
		 * 	@see org.flashapi.swing.containers.AccordionContainer#view
		 */
		public function set selectedItem(value:ListItem):void {
			if(value == null) throw new NullPointerException();
			var ac:AccordionContainer = value.item;
			spas_internal::setSelectedAccordionContainer(ac);
		}
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			if($objList.size > 0) _needsViewHResize = true;
			var s:uint = $objList.size;
			_viewHeight = value-s * AccordionContainer.HEADER_HEIGHT;
			spas_internal::lafDTO.height = $height = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			if($objList.size > 0) _needsViewWResize = true;
			spas_internal::lafDTO.width = $width = value;
			setRefresh();
		}
		
		/**
		 *  Sets or gets the index of the current view container displayed within the
		 * 	<code>Accordion</code> instance.
		 */
		public function set index(value:int):void {
			$selectedIndex = value;
			changeCurrentIndex();
		}
		
		private var _backgroundOpacity:Number = 1;
		/**
		 *  Sets or gets the opacity for background of the <code>Accordion</code>
		 * 	instance, from <code>0</code> (fully transparent), to <code>1</code>
		 * 	(fully opaque).
		 * 
		 * 	@default 1
		 */
		public function get backgroundOpacity():Number {
			return _backgroundOpacity;
		}
		public function set backgroundOpacity(value:Number):void {
			spas_internal::lafDTO.backgroundOpacity = _backgroundOpacity = value;
			lookAndFeel.drawBackground();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			if ($selectedIndex == -1) $selectedIndex = 0;
			var ac:AccordionContainer = new AccordionContainer(this, value);
			ac.target = $content;
			var li:ListItem = new ListItem(ac, $objList, value, data);
			$dataList[ac] = li;
			ac.display();
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			var ac:AccordionContainer = new AccordionContainer(this, value);
			ac.target = $content;
			var li:ListItem = new ListItem(ac, $objList, value, data, index);
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle;
			if ($objList.size < 1)
				r = spas_internal::uioSprite.getBounds(spas_internal::getCoordinateSpace(targetCoordinateSpace));
			else {
				var view:Canvas = $listItem.item.view;
				var viewScale:Array = $listItem.item.viewScale;
				view.scaleX = view.scaleY = 0;
				r = spas_internal::uioSprite.getRect(spas_internal::getCoordinateSpace(targetCoordinateSpace));
				view.scaleX = viewScale[0];
				view.scaleY = viewScale[1];
				/*r = spas_internal::background.getBounds(targetCoordinateSpace);*/
			}
			return r;
		}
		
		/**
		 * 	Returns a reference to the view contained within the <code>AccordionContainer</code> 
		 * 	instance at the specified index.
		 * 
		 * 	@param	index	The index at which to get the view container.
		 * 
		 * 	@return	The <code>AccordionContainer</code> view at the specified index.
		 */
		public function getViewAt(index:uint):Canvas {
			var li:ListItem = getItemAt(index);
			return li.item.view;
		}
		
		/**
		 * 	Returns the <code>AccordionContainer</code> instance at the specified index.
		 * 
		 * 	@param	index	The index at which to get the <code>AccordionContainer</code>
		 * 					instance.
		 * 
		 * 	@return	The <code>AccordionContainer</code> instance at the specified index.
		 */
		public function getContainerAt(index:uint):AccordionContainer {
			var li:ListItem = getItemAt(index);
			return li.item;
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			var ac:AccordionContainer = item.item;
			var ind:int = ac.spas_internal::itemIndex;
			if (ind == $selectedIndex) $selectedIndex = -1;
			ac.finalize();
			ac = null;
			$objList.remove(item);
			if ($listItem != null) {
				if ($listItem == item) {
					$listItem = null;
					$value = null;
					$data = null;
				}
			}
			item.finalize();
			item = null;
			updateItemList();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItemAt(index:int):void {
			this.removeItem(this.getItemAt(index));
		}
		
		/**
		 * 	Sets the <code>Easing</code> object used to render the accordion animation. If no
		 * 	<code>Easing</code> object is specified, an easing function based on the
		 * 	<code>Linear</code> class is used.
		 * 
		 * 	<p>The accordion animation effect can be deactivated by setting the
		 * 	<code>useAnimation</code> property to <code>false</code>.</p>
		 * 
		 * 	<p>The <code>Easing</code> object follows the function signature popularized by
		 * 	Robert Penner. For more information, see http://www.robertpenner.com/profmx.</p>
		 * 	
		 * 	@param	value 	A new <code>Easing</code> object to use as animation for
		 * 					transition between two views.
		 * 
		 * 	@see #useAnimation
		 *  @see org.flashapi.swing.motion.Tween#setEasingFunction();
		 */
		public function setEasingFunction(value:Easing):void {
			_tweenEasing = value;
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_selectedView = null;
			if (_tween != null) {
				_tween.finalize();
				_tween = null
			}
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function resize(width:Number, height:Number):void { 
			if($objList.size > 0) _needsViewWResize = _needsViewHResize = true;
			super.resize(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			fixDisplayContainer($selectedIndex);
			super.createUIObject(x, y);
			
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			lookAndFeel.drawBackground();
			lookAndFeel.drawBorder();
			if (_needsViewHResize) {
				resizeViewHeight();
				_needsViewHResize = false;
			}
			if (_needsViewWResize) {
				updateItemsWidth();
				_needsViewWResize = false;
			}
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function updateItemList():void {
			var it:Iterator = $objList.iterator;
			var ac:AccordionContainer;
			var s:uint = $objList.size;
			_viewHeight = $height - s * AccordionContainer.HEADER_HEIGHT;
			var h:AccordionHeader;
			var c:Canvas;
			var i:int = 0;
			var next:ListItem;
			var nextHeight:Number = 0;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				ac = next.item;
				h = next.item.header;
				c = next.item.view;
				c.scaleX = c.scaleY = 0;
				ac.y = nextHeight;
				if (i == $selectedIndex) {
					if($listItem) setheaderHighlight($listItem, false);
					$listItem = next;
					ac.setViewHeight(_viewHeight);
					if ($active) setheaderHighlight($listItem);
					nextHeight += AccordionContainer.HEADER_HEIGHT + _viewHeight;
				} else {
					ac.setViewHeight(0);
					nextHeight +=  AccordionContainer.HEADER_HEIGHT;
				}
				h.enabled = $enabled;
				h.active = c.active = $active;
				ac.spas_internal::itemIndex = i;
				++i;
			}
			it.reset();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var it:Iterator = $objList.iterator;
			var ac:AccordionContainer;
			while(it.hasNext()) { 
				ac = it.next().item;
				ac.fixLaf();
			}
			it.reset();
		}
		
		/**
		 *  @private
		 */
		spas_internal function setSelectedAccordionContainer(value:AccordionContainer):void {
			if ($dataList[value] != $listItem) {
				setheaderHighlight($listItem, false);
				_previousItem = $listItem;
				$listItem = $dataList[value];
				var view:Canvas = $listItem.item.view;
				var viewScale:Array = $listItem.item.viewScale;
				view.scaleX = viewScale[0];
				view.scaleY = viewScale[1];
				spas_internal::fixSizeToContent();
				setheaderHighlight($listItem);
				if(_useAnimation) {
					_tween = new Tween(this, 0, _viewHeight, 300);
					if(_tweenEasing!=null) _tween.setEasingFunction(_tweenEasing);
					$evtColl.addEvent(_tween, MotionEvent.UPDATE, tweenUpdateHandler);
					$evtColl.addEvent(_tween, MotionEvent.FINISH, tweenFinishTweenHandler);
					_tween.play();
				} else {
					$listItem.item.setViewHeight(_viewHeight);
					_previousItem.item.setViewHeight(0);
					fixItemPositions();
				}
				$selectedIndex = $listItem.index;
				dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
			}
		}
		
		/**
		 *  @private
		 */
		spas_internal function fixSizeToContent():void {
			if (!_resizeToContent) return;
			var w:Number = $listItem.item.view.width;
			if(w > 0 && w != $width) {
				$width = $listItem.item.view.width;
				var it:Iterator = $objList.iterator;
				var ac:AccordionContainer;
				while(it.hasNext()) { 
					ac = it.next().item;
					ac.width = $width;
				}
				setRefresh();
				it.reset();
			}
		}
		
		/**
		 *  @private
		 */
		override protected function changeCurrentIndex():void {
			fixDisplayContainer($selectedIndex);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _border:Sprite;
		private var _previousItem:ListItem = null;
		private var _tween:Tween;
		private var _viewHeight:Number;
		private var _tweenEasing:Easing = null;
		private var _needsViewHResize:Boolean = false;
		private var _needsViewWResize:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			createBackground();
			initSize(width, height);
			initMinSize(50, 50);
			$dataList = new Dictionary(true);
			createContainers();
			initLaf(AccordionUIRef);
			spas_internal::lafDTO.background = spas_internal::background;
			spas_internal::lafDTO.border = _border;
			spas_internal::lafDTO.backgroundOpacity = 1;
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			spas_internal::setSelector(Selectors.ACCORDION);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			$content = new Sprite();
			spas_internal::uioSprite.addChild($content);
			_border = new Sprite();
			spas_internal::uioSprite.addChild(_border);
		}
		
		private function setheaderHighlight(item:ListItem, value:Boolean = true):void {
			item.item.header.selected = value;
		}
		
		private function tweenUpdateHandler(e:MotionEvent):void {
			$listItem.item.setViewHeight(Number(e.value));
			_previousItem.item.setViewHeight(_viewHeight-Number(e.value));
			fixItemPositions();
		}
		
		private function fixItemPositions():void {
			var nextItem:ListItem;
			var prevItem:ListItem;
			var nextAC:AccordionContainer;
			var prevAc:AccordionContainer;
			var i:uint = 1
			for(; i < $objList.size; ++i) {
				prevItem = $objList.get(i-1) as ListItem;
				nextAC = prevItem.item;
				nextItem = $objList.get(i) as ListItem;
				prevAc = nextItem.item;
				prevAc.y = nextAC.y + nextAC.height;
			}
		}
		
		private function tweenFinishTweenHandler(e:MotionEvent):void {
			var view:Canvas = _previousItem.item.view;
			view.scaleX = view.scaleY = 0;
			$listItem.item.setViewHeight(_viewHeight);
			_previousItem.item.setViewHeight(0);
			fixItemPositions();
			$evtColl.removeEvent(_tween, MotionEvent.UPDATE, tweenUpdateHandler);
			$evtColl.removeEvent(_tween, MotionEvent.FINISH, tweenFinishTweenHandler);
			_tween.finalize();
			_tween = null;
			this.dispatchEvent(new AccordionEvent(AccordionEvent.ANIMATION_FINISH));
		}
		
		private function fixDisplayContainer(value:Number):void {
			if($objList.size <= 0) return;
			var id:Number = -1;
			if(value < 0) id = 0;
			else if(value > $objList.size-1) id = $objList.size-1;
			else id = value;
			var ac:AccordionContainer = $objList.get(id).item;
			spas_internal::setSelectedAccordionContainer(ac);
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			var it:Iterator = $dataProvider.iterator;
			while(it.hasNext()) {
				var obj:Object = it.next();
				var li:ListItem = addItem(obj.label, obj.data);
				var view:Canvas
				if(obj.element) {
					view = li.item.view;
					view.removeElements();
					view.addElement(obj.element, obj.type != null ? obj.type : DataFormat.GRAPHIC);
				}
			}
			it.reset();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
			updateItemList();
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			checkStrictMode("Accordion");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			var prop:XML;
			for each(prop in data.item) {
				var li:ListItem = addItem(prop.@label.toString(), prop.@data.toString());
				var view:Canvas = li.item.view;
				view.removeElements();
				view.addElement(prop.@element, prop.@type != null ? prop.@type : DataFormat.GRAPHIC);
			}
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
			updateItemList();
		}
		
		private function fixAccordionContainersLaf():void {
			var it:Iterator = $objList.iterator;
			var ac:AccordionContainer;
			while(it.hasNext()) { 
				ac = it.next().item;
				ac.fixLaf();
			}
			it.reset();
		}
		
		private function resizeViewHeight():void {
			$listItem.item.setViewHeight(_viewHeight);
			fixItemPositions();
		}
		
		private function updateItemsWidth():void {
			var it:Iterator = $objList.iterator;
			it.reset();
			var next:ListItem;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				next.item.updateWidth();
			}
			it.reset();
		}
	}
}