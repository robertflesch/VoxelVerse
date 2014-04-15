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
	// UIContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.2.0, 29/03/2011 17:17
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.system.LoaderContext;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.LayoutHorizontalDirection;
	import org.flashapi.swing.constants.LayoutVerticalDirection;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.CSSGateway;
	import org.flashapi.swing.Element;
	import org.flashapi.swing.event.ContainerEvent;
	import org.flashapi.swing.event.LayoutEvent;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.swing.layout.FlowLayout;
	import org.flashapi.swing.layout.Layout;
	import org.flashapi.swing.managers.LayoutManager;
	import org.flashapi.swing.net.UILoader;
	import org.flashapi.swing.net.UILoaderInfo;
	import org.flashapi.swing.util.ArrayList;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a child element is added to the <code>UIContainer</code>.
	 *
	 *  @eventType org.flashapi.swing.event.ContainerEvent.ELEMENT_ADDED
	 */
	[Event(name = "elementAdded", type = "org.flashapi.swing.event.ContainerEvent")]
	
	/**
	 *  Dispatched when a child element is removed from the <code>UIContainer</code>.
	 *
	 *  @eventType org.flashapi.swing.event.ContainerEvent.ELEMENT_REMOVED
	 */
	[Event(name = "elementRemoved", type = "org.flashapi.swing.event.ContainerEvent")]
	
	/**
	 *  Dispatched when the <code>UIContainer</code> layout is updated.
	 *
	 *  @eventType org.flashapi.swing.event.ContainerEvent.LAYOUT_UPDATED
	 */
	[Event(name = "layoutUpdated", type = "org.flashapi.swing.event.ContainerEvent")]
	
	/**
	 *  Dispatched when a child element has been loaded within the <code>UIContainer</code>.
	 *
	 *  @eventType org.flashapi.swing.event.ContainerEvent.ELEMENT_LOADED
	 */
	[Event(name = "elementLoaded", type = "org.flashapi.swing.event.ContainerEvent")]
	
	/**
	 *  Dispatched when a HTML element has been loaded within the <code>UIContainer</code>.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.HTML_COMPLETE
	 */
	[Event(name = "htmlComplete", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 *  Dispatched when a child element has been added within the <code>UIContainer</code>.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.INIT
	 */
	[Event(name = "init", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 *  Dispatched when a child element has been added within the <code>UIContainer</code>.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.COMPLETE
	 */
	[Event(name = "complete", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 * 	The <code>UIContainer</code> class is the base class for all SPAS 3.0 containers.
	 * 
	 * 	<p>The default <code>horizontalGap</code> and <code>verticalGap</code> value
	 * 	for all <code>UIContainer</code> is <code>5</code> pixels.</p>
	 * 
	 * <p><strong><code>UIContainer</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">layout-alignment</code></td>
	 * 			<td>Sets the layout alignement of the container object.</td>
	 * 			<td>Recognized values are <code class="css">top</code>, <code class="css">middle</code>,
	 * 			<code class="css">bottom</code>, <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code></td>
	 * 			<td><code>layout.horizontalAlignment</code> or <code>layout.verticalAlignment</code></td>
	 * 			<td>Properties.LAYOUT_ALIGNMENT</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">layout-orientation</code></td>
	 * 			<td>Sets the layout orientation for this container object.</td>
	 * 			<td>Valid values are <code class="css">horizontal</code> and
	 * 			<code class="css">vertical</code></td>
	 * 			<td><code>layout.orientation</code></td>
	 * 			<td>Properties.LAYOUT_ORIENTATION</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UIContainer extends UIObject implements IUIContainer {
		
		//TODO: loading error management for all elements (style, text, html, graphics...)
		// implement a finalize method for all Layout objects.
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>UIContainer</code> instance.
		 */
		public function UIContainer() { 
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/*
		 * 	[Not yet implemented.]
		 */
		public var info:UILoaderInfo;
		
		/**
		 * 	Specifies a <code>LoaderContext</code> object. 
		 * 	The <code>loaderContext</code> object defines the following properties: 
		 * 	<ul>
		 * 		<li>Whether or not Flash Player should check for the existence of a policy
		 * 		file upon loading the object.</li>
		 * 		<li>The <code>ApplicationDomain</code> for the loaded object.</li>
		 * 		<li>The <code>SecurityDomain</code> for the loaded object.</li>
		 * 	</ul>
		 * 
		 * 	<p>For complete details, see the description of the <code>LoaderContext</code>
		 * 	properties.</p>
		 * 
		 * 	@see org.flashapi.swing.net.UILoader
		 * 
		 * 	@default null
		 */
		public var loaderContext:LoaderContext = null;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoAdjustSize</code> property.
		 * 
		 * 	@see #autoAdjustSize
		 */
		protected var $autoAdjustSize:Boolean = false;
		/**
		 * @inheritDoc
		 */
		public function get autoAdjustSize():Boolean {
			return $autoAdjustSize;
		}
		public function set autoAdjustSize(value:Boolean):void {
			$autoAdjustSize = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the display object used as mask by the content
		 * 	container.
		 * 
		 * 	@see #contentMask
		 */
		protected var $contentMask:DisplayObject = null;
		/**
		 * 	<strong>[Deprecated]</strong> A reference to the display object used as mask
		 * 	by the content container.
		 * 
		 * 	@default null
		 */
		public function get contentMask():DisplayObject {
			return $contentMask;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>horizontalOrientation</code> property.
		 * 
		 * 	@see #horizontalOrientation
		 */
		protected var $horizontalOrientation:String = LayoutHorizontalDirection.LEFT_TO_RIGHT;
		/**
		 * @inheritDoc
		 */
		public function get horizontalOrientation():String {
			return $horizontalOrientation;
		}
		public function set horizontalOrientation(value:String):void {
			$horizontalOrientation = value;
			$layout.setHorizontalOrientation(value);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get invalidateLayout():Boolean {
			return spas_internal::invalidateLayoutUpdate;
		}
		public function set invalidateLayout(value:Boolean):void {
			spas_internal::invalidateLayoutUpdate = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>layout</code> property.
		 * 
		 * 	@see #layout
		 */
		protected var $layout:Layout;
		/**
		 * @inheritDoc
		 */
		public function get layout():Layout {
			return $layout;
		}
		public function set layout(value:Layout):void {
			$layout = value;
			$layout.addAllObjects(spas_internal::elementsList.toArray());
			spas_internal::initLayout();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get numElements():uint {
			return $content.numChildren;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>typeOfContent</code> property.
		 * 
		 * 	@see #typeOfContent
		 */
		protected var $typeOfContent:String;
		/**
		 * @inheritDoc
		 */
		public function get typeOfContent():String {
			return $typeOfContent;
		}
		
		/**
		 *  @private
		 */
		protected var $verticalOrientation:String = LayoutVerticalDirection.TOP_TO_BOTTOM;
		/**
		 * @inheritDoc
		 */
		public function get verticalOrientation():String {
			return $verticalOrientation;
		}
		public function set verticalOrientation(value:String):void {
			$verticalOrientation = value;
			$layout.setVerticalOrientation(value);
		}
		
		private var _wordWrap:Boolean = false
		/**
		 * @inheritDoc
		 */
		public function get wordWrap():Boolean {
			return _wordWrap;
		}
		public function set wordWrap(value:Boolean):void {
			spas_internal::textRef.wordWrap = _wordWrap = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function forceLayout():void {
			spas_internal::updateLayout();
		}
		
		/**
		 * @inheritDoc
		 */
		public function setLayout(layout:Layout = null):void {
			$layout = layout == null ? new AbsoluteLayout() : layout;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addElement(value:*, type:String = "graphic", constraints:Object = null):Element {
			var elmIsUIO:Boolean = value is IUIObject;
			var element:Element = new Element();
			if (elmIsUIO && spas_internal::elementsList.contains(value)) {
				if (value.displayed) {
					element.setElement(value);
					return element;
				} else {
					Element.spas_internal::removeLayoutListener(value);
					spas_internal::elementsList.remove(value);
					spas_internal::uioToDisplay.remove(value);
				}
			}
			
			setListChanges();
			$childrenToRender++;
			$typeOfContent = type;
			var e:* = null;
			if (elmIsUIO) {
				$evtColl.addEvent(value, UIOEvent.DISPLAYED, updateChildrenToRender);
				if(hasTextField()) {
					$content.removeChild(spas_internal::textRef);
					spas_internal::elementsList.clear();
					spas_internal::uioToDisplay.clear();
				}
				value.target = this;
				if (!value.hasDisplayEffect) value.display();
				else spas_internal::uioToDisplay.add(value);
				if (!_invalidateElementListUpdate) spas_internal::elementsList.add(value);
				dispatchAttachChildEvents(value.spas_internal::uioSprite);
				initializeScrollableContainer();
				e = value;
				value.constraints = constraints;
				addToLayout(value);
			} else {
				switch(type){
					case DataFormat.GRAPHIC : 
						if(hasTextField()) {
							$content.removeChild(spas_internal::textRef);
							spas_internal::elementsList.clear();
							spas_internal::uioToDisplay.clear();
							$layout.clear();
						}
						switch(typeof value) {
							case PrimitiveType.STRING :
								e = loadAndAddChild(value);
								break;
							case PrimitiveType.OBJECT :
								e = getAndAddChild(value);
								break;
						}
						break;
					case DataFormat.TEXT : 
						if(!hasTextField()) {
							removeElements();
							$content.addChild(spas_internal::textRef);
						}
						$childrenToRender = 0;
						switch(typeof value) {
							case PrimitiveType.STRING :
								e = loadAndAddText(value);
								break;
							case PrimitiveType.OBJECT :
								getAndAddText(value.toString());
								e = value;
								break;
						}
						break;
					case DataFormat.HTML : 
						if(!hasTextField()) {
							removeElements();
							$content.addChild(spas_internal::textRef);
						}
						$childrenToRender = 0;
						switch(typeof value) {
							case PrimitiveType.STRING :
								e = loadAndAddHtml(value);
								break;
							case PrimitiveType.OBJECT :
								getAndAddHtml(value);
								e = value;
								break;
						}
						break;
				}
			}
			element.spas_internal::setElement(e);
			element.spas_internal::target = this;
			element.spas_internal::addLayoutListener(value is IUIObject);
			dispatchAddEvent(element);
			return element;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addElementAt(value:*, index:uint, type:String = "graphic", constraints:Object = null):Element {
			//TODO: check if the spas_internal::elementsList moved up one position in the child list.
			// when a currently occupied index position is specified.
			spas_internal::invalidateLayoutUpdate = _invalidateElementListUpdate =
				spas_internal::invalidateAddEventDispatching = true;
			var element:Element = addElement(value, type, constraints);
			
			spas_internal::elementsList.addAt(value, index);
			//$content.setChildIndex(spas_internal::elementsList.get(index), index);
			
			spas_internal::invalidateLayoutUpdate = _invalidateElementListUpdate =
				spas_internal::invalidateAddEventDispatching = false;
			spas_internal::addToLayoutManagerQueue();
			dispatchAddEvent(element);
			return element;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addGraphicElements(... rest):void {
			var l:int = rest.length;
			var i:int = 0;
			spas_internal::invalidateLayoutUpdate = true;
			if (l == 1 && rest[0] is Array) {
				l = rest[0].length;
				for (; i < l; i++) addElement(rest[0][i]);
			} else {
				for (; i < l; i++) addElement(rest[i]);
			}
			spas_internal::invalidateLayoutUpdate = false;
			spas_internal::addToLayoutManagerQueue();
		}
		
		/*public function containsElement(value:*):Boolean {
			if(Element
			return element;
		}*/
		
		/**
		 * @inheritDoc
		 */
		public function getElementAt(index:int):Element {
			var element:Element = new Element();
			element.setElement(spas_internal::elementsList.get(index));
			return element;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getObjectAt(index:int):* {
			return spas_internal::elementsList.get(index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElementIndex(value:*):int {
			return spas_internal::elementsList.indexOf(value);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElements():Array {
			return spas_internal::elementsList.toArray();
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElementByName(name:String):Element {
			var it:Iterator = spas_internal::elementsList.iterator;
			var obj:*;
			while(it.hasNext()) {
				obj = it.next();
				if(obj.name == name) {
					var element:Element = new Element();
					element.spas_internal::setElement(obj);
					element.spas_internal::target = this;
					return element;
				}
			}
			it.reset();
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getStyle():StyleSheet {
			return spas_internal::textRef.styleSheet;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeElement(value:*):* {
			setListChanges();
			spas_internal::elementsList.remove(value);
			spas_internal::uioToDisplay.remove(value);
			Element.spas_internal::removeLayoutListener(value);
			if (value is IUIObject) {
				value.remove();
				value.target = null;
			} else {
				$content.removeChild(value);
				$layout.removeObject(value);
			}
			setRefresh();
			var e:ContainerEvent = new ContainerEvent(ContainerEvent.ELEMENT_REMOVED);
			e.spas_internal::elm = value;
			this.dispatchEvent(e);
			return value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeElementAt(index:int):* {
			return removeElement(spas_internal::elementsList.get(index));
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeLastElement():* {
			return removeElement(spas_internal::elementsList.get($content.numChildren -1));
		}
		
		/**
		 * @inheritDoc
		 */
		public function removefirstElement():* {
			return removeElement(spas_internal::elementsList.get(0));
		}
		
		/**
		 * @inheritDoc
		 */
		public function finalizeElements():void {
			setListChanges();
			$layout.clear();
			if(hasTextField()) $content.removeChild(spas_internal::textRef);
			var stack:Array = spas_internal::elementsList.toArray();
			var l:int = stack.length - 1;
			var obj:*;
			for (; l >= 0; l--) {
				obj = stack[l];
				Element.spas_internal::removeLayoutListener(obj);
				if (obj is Finalizable) obj.finalize();
				else $content.removeChild(obj);
			}
			stack = [];
			stack = null;
			spas_internal::elementsList.clear();
			spas_internal::uioToDisplay.clear();
			spas_internal::elementsList = new ArrayList();
			spas_internal::uioToDisplay = new ArrayList();
			this.dispatchEvent(new ContainerEvent(ContainerEvent.LAYOUT_UPDATED));
			setRefresh();
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeElements():void {
			closeLoadingOperations();
			setListChanges();
			$layout.clear();
			if(hasTextField()) $content.removeChild(spas_internal::textRef);
			var stack:Array = spas_internal::elementsList.toArray();
			var l:int = stack.length - 1;
			var obj:*;
			for (; l >= 0; l--) {
				obj = stack[l];
				if(obj is IUIObject) obj.remove();
				else $content.removeChild(obj);
				Element.spas_internal::removeLayoutListener(obj);
			}
			stack = [];
			stack = null;
			spas_internal::elementsList = new ArrayList();
			this.dispatchEvent(new ContainerEvent(ContainerEvent.LAYOUT_UPDATED));
			setRefresh();
		}
		
		/**
		 * @inheritDoc
		 */
		public function setStyle(value:*):void {
			if(value is String) loadAndSetStyle(value);
			else if (value is StyleSheet) getAndSetStyle(value);
			else throw new IllegalArgumentException(Locale.spas_internal::ERRORS.CSS_PARAMETER_ERROR);
		}
		
		/**
		 * @inheritDoc
		 */
		public function swapElements(element1:*, element2:*):void { }
		
		/**
		 * @inheritDoc
		 */
		public function swapElementsAt(index1:int, index2:int):void {
			$content.swapChildrenAt(index1, index2);
			spas_internal::elementsList.swap(index1, index2);
			$layout.swapElementsAt(index1, index2);
			spas_internal::updateLayout();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			//_lytManager.spas_internal::addToQueue(this);
			var stack:Array = spas_internal::elementsList.toArray();
			var l:int = stack.length - 1;
			for (; l >= 0; l--) Element.spas_internal::removeLayoutListener(stack[l]);
			stack = [];
			stack = null;
			spas_internal::elementsList.finalize();
			spas_internal::uioToDisplay.finalize();
			spas_internal::elementsList = null;
			spas_internal::uioToDisplay = null;
			_styleSheet = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal var elementsList:ArrayList = new ArrayList();
		
		/**
		 * @private
		 */
		spas_internal var uioToDisplay:ArrayList = new ArrayList();
		
		/**
		 * @private
		 */
		spas_internal var invalidateAddEventDispatching:Boolean = false;
		
		/**
		 * 	@private
		 */
		protected var $textFormat:TextFormat;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function initializeScrollableContainer(type:String = "graphic"):void {}
		//protected function initializeScrollableContainer(type:String = DataFormat.GRAPHIC):void {}
		
		/**
		 * 	@private
		 */
		spas_internal function updateLayout():void {
			if (!$layout.isRendering) {
				if ($typeOfContent == DataFormat.GRAPHIC &&
					spas_internal::invalidateLayoutUpdate == false) $layout.moveObjects(spas_internal::getLayoutBounds(), this);
			} else _lytManager.spas_internal::addToQueue(this);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function getLayoutBounds():Rectangle {
			var l:Number = isNaN($padL) ? 0 : $padL;
			var r:Number = isNaN($padR) ? 0 : $padR;
			var t:Number = isNaN($padT) ? 0 : $padT;
			var b:Number = isNaN($padB) ? 0 : $padB;
			return new Rectangle(l, t, $width - r, $height - b);
		}
		
		/**
		 * 	@private
		 */
		override spas_internal function addToLayoutManagerQueue(e:Object = null):void {
			if (spas_internal::invalidateLayoutUpdate == false) {
				if (spas_internal::elementsList.size > 0 && $typeOfContent == DataFormat.GRAPHIC) {
					if (_uiLoaderStackLength < 1 && spas_internal::uioToDisplay.size > 0) {
						$evtColl.addEvent($layout, LayoutEvent.LAYOUT_FINISHED, onLayoutFinished);
					}
					if ($target is UIContainer && $target.spas_internal::invalidateLayoutUpdate == false && !$layout.animated) {
						$evtColl.addEvent($target.layout, LayoutEvent.LAYOUT_FINISHED, addTargetToLayoutManagerQueue);
					}
					_lytManager.spas_internal::addToQueue(this);
					//_lytManager.spas_internal::addToQueue(_target);
				} else {
					//TODO : vérifier si $target à besoin d'être modifié
					if ($target is UIContainer && $target.spas_internal::invalidateLayoutUpdate == false) _lytManager.spas_internal::addToQueue($target);
				}
			}
		}
		
		/**
		 * 	@private
		 */
		protected function updateChildrenToRender(e:UIOEvent):void {
			$childrenToRender--;
			$evtColl.removeEvent(e.target, UIOEvent.DISPLAYED, updateChildrenToRender);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function initLayout():void {
			$layout.setTarget(this);
			$layout.setVerticalOrientation($verticalOrientation);
			$layout.setHorizontalOrientation($horizontalOrientation);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function getExplicitSize():Rectangle {
			var rect:Rectangle = new Rectangle(0, 0, 0, 0);
			var it:Iterator = spas_internal::elementsList.iterator;
			var obj:*;
			while(it.hasNext()) {
				obj = it.next();
				var newRect:Rectangle = obj.getRect(null);
				newRect.x = obj.x, newRect.y = obj.y; 
				rect = rect.union(newRect);
			}
			it.reset();
			return rect;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _styleSheet:StyleSheet;
		private var _cssLoader:UILoader;
		private var _htmlText:String = "";
		private var _uiLoaderStack:Dictionary;
		private var _uiLoaderStackLength:uint = 0;
		private var _invalidateElementListUpdate:Boolean = false;
		private var _lytManager:LayoutManager;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_lytManager = UIDescriptor.getUIManager().layoutManager;
			_styleSheet = new StyleSheet();
			createLoaderStack();
			spas_internal::textRef = new TextField();
			setTextFieldProperties();
			$layout = new FlowLayout();
			spas_internal::initLayout();
			createLoadingEvents();
		}
		
		private function addToLayout(value:*):void {
			$layout.addObject(value);
			spas_internal::addToLayoutManagerQueue();
		}
		
		private function hasTextField():Boolean {
			return $content.contains(spas_internal::textRef);
		}
		
		private function loadAndAddChild(value:String):Loader {
			var l:UILoader = new UILoader(this);
			l.output = this.print;
			_uiLoaderStack[l] = l;
			_uiLoaderStackLength += 1;
			l.loaderContext = loaderContext;
			l.load(value);
			//addToLayout(uiLoader.loader);
			return l.loader;
		}
		
		private function ioErrorEvent(e:LoaderEvent):void {
			_uiLoaderStack[e.uiloader] = null;
			_uiLoaderStackLength -= 1;
			$childrenToRender--;
		}
		
		private function loadAndAddText(value:String):URLLoader {			
			var l:UILoader = new UILoader(this, DataFormat.TEXT);
			l.output = this.print;
			_uiLoaderStack[l] = l;
			_uiLoaderStackLength += 1;
			l.load(value);
			return l.loader;
		}
		
		private function loadAndAddHtml(value:String):URLLoader {
			var l:UILoader = new UILoader(this, DataFormat.HTML);
			l.output = this.print;
			_uiLoaderStack[l] = l;
			_uiLoaderStackLength += 1;
			l.load(value);
			return l.loader;
		}
		
		private function loadAndSetStyle(value:String):void {			
			_cssLoader = new UILoader(this, DataFormat.CSS);
			_cssLoader.output = this.print;
			_cssLoader.load(value);
		}
		
		/*private function graphicInitEvent(e:LoaderEvent):void {
			$evtColl.removeEvent(this, LoaderEvent.INIT, graphicInitEvent);
		}*/
		
		private function graphicCompleteEvent(e:LoaderEvent):void {
			var d:* = e.data;
			addTargetToObject(d);
			$content.addChild(d);
			if(!_invalidateElementListUpdate) spas_internal::elementsList.add(d);
			//UIManager.document.redraw();
			/*_uiLoaderStack[e.uiloader] = null;
			_uiLoaderStackLength -= 1;*/
			if ($autoAdjustSize) {
				$width = $content.width;
				$height = $content.height;
			}
			addToLayout(d);
			$childrenToRender--;
			dispatchChangeEvent();
			//spas_internal::metricsChanged = true;
			$storedSize.checkMetricsChanges();
			dispatchLoadedEvent(e);
		}
		
		/*private function textInitEvent(e:LoaderEvent):void {
			$evtColl.removeEvent(this, LoaderEvent.INIT, textInitEvent);
		}*/
		
		private function textCompleteEvent(e:LoaderEvent):void {
			spas_internal::textRef.text = e.data;
			/*_uiLoaderStack[e.uiloader] = null;
			_uiLoaderStackLength -= 1;*/
			dispatchLoadedEvent(e);
		}
		
		/*private function htmlInitEvent(e:LoaderEvent):void {
			$evtColl.removeEvent(this, LoaderEvent.INIT, htmlInitEvent);
		}*/
		
		private function htmlCompleteEvent(e:LoaderEvent):void {
			spas_internal::textRef.htmlText = _htmlText = e.data;
			setRefresh();
			/*_uiLoaderStack[e.uiloader] = null;
			_uiLoaderStackLength -= 1;*/
			dispatchLoadedEvent(e);
		}
		
		private function dispatchLoadedEvent(e:LoaderEvent):void {
			var ce:ContainerEvent = new ContainerEvent(ContainerEvent.ELEMENT_LOADED);
			ce.spas_internal::elm = e.uiloader as Element;
			this.dispatchEvent(ce);
			_uiLoaderStack[e.uiloader] = null;
			delete _uiLoaderStack[e.uiloader];
			_uiLoaderStackLength -= 1;
		}
		
		/*private function cssInitEvent(e:LoaderEvent):void {
			$evtColl.removeEvent(this, LoaderEvent.INIT, cssInitEvent);
		}*/
		
		private function cssCompleteEvent(e:LoaderEvent):void {
			_styleSheet.parseCSS(e.data);
			_styleSheet = CSSGateway.convertForColorKeywordCompatibility(_styleSheet);
			if($displayEffectIsRendering) $evtColl.addEvent(this, UIOEvent.DISPLAYED, applyCSSAfterEffectRendering);
			else applyNewStyleSheet();
		}
		
		private function applyCSSAfterEffectRendering(e:UIOEvent):void {
			$evtColl.removeEvent(this, UIOEvent.DISPLAYED, applyCSSAfterEffectRendering);
			applyNewStyleSheet();
		}
		
		private function applyNewStyleSheet():void {
			spas_internal::textRef.styleSheet = _styleSheet;
			if($typeOfContent != DataFormat.GRAPHIC) {
				spas_internal::textRef.htmlText = _htmlText;
				setRefresh();
			}
		}
		
		private function getAndAddChild(child:DisplayObject):DisplayObject {
			addTargetToObject(child);
			var c:DisplayObject = $content.addChild(child);
			if (!_invalidateElementListUpdate) spas_internal::elementsList.add(c);
			addToLayout(c);
			dispatchAttachChildEvents(c);
			return c;
		}
		
		private function addTargetToObject(obj:*):void {
			if (obj.hasOwnProperty("target")) obj.target = this;
		}
		
		private function getAndAddText(text:String):void {			
			spas_internal::textRef.text = text;
			_htmlText = new String();
			dispatchAttachChildEvents(text);
		}
		
		private function getAndAddHtml(html:String):void {
			spas_internal::textRef.htmlText = _htmlText = html;
			dispatchEvent(new LoaderEvent(LoaderEvent.HTML_COMPLETE, html));
			dispatchAttachChildEvents(html);
		}
		
		private function getAndSetStyle(style:StyleSheet):void {
			/*_styleSheet = style;
			spas_internal::textRef.styleSheet = _styleSheet;
			dispatchEvent(new LoaderEvent(LoaderEvent.CSS_COMPLETE, _styleSheet));
			dispatchAttachChildEvents(_styleSheet);*/
			_styleSheet = CSSGateway.convertForColorKeywordCompatibility(style);
			if($displayEffectIsRendering) $evtColl.addEvent(this, UIOEvent.DISPLAYED, applyCSSAfterEffectRendering);
			else applyNewStyleSheet();
		}
		
		private function dispatchAttachChildEvents(data:*):void {
			dispatchEvent(new LoaderEvent(LoaderEvent.INIT, data));
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, data));
			dispatchChangeEvent();
			//spas_internal::metricsChanged = true;
			$storedSize.checkMetricsChanges();
		}
		
		private function setTextFieldProperties():void {
			$textFormat = new TextFormat(WebFonts.ARIAL);
			spas_internal::textRef.defaultTextFormat = $textFormat;
			spas_internal::textRef.multiline = spas_internal::textRef.condenseWhite = true;
		}
		
		private function setListChanges():void {
			$layout.hasElementListChanged = true;
		}
		
		private function dispatchAddEvent(elm:Element):void {
			if (!spas_internal::invalidateAddEventDispatching) {
				var e:ContainerEvent = new ContainerEvent(ContainerEvent.ELEMENT_ADDED);
				e.spas_internal::elm = elm;
				this.dispatchEvent(e);
			}
		}
		
		/**
		 * 	@bugFix SB-8:
		 * 	The _renderingHiddenUIOBjects property is used to prevent possible
		 * 	mutliple calls to the diplayHiddenUIOBjects() method due to the
		 * 	onLayoutFinished() and onLayoutManagerFinished() events.
		 */
		private var _renderingHiddenUIOBjects:Boolean = false;
		
		private function onLayoutFinished(e:LayoutEvent):void {
			if (_uiLoaderStackLength == 1) $evtColl.removeEvent($layout, LayoutEvent.LAYOUT_FINISHED, onLayoutFinished);
			if (_lytManager.updateInProgress) $evtColl.addEvent(_lytManager, LayoutEvent.LAYOUT_MANAGER_PROCESS_FINISHED, onLayoutManagerFinished);
			else diplayHiddenUIOBjects();
		}
		
		private function onLayoutManagerFinished(e:LayoutEvent):void {
			$evtColl.removeEvent(_lytManager, LayoutEvent.LAYOUT_MANAGER_PROCESS_FINISHED, onLayoutManagerFinished);
			diplayHiddenUIOBjects();
		}
		
		private function diplayHiddenUIOBjects():void {
			if (_renderingHiddenUIOBjects) return;
			_renderingHiddenUIOBjects = true;
			var it:Iterator = spas_internal::uioToDisplay.iterator;
			while (it.hasNext()) it.next().display();
			spas_internal::uioToDisplay.clear();
			it.reset();
			_renderingHiddenUIOBjects = false;
		}
		
		private function addTargetToLayoutManagerQueue(e:LayoutEvent):void {
			$evtColl.removeEvent($target.layout, LayoutEvent.LAYOUT_FINISHED, addTargetToLayoutManagerQueue);
			//TODO : vérifier si $target a besoin d'être modifié
			if ($target.spas_internal::invalidateLayoutUpdate == false &&
				spas_internal::invalidateLayoutUpdate == false) _lytManager.spas_internal::addToQueue($target);
		}
		
		private function createLoadingEvents():void {
			//_cssLoader.addEventListener(LoaderEvent.INIT, cssInitEvent);
			$evtColl.addEvent(this, LoaderEvent.CSS_COMPLETE, cssCompleteEvent);
			//this.addEventListener(LoaderEvent.INIT, graphicInitEvent);
			$evtColl.addEvent(this, LoaderEvent.GRAPHIC_COMPLETE, graphicCompleteEvent);
			$evtColl.addEvent(this, LoaderEvent.IO_ERROR, ioErrorEvent);
			//uiLoader.addEventListener(LoaderEvent.INIT, htmlInitEvent);
			$evtColl.addEvent(this, LoaderEvent.HTML_COMPLETE, htmlCompleteEvent);
			//uiLoader.addEventListener(LoaderEvent.INIT, textInitEvent);
			$evtColl.addEvent(this, LoaderEvent.TEXT_COMPLETE, textCompleteEvent);
		}
		
		private function closeLoadingOperations():void {
			for each(var uil:UILoader in _uiLoaderStack) {
				uil.close();
				uil.finalize();
				uil = null;
			}
			createLoaderStack();
			_uiLoaderStackLength = 0;
		}
		
		private function createLoaderStack():void {
			_uiLoaderStack = new Dictionary(true);
		}
	}
}