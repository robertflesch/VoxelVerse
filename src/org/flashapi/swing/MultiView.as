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
	// MultiView.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.6, 22/02/2010 23:40
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.MultiViewMetricsMode;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.IndexEvent;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("MultiView.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the index of the view currently displayed within this
	 * 	<code>MultiView</code> changes.
	 *
	 *  @eventType org.flashapi.swing.event.IndexEvent.INDEX_CHANGED
	 */
	[Event(name = "indexChanged", type = "org.flashapi.swing.event.IndexEvent")]
	
	/**
	 * 	<img src="MultiView.png" alt="MultiView" width="18" height="18"/>
	 * 
	 *  The <code>MultiView</code> defines a group of <code>Canvas</code> objects,
	 * 	where each canvas contains custom child elements. Only one <code>Canvas</code>
	 * 	instance is visible at a time.
	 * 
	 * 	<p>A <code>Canvas</code> instance is called a "view" and can ba accessed through
	 * 	the view API. You can programmatically select the active view by setting the
	 * 	<code>index</code> property.</p>
	 * 
	 * 	<p><strong>Note:</strong> the following methods and properties, defined by
	 * 	the the <code>IUIContainer</code> interface, cannot be used with <code>MultiView</code>
	 * 	instances:
	 * 	<ul>
	 * 		<li><code>numElements</code>,</li>
	 * 		<li><code>addElement()</code>,</li>
	 * 		<li><code>addElementAt()</code>,</li>
	 * 		<li><code>addGraphicElements()</code>,</li>
	 * 		<li><code>getElementAt()</code>,</li>
	 * 		<li><code>getElements()</code>,</li>
	 * 		<li><code>removeElement()</code>,</li> 
	 * 		<li><code>removeElements()</code>.</li>
	 * 	</ul>
	 * 	</p>

	 *  @includeExample MultiViewExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MultiView extends Box implements Observer, Border, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>MultiView</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	viewNum		The default number of views of this <code>MultiView</code>
		 * 						instance.
		 * 	@param	width		The width of the <code>MultiView</code> instance, in
		 * 						pixels.
		 * 	@param	height		The height of the <code>MultiView</code> instance, in
		 * 						pixels.
		 * 	@param	borderStyle	The type of border for this the <code>MultiView</code>
		 * 						instance, defined by the <code>BorderStyle</code> class.
		 * 						Default value is <code>BorderStyle.NONE</code>.
		 */
		public function MultiView(viewNum:uint = 0, width:Number = 100, height:Number = 100, borderStyle:String = "none") {
			super(width, height, borderStyle);
			 initObj(viewNum);
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
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>currentView</code> property.
		 * 
		 * 	@see #currentView
		 */
		protected var $currentView:Canvas = null;
		/**
		 * 	Returns a reference to the view currently displayed within this
		 * 	<code>MultiView</code> instance. If no view is currently active
		 * 	within the <code>MultiView</code> instance, returns <code>null</code>.
		 * 
		 * 	@return A <code>Canvas</code>; the current view of the <code>MultiView</code>
		 * 			instance.
		 * 
		 * 	@default null
		 * 
		 * 	@see #index
		 */
		public function get currentView():Canvas {
			return $currentView;
		}
		
		/**
		 * 	Returns the number of <code>Canvas</code> views contained within this
		 * 	<code>MultiView</code> instance.
		 * 
		 * 	@default 0
		 */
		public function get numViews():uint {
			return $viewStack.length;
		}
		
		/**
		 *  Sets or gets the current view container for the <code>MultiView</code>
		 * 	instance. If no view is currently active within the <code>MultiView</code>
		 * 	instance, returns <code>-1</code>.
		 * 
		 * 	@default -1
		 * 
		 * 	@see #currentView
		 */
		public function set index(value:int):void {
			var oldId:Number = this.index;
			spas_internal::setIndex(value);
			if (value == -1) {
				deactiveView($currentView);
				$currentView = null;
			} else {
				var c:Canvas = $viewStack[value];
				activeView(c);
			}
			this.dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGED, oldId, oldId, c));
		}
		
		private var _metricsMode:String = MultiViewMetricsMode.NORMAL;
		/**
		 * 	Sets or gets the mode selected to manage the metrics of all views when
		 * 	this <code>MultiView</code> instance is resized. Possible values are
		 * 	<code>MultiViewMetricsMode.NORMAL</code> or <code>MultiViewMetricsMode.RECURSIVE</code>.
		 * 	If <code>MultiViewMetricsMode.NORMAL</code>, only the current view is
		 * 	resized. If <code>MultiViewMetricsMode.RECURSIVE</code>, all views contained
		 * 	within this <code>MultiView</code> instance are resized.
		 * 
		 * 	@default MultiViewMetricsMode.NORMAL
		 */
		public function get metricsMode():String {
			return _metricsMode;
		}
		public function set metricsMode(value:String):void {
			_metricsMode = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a new view to this <code>MultiView</code> instance and returns a
		 * 	reference to the <code>Canvas</code> instance used to display this view.
		 * 	The view is added to the front (top) of all other views in the
		 * 	<code>MultiView</code> display list.
		 *	
		 * 	@return	The <code>Canvas</code> instance used to display the new view.
		 * 
		 * 	@see #removeView()
		 */
		public function addView():Canvas {
			var c:Canvas = new Canvas($width, $height);
			if ($currentView == null) $currentView = c;
			c.autoAdjustSize = false;
			updateViewMetrics(c);
			c.target = $content;
			c.display();
			c.visible = false;
			$viewStack.push(c);
			return c;
		}
		
		/**
		 * 	Returns the <code>Canvas</code> instance that exists at the specified index. 
		 * 
		 * 	@param	value	The index position of a <code>Canvas</code> instance
		 * 					within the <code>MultiView</code> display list. 
		 * 
		 * 	@return		The view <code>Canvas</code> instance found at the specified
		 * 				index.
		 */
		public function getViewAt(value:uint):Canvas {
			return $viewStack[value];
		}
		
		/**
		 * 	Removes the last wiew added to this <code>MultiView</code> instance.
		 * 
		 * 	@see #addView()
		 */
		public function removeView():void {
			var c:Canvas = $viewStack.pop();
			if (c == $currentView) {
				deactiveView(c);
				$currentView = null;
				var l:int = $viewStack.length - 1;
				if(l > 0) activeView($viewStack[l]);
			}
			c.finalize();
		}
		
		/**
		 * 	Removes the <code>Canvas</code> view at the specified index in this
		 * 	<code>MultiView</code> instance. The index positions of all view objects
		 * 	above the removed <code>Canvas</code> are decreased by <code>1</code>.
		 * 
		 * 	@param	value	The index at wich to remove the <code>Canvas</code> view. 
		 */
		public function removeViewAt(value:uint):void {
			var c:Canvas = $viewStack[value];
			$viewStack.splice(value, 1);
			if (c == $currentView) {
				deactiveView(c);
				$currentView = null;
				var l:int = $viewStack.length - 1;
				activeView($viewStack[l]);
			}
			c.finalize();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			var c:Canvas;
			var l:int = $viewStack.length - 1;
			for (; l >= 0; l--) {
				c = $viewStack[l];
				c.removeElements();
				c.finalize();
				$viewStack[l] = null;
			}
			$viewStack = [];
			$viewStack = null;
			$currentView = null;
			super.finalize();
		}
		
		/**
		 * 	@private
		 */
		override public function finalizeElements():void {
			var c:Canvas;
			var l:int = $viewStack.length - 1;
			for (; l >= 0; l--) {
				c = $viewStack[l];
				c.finalizeElements();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden UIContainer methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function get numElements():uint {
			return 0;
		}
		
		/**
		 * 	@private
		 */
		override public function addElement(value:*, type:String = "graphic", constraints:Object = null):Element {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function addElementAt(value:*, index:uint, type:String = "graphic", constraints:Object = null):Element {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function addGraphicElements(... rest):void {}
		
		/**
		 * 	@private
		 */
		override public function getElementAt(index:int):Element {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function getElements():Array {
			return spas_internal::elementsList.toArray();
		}
		
		/**
		 * 	@private
		 */
		override public function getElementByName(name:String):Element {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function removeElement(value:*):* {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function removeElements():void { }
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An internal <code>Array</code> value that is used to store all views of
		 * 	the <code>MultiView</code> instance.
		 */
		protected var $viewStack:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function activeView(view:Canvas):void {
			if ($currentView != null) deactiveView($currentView);
			view.invalidateLayout = false;
			updateViewMetrics(view);
			view.visible = true;
			$currentView = view;
		}
		
		/**
		 *  @private
		 */
		protected function deactiveView(view:Canvas):void {
			view.invalidateLayout = true;
			view.visible = false;
		}
		
		/**
		 *  @private
		 */
		protected function initViews(viewNum:uint):void {
			if (viewNum > 0) {
				for (; viewNum > 0; viewNum--) addView();
				activeView($viewStack[0]);
				spas_internal::setIndex(0);
			}
		}
		
		/**
		 *  @private
		 */
		protected function updateViewMetrics(view:Canvas):void {
			if (view == null) return;
			view.move($padL, $padT);
			view.resize($width - $padL - $padR, height - $padT - $padB);
			view.spas_internal::updateLayout();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			$borderDecorator.drawBackground();
			$borderStyle != BorderStyle.NONE ?
				$borderDecorator.drawBorders() : $borderDecorator.clearBorders();
			drawMask();
			if (_metricsMode == MultiViewMetricsMode.NORMAL) updateViewMetrics($currentView);
			else if (_metricsMode == MultiViewMetricsMode.RECURSIVE) updateAllViewsMetrics();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(viewNum:uint):void {
			$layout = new AbsoluteLayout();
			$viewStack = [];
			this.padding = this.verticalGap = this.horizontalGap = 0;
			initViews(viewNum);
			spas_internal::setSelector(Selectors.MULTI_VIEW);
			spas_internal::isInitialized(2);
		}
		
		private function updateAllViewsMetrics():void {
			var l:int = $viewStack.length - 1;
			for (; l >= 0; l--) updateViewMetrics($viewStack[l]);
		}
	}
}