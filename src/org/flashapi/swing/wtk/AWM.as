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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// AWM.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.5.0, 13/11/2010 16:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.ClosableProperties;
	import org.flashapi.swing.constants.DragConstraint;
	import org.flashapi.swing.constants.ScrollPolicy;
	import org.flashapi.swing.constants.WindowState;
	import org.flashapi.swing.containers.ScrollableContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.event.WindowEvent;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.layout.FlowLayout;
	import org.flashapi.swing.localization.wtk.WTKLocaleUs;
	import org.flashapi.swing.plaf.libs.WindowUIRef;
	import org.flashapi.swing.renderer.IconMenuRenderer;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.util.TextMetricsUtil;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Event
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the close button is clicked and the <code>defaultCloseOperation</code>
	 * 	property is set to <code>ClosableProperties.DO_NOTHING_ON_CLOSE</code>.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.CLOSE_BUTTON_CLICKED
	 */
	[Event(name = "closeButtonClicked", type = "org.flashapi.swing.event.WidowEvent")]
	
	/**
	 *  Dispatched when users double-clicks on the title bar.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.TITLE_BAR_DOUBLE_CLICK
	 */
	[Event(name = "titleBarDoubleClick", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 * 	The <code>AWM</code> class (for Abstract Window Methods) is the base class
	 * 	for all window objects that are part of the SPAS 3.0 Windowing ToolKit
	 * 	(aka WTK).
	 * 	
	 * 	<p><code>AWM</code> instances defines specific metric properties, such as
	 * 	<code>outerHeight</code> or <code>outerWidth</code>, as shown below:</p>
	 * 	<p><img src = "../../../../doc-images/awm_metrics.jpg" alt="AWM class metrics sheme." /></p>
	 * 
	 * 	<p><strong><code>AWM</code> instances support the following CSS properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-color</code></td>
	 * 			<td>Sets the font color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>fontColor</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">html</code></td>
	 * 			<td>Indicates whether the text displayed within this object support HTML entities, or not.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>html</code></td>
	 * 			<td><code>Properties.HTML</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">icon</code></td>
	 * 			<td>Add an icon to this object.</td>
	 * 			<td>Must be a valid URI to an image or a SWF file.</td>
	 * 			<td>The <code>setIcon()</code> method.</td>
	 * 			<td><code>Properties.ICON</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">inner-panel</code></td>
	 * 			<td>Indicates whether the object has an inner panel, or not.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>innerPanel</code></td>
	 * 			<td><code>Properties.INNER_PANEL</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">inner-panel-color</code></td>
	 * 			<td>Sets the inner panel color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>innerPanelColor</code></td>
	 * 			<td><code>Properties.INNER_PANEL_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">footer-color</code></td>
	 * 			<td>Sets the color of the footer object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>footerColor</code></td>
	 * 			<td><code>Properties.FOOTER_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">header-color</code></td>
	 * 			<td>Sets the color of the header object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>headerColor</code></td>
	 * 			<td><code>Properties.HEADER_COLOR</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AWM extends ScrollableContainer implements WTK {
		
		//TODO: icon menuhas been changed on 29/11/2008. We must implement the new IconMenuRenderer sub-system.
		public var iconMenu:IconMenuRenderer = null;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AWM</code> instance.
		 */
		public function AWM() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Indicates whether the <code>TopLevelManager</code> singleton is authorized
		 * 	to manage the z-index of this window (<code>false</code>), or not
		 * 	(<code>true</code>).
		 */
		public var invalidateTopLevelManager:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>buttonsClassName</code> property.
		 * 
		 * 	@see #buttonsClassName
		 */
		protected var $buttonsClassName:String = "";
		/**
		 * 	@inheritDoc
		 */
		public function get buttonsClassName():String {
			return $buttonsClassName;
		}
		public function set buttonsClassName(value:String):void {
			$closeButton.className = $buttonsClassName = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		[Inspectable(defaultValue="#EAEAEA", name="color", type="Color")]
		override public function set color(value:*):void {
			if (value == Color.DEFAULT) {
				spas_internal::useDefaultLafColor = true;
				fixDefaultLafColor();
			} else {
				spas_internal::lafDTO.color = $color = getColor(value);
				spas_internal::useDefaultLafColor = false;
			}
			$textureManager.color = $color;
			if ($displayed) lookAndFeel.drawWindow();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>closeButton</code> property.
		 * 
		 * 	@see #closeButton
		 */
		protected var $closeButton:WindowButton;
		/**
		 * 	@inheritDoc
		 */
		public function get closeButton():WTKButton {
			return $closeButton;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get closeButtonActive():Boolean {
			return $closeButton.active;
		}
		public function set closeButtonActive(value:Boolean):void {
			$closeButton.active = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>closeButtonAlt</code> property.
		 * 
		 * 	@see #closeButtonAlt
		 */
		protected var $closeButtonAlt:String = $btnLocalization.CLOSE;
		/**
		 * 	@inheritDoc
		 */
		public function get closeButtonAlt():String {
			return $closeButtonAlt;
		}
		public function set closeButtonAlt(value:String):void {
			$closeButton.alt = $closeButtonAlt = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get closeButtonEnabled():Boolean {
			return $closeButton.enabled;
		}
		public function set closeButtonEnabled(value:Boolean):void {
			$closeButton.enabled = value;
		}
		
		/**
		 * @private
		 */
		private var _closeOperation:String = ClosableProperties.DISPOSE_ON_CLOSE;
		/**
		 * 	@inheritDoc
		 */
		public function get defaultCloseOperation():String {
			return _closeOperation;
		}
		public function set defaultCloseOperation(value:String):void {
			_closeOperation = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontColor</code> property.
		 * 
		 * 	@see #fontColor
		 */
		protected var $fontColor:*;
		[Inspectable(defaultValue="#333333", type="Color", name="fontColor")]
		/**
		 * 	@inheritDoc
		 */
		public function get fontColor():* {
			return $fontColor;
		}
		public function set fontColor(value:*):void {
			$fontColor = value != Color.DEFAULT ? getColor(value) : value;
			if(_title) setLafTextFormat();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>icon</code> property.
		 * 
		 * 	@see #icon
		 */
		protected var $icon:Icon;
		/**
		 * 	@inheritDoc
		 */
		public function get icon():WTKIcon {
			return $icon as WTKIcon;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get iconMenuColor():* {
			return (iconMenu == null) ? NaN : iconMenu.color;
		}
		public function set iconMenuColor(value:*):void {
			if (iconMenu == null) return;
			iconMenu.color = getColor(value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>innerPanel</code> property.
		 * 
		 * 	@see #innerPanel
		 */
		protected var $innerPanel:Boolean = false;
		[Inspectable(defaultValue="true", name="innerPanel")]
		/**
		 *  @inheritDoc
		 */
		public function get innerPanel():Boolean {
			return $innerPanel;
		}
		public function set innerPanel(value:Boolean):void {
			$innerPanel = value;
			setIPOffset();
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>innerPanelColor</code> property.
		 * 
		 * 	@see #innerPanelColor
		 */
		protected var $ipColor:* = NaN;
		[Inspectable(defaultValue="#FFFFFF", name="innerPanelColor", type="Color")]
		/**
		 *  @inheritDoc
		 */
		public function get innerPanelColor():* {
			return $ipColor;
		}
		public function set innerPanelColor(value:*):void {
			spas_internal::lafDTO.innerPanelColor = $ipColor = isNaN(value) ? NaN : getColor(value);
			if($displayed) lookAndFeel.drawInnerPanel();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>innerPanelOpacity</code> property.
		 * 
		 * 	@see #innerPanelOpacity
		 */
		protected var $ipAlpha:Number = 1;
		[Inspectable(defaultValue="1", name="innerPanelOpacity", type="Number")]
		/**
		 *  @inheritDoc
		 */
		public function get innerPanelOpacity():Number {
			return $ipAlpha;
		}
		public function set innerPanelOpacity(value:Number):void {
			spas_internal::lafDTO.innerPanelAlpha = $ipAlpha = value;
			if($displayed) lookAndFeel.drawInnerPanel();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>maximized</code> property.
		 * 
		 * 	@see #maximized
		 */
		protected var $maximized:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get maximized():Boolean {
			return $maximized;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>minimized</code> property.
		 * 
		 * 	@see #minimized
		 */
		protected var $minimized:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get minimized():Boolean {
			return $minimized;
		}
		
		private var _onCloseFunction:Function = null;
		/**
		 * 	@inheritDoc
		 */
		public function get onCloseFunction():Function {
			return _onCloseFunction;
		}
		public function set onCloseFunction(value:Function):void {
			_onCloseFunction = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>outerHeight</code> property.
		 * 
		 * 	@see #outerHeight
		 */
		protected var $outerHeight:Number;
		/**
		 * 	@inheritDoc
		 */
		public function get outerHeight():Number {
			return $outerHeight;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>outerWidth</code> property.
		 * 
		 * 	@see #outerWidth
		 */
		protected var $outerWidth:Number;
		/**
		 * 	@inheritDoc
		 */
		public function get outerWidth():Number {
			return $outerWidth;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>showCloseButton</code> property.
		 * 
		 * 	@see #showCloseButton
		 */
		protected var $showCloseButton:Boolean = true
		/**
		 * 	@inheritDoc
		 */
		public function get showCloseButton():Boolean {
			return $showCloseButton;
		}
		public function set showCloseButton(value:Boolean):void {
			$closeButton.visible = $showCloseButton = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>state</code> property.
		 * 
		 * 	@see #state
		 */
		protected var $state:String = WindowState.NORMAL;
		/**
		 *  @inheritDoc
		 */
		public function get state():String {
			return $state;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>titleBarButton</code> property.
		 * 
		 * 	@see #titleBarButton
		 */
		protected var $titleBarHitArea:Sprite;
		/**
		 *  @inheritDoc
		 */
		public function get titleBarButton():Sprite {
			return $titleBarHitArea;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>label</code> property.
		 * 
		 * 	@see #label
		 */
		protected var $label:String = null;
		[Inspectable(defaultValue="Label", name="label")]
		/**
		 *  @inheritDoc
		 */
		public function get label():String {
			return $label;
		}
		public function set label(value:String):void {
			$label = value;
			truncateLabel();
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>html</code> property.
		 * 
		 * 	@see #html
		 */
		protected var $html:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get html():Boolean {
			return $html;
		}
		public function set html(value:Boolean):void {
			$html = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>windowOpacity</code> property.
		 * 
		 * 	@see #windowOpacity
		 */
		protected var $winAlpha:Number = 1;
		[Inspectable(defaultValue="1", name="windowOpacity", type="Number")]
		/**
		 *  @inheritDoc
		 */
		public function get windowOpacity():Number {
			return $winAlpha;
		}
		public function set windowOpacity(value:Number):void {
			spas_internal::lafDTO.windowOpacity = $winAlpha = value;
			if ($displayed) lookAndFeel.drawWindow();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Header & footer controls API
		//
		//--------------------------------------------------------------------------
		
		private var _headerOpacity:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get headerOpacity():Number {
			return _headerOpacity;
		}
		public function set headerOpacity(value:Number):void {
			spas_internal::lafDTO.headerOpacity = _headerOpacity = value; 
			if($header.displayed) $header.redraw();
		}
		
		private var _footerOpacity:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get footerOpacity():Number {
			return _footerOpacity;
		}
		public function set footerOpacity(value:Number):void {
			spas_internal::lafDTO.footerOpacity = _footerOpacity = value; 
			if($footer.displayed) $footer.redraw();
		}
		
		private var _headerColor:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get headerColor():* {
			return _headerColor;
		}
		public function set headerColor(value:*):void {
			_headerColor = value;
			if (value == Color.DEFAULT || isNaN(value))
				spas_internal::lafDTO.headerColor = lookAndFeel.getBackgroundColor();
			else spas_internal::lafDTO.headerColor = getColor(value);
			if($header.displayed) $header.redraw();
		}
		
		private var _footerColor:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get footerColor():* {
			return _footerColor;
		}
		public function set footerColor(value:*):void {
			_footerColor = value;
			if (value == Color.DEFAULT || isNaN(value))
				spas_internal::lafDTO.footerColor = lookAndFeel.getBackgroundColor();
			else spas_internal::lafDTO.footerColor = getColor(value);
			if($footer.displayed) $footer.redraw();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>header</code> property.
		 * 
		 * 	@see #header
		 */
		protected var $header:WindowControlContainer;
		/**
		 *  @inheritDoc
		 */
		public function get header():WTKControlContainer {
			return $header;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>footer</code> property.
		 * 
		 * 	@see #footer
		 */
		protected var $footer:WindowControlContainer;
		/**
		 *  @inheritDoc
		 */
		public function get footer():WTKControlContainer {
			return $footer;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function deleteIcon():void {
			$hasIcon = false;
			$icon.removeElements();
			setTitleProperties();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawIcon(brush:Class = null):void {
			if(brush != null) $icon.setBrush(brush, new Rectangle(0, 0, 18, 18));
			$hasIcon = true;
			$icon.eventCollector.addEvent($icon, LoaderEvent.GRAPHIC_COMPLETE, setIconProperties);
			$icon.paint();
			displayIcon();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function clearIcon():void {
			$hasIcon = false;
			$icon.clear();
			setTitleProperties();
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			if ($displayed) {
				$scrollableArea.remove();
				unload();
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function setIcon(value:*):void {
			$hasIcon = true;
			$icon.addIcon(value);
			//_eventCollector.addEvent(_icon, LoaderEvent.GRAPHIC_COMPLETE, setIconProperties);
			$icon.eventCollector.addEvent($icon, LoaderEvent.GRAPHIC_COMPLETE, setIconProperties);
			displayIcon();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$evtColl.removeEvent($header, UIOEvent.REMOVED, setNewControlSize);
			$evtColl.removeEvent($footer, UIOEvent.REMOVED, setNewControlSize);
			
			spas_internal::lafDTO.getHeaderTrayHeight = null;
			spas_internal::lafDTO.getFooterTrayHeight = null;
			spas_internal::lafDTO.isFooterDisplayed = null;
			spas_internal::lafDTO.footerTray = null;
			spas_internal::lafDTO.headerTray = null;
			spas_internal::lafDTO.chrome = null;
			spas_internal::lafDTO.titleBar = null;
			spas_internal::lafDTO.windowArea = null;
			spas_internal::lafDTO.innerPanelContainer = null;
			spas_internal::lafDTO.closeButton = null;
			
			if ($closeButton != null) {
				$closeButton.finalize();
				$closeButton = null;
			}
			if (iconMenu != null) {
				iconMenu.finalize();
				iconMenu = null;
			}
			$windowArea = null;
			spas_internal::chrome = null;
			_titleBar = null;
			$header.finalize();
			$header = null;
			$footer.finalize();
			$footer = null;
			$icon.finalizeElements();
			$icon.finalize();
			$icon = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  SizeAdjuster properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function setRealSize(width:Number, height:Number):void {
			var flag:Boolean = $invalidateRefresh;
			$invalidateRefresh = true;
			setRealWidth(width);
			setRealHeight(height);
			$invalidateRefresh = flag ? true : false;
			setRefresh();
		}
		
		/**
		 * @inheritDoc
		 */
		public function getRealHeight():Number {
			return computeRealHeight($height)
		}
		
		/**
		 * @inheritDoc
		 */
		public function setRealHeight(value:Number):void {
			var hh:Number = $header.displayed ? $header.height : 0;
			var fh:Number = $footer.displayed ? $footer.height : 0;
			var h:Number = value - $titleBarHeight - $topOffset - $bottomOffset - $ipOffset - hh - fh;
			spas_internal::lafDTO.height = $height = h < $minHeight ? $minHeight : h;
			setRefresh();
		}
		
		/**
		 * @inheritDoc
		 */
		public function getRealWidth():Number {
			return computeRealWidth($width);
		}
		
		/**
		 * @inheritDoc
		 */
		public function setRealWidth(value:Number):void {
			var w:Number = value - $leftOffset - $rightOffset - $ipOffset;
			spas_internal::lafDTO.width = $width = w < $minWidth ? $minWidth : w;
			setRefresh();
		}
		
		/**
		 * @inheritDoc
		 */
		public function getRealMinWidth():Number {
			return computeRealWidth($minWidth);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getRealMinHeight():Number {
			return computeRealHeight($minHeight);
		}
		
		/**
		 * 	Returns the class used to define the default localization for all buttons.
		 * 
		 * 	@return The default localization for all buttons.
		 * 
		 * 	@see #setButtonLocalization()
		 */
		public static function getButtonLocalization():Class {
			return $btnLocalization;
		}
		
		/**
		 * 	Changes the class used to define the default localization for all buttons.
		 * 
		 * 	@param	wtkLocale	The default localization for all buttons.
		 * 
		 * 	@see #getButtonLocalization()
		 */
		public static function setButtonLocalization(wtkLocale:Class):void {
			$btnLocalization = wtkLocale;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		//protected var $closable:Boolean = true;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>Sprite</code> object that is used to
		 * 	render the window inner panel.
		 */
		protected var $innerPanelContainer:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>Sprite</code> object that is used to
		 * 	render the window title bar.
		 */
		protected var $titleBarContainer:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>Sprite</code> object that is used to
		 * 	display the window <code>Icon</code> object.
		 * 
		 * 	@see #icon
		 */
		protected var $iconContainer:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the window 
		 * 	currently displays an icon (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@see #icon
		 */
		protected var $hasIcon:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>UITextFormat</code> object that 
		 * 	is used to render the title bar label of the window.
		 */
		protected var $format:UITextFormat;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal reference that indicates the width for all window
		 * 	buttons.
		 */
		protected var $buttonsWidth:Number;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>Sprite</code> object that is used to
		 * 	render the window area when the window is resized.
		 */
		protected var $windowArea:Sprite = null;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the header 
		 * 	and footer controls must automatically be updated when the window is resized
		 * 	(<code>true</code>), or not (<code>false</code>).
		 */
		protected var $activateControlsUpdate:Boolean = true;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the buttons localization class.
		 */
		protected static var $btnLocalization:Class = WTKLocaleUs;
		
		//--------------------------------------------------------------------------
		//
		//  Skin management
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 * 	FOR DEVELOPERS ONLY
		 */
		spas_internal var chrome:Sprite;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function init(label:String, w:Number, h:Number):void {
			$label = label;
			if (spas_internal::isComponent) {
				super.width = w;
				super.height = h;
			}
			initSize(w, h);
		}
		
		/**
		 * @private
		 */
		protected function fixSize():void {
			var hh:Number = $header.displayed ? $header.height : 0;
			var fh:Number = $footer.displayed ? $footer.height : 0;
			//if(_innerPanel) {
				$outerWidth = $width+$leftOffset+$rightOffset+$ipOffset;
				$outerHeight = $height+$titleBarHeight+$topOffset+$bottomOffset+$ipOffset + hh + fh;
				$backgroundWidth = $width+$ipOffset;
				$backgroundHeight = $height+$ipOffset;
			/*} else {
				_outerWidth = _width+_leftOffset+_rightOffset;
				_outerHeight = _height+_titleBarHeight+_topOffset+_bottomOffset + hh + fh;
				_backgroundWidth = _width;
				_backgroundHeight = _height;
			}*/
			spas_internal::lafDTO.outerWidth = $outerWidth;
			spas_internal::lafDTO.outerHeight = $outerHeight;
			spas_internal::lafDTO.spas_internal::setSize($width, $height);
			var tw:Number = $width + $ipOffset;
			spas_internal::lafDTO.trayWidth = tw;
			if($activateControlsUpdate) {
				if($header.width != tw) {
					$header.spas_internal::setWidth(tw);
					$header.spas_internal::updateLayout();
				}
				if($footer.width != tw) {
					$footer.spas_internal::setWidth(tw);
					$footer.spas_internal::updateLayout();
				}
				setLAFPositions();
			}
		}
		
		/**
		 * @private
		 */
		protected function createContainers():void {
			spas_internal::uioSprite.addChild($innerPanelContainer);
			spas_internal::lafDTO.innerPanelContainer = $innerPanelContainer;
			createScrollableContainers();
			$scrollableArea.scrollPolicy = ScrollPolicy.NONE;
			spas_internal::background.buttonMode = true;
			spas_internal::background.useHandCursor = false;
			/*contentMask.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler);
			function _mouseDownHandler(event:MouseEvent):void { setToTopLevel(); trace("called"); };*/
			initLaf(WindowUIRef);
			createAWMControls();
			spas_internal::uioSprite.addChild($titleBarContainer);
			$titleBarContainer.addChild(_titleBar);
		}
		
		/**
		 * @private
		 */
		protected function setLAFPositions():void {
			var hh:Number = $header.displayed ? $header.height : 0;
			$header.y = $titleBarHeight + $topOffset;
			$footer.x = $header.x = spas_internal::background.x =
				spas_internal::borders.x = $leftOffset;
			spas_internal::background.y = spas_internal::borders.y =
				$titleBarHeight + $topOffset + hh;
			$innerPanelContainer.x = $leftOffset + $innerPanelOffset;
			$innerPanelContainer.y = $titleBarHeight + $topOffset + $innerPanelOffset + hh;
			$iconContainer.x = $titleLeftOffset;
			$iconContainer.y = $titleTopOffset;
			$footer.y = $innerPanelContainer.y + $height;
			$borderDecorator.spas_internal::fixBorderOrigin(spas_internal::borders.x, spas_internal::borders.y);
		}
		
		/**
		 * @private
		 */
		protected function createTitleBarItems():void {
			spas_internal::uioSprite.addChild($iconContainer);
			$icon.target = $iconContainer;
			$closeButton.target = $titleBarContainer;
			//_closeButton.alt = _closeButtonAlt;
			//initCloseButton();
			$closeButton.display();
			$titleBarContainer.hitArea = $titleBarHitArea;
			setCloseButtonBehavior();
		}
		
		/**
		 * @private
		 */
		protected function createTitleBar():void {
			if (!_title) {
				$titleBarHitArea.doubleClickEnabled = true;
				$evtColl.addEvent($titleBarHitArea, MouseEvent.DOUBLE_CLICK, doubleClickHandler);
				$evtColl.addEvent($titleBarContainer, MouseEvent.MOUSE_DOWN, mouseDownHandler);
				$evtColl.addEvent($titleBarContainer, MouseEvent.MOUSE_UP, mouseUpHandler);
				_title = new TextField();
				setLafTextFormat();
				truncateLabel();
				_title.selectable = false;
				$titleBarContainer.addChild(_title);
				$titleBarContainer.addChild($titleBarHitArea);
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			fixTopLevel();
			if($icon.displayed) resetIconMenu();
			if (!$maximized && $draggable) {
				var q:int = getQuality();
				$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, dispatchStartDragEvent);
				if(q==3 || $autoRaise) {
					spas_internal::deactivateShadow();
					spas_internal::deactivateGlow();
					lookAndFeel.addRaiseEffect();
					constraintDefinition();
					$evtColl.addEvent(this.parent, MouseEvent.MOUSE_UP, bestQualityMouseUpHandler);
				}
				else if(q>0 && q<3) constraintDefinition();
				else {
					var wa:Sprite = $windowArea;
					spas_internal::deactivateShadow();
					spas_internal::deactivateGlow();
					lookAndFeel.drawWindowArea();
					switch($dragConstraint) {
						case DragConstraint.FREE :
							wa.startDrag();
							break;
						case DragConstraint.STAGE :
							var r:Rectangle = new Rectangle(
								-spas_internal::uioSprite.x, -spas_internal::uioSprite.y,
								$stage.stageWidth - wa.width, $stage.stageHeight - wa.height);
							wa.startDrag(false, r);
							break;
					}
					$evtColl.addEvent(this.parent, MouseEvent.MOUSE_UP, windowAreaMouseUpHandler);
				}
			}
		}
		
		private function constraintDefinition():void {
			var sh:Number = $stage.stageHeight;
			var h:Number = $minimized ? sh - lookAndFeel.getTitleBarHeight() : sh - $outerHeight;
			switch($dragConstraint) {
				case DragConstraint.FREE :
					spas_internal::uioSprite.startDrag();
					break;
				case DragConstraint.STAGE :
					spas_internal::uioSprite.startDrag(
						false, new Rectangle(0, 0, $stage.stageWidth - $outerWidth, h));
					break;
			}
		}
			
		private function dispatchStartDragEvent(e:MouseEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, dispatchStartDragEvent);
			dispatchWindowEvent(WindowEvent.WINDOW_DRAG_START);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			spas_internal::uioSprite.stopDrag();
			$x = spas_internal::uioSprite.x;
			$y = spas_internal::uioSprite.y;
			dispatchWindowEvent(WindowEvent.WINDOW_DRAG_STOP);
			if ($evtColl.hasRegisteredEvent($stage, MouseEvent.MOUSE_MOVE, dispatchStartDragEvent))
				$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, dispatchStartDragEvent);
		}
		
		private function windowAreaMouseUpHandler(e:MouseEvent):void {
			var wa:Sprite = $windowArea;
			wa.graphics.clear();
			wa.stopDrag();
			spas_internal::uioSprite.x += wa.x;
			spas_internal::uioSprite.y += wa.y;
			wa.x = wa.y = 0;
			spas_internal::reactivateShadow();
			spas_internal::reactivateGlow();
			$evtColl.removeEvent(this.parent, MouseEvent.MOUSE_UP, windowAreaMouseUpHandler);
		}
		
		private function bestQualityMouseUpHandler(e:MouseEvent):void {
			spas_internal::uioSprite.stopDrag();
			lookAndFeel.removeRaiseEffect();
			spas_internal::reactivateShadow(); spas_internal::reactivateGlow();
			$evtColl.removeEvent(this.parent, MouseEvent.MOUSE_UP, bestQualityMouseUpHandler);
		}
		
		/**
		 * @private
		 */
		protected function doubleClickHandler(e:MouseEvent):void {
			dispatchWindowEvent(WindowEvent.TITLE_BAR_DOUBLE_CLICK);
		}
		
		/**
		 * @private
		 */
		protected function setLafTextFormat():void {
			if (!isNaN($fontColor)) $format.color = $fontColor;
			_title.defaultTextFormat = $format;
			lookAndFeel.setTextEffect();
		}
		
		/**
		 * @private
		 */
		protected function setTitleProperties():void {
			var w:Number = $outerWidth-$buttonsWidth;
			var f:Figure = Figure.setFigure($titleBarHitArea);
			f.clear();
			f.beginFill(0, 0);
			f.drawRectangle(0, 0, w, $titleBarHeight);
			f.endFill();
			var icd:Number = 0;
			if($hasIcon) icd = lookAndFeel.getIconDelay();
			_title.x = $titleLeftOffset + $iconContainer.width + icd;
			_title.y = $topOffset;
			_title.height = $titleBarHeight-$topOffset;
			_title.visible = (_title.x < w);
			_title.width = w - _title.x - 2;
			truncateLabel();
		}
		
		/**
		 * @private
		 */
		protected function setContentPosition():void {
			var hh:Number = $header.displayed ? $header.height : 0;
			if ($innerPanel) {
				$scrollableContainer.x = $leftOffset + $innerPanelOffset;
				$scrollableContainer.y = $titleBarHeight + $topOffset + $innerPanelOffset + hh;
			} else {
				$scrollableContainer.x = $leftOffset;
				$scrollableContainer.y = $titleBarHeight + $topOffset + hh;
			}
			$contentMask.x = $scrollableContainer.x;
			$contentMask.y = $scrollableContainer.y; 
		}
		
		/**
		 * @private
		 */
		protected function setCloseButtonBehavior():void {
			$evtColl.addEvent($closeButton, UIMouseEvent.PRESS, closeBtnMouseDownHandler);
			$evtColl.addEvent($closeButton, UIMouseEvent.RELEASE, closeBtnMouseUpHandler);
		}
		
		/**
		 * @private
		 */
		protected function displayIcon():void {
			$icon.display();
		}
		
		/**
		 * @private
		 */
		protected function setIconProperties(e:LoaderEvent):void {
			if (!spas_internal::uioSprite.contains(_iconButton)) {
				spas_internal::uioSprite.addChild(_iconButton);
				_iconButton.doubleClickEnabled = true;
			}
			drawIconHitArea();
			$evtColl.addEvent(_iconButton, MouseEvent.MOUSE_DOWN, addMenu);
			$evtColl.addEvent(_iconButton, MouseEvent.DOUBLE_CLICK, closeFromIconMenu);
			setTitleProperties();
			$icon.eventCollector.removeEvent($icon, LoaderEvent.GRAPHIC_COMPLETE, setIconProperties);
			//the following code does not work:
			//_eventCollector.removeEvent(_icon, LoaderEvent.GRAPHIC_COMPLETE, setIconProperties);
		}
		
		/**
		 * @private
		 */
		protected function setButtonCommonBehavior(e:MouseEvent):void {
			e.stopImmediatePropagation();
			fixTopLevel();
			removeIconMenu();
		}
		
		/**
		 * @private
		 */
		protected function fixTopLevel():void {
			if (!invalidateTopLevelManager) {
				setToTopLevel();
				dispatchWindowEvent(WindowEvent.IS_OVER_ALL);
			}
		}
		
		/**
		 * @private
		 */
		protected function removeIconMenu():void {
			if (iconMenu == null) return;
			if(iconMenu.displayed) iconMenu.remove();
		}
		
		/**
		 * @private
		 */
		protected function drawMask():void {
			var f:Figure = Figure.setFigure($contentMask);
			f.clear();
			f.beginFill(0);
			f.drawRectangle(0, 0, $width, $height);
			f.endFill();
		}
		
		/**
		 * @private
		 */
		protected function getIconBounds(btn:WindowButton):Rectangle {
			var rect:Rectangle = new Rectangle(
				0, 0, btn.width - btn.lookAndFeel.getRightOffset() - btn.lookAndFeel.getLeftOffset(),
				btn.height - btn.lookAndFeel.getTopOffset() - btn.lookAndFeel.getBottomOffset());
			return rect;
		}
		
		/**
		 * 	@private
		 */
		protected function fixWindowButtonLaf(btn:WindowButton, icon:Class):void {
			btn.width = btn.height = $buttonsSize;
			btn.drawIcon(icon, getIconBounds(btn));
		}
		
		/**
		 * @private
		 */
		protected function dispatchWindowEvent(type:String):void {
			this.dispatchEvent(new WindowEvent(type));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _title:TextField;
		private var _iconButton:Sprite;
		private var _titleBar:Sprite;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createUISprites();
			createChromeContainer();
			spas_internal::lafDTO.titleBar = _titleBar;
			spas_internal::lafDTO.windowOpacity = $winAlpha;
			spas_internal::lafDTO.innerPanelOpacity = $ipAlpha;
			spas_internal::lafDTO.innerPanelColor = $ipColor;
			spas_internal::lafDTO.state = $state;
			createTextureManager(spas_internal::chrome);
			$parent = $stage;
			$draggable = true;
			createUIObjects();
			createIconMenu();
			$fontColor = Color.DEFAULT;
			$layout = new FlowLayout();
			spas_internal::initLayout();
			$borderStyle = BorderStyle.NONE;
		}
		
		private function initTextFormat():void {
			$format = lookAndFeel.getTextFormat().clone();
		}
		
		private function truncateLabel():void {
			TextMetricsUtil.truncateToFit($label, _title, _title.width);
		}
		
		private function addMenu(event:MouseEvent):void {
			if (iconMenu == null) return;
			$evtColl.removeEvent(_iconButton, MouseEvent.MOUSE_DOWN, addMenu);
			setButtonCommonBehavior(event);
			$evtColl.addEvent(iconMenu, UIMouseEvent.PRESS_OUTSIDE, deactivateIconMenu);
			
			iconMenu.shadow = true;
			iconMenu.display($rightOffset, $titleBarHeight);
			$evtColl.addEvent($iconContainer, MouseEvent.MOUSE_DOWN, removeMenu);
		}
		
		private function removeMenu(event:MouseEvent):void {
			resetIconMenu();
		}
		
		private function deactivateIconMenu(e:UIMouseEvent):void {
			resetIconMenu();
		}
		
		private function resetIconMenu():void {
			if (iconMenu == null) return;
			iconMenu.remove();
			$evtColl.removeEvent($iconContainer, MouseEvent.MOUSE_DOWN, removeMenu);
			$evtColl.removeEvent(iconMenu, UIMouseEvent.PRESS_OUTSIDE, deactivateIconMenu);
			$evtColl.addEvent(_iconButton, MouseEvent.MOUSE_DOWN, addMenu);
		}
		
		private function closeBtnMouseDownHandler(e:UIMouseEvent):void {
			setButtonCommonBehavior(e);
		}
		
		private function closeBtnMouseUpHandler(e:UIMouseEvent):void {
			doCloseOperation();
		}
		
		private function doCloseOperation():void {
			switch(_closeOperation) {
				case ClosableProperties.DISPOSE_ON_CLOSE :
					//if ($closable) this.remove();
					this.remove();
					break;
				case ClosableProperties.CALL_CLOSE_FUNCTION :
					if (_onCloseFunction != null) {
						$evtColl.addEvent(this, UIOEvent.REMOVED, callCloseFunction);
					}
					this.remove();
					break;
				case ClosableProperties.REMOVE_ON_CLOSE :
					finalize();
					break;
				case ClosableProperties.DO_NOTHING_ON_CLOSE :
					dispatchWindowEvent(WindowEvent.CLOSE_BUTTON_CLICKED);
					break;
				case ClosableProperties.ONLY_CALL_CLOSE_FUNCTION :
					if (_onCloseFunction != null) _onCloseFunction();
					break;
			}
		}
		
		private function callCloseFunction(e:UIOEvent):void {
			$evtColl.removeEvent(this, UIOEvent.REMOVED, callCloseFunction);
			_onCloseFunction();
		}
		
		private function drawIconHitArea():void {
			var tbb:Figure = Figure.setFigure(_iconButton);
			tbb.clear();
			tbb.beginFill(0, 0);
			tbb.drawRectangle($iconContainer.x, 0, $iconContainer.x + $iconContainer.width, $titleBarHeight);
			tbb.endFill();
		}
		
		private function closeFromIconMenu(e:MouseEvent):void {
			doCloseOperation();
		}
		
		private function createIconMenu():void {
			/*iconMenu = new Menu(150);
			iconMenu.target = spas_internal::CONTAINER;*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  header & footer controls managment
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function fixControlsLaf():void {
			if ($header == null) return;
			var c:uint = lookAndFeel.getBackgroundColor();
			if (isNaN(_headerColor)) spas_internal::lafDTO.headerColor = c;
			if (isNaN(_footerColor)) spas_internal::lafDTO.footerColor = c;
			$header.spas_internal::drawingFunction = lookAndFeel.drawHeaderTray;
			$footer.spas_internal::drawingFunction = lookAndFeel.drawFooterTray;
		}
		
		private function createAWMControls():void {
			var w:Number = $width + $ipOffset;
			$header = new WindowControlContainer(this, spas_internal::lafDTO, w, Selectors.HEADER);
			$header.target = spas_internal::uioSprite;
			$footer = new WindowControlContainer(this, spas_internal::lafDTO, w, Selectors.FOOTER);
			$footer.target = spas_internal::uioSprite;
			spas_internal::lafDTO.headerOpacity = spas_internal::lafDTO.footerOpacity = 1;
			
			spas_internal::lafDTO.getHeaderTrayHeight = function():Number {
				return $header.height;
			}
			spas_internal::lafDTO.getFooterTrayHeight = function():Number {
				return $footer.height;
			}
			spas_internal::lafDTO.isFooterDisplayed = function():Boolean {
				return $footer.displayed;
			}
			
			spas_internal::lafDTO.footerTray = $footer.spas_internal::tray;
			spas_internal::lafDTO.headerTray = $header.spas_internal::tray;
			
			$evtColl.addEvent($header, UIOEvent.DISPLAYED, setNewControlSize);
			$evtColl.addEvent($footer, UIOEvent.DISPLAYED, setNewControlSize);
			$evtColl.addEvent($header, UIOEvent.REMOVED, setNewControlSize);
			$evtColl.addEvent($footer, UIOEvent.REMOVED, setNewControlSize);
			$evtColl.addEvent($header, UIOEvent.DISPLAYED, swapControl);
			$evtColl.addEvent($footer, UIOEvent.DISPLAYED, swapControl);
			fixControlsLaf();
		}
		
		private function setNewControlSize(e:UIOEvent):void {
			setRefresh();
		}
		
		private function createUISprites():void {
			$innerPanelContainer = new Sprite();
			$titleBarContainer = new Sprite();
			$iconContainer = new Sprite();
			$titleBarHitArea = new Sprite();
			_iconButton = new Sprite();
			_titleBar = new Sprite();
		}
		
		//--> End header & footer controls managment
		
		private function createUIObjects():void {
			$closeButton = new WindowButton();
			spas_internal::lafDTO.closeButton = $closeButton;
			$closeButton.alt = $closeButtonAlt;
			$icon = new Icon();
		}
		
		private function setUIObjectsLaf():void {
			$scrollableArea.lockLaf(lookAndFeel.getScrollBarLaf(), true);
			fixControlsLaf();
			//iconMenu.lockLaf(lookAndFeel.ICON_MENU_LAF, true);
			$closeButton.lockLaf(lookAndFeel.getButtonLaf(), true);
			fixWindowButtonLaf($closeButton, lookAndFeel.getCloseButtonBrush());
		}
		
		private function createChromeContainer():void {
			spas_internal::chrome = new Sprite();
			spas_internal::lafDTO.chrome = spas_internal::chrome;
			spas_internal::uioSprite.addChildAt(spas_internal::chrome, 0);
		}
		
		private function swapControl(e:UIOEvent):void {
			if ($windowArea == null) return;
			var c:Sprite = e.target.container;
			if (spas_internal::uioSprite.getChildIndex($windowArea) <
				spas_internal::uioSprite.getChildIndex(c)) {
					spas_internal::uioSprite.swapChildren($windowArea, c);
				}
		}
		
		private function computeRealHeight(value:Number):Number {
			var hh:Number = $header.displayed ? $header.height : 0;
			var fh:Number = $footer.displayed ? $footer.height : 0;
			var h:Number = value + $titleBarHeight + $topOffset + $bottomOffset + $ipOffset + hh + fh;
			return h;
		}
		
		private function computeRealWidth(value:Number):Number {
			var w:Number = value + $leftOffset + $rightOffset + $ipOffset;
			return w;
		}
		
		//--> L&F properties managment:
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Number</code> value that represents the height of the
		 * 	window title bar, specified by the current Look and Feel.
		 */
		protected var $titleBarHeight:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the top edge offset
		 * 	of the window, specified by the current Look and Feel.
		 */
		protected var $topOffset:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the bottom edge offset
		 * 	of the window, specified by the current Look and Feel.
		 */
		protected var $bottomOffset:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the right-hand offset
		 * 	of the window, specified by the current Look and Feel.
		 */
		protected var $rightOffset:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the left-hand offset
		 * 	of the window, specified by the current Look and Feel.
		 */
		protected var $leftOffset:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the inner pannel offset,
		 * 	specified by the current Look and Feel.
		 */
		protected var $innerPanelOffset:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the left-hand offset
		 * 	of the title bar, specified by the current Look and Feel.
		 */
		protected var $titleLeftOffset:Number;
		
		/**
		 * 	An internal <code>Number</code> value that represents the top edge offset
		 * 	of the title bar, specified by the current Look and Feel.
		 */
		protected var $titleTopOffset:Number;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Number</code> value that represents the size of the
		 * 	title bar buttons, specified by the current Look and Feel.
		 */
		protected var $buttonsSize:Number;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Number</code> value that defines the offset between
		 * 	the inner panel position and the window borders, when <code>innerPanel</code>
		 * 	is <code>true</code>.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #innerPanel
		 */
		protected var $ipOffset:Number;
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			$titleBarHeight = lookAndFeel.getTitleBarHeight();
			$topOffset = lookAndFeel.getTopOffset();
			$bottomOffset = lookAndFeel.getBottomOffset();
			$rightOffset = lookAndFeel.getRightOffset();
			$leftOffset = lookAndFeel.getLeftOffset();
			$innerPanelOffset = lookAndFeel.getInnerPanelOffset();
			setIPOffset();
			$titleLeftOffset = lookAndFeel.getTitleBarLeftOffset();
			$titleTopOffset = lookAndFeel.getTitleBarTopOffset();
			$buttonsSize = lookAndFeel.getButtonSize();
			initTextFormat();
			if (_title) setLafTextFormat();
			setUIObjectsLaf();
		}
		
		/**
		 *  @private
		 */
		protected function setIPOffset():void {
			$ipOffset = $innerPanel ? 2 * $innerPanelOffset : 0;
		}
	}
}