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
	// ScrollGalleryContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/06/2009 21:41
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.TimerEvent;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.core.Gallery;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.ScrollGallery;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>ScrollGalleryContainer</code> class creates a control object  
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
	public class ScrollGalleryContainer extends PictureGalleryContainer implements GalleryContainer {		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ScrollGalleryContainer</code> instance.
		 * 
		 * 	@param gallery 	The gallery object that creates the <code>ScrollGalleryContainer</code>
		 * 					instance.
		 * 	@param captionText The plain text displayed by the caption control.
		 * 						Default value is <code>""</code>.
		 */
		public function ScrollGalleryContainer(gallery:Gallery, captionText:String = "") {
			super(gallery, captionText);
			initObj(gallery);
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
			_scrollGallery = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _scrollGallery:ScrollGallery;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(gallery:Gallery):void {
			_scrollGallery = gallery as ScrollGallery;
			$evtColl.addEvent(this.thumbnail, UIOEvent.METRICS_CHANGED, updateItemsPositions);
			$evtColl.addEvent(_scrollGallery.spas_internal::timer, TimerEvent.TIMER, moveItem);
			spas_internal::isInitialized(3);
		}
		
		private function moveItem(e:TimerEvent):void {
			var sl:Number = _scrollGallery.spas_internal::slideLength;
			var b:Box = _scrollGallery.galleryContainer;
			var w:Number =  _scrollGallery.width - b.paddingLeft - b.paddingRight;
			if (this.x + this.width < 0) this.x += sl;
			else if (this.x > w) this.x -= sl;
			this.x += _scrollGallery.spas_internal::getSpeed();
		}
		
		private function updateItemsPositions(e:UIOEvent):void {
			_scrollGallery.spas_internal::updateItemsPositions();
		}
	}
}