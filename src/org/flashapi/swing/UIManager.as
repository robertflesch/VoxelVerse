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
	// UIManager.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 27/01/2010 13:43
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.Quality;
	import org.flashapi.swing.containers.IMainContainer;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LAFValidator;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.cursor.Cursor;
	import org.flashapi.swing.framework.Debugger;
	import org.flashapi.swing.framework.DebugObject;
	import org.flashapi.swing.managers.CSSManager;
	import org.flashapi.swing.managers.DepthManager;
	import org.flashapi.swing.managers.DnDManager;
	import org.flashapi.swing.managers.FocusManager;
	import org.flashapi.swing.managers.KeyboardManager;
	import org.flashapi.swing.managers.LayoutManager;
	import org.flashapi.swing.managers.LibraryManager;
	import org.flashapi.swing.managers.TopLevelManager;
	import org.flashapi.swing.plaf.libs.BoxHelpUIRef;
	import org.flashapi.swing.util.Observable;
	import org.flashapi.swing.util.UIManagerUtil;
	
	use namespace spas_internal;
	
	[IconFile("UIManager.png")]
	
	/**
	 * 	<img src="UIManager.png" alt="UIManager" width="18" height="18"/>
	 * 
	 *  The <code>UIManager</code> class is the base class used by the SPAS 3.0 to
	 * 	manage all processes of an application. It creates for you a collection of
	 * 	singleton object references, such as <code>Application</code>, <code>Cursor</code>,
	 * 	<code>CSSManager</code>, <code>layoutManager</code>... These objects allow
	 * 	you to control all internal processes of a SPAS 3.0 application.
	 * 
	 * 	<p>As the SPAS 3.0 API is <em>freely</em> inspired of the Document Object
	 * 	Model (DOM), the <code>UIManager</code> class provides a acces to the
	 * 	<code>document</code> property. The <code>document</code> property allows access
	 * 	to the main <code>Application</code> instance. Through the <code>document</code>
	 * 	property SPAS 3.0 defines a set of methods to access and manipulate each
	 * 	<code>Element</code> of your application - exactly as the DOM <code>document</code>
	 * 	property do.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UIManager {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A <code>DeniedConstructorAccessException</code> if you try to 
		 * 				create a new <code>UIManager</code> instance.
		 */
		public function UIManager() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The value of the plain color usually used to render working spaces within
		 * 	an application
		 * 
		 * 	@default Color.WINDOWS_WORKSPACE_COLOR
		 */
		public static var windowsWorkspaceColor:uint = Color.WINDOWS_WORKSPACE_COLOR;
		
		//--------------------------------------------------------------------------
		//
		//  Debbuger object
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines the <code>Debugger</code> object used to output information from
		 * 	the current project. The default <code>Debugger</code> instance allows
		 * 	to output information in the output panel of the Flash IDE. To output
		 * 	information into the result panel of the FlashDevelop IDE, use the
		 * 	<code>FDTrace</code> debugger instead.
		 * 
		 * 	@see #print()
		 * 	@see org.flashapi.swing.framework.FDTrace
		 */
		public static var debugger:Debugger = new DebugObject();
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private static var _clipboard:String = "";
		/**
		 * 	[Deprecated, will be replaced by the <code>ClipboardManager</code> class.]
		 */
		public static function get clipboard():String {
			return _clipboard;
		}
		public static function set clipboard(value:String):void {
			_clipboard = value;
		}
		
		private static var _cssManager:CSSManager;
		/**
		 *  Returns a reference to the <code>CSSManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.CSSManager
		 */
		public static function get cssManager():CSSManager {
			return _cssManager;
		}
		
		private static var _cursor:Cursor = null;
		/**
		 *  Returns a reference to the <code>Cursor</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@default null
		 * 
		 * 	@see #addCursor()
		 * 	@see #removeCursor()
		 * 	@see org.flashapi.swing.cursor.Cursor
		 */
		public static function get cursor():Cursor {
			return _cursor;
		}
		
		private static var _document:Application;
		/**
		 *  Returns a reference to the <code>Application</code> instance,
		 * 	which represents the SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.Application
		 */
		public static function get document():Application {
			return _document;
		}
		
		private static var _dragManager:DnDManager;
		/**
		 *  Returns a reference to the <code>DnDManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.DnDManager
		 */
		public static function get dragManager():DnDManager {
			return _dragManager;
		}
		
		private static var _focusManager:FocusManager;
		/**
		 *  Returns a reference to the <code>FocusManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.FocusManager
		 */
		public static function get focusManager():FocusManager {
			return _focusManager;
		}
		
		private static var _initialWidth:Number;
		/**
		 *  Returns the initial width of the <code>Stage</code> object. The
		 * 	<code>initialWidth</code> represents the width of the <code>Stage</code>
		 * 	object when the SPAS 3.0 main application is initialized.
		 * 
		 * 	@see #initialHeight
		 */
		public static function get initialWidth():Number {
			return _initialWidth;
		}
		
		private static var _initialHeight:Number;
		/**
		 *  Returns the initial height of the <code>Stage</code> object. The
		 * 	<code>initialHeight</code> represents the height of the <code>Stage</code>
		 * 	object when the SPAS 3.0 main application is initialized.
		 * 
		 * 	@see #initialWidth
		 */
		public static function get initialHeight():Number {
			return _initialHeight;
		}
		
		private static var _layoutManager:LayoutManager;
		/**
		 *  Returns a reference to the <code>LayoutManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.LayoutManager
		 */
		public static function get layoutManager():LayoutManager {
			return _layoutManager;
		}
		
		/**
		 *  Returns a reference to the <code>MainContainer</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.containers.IMainContainer
		 * 	@see org.flashapi.swing.Application
		 */
		public static function get mainContainer():IMainContainer {
			return _document.spas_internal::appContainer;
		}
		
		private static var _pageSize:Rectangle;
		/**
		 * 	Returns a <code>Rectangle</code> that represents the current size of the page;
		 * 	this rectangle delimits visible bounds of the main application.
		 */
		public static function get pageSize():Rectangle {
			return _pageSize;
		}
		
		private static var _quality:String;
		/**
		 * 	A value from the <code>Quality</code> class that specifies which rendering
		 * 	quality the application uses. Valid values are:
		 * 	<ul>
		 * 		<li><code>Quality.LOW</code> — Low rendering quality. Graphics are not
		 * 		anti-aliased, and bitmaps are not smoothed.</li>
		 * 		<li><code>Quality.MEDIUM</code> — Medium rendering quality. Graphics
		 * 		are anti-aliased using a 2 x 2 pixel grid, but bitmaps are not smoothed.
		 * 		This setting is suitable for movies that do not contain text.</li>
		 * 		<li><code>Quality.HIGH</code> — High rendering quality. Graphics are
		 * 		anti-aliased using a 4 x 4 pixel grid, and bitmaps are smoothed if
		 * 		the movie is static.</li>
		 * 		<li><code>Quality.BEST</code> — Very high rendering quality. Graphics
		 * 		are anti-aliased using a 4 x 4 pixel grid and bitmaps are always
		 * 		smoothed.</li>
		 * 	</ul>
		 * 
		 * 	@default Quality.HIGH
		 */
		public static function get quality():String {
			return _quality;
		}
		public static function set quality(value:String):void { 
			_stage.quality = _quality = value;
		}
		
		private static var _root:DisplayObject;
		/**
		 * 	The <code>root</code> property is the top-most display object in the
		 * 	portion of the display list's tree structure represented by the
		 * 	<code>document</code> application.
		 * 
		 * 	@see #stage
		 */
		public static function get root():DisplayObject {
			return _root;
		}
		
		private static  var _stage:Stage;
		/**
		 * 	Provides a global access point for the global <code>Stage</code> object.
		 * 
		 * 	@see #root
		 */
		public static function get stage():Stage {
			return _stage;
		}
		
		private static var _topLevelManager:TopLevelManager;
		/**
		 *  Returns a reference to the <code>TopLevelManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.TopLevelManager
		 */
		public static function get topLevelManager():TopLevelManager {
			return _topLevelManager;
		}
		
		private static var _libManager:LibraryManager;
		/**
		 *  Returns a reference to the <code>LibraryManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.LibraryManager
		 */
		public static function get libManager():LibraryManager {
			return _libManager;
		}
		
		private static var _keyboardManager:KeyboardManager;
		/**
		 * 
		 *  Returns a reference to the <code>KeyboardManager</code> instance used by the
		 * 	SPAS 3.0 main application.
		 * 
		 * 	@see org.flashapi.swing.managers.KeyboardManager
		 */
		public static function get keyboardManager():KeyboardManager {
			return _keyboardManager;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Displays the cursor rendered by the SPAS 3.0 framework, whith the specified
		 * 	<code>type</code> of cursor.
		 * 
		 * 	@param	value	A <code>CursorType</code> class constant that indicates 
		 * 					the type of cursor to use to render the <code>Cursor</code>
		 * 					instance.
		 * 					Default value is <code>CursorType.DEFAULT_CURSOR</code>.
		 * 
		 * 	@see #removeCursor()
		 * 	@see org.flashapi.swing.cursor.Cursor
		 */
		public static function addCursor(value:String = "default"):void {
			_cursor.type = value;
			_cursor.display();
		}
		
		/**
		 *  Returns a <code>Boolean</code> value that indicates whether the <code>Application</code>
		 * 	is displayed using full screen mode (<code>true</code>), or not (<code>false</code>).
		 * 	
		 * 	@return <code>true</code> if the <code>Application</code> is full screen;
		 * 			<code>false</code> otherwise.
		 * 
		 * 	@default false
		 * 
		 * 	@see #setFullScreen()
		 */
		public static function getFullScreen():Boolean {
			return _fullScreenMode;
		}
		
		/**
		 * 	Returns the current height of the <code>Stage</code> object, in pixels.
		 * 
		 * 	@return	The current height of the <code>Stage</code> object.
		 * 
		 * 	@see #getWidth()
		 */
		public static function getHeight():Number {
			return stage.stageHeight;
		}
		
		/**
		 * 	Returns the current width of the <code>Stage</code> object, in pixels.
		 * 
		 * 	@return	The current width of the <code>Stage</code> object.
		 * 
		 * 	@see #getHeight()
		 */
		public static function getWidth():Number {
			return stage.stageWidth;
		}
		
		/**
		 *  Returns a <code>Boolean</code> value that indicates whether the
		 * 	SPAS 3.0 Framework has a main container, defined within the <code>Application</code>
		 * 	instance, (<code>true</code>), or not (<code>false</code>).
		 * 	<code>true</code> means that the SPAS 3.0 application is created from an 
		 * 	external class which is a subclass of the <code>Application</code> class.
		 * 	Otherwise, the SPAS 3.0 application is created from the Flash IDE main timeline
		 * 	and has been initialized through the <code>UIManager.initialize()</code> method.
		 * 
		 * 	@return		<code>true</code> if the  SPAS 3.0 application is an
		 * 				<code>Application</code> sub-class; false otherwise.
		 * 
		 * 	@see #initialize()
		 * 	@see org.flashapi.swing.Application
		 * 	@see org.flashapi.swing.containers.MainContainer
		 */
		public static function hasMainContainer():Boolean {
			return _hasMainContainer;
		} 
		
		/**
		 * 	Initializes the SPAS 3.0 application if it used from the main timeline
		 * 	of the Flash IDE. You must use the <code>UIManager.initialize()</code> method
		 * 	before using any <code>UIObject</code> directly from the Flash IDE.
		 * 
		 * 	<p>As the SPAS 3.0 uses the <code>target</code> parameter to initialize
		 * 	the global access to the <code>Stage</code> object, you should use the
		 * 	<code>this</code> keyword as a reference of the main timeline to define
		 * 	the <code>target</code> parameter. The following sample illustrates the best
		 * 	practice for initializing a SPAS 3.0 application from the Flash IDE:</p>
		 * 	<pre>// Place the following lines of code into the first frame of the main timeline:
		 * 	import org.flashapi.swing.*;
		 * 	UIManager.initialize(this);
		 * 	</pre>
		 * 	
		 * 	<p>If you use the <code>Application</code> class to create your application,
		 * 	you do not have to use this method.</p>
		 * 
		 * 	@param	target 	A <code>DisplayObject</code> reference used to initialeze
		 * 					the SPAS 3.0 application.
		 * 
		 * 	@see #hasMainContainer()
		 */
		public static function initialize(target:DisplayObject):void {
			spas_internal::init(target);
		}
		
		/**
		 * 	Opens or replaces a window in the current application that contains the
		 * 	Flash Player container. For more details, see the
		 * 	<a href="http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/package.html#navigateToURL()"
		 * 	alt="navigateToURL" title="navigateToURL">navigateToURL</a> method.
		 * 
		 * 	@param	request	A <code>URLRequest</code> or a <code>String</code> object
		 * 					that specifies the URI to navigate to. 
		 * 	@param	window	The browser window or HTML frame in which to display
		 * 					the document specified by the <code>request</code> parameter.
		 * 					Possible values are the <code>WindowFrame</code> class
		 * 					constants. If you do not specify a value for this parameter,
		 * 					a new empty window is created.
		 */
		public static function navigateToURL(request:*, window:String = null):void {
			var r:URLRequest = (request is URLRequest) ? request : new URLRequest(request);
			flash.net.navigateToURL(r, window);
		}
		
		/**
		 * 	Removes the cursor added by the <code>addCursor()</code> method.
		 * 
		 * 	@see #addCursor()
		 */
		public static function removeCursor():void {
			_cursor.remove();
		}
		
		/**
		 * 	Specifies whether the SPAS 3.0 application is displayed in full screen,
		 * 	or not.
		 * 	
		 * 	@param	value	A <code>Boolean</code> value that specifies the whether
		 * 					the <code>Application</code> is displayed in full screen
		 * 					(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@see #getFullScreen()
		 */
		public static function setFullScreen(value:Boolean):void {
			_fullScreenMode = value;
			setFullScreenMode();
		}
		
		/**
		 * 	Returns a <code>String</code> that represents the full URL of a
		 * 	SPAS 3.0 application, when embeded within an HTML file. The
		 * 	returned URL value contains all parameters passed as header variables
		 * 	for this application.
		 * 
		 * 	The <code>getURL()</code> method returns <code>null</code> if the
		 * 	SPAS 3.0 application is not embeded within an HTML file.
		 * 
		 * 	@return	The full URL of the current SPAS 3.0 application.
		 * 
		 * 	@see #getURLVars()
		 */
		public static function getURL():String {
			if (!ExternalInterface.available) return null;
			try {
				var s:String = ExternalInterface.call(_urlFunctionName);
			} catch (error:Error) {
				s = null;
			}
			return s;
		}
		
		/**
		 * 	Returns an <code>Object</code> that contains all header variables passed
		 * 	as parameters to the URL of the current SPAS 3.0 application.
		 * 
		 * 	@return An <code>Object</code> that contains all header variables for
		 * 			this application.
		 * 
		 * 	@see #getURL()
		 */
		public static function getURLVars():Object {
			var obj:Object = {};
			var url:String = UIManager.getURL();
			if (url != null) {
				var index:int = url.indexOf("?");
				if (index == -1) return obj;
				else {
					var tempArr:Array = url.substr(index+1).split("&");
					var splitArr:Array;
					var item:String;
					for each(item in tempArr) {
						splitArr = item.split("=");
						obj[splitArr[0]] = splitArr[1];
					}
				}
			}
			return obj;
		}
		
		/**
		 * 	Displays the object, specified by the <code>obj</code> parameter, over all other
		 * 	objects contained within its parent container.
		 * 
		 * 	@param	obj The object that must be displayed over all other objects.
		 */
		public static function setToTopLevel(obj:*):void {
			if(cursor.displayed) {
				if(!DepthManager.isOverAll(obj) && obj != cursor) {
					if (DepthManager.getDepth(obj) == DepthManager.getParentMaxDepth(obj) - 1)
						return;
					/*	
					 * todo: check if return works.
					 * trace("called");
					*/
					DepthManager.setOverAll(obj);
				}
				DepthManager.setOverAll(cursor);
			} else if (!DepthManager.isOverAll(obj) && obj != cursor) {
				DepthManager.setOverAll(obj);
			}
			if (obj is IUIObject) _focusManager.spas_internal::setFocus(obj);
		}
		
		/**
		 * 	Sets a common Look and Feel for all <code>BoxHelp</code> instances.
		 * 
		 * 	@param	value	The Look and Feel class reference to be shared by
		 * 					all <code>BoxHelp</code> instances.
		 * 
		 *  @throws org.flashapi.swing.exceptions.NullPointerException A
		 * 			<code>NullPointerException</code> if the <code>value</code>
		 * 			parameter does not implements the <code>LookAndFeel</code>
		 * 	interface.
		 */
		public static function setBoxHelpLaf(value:Object):void {
			LAFValidator.validate(value);
			BoxHelpUIRef.laf = value;
			var obs:Observable = BoxHelpUIRef.lafList;
			if (obs == null) return;
			if (obs.countObservers() > 0) { 
				obs.setChanged();
				obs.notifyObservers();
			}
		}
		
		/**
		 * 	Displays expressions, or writes to log files, while debugging. A single
		 * 	print statement can support multiple arguments. If any argument in a print
		 * 	statement includes a data type other than a <code>String</code>, the print
		 * 	function invokes the associated <code>toString()</code> method for that
		 * 	data type.
		 * 
		 * 	@param	...arguments One or more (comma separated) expressions to evaluate.
		 * 	For multiple expressions, a space is inserted between each expression in
		 * 	the output.
		 * 
		 * 	@see #debugger
		 */
		public static function print(...arguments):void {
			UIManager.debugger.print(arguments);
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		public static function setLocalization(value:String = "default"):void {	}
		
		/*public static function loadPolicyFile(url:String):void {
			Security.loadPolicyFile(url);
		}
		
		public static function showRedrawRegions(on:Boolean, color:uint = 0xFF0000):void {
			flash.profiler.showRedrawRegions(on, color);
		}*/
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal static var mainMenu:ContextMenu = new ContextMenu();
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal static function init(target:DisplayObject, newDocument:Boolean = true):Boolean {
			if(_initialized) return false;
			else {
				UIDescriptor.spas_internal::initDescriptor("SPAS 3.0", UIManager);
				_initialized = true;
				_stage = target.stage;
				_layoutManager = LayoutManager.spas_internal::getInstance();
				_initialWidth = _stage.stageWidth;
				_initialHeight = _stage.stageHeight;
				_root = target.root;
				_topLevelManager = TopLevelManager.spas_internal::getInstance();
				_libManager = LibraryManager.spas_internal::getInstance();
				_cssManager = CSSManager.spas_internal::getInstance();
				_focusManager = FocusManager.spas_internal::getInstance();
				if (newDocument) _document =  new Application();
				else {
					_document = target as Application;
					_hasMainContainer = true;
				}
				if (!UIManagerUtil.spas_internal::hasUIManagerDocument())
					UIManagerUtil.spas_internal::setUIManagerDocument(_document);
				_cursor = Cursor.spas_internal::getInstance();
				_dragManager = DnDManager.spas_internal::getInstance();
				_keyboardManager = KeyboardManager.spas_internal::getInstance();
				_loader = target.root.loaderInfo;
				UIManager.quality = Quality.HIGH;
				initStage();
				initMainMenu();
				initJavaScript();
			}
			return true;
		}
		
		/**
		 * @private
		 */
		spas_internal static function isInitialized():Boolean {
			return _initialized;
		}
		
		/*
		 * @private
		 */
		/*spas_internal static function refreshDocumentPage(uio:UIObject):void {
			if (uio.target == _document.spas_internal::appContainer
				&& _document.spas_internal::isDrawable) {
				_document.spas_internal::appContainer.spas_internal::drawScrollBounds();
			}
		}*/
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static var _loader:LoaderInfo;
		//private static var _target:DisplayObject;
		private static var _initialized:Boolean = false;
		private static var _hasMainContainer:Boolean = false;
		private static var _fullScreenMode:Boolean = false;
		private static var _stageEvtColl:EventCollector;
		private static var _urlFunctionName:String = "getURL";
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private static function initMainMenu():void {
			spas_internal::mainMenu.hideBuiltInItems();
			var spasItem:ContextMenuItem = new ContextMenuItem("SPAS 3.0");
			_stageEvtColl.addEvent(spasItem, ContextMenuEvent.MENU_ITEM_SELECT, spasItemSelect);
			spas_internal::mainMenu.customItems.push(spasItem);
		}
		
		private static function spasItemSelect(e:ContextMenuEvent):void {
			flash.net.navigateToURL(new URLRequest(UIDescriptor.spas_internal:: SPAS_URL));
		}
		
		private static function setFullScreenMode():void {
			stage.displayState = _fullScreenMode ?
				StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
		}
		
		private static function initStage():void {
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align = StageAlign.TOP_LEFT;
			_stageEvtColl = new EventCollector();
			_stageEvtColl.addEvent(_stage, MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
			_stageEvtColl.addEvent(_stage, Event.MOUSE_LEAVE, stageMouseLeaveHandler);
			_stageEvtColl.addEvent(_stage, Event.RESIZE, stageResizeEventHandler);
			_stageEvtColl.addEvent(_stage, FullScreenEvent.FULL_SCREEN, stageFSEventHandler);
			_pageSize = new Rectangle();
			//flash.profiler.showRedrawRegions(false);
		}
		
		private static function stageMouseEnterHandler(e:MouseEvent):void {
			_stageEvtColl.removeEvent(_stage, MouseEvent.MOUSE_MOVE, stageMouseEnterHandler);
			if (_cursor != null) _cursor.spas_internal::mouseEnterHandler();
			_stageEvtColl.addEvent(_stage, MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
		}
		
		private static function stageMouseMoveHandler(e:MouseEvent):void {
			if(_cursor != null) _cursor.spas_internal::mouseMoveHandler();
			//e.updateAfterEvent();
		}
		
		private static function stageMouseLeaveHandler(e:Event):void {
			if (_cursor != null) _cursor.spas_internal::mouseLeaveHandler();
			_stageEvtColl.removeEvent(_stage, MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
			_stageEvtColl.addEvent(_stage, MouseEvent.MOUSE_MOVE, stageMouseEnterHandler);
		}
		
		private static function stageFSEventHandler(e:FullScreenEvent):void {
			if (_hasMainContainer) _document.spas_internal::resizeEventHandler();
		}
		
		private static function stageResizeEventHandler(e:Event):void {
			//_topLevelManager.spas_internal::setNewPosition();
			if (_hasMainContainer) _document.spas_internal::resizeEventHandler();
		}
		
		private static function initJavaScript():void {
			//http://www.kirupa.com/forum/showthread.php?t=238858
			if (!ExternalInterface.available) return;
			var initGetURL:String = 
			"document.insertScript = function (){ function getURL(){ return document.URL; } }";
			ExternalInterface.call(initGetURL);
		}
	}
}