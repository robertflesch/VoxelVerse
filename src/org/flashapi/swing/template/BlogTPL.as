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

package org.flashapi.swing.template {
	
	// -----------------------------------------------------------
	// BlogTPL.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 08/04/2009 16:26
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Point;
	import org.flashapi.swing.Application;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.constants.BlogMenuPosition;
	import org.flashapi.swing.constants.LayoutHorizontalAlignment;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.LayoutVerticalAlignment;
	import org.flashapi.swing.containers.MainContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.Drawing;
	import org.flashapi.swing.event.ApplicationEvent;
	import org.flashapi.swing.event.LayoutEvent;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.HorizontalSeparator;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.swing.Separator;
	import org.flashapi.swing.Text;
	import org.flashapi.swing.text.CssString;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>BlogTPL</code> class creates an template file that allows to deploy
	 * 	a SPAS 3.0 application similar to blog-like Web sites.
	 * 
	 * 	<p>The following table lists the CSS attributes defined as default style for
	 * 	this <code>BlogTPL</code> class:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>CSS type</th>
	 * 			<th>CSS properties</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>body</code></td>
	 * 			<td>selector</td>
	 * 			<td><code>color:#31353D;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h1</code></td>
	 * 			<td>selector</td>
	 * 			<td><code>font-weight:bold;</code><br>
	 * 				<code>font-color:gray;</code><br>
	 * 				<code>font-size:18;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>#banner</code></td>
	 * 			<td>unique ID</td>
	 * 			<td><code>gradient:true;</code><br>
	 * 				<code>gradient-colors:#666666 #31353D;</code><br>
	 * 				<code>shadow:true;</code><br>
	 * 				<code>padding:10;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>#footer</code></td>
	 * 			<td>unique ID</td>
	 * 			<td><code>gradient:true;</code><br>
	 * 				<code>gradient-colors:#666666 #31353D;</code><br>
	 * 				<code>shadow:true;</code><br>
	 * 				<code>padding:10;</code><br>
	 * 				<code>height:50;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>#background</code></td>
	 * 			<td>unique ID</td>
	 * 			<td><code>color:#EEEEEE;</code><br>
	 * 				<code>shadow:true;</code><br></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>#menu</code></td>
	 * 			<td>unique ID</td>
	 * 			<td><code>color:#EEEEEE;</code><br>
	 * 				<code>padding:10;</code><br></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>#separators</code></td>
	 * 			<td>class</td>
	 * 			<td><code>width:parent;</code><br>
	 * 				<code>margin-top:15;</code><br>
	 * 				<code>margin-bottom:10;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>.menuTitle</code></td>
	 * 			<td>class</td>
	 * 			<td><code>text-transform:uppercase;</code><br>
	 * 				<code>font-weight:bold;</code><br>
	 * 				<code>font-color:darkRed;</code><br>
	 * 				<code>font-size:14;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>.menuText</code></td>
	 * 			<td>class</td>
	 * 			<td><code>width:parent;</code><br>
	 * 				<code>height:auto;</code><br>
	 * 				<code>font-size:11;</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>.entryInfo</code></td>
	 * 			<td>class</td>
	 * 			<td><code>font-color:lightSlateGray;</code><br>
	 * 				<code>font-style:italic;</code><br>
	 * 				<code>font-size:11;</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 *  @includeExample BlogTPLExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BlogTPL extends Application {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BlogTPL</code> application with the
		 * 	specified parameters.
		 * 
		 * 	@param	onLoad	A callback function that is called once the application
		 * 					is fully loaded.
		 * 	@param	pageWidth	The width of the page where entries are displayed, in
		 * 						pixels.
		 * 	@param	menuWidth	The width of the side bar menu, in pixels.
		 * 	@param	hasFooter	Indicates whether the template displays a footer section
		 * 						(<code>true</code>), or not (<code>false</code>).
		 * 	@param	style	A <code>StyleSheet</code> or a url to a valid CSS file used
		 * 					to override the default style for this <code>BlogTPL</code>
		 * 					application.
		 */
		public function BlogTPL(onLoad:Function = null, pageWidth:Number = 500, menuWidth:Number = 200, hasFooter:Boolean = true, style:* = null) {
			super();
			initObj(onLoad, pageWidth, menuWidth, hasFooter, style);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/*
		public static const PAGE:String = "page";
		public static const AUTO:String = "auto";
		*/
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _banner:Box;
		/**
		 * 	A reference to the <code>Box</code> container used as header for this
		 * 	<code>BlogTPL</code> application.
		 * 
		 * 	@see #footer
		 */
		public function get banner():Box {
			return _banner;
		}
		
		private var _footer:Box;
		/**
		 * 	A reference to the <code>Box</code> container used as footer for this
		 * 	<code>BlogTPL</code> application.
		 * 
		 * 	@see #header
		 * 	@see #hasFooter
		 */
		public function get footer():Box {
			return _footer;
		}
		
		private var _hasFooter:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the template has a
		 * 	footer (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get hasFooter():Boolean {
			return _hasFooter;
		}
		public function set hasFooter(value:Boolean):void {
			_hasFooter = value;
			displayFooter();
		}
		
		/*
		private var _heightConstraint:String = AUTO;
		//private var _heightConstraint:String = PAGE;
		public function get heightConstraint():String {
			return _heightConstraint;
		}
		public function set heightConstraint(value:String):void {
			_heightConstraint = value;
			setPositions();
		}*/
		
		private var _menu:Box;
		/**
		 * 	A reference to the <code>Box</code> container used as menu for this
		 * 	<code>BlogTPL</code> application.
		 */
		public function get menu():Box {
			return _menu;
		}
		
		private var _menuPosition:String;
		/**
		 * 	Pets or gets the position of the side-bar menu for this <code>BlogTPL</code>
		 * 	application. Possible values are <code>BlogMenuPosition.RIGHT</code> or
		 * 	<code>BlogMenuPosition.LEFT</code>.
		 * 
		 * 	@default BlogMenuPosition.RIGHT
		 * 
		 * 	@see #menu
		 */
		public function get menuPosition():String {
			return _menuPosition;
		}
		public function set menuPosition(value:String):void {
			_menuPosition = value;
			setPositions();
		}
		
		/**
		 * 	Returns the current position of the left-hand bound for this <code>BlogTPL</code>
		 * 	application, in pixels, relative to the main SWF file.
		 * 
		 * 	@see #right
		 */
		public function get left():Number {
			return _bgPosition.x;
		}
		
		/**
		 * 	Returns the current position of the right-hand bound for this <code>BlogTPL</code>
		 * 	application, in pixels, relative to the main SWF file.
		 * 
		 * 	@see #left
		 */
		public function get right():Number {
			return _bgPosition.x + _pageWidth;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var __padL:Number = 10;
		/**
		 * 	@private
		 */
		override public function get paddingLeft():Number {
			return __padL;
		}
		override public function set paddingLeft(value:Number):void {
			__padL = value;
		}
		
		private var __padR:Number = 10;
		/**
		 * 	@private
		 */
		override public function get paddingRight():Number {
			return __padR;
		}
		override public function set paddingRight(value:Number):void {
			__padR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Creates and returns a new <code>HorizontalSeparator</code> instance
		 * 	in order to horizontally separate objects displayed within the side-bar
		 * 	menu.
		 * 
		 * 	@return	A new <code>HorizontalSeparator</code> instance to separate objects
		 * 			within the side-bar menu.
		 */
		public function getSeparator():HorizontalSeparator { 
			var sep:HorizontalSeparator = new HorizontalSeparator();
			sep.className = "separators";
			return sep;
		}
		
		/**
		 * 	Creates and returns a new <code>Label</code> instance in order to display
		 * 	section titles within the side-bar menu.
		 * 
		 * 	@return	A new <code>Label</code> instance to create a section title within
		 * 			the side-bar menu.
		 */
		public function getMenuTitle(label:String):Label { 
			var lab:Label = new Label(label);
			lab.className = "menuTitle";
			return lab;
		}
		
		/**
		 * 	Creates and returns a new <code>Text</code> instance in order to display
		 * 	section information within the side-bar menu.
		 * 
		 * 	@return	A new <code>Label</code> instance to create a section information 
		 * 			within the side-bar menu.
		 */
		public function getMenuText(label:String):Text { 
			var txt:Text = new Text();
			txt.appendText(label);
			txt.className = "menuText";
			return txt;
		}
		
		/**
		 * 	Creates and returns a new <code>Label</code> instance in order to display
		 * 	information about entries within the main page.
		 * 
		 * 	@return	A new <code>Label</code> instance to create an entry information 
		 * 			within the main page.
		 */
		public function getEntryInfo(label:String):Label { 
			var lab:Label = new Label(label);
			lab.className = "entryInfo";
			return lab;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _backgroundDr:Drawing;
		private var _appWidth:Number;
		private var _menuSeparator:Separator;
		private var _mask:Shape;
		private var _bgPosition:Point;
		private var _style:*;
		private var _onLoad:Function;
		private var _menuWidth:Number;
		private var _pageWidth:Number;
		private var _stage:Stage;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(onLoad:Function, pageWidth:Number, menuWidth:Number, hasFooter:Boolean, style:*):void {
			_stage = UIDescriptor.getUIManager().stage;
			_pageWidth = pageWidth;
			_menuWidth = menuWidth;
			_hasFooter = hasFooter;
			_style = style;
			_onLoad = onLoad;
			_bgPosition = new Point();
			if (onLoad != null) this.entryPoint = initTemplate;
			else initTemplate();
		}
		
		private function initTemplate():void {
			(_style == null) ? createDefaultStyle() : this.styleSheet = _style;
			_menuPosition = BlogMenuPosition.RIGHT;
			createTemplate();
			drawBackground();
			setPositions();
			if(_onLoad!=null)_onLoad();
		}
		
		private function createTemplate():void {
			setWidth();
			var mc:MainContainer = spas_internal::appContainer;
			mc.fixToParentHeight = mc.fixToParentWidth = false;
			this.width = _appWidth;
			this.background.layout = new AbsoluteLayout();
			this.layout.orientation = LayoutOrientation.VERTICAL;
			this.horizontalAlignment = LayoutHorizontalAlignment.LEFT;
			this.verticalAlignment = LayoutVerticalAlignment.TOP;
			this.paddingBottom = this.paddingTop = 10;
			_banner = new Box(_appWidth);
			_banner.id = "banner";
			_footer = new Box(_appWidth);
			_footer.id = "footer";
			_backgroundDr = new Drawing(_appWidth, _stage.stageHeight);
			_backgroundDr.id = "background";
			_menu = new Box(_menuWidth);
			_menu.layout.orientation = LayoutOrientation.VERTICAL;
			_menu.autoHeight = true;
			_menu.id = "menu";
			_menuSeparator = new Separator();
			$evtColl.addEvent(this, ApplicationEvent.RESIZED, fixPositions);
			$evtColl.addEvent(mc.scrollableArea.spas_internal::VScrollBar, ScrollEvent.SCROLL, fixVPositions);
			$evtColl.addEvent(mc.scrollableArea.spas_internal::HScrollBar, ScrollEvent.SCROLL, fixHPositions);
			$evtColl.addEventCollection([this.layout, _menu.layout], LayoutEvent.LAYOUT_FINISHED, containerEventHandler);
			this.background.addGraphicElements(_backgroundDr, _menu, _banner, _menuSeparator);
			displayFooter();
			_mask = new Shape;
			mc.container.addChild(_mask);
			mc.content.mask = _mask;
		}
		
		private function drawBackground():void {
			var h:Number = _banner.height;
			_backgroundDr.clear();
			_backgroundDr.beginFill(0xEEEEEE);
			_backgroundDr.drawRoundedBox(0, 0, _appWidth, _stage.stageHeight - h, 0, 0, 0, 0);
			_backgroundDr.endFill();
		}
		
		private function drawMask(w:Number, h:Number):void {
			with(_mask.graphics) {
				clear();
				beginFill(0xFF0000);
				drawRect(0, 0, w, h);
				endFill();
			}
		}
		
		private function setPositions():void {
			var h:Number = _banner.height;
			var w:Number = (_stage.stageWidth - _appWidth) / 2;
			var stgH:Number = _stage.stageHeight;
			_bgPosition.x = w > 0 ? w :0;
			this.marginLeft = _mask.x = _bgPosition.x;
			_backgroundDr.y = _mask.y = this.marginTop = h;
			var padT:Number = this.paddingTop;
			backgroundPosition = _bgPosition;
			if (_menuPosition == BlogMenuPosition.LEFT) {
				super.paddingRight = __padR;
				super.paddingLeft = _menuWidth + __padL;
				_menu.move(0, h);
				_menuSeparator.move(0, h + padT);
			} else {
				super.paddingRight = _menuWidth + __padR;
				super.paddingLeft = __padL;
				_menu.move(_pageWidth, h);
				_menuSeparator.move(_pageWidth, h + padT);
			}
			var fDelay:Number = 0;
			if (_footer.displayed) {
				fDelay = _footer.height;
				_footer.y = stgH - fDelay;
				
			}
			this.marginBottom = fDelay;
			_menuSeparator.height = stgH - h - padT - this.paddingBottom - fDelay;
			fixHeight();
			drawMask(_appWidth, stgH - h - fDelay);
		}
		
		private function createDefaultStyle():void {
			var css:CssString = new CssString();
			css.appendStyle(" body { color:#31353D; } ");
			css.appendStyle(" h1 { font-weight:bold; font-color:gray; font-size:18; } ");
			css.appendStyle(" #banner { gradient-background:true; gradient-background-colors:#666666 #31353D; shadow:true; padding:10; } ");
			css.appendStyle(" #footer { gradient-background:true; gradient-background-colors:#666666 #31353D; shadow:true; padding:10; height:50; } ");
			css.appendStyle(" #background { color:#EEEEEE; shadow:true; } ");
			css.appendStyle(" #menu { padding:10; background-color:#EEEEEE; } ");
			css.appendStyle(" .separators { width:parent; margin-top:15; margin-bottom:10; } ");
			css.appendStyle(" .menuTitle { text-transform:uppercase; font-weight:bold; font-color:darkRed; font-size:14; } ");
			css.appendStyle(" .menuText { width:parent; height:auto; font-size:11; } ");
			css.appendStyle(" .entryInfo { font-color:lightslategray; font-size:11; font-style:italic; } ");
			this.styleSheet = css;
		}
		
		private function fixPositions(e:ApplicationEvent):void {
			setPositions();
			drawBackground();
		}
		
		private function fixVPositions(e:ScrollEvent):void {
			/*switch(_heightConstraint) {
				case PAGE : break;
				case AUTO : break;
			}*/
			_menu.y = content.y; 
		}
		
		private function fixHPositions(e:ScrollEvent):void {
			var cx:Number = this.content.x;
			if (_menuPosition == BlogMenuPosition.LEFT) {
				//
			} else _menu.x = _menuSeparator.x = cx + _pageWidth;
		}
		
		private function displayFooter():void {
			if (_hasFooter) this.background.addElement(_footer);
			else if (!_hasFooter && _footer.displayed) this.background.removeElement(_footer);
		}
		
		private function setWidth():void {
			_appWidth = _pageWidth + _menuWidth;
		}
		
		private function fixHeight():void {
			var mc:MainContainer = spas_internal::appContainer;
			var h:Number = mc.spas_internal::getExplicitSize().height;
			var H:Number = _menu.height;
			mc.height = (H > h ? H : h);
		}
		
		private function containerEventHandler(e:LayoutEvent):void {
			_menu.y = content.y; 
			fixHeight();
		}
	}
}