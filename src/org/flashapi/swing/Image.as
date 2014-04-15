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
	// Image.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.6, 15/03/2010 22:42
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.ImageMap;
	import org.flashapi.swing.event.ImageEvent;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.plaf.libs.ImageUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Image.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the external source for this <code>Image</code> instance
	 * 	is fully loaded.
	 *
	 *  @eventType org.flashapi.swing.event.ImageEvent.IMAGE_LOADED
	 */
	[Event(name = "imageLoaded", type = "org.flashapi.swing.event.ImageEvent")]
	
	/**
	 *  Dispatched when the external source for this <code>Image</code> instance
	 * 	is fully loaded.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.METRICS_CHANGED
	 */
	[Event(name = "metricsChanged", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 * 	<img src="Image.png" alt="Image" width="18" height="18"/>
	 * 
	 *  The <code>Image</code> class lets you create a specific wrapper object
	 * 	for graphic images. Its functionalities are very similar to that of the
	 * 	<code>image</code> HTML element. <code>image</code> instances can 
	 * 	display external images, such as SWF and bitmap files, or embeded assets.
	 * 
	 *  @includeExample ImageExample.as
	 * 
	 * 	@see org.flashapi.swing.draw.ImageMap
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Image extends UIContainer implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Image</code> instance with the specified
		 * 					parameters.
		 * 
		 * 	@param	src		The source object for this <code>Image</code> instance.
		 * 					Default value is <code>null</code>.
		 * 	@param	width	The width of this <code>Image</code> instance, in pixels. Default value is <code>NaN</code>.
		 * 	@param	height	The height of this <code>Image</code> instance, in pixels. Default value is <code>NaN</code>.
		 * 	@param	fitContentToFrame	A <code>Boolean</code> value that indicates 
		 * 								whether the size of the source image fits to
		 * 								the size defined for this <code>Image</code>
		 * 								instance (<code>true</code>), or not
		 * 								(<code>false</code>).
		 * 								Default value is <code>false</code>.
		 * 	@param	respectRatio	A <code>Boolean</code> value that indicates whether
		 * 							the image ratio is respected (<code>true</code>), 
		 * 							or not (<code>false</code>). This property is only
		 * 							used when the <code>fitContentToFrame</code> is
		 * 							<code>true</code>.
		 */
		public function Image(src:* = null, width:Number = NaN, height:Number = NaN, fitContentToFrame:Boolean = false, respectRatio:Boolean = true) {
			super();
			initObj(src, width, height, fitContentToFrame, respectRatio);
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
		
		private var _alt:String = null;
		/**
		 * 	A <code>String</code> that represents the alternate text of this
		 * 	<code>Image</code> instance. The alternate text is displayed within a
		 * 	<code>BoxHelp</code> instance. If <code>null</code>, the <code>BoxHelp</code>
		 * 	is not displayed.
		 * 
		 * 	@default null
		 * 
		 * 	@see #longdesc
		 * 	@see #boxhelp
		 */
		public function get alt():String {
			return _alt;
		}
		public function set alt(value:String):void {
			_alt = value;
			if (_alt != null) _boxhelp.label = _alt;
		}
		
		/**
		 * 	Returns a reference of the <code>BoxHelp</code> instance used to display
		 * 	the alternate text specified by the <code>alt</code> property.
		 * 
		 * 	@see #alt
		 */
		public function get boxhelp():BoxHelp {
			return _boxhelp;
		}
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = _fitContentToFrame ?
				new Rectangle(0, 0, _storedImgWidth, _storedImgHeight) :
					new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		/**
		 * @private
		 */
		override public function get height():Number {
			var h:Number = NaN;
			if (!isNaN($height)) h = $height;
			else if (_src != null) h = _imageContainer.height;
			return h;
		}
		
		private var _longdesc:String = null;
		/**
		 * 	This attribute specifies a link to a long description of the image.
		 * 	This description should supplement the short description provided using the
		 * 	<code>alt</code> property. When the image has an associated image map,
		 * 	this attribute should provide information about the content of the map.
		 * 
		 * 	@see #alt
		 * 	@see #usemap
		 */
		public function get longdesc():String {
			return _longdesc;
		}
		public function set longdesc(value:String):void {
			_longdesc = value;
		}
		
		private var _fitContentToFrame:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the size of the source
		 * 	image fits to the size defined for this <code>Image</code> instance
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #respectRatio
		 */
		public function get fitContentToFrame():Boolean {
			return _fitContentToFrame;
			setRefresh();
		}
		public function set fitContentToFrame(value:Boolean):void {
			_fitContentToFrame = value;
		}
		
		private var _respectRatio:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the image ratio is
		 * 	respected (<code>true</code>), or not (<code>false</code>). This property
		 * 	is only used when the <code>fitContentToFrame</code> is <code>true</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #fitContentToFrame
		 */
		public function get respectRatio():Boolean {
			return _respectRatio;
		}
		public function set respectRatio(value:Boolean):void {
			_respectRatio = value;
			setRefresh();
		}
		
		private var _src:* = null;
		/**
		 * 	Sets or gets the source image for this <code>Image</code> instance.
		 * 	
		 * 	@default null
		 */
		public function get source():* {
			return _src;
		}
		public function set source(src:*):void {
			_imageContainer.removeElements();
			if (src != null) _src = _imageContainer.addElement(src);
		}
		
		/**
		 * 	Associates an image map object to this <code>Image</code> instance.
		 * 
		 * 	@param	value	A XML file/object to use as map. The value parameter
		 * 					can be an URI, or a XML object. If using an URI as parameter,
		 * 					the external XML file is automatically loaded.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalArgumentException An
		 * 			<code>IllegalArgumentException</code> if the <code>value</code>
		 * 			parameter is neither an URI or a <code>XML</code> object.
		 * 
		 * 	@see org.flashapi.swing.draw.ImageMap
		 */
		public function set usemap(value:*):void { 
			if(_imageMap == null) _imageMap = new ImageMap(this);
			_imageMap.setMapData(value);
		}
		
		/**
		 * @private
		 */
		override public function get width():Number {
			var w:Number = NaN;
			if (!isNaN($width)) w = $width;
			else if (_src != null) w = _imageContainer.width;
			return w;
		}
		
		private var _vAlign:String;
		/**
		 * 	Sets or get the vertical alignment of the wrapped image within this
		 * 	<code>Image</code> instance. Valid values are the constants
		 * 	of the <code>LayoutVerticalAlignment</code> class.
		 * 
		 * 	@default LayoutVerticalAlignment.TOP
		 * 
		 * 	@see #hAlign
		 */
		public function get vAlign():String {
			return _vAlign;
		}
		public function set vAlign(value:String):void {
			_vAlign =
			_imageContainer.layout.verticalAlignment = value;
		}
		
		private var _hAlign:String;
		/**
		 * 	Sets or get the horizontal alignment of the wrapped image within this
		 * 	<code>Image</code> instance. Valid values are the constants
		 * 	of the <code>LayoutHorizontalAlignment</code> class.
		 * 
		 * 	@default LayoutHorizontalAlignment.LEFT
		 * 
		 * 	@see #hAlign
		 */
		public function get hAlign():String {
			return _hAlign;
		}
		public function set hAlign(value:String):void {
			_hAlign =
			_imageContainer.layout.horizontalAlignment = value;
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
			if (_imageMap != null) _imageMap.finalize();
			_boxhelp.finalize();
			_imageContainer.removeElements();
			_imageContainer.finalize(); 
			super.finalize();
		}
		
		/**
		 * @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = _fitContentToFrame ? new Rectangle(0, 0, _storedImgWidth, _storedImgHeight) : new Rectangle(0, 0, $width, $height);
			return r;
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
			var vRatio:Number = 1;
			var hRatio:Number = 1;
			$content.scaleX = $content.scaleY = 1;
			var ic:Sprite = _imageContainer.content;
			if (!isNaN($width)) hRatio = $width / ic.width;
			if (!isNaN($height)) vRatio = $height / ic.height;
			if (_fitContentToFrame) {
				if (_respectRatio) {
					var r:Number = vRatio >= hRatio ? hRatio : vRatio;
					$content.scaleX = $content.scaleY = r;
					_storedImgWidth = ic.width * r;
					_storedImgHeight = ic.height * r;
				} else {
					$content.scaleX = hRatio;
					_storedImgWidth = ic.width * hRatio;
					$content.scaleY = vRatio;
					_storedImgHeight = ic.height * vRatio;
				}
			}
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _imageContainer:Canvas;
		private var _boxhelp:BoxHelp;
		private var _imageMap:ImageMap = null;
		private var _storedImgWidth:Number = NaN;
		private var _storedImgHeight:Number = NaN;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(src:*, width:Number, height:Number, fitContentToFrame:Boolean, respectRatio:Boolean):void {
			$width = width;
			$height = height;
			_fitContentToFrame = fitContentToFrame;
			_respectRatio = respectRatio;
			initMinSize(0, 0); 
			initLaf(ImageUIRef);
			spas_internal::uioSprite.addChild($content);
			$autoAdjustSize = true;
			_boxhelp = new BoxHelp();
			_imageContainer = new Canvas();
			if (!isNaN(width)) _imageContainer.width = $width;
			if (!isNaN(height)) _imageContainer.height = $height;
			addElement(_imageContainer);
			$evtColl.addEvent(_imageContainer, UIMouseEvent.ROLL_OVER, rollOverHandler);
			$evtColl.addEvent(_imageContainer, UIMouseEvent.ROLL_OUT, rollOutHandler);
			$evtColl.addEvent(_imageContainer, LoaderEvent.COMPLETE, onImageLoaded);
			this.source = src;
			spas_internal::setSelector(Selectors.IMAGE);
			spas_internal::isInitialized(1);
		}
		
		private function rollOverHandler(e:UIMouseEvent):void {
			if (_alt != null) {
				_boxhelp.shadow = $dropShadow;
				_boxhelp.glow = $glowFilter;
				_boxhelp.label = _alt;
				_boxhelp.display();
			}
		}
		
		private function rollOutHandler(e:UIMouseEvent):void {
			_boxhelp.remove();
		}
		
		private function onImageLoaded(e:LoaderEvent):void {
			this.dispatchEvent(new ImageEvent(ImageEvent.IMAGE_LOADED));
			dispatchUIOEvent(UIOEvent.METRICS_CHANGED);
		}
	}
}