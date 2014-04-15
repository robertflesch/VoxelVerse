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
	// PictureGalleryContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 28/06/2009 12:47
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.CaptionPosition;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.core.Gallery;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.Text;
	import org.flashapi.swing.Thumbnail;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>PictureGalleryContainer</code> class creates a control object  
	 * 	composed of a caption/thumbnail pair displayed within the specified 
	 * 	<code>Gallery</code> object.
	 *
	 *  @see org.flashapi.swing.core.Gallery
	 *  @see org.flashapi.swing.core.AbstractGallery
	 *  @see org.flashapi.swing.containers.GalleryContainer
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 **/
	public class PictureGalleryContainer extends Canvas implements GalleryContainer {		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>PictureGalleryContainer</code> instance.
		 * 
		 * 	@param gallery 	The gallery object that creates the <code>PictureGalleryContainer</code>
		 * 					instance.
		 * 	@param captionText The plain text displayed by the caption control.
		 * 						Default value is <code>""</code>.
		 */
		public function PictureGalleryContainer(gallery:Gallery, captionText:String = "") {
			super();
			initObj(gallery, captionText);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		public static var laf:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Alternate text for this <code>PictureGalleryContainer</code> instance.
		 * 
		 * 	@see org.flashapi.swing.button.core.ABM#alt
		 * 
		 * 	@default null
		 */
		public function get alt():String {
			return _thumbnail.alt;
		}
		public function set alt(value:String):void {
			_thumbnail.alt = value;
		}
		
		private var _gallery:Gallery;
		/**
		 * 	Returns the parent <code>Gallery</code> instance for this picture gallery
		 * 	container.
		 */
		public function get gallery():Gallery {
			return _gallery;
		}
		
		private var _caption:Text;
		/**
		 * 	A refence to the <code>Text</code> object used by the gallery container to
		 * 	display the caption text.
		 * 
		 * 	@see org.flashapi.swing.Text
		 */
		public function get caption():Text {
			return _caption;
		}
		
		/**
		 * 	@private
		 */
		/*override public function set height(value:Number):void {
			//_height = _thumbnail.height = _caption.height = value;
			setRefresh();
		}*/
		
		private var _thumbnail:Thumbnail;
		/**
		 * 	A refence to the <code>Thumbnail</code> object for this picture gallery
		 * 	container. <code>Thumbnail</code> objects are used by the picture gallery
		 * 	to display images within the gallery container.
		 * 
		 * 	@see org.flashapi.swing.Thumbnail
		 */
		public function get thumbnail():Thumbnail {
			return _thumbnail;
		}
		
		/**
		 * 	@private
		 */
		/*override public function set width(value:Number):void {
			//_width = _thumbnail.width = _caption.width = value;
			setRefresh();
		}*/
		
		/**
		 * 	Sets or gets the text displayed within the caption control.
		 * 
		 * 	@default ""
		 */
		public function get text():String {
			return _caption.text;
		}
		public function set text(value:String):void {
			_caption.text = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		private var _captionPosition:String;
		/**
		 * 	Sets or gets the vertical position of the caption for this
		 * 	<code>PictureGalleryContainer</code> instance.
		 * 	<p>Valid values are:
		 * 		<ul>
		 * 			<li><code>CaptionPosition.TOP</code>,</li>
		 * 			<li><code>CaptionPosition.BOTTOM</code>.</li>
		 * 		</ul>
		 * 	</p>
		 * 
		 *  @param	value	The new vertical position of the caption.
		 * 
		 * 	@default	CaptionPosition.BOTTOM
		 */
		public function setCaptionPositions(value:String):void {
			if (_captionPosition == value) return;
			_captionPosition = value;
			refreshContainerDisplayList();
		}
		
		private var _showCaption:Boolean;
		/**
		 * 
		 * @param	value
		 */
		public function showCaption(value:Boolean):void {
			if (_showCaption == value) return;
			_showCaption = value;
			refreshContainerDisplayList();
		}
		
		/**
		 *  @private
		 */
		public function fixLaf():void {
			var lafObj:Object = (gallery as UIObject).lookAndFeel;
			_thumbnail.lockLaf(lafObj.getThumbnailLaf(), true);
			_caption.lockLaf(lafObj.getTextLaf(), true);
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			finalizeElements();
			_thumbnail = null;
			if (!_gallery.showCaptions) _caption.finalize();
			_caption = null;
			_gallery = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(gallery:Gallery, captionText:String):void {
			$autoAdjustSize = false;
			this.className = gallery.containerClassName;
			$layout.orientation = LayoutOrientation.VERTICAL;
			$verticalGap = 5;
			_gallery = gallery;
			_thumbnail = new Thumbnail();
			_thumbnail.spas_internal::setSelector(Selectors.GALLERY_THUMBNAIL);
			_thumbnail.className = gallery.thumbnailClassName;
			var lafObj:Object = (gallery as UIObject).lookAndFeel;
			_thumbnail.lockLaf(lafObj.getThumbnailLaf(), true);
			$mrgL = $mrgR = _thumbnail.lookAndFeel.getGlowFilter().blurX/2;
			$mrgT = $mrgB = _thumbnail.lookAndFeel.getGlowFilter().blurY/2;
			_caption = new Text(_thumbnail.width);
			_caption.lockLaf(lafObj.getTextLaf(), true);
			_caption.autoHeight = true;
			_caption.textAlign = gallery.textAlign;
			if(gallery.fontColor) _caption.fontColor = gallery.fontColor;
			if(gallery.fontSize) _caption.fontSize = gallery.fontSize;
			//if(gallery.fontSize) _caption.fontSize = gallery.fontSize; ???
			_caption.text = captionText;
			setCaptionPositions(gallery.captionPosition);
			$evtColl.addEvent(_thumbnail, UIMouseEvent.CLICK, doDispatchEvent);
			
			spas_internal::setSelector("gallerycontainer");
			spas_internal::isInitialized(2);
		}
		
		private function doDispatchEvent(e:UIMouseEvent):void {
			_gallery.setSelectedPicture(this);
		}
		
		private function refreshContainerDisplayList():void {
			removeElements();
			switch(_captionPosition) {
				case CaptionPosition.TOP :
					if(_gallery.showCaptions) addElement(_caption);
					addElement(_thumbnail);
					break;
				case CaptionPosition.BOTTOM :
					addElement(_thumbnail);
					if(_gallery.showCaptions) addElement(_caption);
					break;
			}
		}
	}
}