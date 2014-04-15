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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// AbstractGallery.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 22/02/2010 21:55
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.CaptionPosition;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.containers.GalleryContainer;
	import org.flashapi.swing.core.Gallery;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.layout.Layout;
	import org.flashapi.swing.list.ALM;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>Gallery</code> value changes due to mouse or
	 * 	keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 * 	The <code>AbstractGallery</code> class represents the base class for
	 * 	picture viewers with thumbnails preview and caption texts.
	 * 
	 * 	<p>For a list of CSS properties supported by <code>Gallery</code> objects
	 * 	see: <a href="Gallery.html" title="org.flashapi.swing.core.Gallery">
	 * 	<code>org.flashapi.swing.core.Gallery</code></a>.</p>
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 *  @see org.flashapi.swing.databinding.XMLQuery
	 * 	
	 *  @see org.flashapi.swing.containers.GalleryContainer
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractGallery extends ALM implements Gallery {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractGallery</code> instance.
		 * 
		 * 	@param width 	The width of the gallery in pixels. Default value is
		 * 					<code>400</code> px.
		 * 	@param height 	The width of the gallery  in pixels. Default value is
		 * 					<code>100</code> px.
		 * 	@param	borderStyle 	The style of the gallery border, defined by 
		 * 							<code>BorderStyle</code> class constants.
		 * 							Default value is <code>BorderStyle.NONE</code>.
		 */
		public function AbstractGallery(width:Number = 400, height:Number = 100, borderStyle:String = "none") {
			super();
			initObj(width, height, borderStyle);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set backgroundAlpha(value:Number):void {
			box.backgroundAlpha = super.backgroundAlpha = value;
		}
		
		/**
		 *  @private
		 */
		override public function set backgroundColor(value:*):void {
			$backgroundColor = value == Color.DEFAULT ? 
				box.lookAndFeel.getBackgroundColor() : getColor(value);
			box.backgroundColor = value;
			//setRefresh();
		}
		
		/**
		 * 	@copy org.flashapi.swing.border.Border#borderStyle
		 */
		public function get borderStyle():String {
			return box.borderStyle;
		}
		public function set borderStyle(value:String):void {
			box.borderStyle = value;
		}
		
		private var _captionPosition:String = CaptionPosition.BOTTOM;
		/**
		 * 	@inheritDoc
		 */
		public function get captionPosition():String {
			return _captionPosition;
		}
		public function set captionPosition(value:String):void { 
			_captionPosition = value;
			for(var gc:Object in $dataList) gc.caption.textAlign = value;
		}
		
		private var _fontColor:* = null;
		/**
		 * 	@inheritDoc
		 */
		public function get fontColor():* {
			return _fontColor;
		}
		public function set fontColor(value:*):void { 
			_fontColor = value;
			for(var gc:Object in $dataList) gc.caption.fontColor = value;
		}
		
		private var _fontSize:Number;
		/**
		 * 	@inheritDoc
		 */
		public function get fontSize():* {
			return _fontSize;
		}
		public function set fontSize(value:*):void {
			_fontSize = value;
			for(var gc:Object in $dataList) gc.caption.fontSize = value;
		}
		
		/**
		 *  @private
		 */
		protected var box:Box;
		/**
		 * 	Returns a reference to the <code>Box</code> instance that is used as
		 * 	container for the <code>Gallery</code> object.
		 */
		public function get galleryContainer():Box {
			return box;
		}
		
		/**
		 *  @private
		 */
		override public function get height():Number {
			return box.height;
		}
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			$height = box.height = value;
			setRefresh();
		}
		
		private var _selectable:Boolean;
		/**
		 * 	@inheritDoc
		 */
		public function get selectable():Boolean {
			return _selectable;
		}
		public function set selectable(value:Boolean):void {
			_selectable = value;
			for(var gc:Object in $dataList) gc.caption.selectable = value;
		}
		
		private var _showCaptions:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get showCaptions():Boolean {
			return _showCaptions;
		}
		public function set showCaptions(value:Boolean):void {
			_showCaptions = value;
			//for(var gc:Object in dataList) gc.caption.selectable = value;
		}
		
		private var _textAlign:String = TextAlign.LEFT;
		/**
		 * 	@inheritDoc
		 */
		public function get textAlign():String {
			return _textAlign;
		}
		public function set textAlign(value:String):void { 
			_textAlign = value;
			for(var gc:Object in $dataList) gc.caption.textAlign = value;
		}
		
		/**
		 *  @private
		 */
		override public function get width():Number {
			return box.width;
		}
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			$width = box.width = value;
			setRefresh();
		}
		
		private var _thumbnailClassName:String = "";
		/**
		 * 	@inheritDoc
		 */
		public function get thumbnailClassName():String {
			return _thumbnailClassName;
		}
		public function set thumbnailClassName(value:String):void { 
			_thumbnailClassName = value;
			for(var gc:Object in $dataList) gc.thumbnail.className = value;
		}
		
		private var _containerClassName:String = "";
		/**
		 * 	@inheritDoc
		 */
		public function get containerClassName():String {
			return _containerClassName;
		}
		public function set containerClassName(value:String):void { 
			_containerClassName = value;
			for(var gc:Object in $dataList) gc.className = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get layout():Layout {
			return box.layout;
		}
		public function set layout(value:Layout):void {
			box.layout = value;
		}
		
		/**
		 *  @private
		 */
		override public function set autoSize(value:Boolean):void {
			$autoSize = box.autoSize = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set autoWidth(value:Boolean):void {
			$autoWidth = box.autoWidth = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set autoHeight(value:Boolean):void {
			$autoHeight = box.autoHeight = value;
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
		override public function remove():void { 
			if ($displayed) {
				box.remove();
				unload(); 
			}
		}
		
		/**
		 *  @private
		 */
		override public function removeAll():void {
			box.removeElements();
			super.removeAll();
		}
		
		/**
		 *  @private
		 */
		public function setSelectedPicture(value:GalleryContainer):void {
			$listItem = $dataList[value];
			$data = $listItem.data;
			$value = $listItem.value;
			spas_internal::setIndex($listItem.index);
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return box.getBounds(targetCoordinateSpace);
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return box.getRect(targetCoordinateSpace);
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			box.finalizeElements();
			box.finalize();
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
			box.lockLaf(lookAndFeel.getBoxLaf(), true);
			var gc:GalleryContainer;
			for each(gc in $dataList) gc.fixLaf();
			updateItemList();
		}
		
		/**
		 *  @private
		 */
		protected function dataProviderChangedHandler(e:ListEvent):void { }
		
		/**
		 *  @private
		 */
		protected function xmlQueryChangedHandler(e:ListEvent):void { }
		
		/**
		 * @private
		 */
		protected function getCaption(value:Object):String {
			return value.caption != null ? value.caption : "";
		}
		
		/**
		 * @private
		 */
		protected function getAlt(value:Object):* {
			return value.alt != null ? value.alt : null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number, borderStyle:String):void {
			$finalizeItems = false;
			box = new Box(width, height, borderStyle);
			box.target = spas_internal::uioSprite;
			$dataList = new Dictionary();
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			initMinSize(50, 50);
		}
	}
}