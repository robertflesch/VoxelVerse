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
	// Thumbnail.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 22:30
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.ContainerEvent;
	import org.flashapi.swing.plaf.libs.ThumbnailUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Thumbnail.png")]
	
	/**
	 * 	<img src="Thumbnail.png" alt="Thumbnail" width="18" height="18"/>
	 * 
	 *  The <code>Thumbnail</code> class lets you crate an image button with the
	 * 	specified source image. It can display an alternate text, and do the
	 * 	same actions as other <code>ABM</code> objects (such as <code>Button</code>,
	 * 	<code>ListItem</code>...)
	 * 
	 * 	<p>To create complex collection of thumbnail images, you should use the
	 * 	<code>PictureGallery</code> class.</p>
	 * 
	 * 	<p>The <code>label</code> propety can not be set for <code>Thumbnail</code>
	 * 	instances.</p>
	 * 
	 *  @includeExample ThumbnailExample.as
	 * 
	 * 	@see org.flashapi.swing.PictureGallery
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Thumbnail extends ABM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Thumbnail</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>Thumbnail</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>Thumbnail</code> instance,
		 * 					in pixels.
		 * 	@param	alt		The alternate text for this <code>Thumbnail</code>
		 * 					instance.
		 */
		public function Thumbnail(width:Number = 100, height:Number = 100, alt:String = "") {
			super();
			initObj(width, height, alt);
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
		//  Overriden getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set autoHeight(value:Boolean):void {
			//trace(this)
			_doCheckSize = true;
			super.autoHeight = value;
		}
		
		/**
		 *  @private
		 */
		override public function set autoWidth(value:Boolean):void {
			_doCheckSize = true;
			super.autoWidth = value;
		}
		
		/**
		 *  @private
		 */
		override public function set autoSize(value:Boolean):void {
			_doCheckSize = true;
			super.autoSize = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	Adds an image element to this <code>Thumbnail</code> instance. The image
		 * 	element can be a <code>UIObject</code> instance, a <code>DisplayObject</code>
		 * 	instance, or a URI links to SWF or image files.
		 * 	
		 * 	@param	value	The element to add as an image to this <code>Thumbnail</code>
		 * 					instance.
		 * 
		 * 	@see #getElement()
		 * 	@see #removeElement()
		 */
		public function addElement(value:*):void {
			super.setIcon(value);
		}
		
		/**
		 * 	Returns the image element contained within this <code>Thumbnail</code>
		 * 	instance.
		 * 
		 * 	@return The image lement ocontained within this <code>Thumbnail</code>
		 * 			instance.
		 * 
		 * 	@see #addElement()
		 * 	@see #removeElement()
		 */
		public function getElement():* {
			return icon.getElementAt(0);
		}	
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			if ($reflection) return r.union(boundaries);
			return r;
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			if ($reflection) return r.union(boundaries);
			return r;
		}
		
		/**
		 *	Removes the image from this <code>Thumbnail</code> instance.
		 * 
		 * 	@see #addElement()
		 * 	@see #getElement()
		 */
		public function removeElement():void {
			deleteIcon();
		} 
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			if (label != "") label = "";
			if (_doCheckSize) checkSize();
			drawMask();
			drawInitialState();
			setEffects();
			if (_doCheckSize) {
				_doCheckSize = false;
				$storedSize.checkMetricsChanges();
			}
		}
		
		/**
		 * @private
		 */
		override protected function setEffects():void {
			icon.shadow = $dropShadow;
			icon.glow = $glowFilter;
		}
		
		/**
		 * @private
		 */
		override protected function setIconProperties(e:ContainerEvent):void {
			icon.eventCollector.removeEvent(icon, ContainerEvent.ELEMENT_LOADED, setIconProperties);
			_doCheckSize = true;
			refresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _iconMask:Shape;
		private var _doCheckSize:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number, alt:String):void {
			init("", width, height, false);
			initLaf(ThumbnailUIRef);
			$vAlign = VerticalAlignment.TOP;
			$hAlign = HorizontalAlignment.LEFT; 
			$labelPlacement = LabelPlacement.RIGHT;
			if(alt!="") this.alt = alt;
			initTextField();
			_iconMask = new Shape();
			icon.content.mask = _iconMask;
			icon.spas_internal::uioSprite.addChild(_iconMask);
			spas_internal::setSelector(Selectors.THUMBNAIL);
			spas_internal::isInitialized(1);
		}
		
		private function drawMask():void {
			var f:Figure = Figure.setFigure(_iconMask);
			f.clear();
			f.beginFill(0, 0);
			f.drawRectangle(0, 0, $width, $height);
			f.endFill();
		}
		
		private function checkSize():void {
			var r:Rectangle = icon.content.getBounds(null);
			if ($autoHeight) $height = r.height;
			if ($autoWidth) $width = r.width;
		}
	}
}