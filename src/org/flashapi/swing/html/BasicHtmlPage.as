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

package org.flashapi.swing.html {
	
	// -----------------------------------------------------------
	// BasicHtmlPage.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/03/2011 02:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flashx.textLayout.compose.IFlowComposer;
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.InlineGraphicElementStatus;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.CompositionCompleteEvent;
	import flashx.textLayout.events.StatusChangeEvent;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.HTMLFormat;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.net.DataLoader;
	import org.flashapi.swing.util.XMLUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	The <code>BasicHtmlPage</code> class create a container that enables loading
	 * 	and displaying XHTML and CSS files within a SPAS 3.0 application.
	 * 
	 * 	@see org.flashapi.swing.html.CssFormatResolver
	 * 	@see org.flashapi.swing.html.BasicHtmlParser
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 10
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class BasicHtmlPage extends UIObject implements IUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>BasicHtmlPage</code> instance with
		 * 					the specified parameters.
		 */
		public function BasicHtmlPage(width:Number = 500, height:Number = NaN) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  A value from the <code>BorderStyle</code> class that specifies the border line style
		 * 	specified for this object. Valid values are:
		 *  <ul>
		 * 		<li><code>BorderStyle.NONE</code>,</li>
		 * 		<li><code>BorderStyle.DASHED</code>,</li>
		 * 		<li><code>BorderStyle.DOTTED</code>,</li>
		 * 		<li><code>BorderStyle.DOUBLE</code>,</li>
		 * 		<li><code>BorderStyle.SOLID</code>,</li>
		 * 		<li><code>BorderStyle.OUTSET</code>,</li>
		 * 		<li><code>BorderStyle.INSET</code>,</li>
		 * 		<li><code>BorderStyle.DOUBLE</code>,</li>
		 * 		<li><code>BorderStyle.RIDGE</code>,</li>
		 * 		<li><code>BorderStyle.GROOVE</code>.</li>
		 * 	</ul>
		 * 	For more information abaout using border styles, see
		 * 	<a href='../../../../appendixes/box_class.html'>The <code>Box</code> class model</a> in the
		 * 	'Appendixes section'.
		 * 
		 * 	@see org.flashapi.swing.constants.BorderStyle
		 * 
		 * 	@default BorderStyle.NONE
		 */
		public function get borderStyle():String {
			return _pageCont.borderStyle;
		}
		public function set borderStyle(value:String):void {
			_pageCont.borderStyle = value;
		}
		
		private var _autoDetectCSS:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>BasicHtmlPage</code>
		 * 	instance automatically detect CSS links contained within the current XHTML
		 * 	page (<code>true</code>), or not (<code>false</code>). If <code>true</code>,
		 * 	the CSS files are loaded and then applied to the <code>BasicHtmlPage</code>
		 * 	object.
		 * 
		 * 	@default true
		 */
		public function get autoDetectCSS():Boolean {
			return _autoDetectCSS;
		}
		public function set autoDetectCSS(value:Boolean):void {
			_autoDetectCSS = value;
		}
		
		private var _htmlFormat:String = HTMLFormat.XHTML_PAGE;
		/**
		 * 	Sets or get the type of html page that will be added to this <code>BasicHtmlPage</code>
		 * 	instance.
		 * 
		 * 	@default HTMLFormat.XHTML_PAGE
		 */
		public function get htmlFormat():String {
			return _htmlFormat;
		}
		public function set htmlFormat(value:String):void {
			_htmlFormat = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Box encapsulation API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set borderAlpha(value:Number):void {
			$borderAlpha = _pageCont.borderAlpha = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set borderColor(value:*):void {
			$borderColor = _pageCont.borderColor = new Color().getValue(value);
		}
		
		/**
		 * 	@private
		 */
		override public function set borderWidth(value:Number):void {
			$borderWidth = _pageCont.borderWidth = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Loads a CSS file into this <code>BasicHtmlPage</code> instance and then,
		 * 	applies it to the current XHTML page.
		 * 
		 * 	@param	uri	A URI reference to a valid CSS file.
		 * 
		 * 	@see #addCSS()
		 */
		public function loadCSS(uri:String):void {
			_cssLoader.load(uri, DataFormat.CSS);
		}
		
		/**
		 * 	Adds a CSS file to this <code>BasicHtmlPage</code> instance and 
		 * 	applied it to the current XHTML page.
		 * 
		 * 	@param	style	A <code>StyleSheet</code> object.
		 * 
		 * 	@see #loadCSS()
		 */
		public function addCSS(style:StyleSheet):void {
			_formatResolver.styleSheet = style;
			applyCSS();
		}
		
		/**
		 * 	Loads a XHTML file into this <code>BasicHtmlPage</code> instance and then,
		 * 	displays it.
		 * 
		 * 	@param	uri	A URI reference to a valid XHTML file.
		 * 
		 * 	@see #addXHTML()
		 * 	@see #htmlFormat
		 */
		public function loadXHTML(uri:String):void {
			_htmlLoader.load(uri, DataFormat.TEXT);
		}
		
		/**
		 * 	Replaces the current XHTML page, currently displayed within this <code>BasicHtmlPage</code>
		 * 	instance, by the new one specified by the <code>xhtml</code> parameter.
		 * 
		 * 	@param	xhtml	The new XHTML page to display within this <code>BasicHtmlPage</code>
		 * 					instance.
		 * 
		 * 	@see #loadXHTML()
		 * 	@see #htmlFormat
		 */
		public function addXHTML(xhtml:XML):void {
			updateFlow(xhtml);
		}
		
		/**
		 * 	@private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return _pageCont.getRect(targetCoordinateSpace);
		}
		
		/**
		 * 	@private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return _pageCont.getBounds(targetCoordinateSpace);
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			removeFlowRefs();
			_flowContainer = null;
			_flowComposer = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		override protected function refresh():void {
			if (_pageCont.width != $width) _pageCont.width = $width;
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _pageCont:Box;
		private var _flow:TextFlow;
		private var _formatResolver:CssFormatResolver;
		private var _htmlLoader:DataLoader;
		private var _cssLoader:DataLoader;
		private var _xhtmlSrc:XML;
		private var _totalImg:uint = 0;
		private var _imgLoaded:uint = 0;
		private var _padding:Number = 0;
		
		private var _updateType:uint = 0;
		private var _compositionHeight:Number = 0;
		private var _flowContainer:ContainerController;
		private var _flowComposer:IFlowComposer;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$width = width;
			$height = height;
			$autoHeight = isNaN($height);
			$content = new Sprite();
			_pageCont = new Box($width);
			_pageCont.target = spas_internal::uioSprite;
			_pageCont.horizontalGap = _pageCont.verticalGap = 0;
			_pageCont.addElement($content);
			_pageCont.display();
			_padding = 2 * _pageCont.paddingLeft;
			
			_formatResolver = new CssFormatResolver();
			_flow = new TextFlow();
			
			_htmlLoader = new DataLoader();
			$evtColl.addEvent(_htmlLoader, LoaderEvent.COMPLETE, htmlLoadComplete);
			//$evtColl.addEvent(_htmlLoader, LoaderEvent.IO_ERROR, loadError);
			
			_cssLoader = new DataLoader();
			$evtColl.addEvent(_cssLoader, LoaderEvent.COMPLETE, cssLoadComplete);
		}
		
		/*private function loadError(e:LoaderEvent):void {
			print("loadError");
		}*/
		
		private function cssLoadComplete(e:LoaderEvent):void {
			var style:StyleSheet = new StyleSheet();
			style.parseCSS(e.data);
			_formatResolver.styleSheet = style;
			applyCSS();
		}
		
		private function htmlLoadComplete(e:LoaderEvent):void {
			var s:String = XMLUtil.removeDefaultNamespaceFromString(e.data);
			updateFlow(new XML(s));
		}
		
		private function updateFlow(xhtml:XML):void {
			_xhtmlSrc = xhtml;
			var parser:BasicHtmlParser = new BasicHtmlParser();
			parser.htmlFormat = _htmlFormat;
			parser.setSource(_xhtmlSrc);
			var markup:String = parser.xhtmlToTextFlowMakup().toXMLString();
			
			var a:Array = parser.getCssCollection();
			if (a.length) this.loadCSS(a[0].href);
			//print(markup)
			
			_totalImg = parser.getImagesNum();
			removeFlowRefs();
			_flow = TextConverter.importToFlow(markup, TextConverter.TEXT_LAYOUT_FORMAT);
			_flowComposer = _flow.flowComposer;
			_flow.interactionManager = new SelectionManager();
			$evtColl.addEvent(_flow, CompositionCompleteEvent.COMPOSITION_COMPLETE, onCompositionComplete);
			$evtColl.addEvent(_flow, StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, recomposeOnLoadComplete);
			_flowComposer.addController(new ContainerController($content, $width - _padding));
			_flowContainer = _flowComposer.getControllerAt(0);
			applyCSS();
			_updateType = 0;
			_flowComposer.updateAllControllers();
		}
		
		private function recomposeOnLoadComplete(e:StatusChangeEvent):void {
			var flow:TextFlow = e.element.getTextFlow();
			if (e.status == InlineGraphicElementStatus.ERROR) {
				(e.element as InlineGraphicElement).source = new EmptyElement();
				var sce:StatusChangeEvent = new StatusChangeEvent(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, false, false, e.element);
				sce.status = InlineGraphicElementStatus.READY;
				_imgLoaded--;
				_flow.dispatchEvent(sce);
			}
			if (flow == _flow) {
				if (e.status == InlineGraphicElementStatus.SIZE_PENDING) {
					_updateType = 1;
					_flowComposer.updateAllControllers();
				} else if (e.status == InlineGraphicElementStatus.READY) {
					_imgLoaded++;
				}
				checkLoadedImgNum();
			}
		}
		
		private function checkLoadedImgNum():void {
			if (_totalImg == _imgLoaded) {
				applyCSS();
				updateCompositionHeight();
				_updateType = 2;
				_flowComposer.updateAllControllers();
				
			}
		}
		
		private function updateCompositionHeight():void {
			_compositionHeight = updateFlowHeight();
			_flowContainer.setCompositionSize(_flowContainer.compositionWidth, _compositionHeight);
		}
		
		private function updateFlowHeight():int {
			if (_flowContainer) {
				var textHeight:int = Math.ceil(_flowContainer.getContentBounds().height);
				return textHeight;
			}
			return 0;
		}
		
		private function applyCSS():void {
			if (_formatResolver.styleSheet != null) {
				_flow.formatResolver = _formatResolver;
			}
		}
		
		private function removeFlowRefs():void {
			if ($evtColl.hasRegisteredEvent(_flow, StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, recomposeOnLoadComplete)) {
				_flow.interactionManager = null;
				_flow.formatResolver = null;
				$evtColl.removeEvent(_flow, CompositionCompleteEvent.COMPOSITION_COMPLETE, onCompositionComplete);
				$evtColl.removeEvent(_flow, StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, recomposeOnLoadComplete);
			}
		}
		
		private function onCompositionComplete(e:CompositionCompleteEvent):void {
			switch(_updateType) {
				case 0 :
					updateCompositionHeight();
					break;
				case 1 :
					break;
				case 2 :
					_compositionHeight = Math.ceil(_flowContainer.getContentBounds().height);
					_pageCont.height = _compositionHeight + _padding;
					dispatchMetricsEvent();
					break;
			}
			//print("damageAbsoluteStart", _flowComposer.isDamaged(_flowComposer.damageAbsoluteStart), _flowComposer.getLineAt(_flowComposer.damageAbsoluteStart));
		}
	}
}