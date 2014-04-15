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
	// ScrollGallery.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 17/03/2010 21:32
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.flashapi.swing.containers.ScrollGalleryContainer;
	import org.flashapi.swing.core.AbstractGallery;
	import org.flashapi.swing.core.Gallery;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.libs.PictureGalleryUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ScrollGallery.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>ScrollGallery</code> instance has been populated
	 * 	by a <code>DataProvider</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the <code>ScrollGallery</code> instance has been populated
	 * 	by a <code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 * 	<img src="ScrollGallery.png" alt="ScrollGallery" width="18" height="18"/>
	 * 
	 * 	The <code>ScrollGallery</code> class represents a "scrolling" picture viewer with 
	 * 	thumbnails preview. You can specify a caption text for each thumbnail displayed 
	 * 	within a <code>PictureGallery</code>.
	 * 
	 * 	<p>When setting the <code>autoWidth</code> or <code>autoSize</code> properties
	 * 	to <code>true</code>, the gallery is not horizontally resized. This functionality 
	 * 	has been removed because it always will deactivate the scrolling effect. To
	 * 	create an auto sized single line gallery of thumbnails, you can use a
	 * 	<code>PictureGallery</code> instance with <code>autoSize</code> set to <code>true</code>.
	 * 	</p>
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>ScrollGallery</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>image:String</code>; the <code>value.image</code> parameter of the
	 * 		<code>ScrollGallery.addItem()</code> method,</li>
	 * 		<li><code>caption:String</code>; the <code>value.caption</code> parameter of
	 * 		the <code>ScrollGallery.addItem()</code> method,</li>
	 * 		<li><code>alt:String</code>; the <code>value.alt</code> parameter of the 
	 * 		<code>ScrollGallery.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter of
	 * 		the <code>ScrollGallery.addItem()</code> method.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>You also can assign a <code>XMLQuery</code> object to a <code>ScrollGallery</code>
	 * 	instance.</p>
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="ScrollGallery" urlPath="my_URLPath"&gt;
	 *			&lt;item image="img_url" caption="caption" alt="alt" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 	<p>The following table lists the attributes you can specify, their data types,
	 * 	and their purposes:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Must be <code>ScrollGallery</code>; you must specifie this attribute if the
	 * 			<code>XMLQuery.strictMode</code> property is <code>true</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>ScrollGallery.urlPath</code> property.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.image</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used as thumbnail for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.caption</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used as caption for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.alt</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used to set the <code>alt</code> property of
	 * 			this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string used as the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 	
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 	<code>ScrollGallery</code>:</p>
	 * 	<p>
	 * 		- using the <code>ScrollGallery.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var sg:ScrollGallery = new ScrollGallery();
	 * 			
	 * 			var obj1:Object = { image:"url_1.jpg", alt:"alt 1", caption:"Caption 1" };
	 * 			sg.addItem(obj1, "myData1");
	 * 
	 * 			var obj2:Object = { image:"url_2.jpg", alt:"alt 2", caption:"Caption 2" };
	 * 			sg.addItem(obj2, "myData2");
	 * 
	 * 			var obj3:Object = { image:"url_3.jpg", alt:"alt 3", caption:"Caption 3" };
	 * 			sg.addItem(obj3, "myData3");
	 * 
	 * 			var obj4:Object = { image:"url_4.jpg", alt:"alt 4", caption:"Caption 4" };
	 * 			sg.addItem(obj4, "myData4");
	 * 
	 * 			sg.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ScrollGallery.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var sg:ScrollGallery = new ScrollGallery();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 
	 * 			dp.addAll(  { image:"url_1.jpg", alt:"alt 1", caption:"Caption 1", data:"myData1" },
	 * 						{ image:"url_2.jpg", alt:"alt 2", caption:"Caption 2", data:"myData2" },
	 * 						{ image:"url_3.jpg", alt:"alt 3", caption:"Caption 3", data:"myData3" },
	 * 						{ image:"url_4.jpg", alt:"alt 4", caption:"Caption 4", data:"myData4" });
	 * 			sg.dataProvider = dp;
	 * 
	 * 			sg.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ScrollGallery.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item image="url_1.jpg" caption="Caption 1" alt="alt 1" data="myData1" /&gt;
	 *								&lt;item image="url_2.jpg" caption="Caption 2" alt="alt 2" data="myData2" /&gt;
	 *								&lt;item image="url_3.jpg" caption="Caption 3" alt="alt 3" data="myData3" /&gt;
	 * 								&lt;item image="url_4.jpg" caption="Caption 3" alt="alt 3" data="myData4" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var sg:ScrollGallery = new ScrollGallery();
	 * 			sg.xmlQuery = request;
	 * 
	 * 			sg.display()
	 * 		</listing>
	 * 	</p>
	 * 
	 *  @includeExample ScrollGalleryExample.as
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 *  @see org.flashapi.swing.databinding.XMLQuery
	 *  @see org.flashapi.swing.containers.GalleryContainer
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScrollGallery extends AbstractGallery implements Gallery, Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ScrollGallery</code> instance with the
		 * 					specified properties.
		 * 
		 * 	@param width 	The width of the <code>ScrollGallery</code> instance, in
		 * 					pixels.
		 * 	@param height 	The height of the <code>ScrollGallery</code> instance, in
		 * 					pixels.
		 * 	@param	borderStyle 	The style of the <code>ScrollGallery</code> instance
		 * 							border, defined by <code>BorderStyle</code> class 
		 * 							constants. Default value is <code>BorderStyle.NONE</code>.
		 */
		public function ScrollGallery(width:Number = 400, height:Number = 100, borderStyle:String = "none") {
			super(width, height, borderStyle);
			initObj();
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
		 *  @private
		 */
		override public function set autoSize(value:Boolean):void { }
		
		/**
		 *  @private
		 */
		override public function set autoWidth(value:Boolean):void { }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			var caption:String = getCaption(value);
			var sgc:ScrollGalleryContainer = new ScrollGalleryContainer(this, caption);
			if (value.image != null) sgc.thumbnail.addElement(value.image);
			var __alt:String = getAlt(value);
			if(__alt != null) sgc.thumbnail.alt = __alt;
			var li:ListItem = new ListItem(sgc, $objList, caption, data);
			$dataList[sgc] = li;
			if (box.numElements == 0) sgc.x = box.paddingLeft;
			if(!_invalidateItemList) updateItemList();
			box.addElement(sgc);
			return li;
		}
		
		/**
		 *  [Not implemented yet.]
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			return null;
		}
		
		/**
		 *  [Not implemented yet.]
		 */
		override public function removeItem(item:ListItem):void {
			/*var pgc:GalleryContainer = item.item;
			if(pgc.displayed) pgc.remove();
			objList.remove(item);
			_listItem = null, _value = _data = null;
			updateItemList();
			setRefresh();*/
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			spas_internal::timer.stop();
			super.remove();
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			spas_internal::timer.stop();
			spas_internal::timer = null;
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
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			box.display();
			refresh();
			doStartEffect();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			drawHitZone();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function dataProviderChangedHandler(e:ListEvent):void {
			$dataList = new Dictionary();
			box.invalidateLayout = _invalidateItemList = true;
			box.removeElements();
			var it:Iterator = $dataProvider.iterator;
			it.reset();
			while(it.hasNext()) {
				var obj:Object = it.next();
				var value:Object = { image:obj.image, alt:obj.alt, caption:obj.caption };
				var d:* = obj.data == null ? null : obj.data;
				addItem(value, d);				
			}
			it.reset();
			obj = null, value = null;
			box.invalidateLayout = _invalidateItemList = false;
			updateItemList();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		/**
		 *  @private
		 */
		override protected function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			checkStrictMode("ScrollGallery");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			box.invalidateLayout = _invalidateItemList = true;
			box.removeElements();
			for each(var prop:XML in data.item) {
				var value:Object = {
						image:$urlPath + prop.@image.toString(),
						alt:prop.@alt.toString(), caption:prop.@caption.toString()
					};
				addItem(value, prop.@data);
			}
			box.invalidateLayout = _invalidateItemList = false;
			updateItemList();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		/**
		 *  @private
		 */
		override protected function updateItemList():void {
			if(_isScrolling) spas_internal::timer.stop();
			var i:int = 0;
			var obj:Object;
			var prev:Object;
			var g:Number = box.horizontalGap;
			var h:Number = 0;
			for (; i < box.numElements; ++i) {
				obj = box.getElementAt(i);
				if (i > 0) {
					prev = box.getElementAt(i-1);
					obj.x = prev.x + prev.width + g;
				}
				obj.y = box.paddingTop;
				spas_internal::slideLength = obj.x + obj.width;
				if (obj.height > h) h = obj.height;
				obj.spas_internal::setIndex(i);
			}
			if ($autoHeight || $autoSize) box.height = box.paddingTop + h + box.paddingBottom;
			if (_isScrolling) spas_internal::timer.start();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Scrolling API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal function getSpeed():Number {
			if(!_isDecelerating) _speed = -(box.container.mouseX - box.width / 2) / 20;
			return _speed;
		}
		
		/**
		 *  @private
		 */
		spas_internal var timer:Timer;
		
		/**
		 *  @private
		 */
		spas_internal var slideLength:Number = 0;
		
		/**
		 *  @private
		 */
		spas_internal function updateItemsPositions():void {
			updateItemList();
		}
		
		private var _speed:Number = 0;
		private var _isScrolling:Boolean = false;
		private var _isDecelerating:Boolean = false;
		private var _isSpeedPositive:Boolean;
		
		private function mouseOverHandler(e:MouseEvent):void {
			if (spas_internal::timer.running) return;
			if (_isDecelerating) {
				_isDecelerating = false;
				$evtColl.removeEvent(spas_internal::timer, TimerEvent.TIMER, decelerationHandler);
			}
			spas_internal::timer.start();
			_isScrolling = true;
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			if (_hitZone.hitTestPoint($stage.mouseX, $stage.mouseY)) return;
			_isSpeedPositive = _speed > 0;
			$evtColl.addEvent(spas_internal::timer, TimerEvent.TIMER, decelerationHandler);
			_isDecelerating = true;
		}
		
		private function decelerationHandler(e:TimerEvent):void {
			if (_isSpeedPositive) _speed -= .20;
			else _speed += .25;
			if ((_isSpeedPositive && _speed <= 0) || (!_isSpeedPositive && _speed >= 0)) {
				$evtColl.removeEvent(spas_internal::timer, TimerEvent.TIMER, decelerationHandler);
				_speed = 0;
				spas_internal::timer.stop();
				_isDecelerating = _isScrolling = false;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _invalidateItemList:Boolean;
		private var _hitZone:Sprite;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_invalidateItemList = false;
			initLaf(PictureGalleryUIRef);
			spas_internal::timer = new Timer(25);
			box.setLayout();
			createHitZone();
			spas_internal::setSelector(Selectors.SCROLL_GALLERY);
			spas_internal::isInitialized(1);
		}
		
		private function createHitZone():void {
			_hitZone = new Sprite();
			spas_internal::uioSprite.addChild(_hitZone);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, mouseOverHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		private function drawHitZone():void {
			with (_hitZone.graphics) {
				clear();
				beginFill(0, 0);
				drawRect(0, 0, box.width, box.height);
				endFill();
			}
		}
	}
}