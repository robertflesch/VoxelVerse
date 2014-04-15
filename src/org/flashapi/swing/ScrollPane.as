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
	// ScrollPane.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 21:33
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.containers.ScrollableContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.ScrollPaneUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ScrollPane.png")]
	
	/**
	 * 	<img src="ScrollPane.png" alt="ScrollPane" width="18" height="18"/>
	 * 
	 * 	The <code>ScrollPane</code> class displays display objects and JPEG, GIF,
	 * 	and PNG files, as well as SWF or text files, in a scrollable area. You can
	 * 	use a scrollpane to limit the screen area that is occupied by these media
	 * 	types. The scrollpane can display content that is loaded from a local disk
	 * 	or from the Internet. You can set this content while authoring and, at run
	 * 	time.
	 * 	<span class="hide">After the scrollpane has focus, if its content has valid tab stops,
	 * 	those markers receive focus. After the last tab stop in the content,
	 * 	focus moves to the next display object.</span>
	 * 
	 *  @includeExample ScrollPaneExample.as
	 * 
	 * 	@see org.flashapi.swing.ScrollBar
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScrollPane extends ScrollableContainer implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ScrollPane</code> instance with the
		 * 					specified properties.
		 * 
		 * 	@param width 	The width of the <code>ScrollPane</code> instance, in
		 * 					pixels.
		 * 	@param height 	The height of the <code>ScrollPane</code> instance, in
		 * 					pixels.
		 * 	@param	type	Indicates the type of data to be displayed within this
		 * 					<code>ScrollPane</code> instance. Valid values are
		 * 					<code>DataFormat</code> constants. Only one kind of data
		 * 					can be displayed at once in a <code>ScrollPane</code> 
		 * 					object. Default value is <code>DataFormat.GRAPHIC</code>.
		 */
		public function ScrollPane(width:Number = 150, height:Number = 80, type:String = "graphic") {
			super();
			initObj(width, height, type);
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
		 * 	Sets or gets the <code>pageScrollSize</code> property for the horizontal
		 * 	scroll bar of this <code>ScrollPane</code> instance.
		 * 
		 * 	@default 1
		 * 
		 * 	@see #vPageScrollSize
		 * 	@see  org.flashapi.swing.scroll.Scrollable#pageScrollSize
		 */
		public function get hPageScrollSize():Number {
			return $scrollableArea.spas_internal::HScrollBar.pageScrollSize;
		}
		public function set hPageScrollSize(value:Number):void {
			$scrollableArea.spas_internal::HScrollBar.pageScrollSize = value;
		}
		
		/**
		 * 	Sets or gets the <code>pageScrollSize</code> property for the vertical
		 * 	scroll bar of this <code>ScrollPane</code> instance.
		 * 
		 * 	@default 1
		 * 
		 * 	@see #hPageScrollSize
		 * 	@see  org.flashapi.swing.scroll.Scrollable#pageScrollSize
		 */
		public function get vPageScrollSize():Number {
			return $scrollableArea.spas_internal::VScrollBar.pageScrollSize;
		}
		public function set vPageScrollSize(value:Number):void {
			$scrollableArea.spas_internal::VScrollBar.pageScrollSize = value;
		}
		
		/**
		 * 	Sets or gets the <code>value</code> property for the horizontal scroll bar
		 * 	of this <code>ScrollPane</code> instance.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #valueV
		 * 	@see  org.flashapi.swing.scroll.Scrollable#value
		 */
		public function get valueH():Number {
			return $scrollableArea.spas_internal::HScrollBar.value;
		}
		public function set valueH(value:Number):void {
			$scrollableArea.spas_internal::HScrollBar.value = value;
		}
		
		/**
		 * 	Sets or gets the <code>value</code> property for the vertical scroll bar
		 * 	of this <code>ScrollPane</code> instance.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #valueH
		 * 	@see  org.flashapi.swing.scroll.Scrollable#value
		 */
		public function get valueV():Number {
			return $scrollableArea.spas_internal::VScrollBar.value;
		}
		public function set valueV(value:Number):void {
			$scrollableArea.spas_internal::VScrollBar.value = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = spas_internal::background.getBounds(targetCoordinateSpace);
			return r;
		}
		
		/**
		 * @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle (0, 0, $width, $height);
			return r;
		}
		
		/**
		 * @private
		 */
		override public function finalize():void {
			spas_internal::lafDTO.contentMask = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			$scrollableArea.display();
			refresh();
		}
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			fixBackgroundSize();
			$borderDecorator.drawBackground();
			lookAndFeel.drawMask();
			$borderDecorator.drawBorders();
			$scrollableArea.resize($width, $height);
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			$scrollableArea.lockLaf(lookAndFeel.getScrollBarLaf(), true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number, type:String):void {
			initSize(width, height);
			$type = type;
			fixBackgroundSize();
			createContainers();
			spas_internal::lafDTO.contentMask = $contentMask;
			initLaf(ScrollPaneUIRef);
			$scrollableArea.resize(width, height);
			spas_internal::setSelector(Selectors.SCROLLPANE);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			createScrollableContainers();
			createBorders();
		}
		
		private function fixBackgroundSize():void {
			$backgroundWidth = $width;
			$backgroundHeight = $height;
		}
	}
}