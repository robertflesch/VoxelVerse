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
	// ScrollableContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 09/04/2011 17:15
	* @see http://www.flashapi.org/
	*/

	import flash.display.Shape;
	import flash.display.Sprite;
	import org.flashapi.swing.border.AbstractBorderContainer;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.Element;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.scroll.ScrollableArea;
	import org.flashapi.swing.ScrollBar;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>ScrollableContainer</code> class is the base class for all
	 * 	<code>UIContainer</code> objects that display vertical and horizontal
	 * 	scroll bars to interact with their content.
	 * 
	 * 	<p><code>ScrollableContainer</code> objects implement the <code>Border</code>
	 * 	interface. It means that scrollable containers have a background and borders
	 * 	that delimit their bounds.</p>
	 * 
	 * <p><strong><code>ScrollableContainer</code> instances support the following CSS properties:</strong></p>
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
	 *  @see org.flashapi.swing.decorator.Border
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScrollableContainer extends AbstractBorderContainer implements Border {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ScrollableContainer</code> instance.
		 */
		public function ScrollableContainer() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
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
			return $scrollableArea.scrollPolicy;
		}
		public function set scrollPolicy(value:String):void {
			$scrollableArea.scrollPolicy = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the vertical <code>ScrollBar</code> instance.
		 * 
		 * 	@see #hScrollBar
		 */
		public function get vScrollBar():ScrollBar {
			return $scrollableArea.spas_internal::VScrollBar;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the horizontal <code>ScrollBar</code> instance.
		 * 
		 * 	@see #vScrollBar
		 */
		public function get hScrollBar():ScrollBar {
			return $scrollableArea.spas_internal::HScrollBar;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private
		 */
		override public function addElement(value:*, type:String = DataFormat.GRAPHIC, constraints:Object = null):Element {
			switch(type) {
				case DataFormat.GRAPHIC :
					$evtColl.addEvent(this, LoaderEvent.GRAPHIC_COMPLETE, redrawGraphicScrollableArea);
					break;
				case DataFormat.HTML :
					$evtColl.addEvent(this, LoaderEvent.HTML_COMPLETE, redrawTextScrollableArea);
					break;
				case DataFormat.TEXT :
					$evtColl.addEvent(this, LoaderEvent.TEXT_COMPLETE, redrawTextScrollableArea);
					break;
			}
			var element:Element = super.addElement(value, type, constraints);
			return element;
		}
		
		/**
		 *	@private
		 */
		override public function setStyle(value:*):void {
			super.setStyle(value);
			if ($typeOfContent != DataFormat.GRAPHIC)
				$evtColl.addOneShotEvent(this, LoaderEvent.CSS_COMPLETE, redrawTextScrollableArea);
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$scrollableArea.finalize();
			$borderDecorator.finalize();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private
		 */
		protected var $scrollableContainer:Sprite;
		
		/**
		 *	@private
		 */
		protected var $scrollableArea:ScrollableArea;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private
		 */
		protected function createBorders():void {
			spas_internal::uioSprite.addChild(spas_internal::borders);
		}
		
		/**
		 *	@private
		 */
		protected function createScrollableContainers():void {
			$scrollableContainer = new Sprite();
			spas_internal::uioSprite.addChild($scrollableContainer);
			$scrollableContainer.addChild($content);
			$scrollableArea = new ScrollableArea ($content);
			$scrollableArea.target = $scrollableContainer;
			$contentMask = new Shape();
			spas_internal::uioSprite.addChild($contentMask);
			$scrollableContainer.mask = $contentMask;
		}
		
		/*override public function removeChild():void {
			super.removeChild();
			if(scrollableArea._displayed) {
				scrollableArea.targetPath = this._content;
				scrollableArea.redraw();
			}
		}*/
		
		/**
		 *	@private
		 */
		protected function redrawTextScrollableArea(e:LoaderEvent):void {
			var hLengthAdjustment:Number =
				$scrollableArea.spas_internal::VScrollBar.visible ?
				$scrollableArea.spas_internal::VScrollBar.width : 0;
			var vLengthAdjustment:Number =
				$scrollableArea.spas_internal::HScrollBar.visible ?
				$scrollableArea.spas_internal::HScrollBar.width : 0;
			spas_internal::textRef.width = $width - hLengthAdjustment;
			spas_internal::textRef.height = $height-vLengthAdjustment;
			initializeScrollableContainer(DataFormat.TEXT);
			if ($evtColl.hasRegisteredEvent(this, LoaderEvent.HTML_COMPLETE, redrawTextScrollableArea))
				$evtColl.removeEvent(this, LoaderEvent.HTML_COMPLETE, redrawTextScrollableArea);
			else if ($evtColl.hasRegisteredEvent(this, LoaderEvent.TEXT_COMPLETE, redrawTextScrollableArea))
				$evtColl.removeEvent(this, LoaderEvent.TEXT_COMPLETE, redrawTextScrollableArea);
			else if ($evtColl.hasRegisteredEvent(this, LoaderEvent.CSS_COMPLETE, redrawTextScrollableArea))
				$evtColl.removeEvent(this, LoaderEvent.CSS_COMPLETE, redrawTextScrollableArea);
		}
		
		/**
		 *	@private
		 */
		protected function redrawGraphicScrollableArea(e:LoaderEvent):void {
			$evtColl.removeEvent(this, LoaderEvent.GRAPHIC_COMPLETE, redrawGraphicScrollableArea);
			initializeScrollableContainer();
		}
		
		/**
		 *	@private
		 */
		override protected function initializeScrollableContainer(type:String = DataFormat.GRAPHIC):void {
			if ($scrollableArea.targetPath != $content && type == DataFormat.GRAPHIC)
				$scrollableArea.targetPath = $content;
			else if ($scrollableArea.targetPath != spas_internal::textRef && type == DataFormat.TEXT)
				$scrollableArea.targetPath = spas_internal::textRef;
			spas_internal::textRef.x = spas_internal::textRef.y = $content.x =
			$content.y = $scrollableArea.spas_internal::HScrollBar.value =
			$scrollableArea.spas_internal::VScrollBar.value = 0;
			$scrollableArea.resize($width, $height);
			doReflection();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//private var _childIsNotUIObject:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createBackground();
			createBackgroundTextureManager(spas_internal::background);
			$borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
		}
	}
}