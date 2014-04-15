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
	// TextArea.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 22:28
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.ScrollPolicy;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.plaf.libs.TextAreaUIRef;
	import org.flashapi.swing.scroll.ScrollableArea;
	import org.flashapi.swing.text.ACTM;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("TextArea.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>TextArea</code> receives the focus.
	 *
	 *  @eventType org.flashapi.swing.event.FocusEvent.FOCUS_IN
	 */
	[Event(name = "focusIn", type = "org.flashapi.swing.event.FocusEvent")]
	
	/**
	 *  Dispatched when the <code>TextArea</code> looses the focus.
	 *
	 *  @eventType org.flashapi.swing.event.FocusEvent.FOCUS_OUT
	 */
	[Event(name = "focusOut", type = "org.flashapi.swing.event.FocusEvent")]
	
	/**
	 * 	<img src="TextArea.png" alt="TextArea" width="18" height="18"/>
	 * 
	 * 	The <code>TextArea</code> class is a multiline text field with a border, a
	 * 	background and optional scroll bars. <code>TextArea</code> instances support
	 * 	the HTML rendering capabilities of the Adobe Flash Player.
	 * 
	 * <p><strong><code>TextArea</code> instances support the following CSS
	 * 	properties:</strong></p>
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
	 *  @includeExample TextAreaExample.as
	 * 
	 * 	@see org.flashapi.swing.Text
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextArea extends ACTM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>TextArea</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>TextArea</code> instance, in pixels.
		 * 	@param	height	The height of the <code>TextArea</code> instance, in pixels.
		 */
		public function TextArea(width:Number = 200, height:Number = 150) {
			super(width, height);
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
		 * 	The <code>scrollPolicy</code> property controls the display of scroll bars.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>ScrollPolicy.AUTO</code>: configures the textarea to include
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
		 * 	@default ScrollPolicy.AUTO
		 */
		public function get scrollPolicy():String {
			return _scrollArea.scrollPolicy;
		}
		public function set scrollPolicy(value:String):void {
			_scrollArea.scrollPolicy = value;
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
			spas_internal::textRef.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			spas_internal::textRef.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			removeEventListener(TextEvent.EDITED, changedHandler);
			_scrollArea.finalize();
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		/**
		 *  Scrolls down the text to the last line displayed within this
		 * 	<code>TextArea</code> instance.
		 * 
		 * 	@see #scrollToTop()
		 */
		public function scrollToBottom():void {
			spas_internal::textRef.scrollV = spas_internal::textRef.maxScrollV;
		}
		
		/**
		 *  Scrolls up the text to the first line displayed within this
		 * 	<code>TextArea</code> instance.
		 * 
		 * 	@see #scrollToBottom()
		 */
		public function scrollToTop():void {
			spas_internal::textRef.scrollV = 0;
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
			updateText();
			fixSize();
			$borderDecorator.drawBackground();
			$borderStyle != BorderStyle.NONE ?
				$borderDecorator.drawBorders() : $borderDecorator.clearBorders();
			spas_internal::textRef.width = _scrollArea.spas_internal::VScrollBar.displayed
				? $width - _scrollArea.spas_internal::VScrollBar.width : $width;
			spas_internal::textRef.height = _scrollArea.spas_internal::HScrollBar.displayed ?
				$height - _scrollArea.spas_internal::HScrollBar.width : $height;
			_scrollArea.resize($width, $height);
			
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			initTextFormat();
			_scrollArea.lockLaf(lookAndFeel.getScrollBarLaf(), true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _scrollArea:ScrollableArea;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$selectable = $autoFocus = true;
			spas_internal::isBorderInstance = true;
			createContainer();
			setEditableMode(true);
			_scrollArea = new ScrollableArea(spas_internal::textRef, width, height);
			initLaf(TextAreaUIRef);
			_scrollArea.target = spas_internal::uioSprite;
			_scrollArea.scrollPolicy = ScrollPolicy.VERTICAL;
			_scrollArea.display();
			spas_internal::setSelector(Selectors.TEXTAREA);
			spas_internal::textRef.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			spas_internal::textRef.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			addEventListener(TextEvent.EDITED, changedHandler);
			spas_internal::isInitialized(1);
		}
		
		private function changedHandler(e:TextEvent):void {
			_scrollArea.redraw();
			doReflection();
		}
		
		private function focusIn(e:FocusEvent):void {
			if($autoFocus) lookAndFeel.drawEmphasizedState();
			dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
		}
		
		private function focusOut(e:FocusEvent):void {
			lookAndFeel.clearEmphasizedState();
			dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
		}
	}
}