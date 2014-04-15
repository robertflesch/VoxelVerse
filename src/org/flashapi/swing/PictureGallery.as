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
	// PictureGallery.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 21:21
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.containers.PictureGalleryContainer;
	import org.flashapi.swing.core.AbstractGallery;
	import org.flashapi.swing.core.Gallery;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.LayoutEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.libs.PictureGalleryUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("PictureGallery.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>PictureGallery</code> instance has been populated
	 * 	by using a <code>DataProvider</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the <code>PictureGallery</code> instance has been populated
	 * 	by using a <code>XMLQuery</code> object.
	 * 
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 * 	<img src="PictureGallery.png" alt="PictureGallery" width="18" height="18"/>
	 * 
	 * 	The <code>PictureGallery</code> class represents a "grid-like" picture
	 * 	viewer with thumbnail previews. You can specify a caption text for each thumbnail
	 * 	displayed within a <code>PictureGallery</code>.
	 * 
	 * 	<p>The <code>autoHeight</code> value for <code>PictureGallery</code> instances
	 * 	is set to <code>true</code>.</p>
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>PictureGallery</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>image:String</code>; the <code>value.image</code> parameter of the
	 * 		<code>PictureGallery.addItem()</code> method,</li>
	 * 		<li><code>caption:String</code>; the <code>value.caption</code> parameter of
	 * 		the <code>PictureGallery.addItem()</code> method,</li>
	 * 		<li><code>alt:String</code>; the <code>value.alt</code> parameter of the
	 * 		<code>PictureGallery.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter of the
	 * 		<code>PictureGallery.addItem()</code> method.</li>
	 * 	</ul>
	 * 	</p>
	 * 	<p>You also can assign a <code>XMLQuery</code> object to a <code>PictureGallery</code>
	 * 	instance.</p>
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="PictureGallery" urlPath="my_URLPath"&gt;
	 *			&lt;item image="img_url" caption="caption" alt="alt" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 	<p>The following table lists the attributes you can specify, their data types, and their
	 * 	purposes:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Must be <code>"PictureGallery"</code>; if the <code>XMLQuery.strictMode</code>
	 * 			property is <code>true</code> you must specifie this attribute.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>PictureGallery.urlPath</code> property.</td>
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
	 * 			<td>Specifies the text used as the <code>alt</code> property for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string used as the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 	
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 	<code>PictureGallery</code>:</p>
	 * 	<p>
	 * 		- using the <code>PictureGallery.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var pg:PictureGallery = new PictureGallery();
	 * 			
	 * 			var obj1:Object = { image:"url_1.jpg", alt:"alt 1", caption:"Caption 1" };
	 * 			pg.addItem(obj1, "myData1");
	 * 
	 * 			var obj2:Object = { image:"url_2.jpg", alt:"alt 2", caption:"Caption 2" };
	 * 			pg.addItem(obj2, "myData2");
	 * 
	 * 			var obj3:Object = { image:"url_3.jpg", alt:"alt 3", caption:"Caption 3" };
	 * 			pg.addItem(obj3, "myData3");
	 * 
	 * 			var obj4:Object = { image:"url_4.jpg", alt:"alt 4", caption:"Caption 4" };
	 * 			pg.addItem(obj4, "myData4");
	 * 
	 * 			pg.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>PictureGallery.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var pg:PictureGallery = new PictureGallery();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 
	 * 			dp.addAll(  { image:"url_1.jpg", alt:"alt 1", caption:"Caption 1", data:"myData1" },
	 * 						{ image:"url_2.jpg", alt:"alt 2", caption:"Caption 2", data:"myData2" },
	 * 						{ image:"url_3.jpg", alt:"alt 3", caption:"Caption 3", data:"myData3" },
	 * 						{ image:"url_4.jpg", alt:"alt 4", caption:"Caption 4", data:"myData4" });
	 * 			pg.dataProvider = dp;
	 * 
	 * 			pg.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>PictureGallery.xmlQuery</code> property:
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
	 * 			var pg:PictureGallery = new PictureGallery();
	 * 			pg.xmlQuery = request;
	 * 
	 * 			pg.display()
	 * 		</listing>
	 * 	</p>
	 * 
	 *  @includeExample PictureGalleryExample.as
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
	public class PictureGallery extends AbstractGallery implements Gallery, Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>PictureGallery</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param width 	The width of the <code>PictureGallery</code> instance, in
		 * 					pixels.
		 * 	@param height 	The height of the <code>PictureGallery</code> instance,
		 * 					in pixels. (Not implemented yet.)
		 * 	@param	borderStyle 	The style of the <code>PictureGallery</code> border,
		 * 							defined by <code>BorderStyle</code> class constants.
		 * 							Default value is <code>BorderStyle.NONE</code>.
		 */
		public function PictureGallery(width:Number = 400, height:Number = 400, borderStyle:String = "none") {
			super(width, width, borderStyle);
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
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			var caption:String = getCaption(value);
			var pgc:PictureGalleryContainer = new PictureGalleryContainer(this, caption);
			if (value.image != null) pgc.thumbnail.addElement(value.image);
			var __alt:String = getAlt(value);
			if(__alt != null) pgc.thumbnail.alt = __alt;
			var li:ListItem = new ListItem(pgc, $objList, caption, data);
			$dataList[pgc] = li;
			box.addElement(pgc);
			/*_height = box.height;
			_width = box.width;*/
			if(!_invalidateItemList) updateItemList();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			return null;
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		override public function removeItem(item:ListItem):void {
			/*var pgc:GalleryContainer = item.item;
			if(pgc.displayed) pgc.remove();
			objList.remove(item);
			_listItem = null, _value = _data = null;
			updateItemList();
			setRefresh();*/
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
			//fixDisplayContainer(_selectedIndex);
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			box.spas_internal::updateLayout();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function dataProviderChangedHandler(e:ListEvent):void {
			$dataList = new Dictionary(true);
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
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		/**
		 *  @private
		 */
		override protected function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			checkStrictMode("PictureGallery");
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			box.invalidateLayout = _invalidateItemList = true;
			box.removeElements();
			for each(var prop:XML in data.item) {
				var value:Object = {
					image:$urlPath + prop.@image.toString(), alt:prop.@alt.toString(),
					caption:prop.@caption.toString()
				};
				addItem(value, prop.@data);
			}
			box.invalidateLayout = _invalidateItemList = false;
			setRefresh();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		/**
		 *  @private
		 */
		override protected function updateItemList():void {
			var i:int = 0;
			var obj:Object;
			for (; i < box.numElements; ++i) {
				obj = box.getElementAt(i);
				obj.spas_internal::setIndex(i);
			}
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _invalidateItemList:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initLaf(PictureGalleryUIRef);
			$autoHeight = box.autoHeight = true;
			$evtColl.addEvent(box.layout, LayoutEvent.LAYOUT_FINISHED, updateTargetLayout);
			spas_internal::setSelector(Selectors.PICTURE_GALLERY);
			spas_internal::isInitialized(1);
		}
		
		private function updateTargetLayout(e:LayoutEvent):void {
			$width = box.width;
			$height = box.height;
			$storedSize.checkMetricsChanges();
		}
	}
}