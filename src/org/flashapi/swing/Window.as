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
	// Window.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.3.0, 31/03/2011 15:32
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.CursorType;
	import org.flashapi.swing.constants.MinimizableProperties;
	import org.flashapi.swing.constants.WindowState;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.LayoutEvent;
	import org.flashapi.swing.event.ResizerEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.event.WindowEvent;
	import org.flashapi.swing.ui.Resizer;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.wtk.AWM;
	import org.flashapi.swing.wtk.UIWindow;
	import org.flashapi.swing.wtk.WindowButton;
	
	use namespace spas_internal;
	
	[IconFile("Window.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Event
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>Windows</code> is restored to its initial state.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.RESTORE
	 */
	[Event(name = "restore", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the <code>Windows</code> is displayed in its minimal size.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.MINIMIZE
	 */
	[Event(name = "minimize", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the <code>Windows</code> is displayed in its maximal size.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.MAXIMIZE
	 */
	[Event(name = "maximize", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the <code>Windows</code> is displayed in fullscreen mode.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.FULLSCREEN
	 */
	[Event(name = "fullscreen", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the user starts to resize the <code>Windows</code>.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.RESIZE_STARTED
	 */
	[Event(name = "resizeStarted", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the <code>Windows</code> resizing, due to user action,
	 * 	is finished.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.RESIZE_FINISHED
	 */
	[Event(name = "resizeFinished", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the retoring button of the <code>Windows</code> is clicked.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.RESTORE_BUTTON_CLICKED
	 */
	[Event(name = "restoreButtonClicked", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the minimizing button of the <code>Windows</code> is clicked.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.MINIMIZE_BUTTON_CLICKED
	 */
	[Event(name = "minimizeButtonClicked", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 *  Dispatched when the maximizing button of the <code>Windows</code> is clicked.
	 *
	 *  @eventType org.flashapi.swing.event.WindowEvent.MAXIMIZE_BUTTON_CLICKED
	 */
	[Event(name = "maximizeButtonClicked", type = "org.flashapi.swing.event.WindowEvent")]
	
	/**
	 * 	<img src="Window.png" alt="Window" width="18" height="18"/>
	 * 
	 *  A <code>Window</code> object is an area of the screen set aside for a
	 * 	special purpose. The user can control the size, shape, and positioning
	 * 	of windows. The active window is the one in which you are currently
	 * 	typing.
	 * 	
	 * 	<p><code>Window</code> objects are composed of several elements; some are listed below:
	 * 		<ul>
	 * 			<li><bold>Title Bar:</bold><br />
	 * 				The horizontal bar at the top of a window that contains the
	 * 				icon and name at the left, the specified title text,
	 * 				and to the right, the trio of window control buttons
	 * 				(minimizing, restoring [or maximizing], and closing). 
	 * 				Clicking on the icon will pop up a menu to control the window.
	 * 			</li>
	 * 			<li><bold>Icon:</bold><br />
	 * 				An <code>Icon</code> instance placed on the top left-hand corner of
	 * 				the window (optional). When it is displayed, the icon is used as a
	 * 				button to control the menu of the window.
	 * 			</li>
	 * 			<li><bold>Pull-down Control Menu:</bold><br />
	 * 				A <code>Menu</code> instance that appears when the icon is selected.
	 * 				(Only if an icon is displayed.)
	 * 			</li>
	 * 			<li><bold>Header control:</bold><br />
	 * 				A special container used to display task bars under the window title bar.
	 * 			</li>
	 * 			<li><bold>Footer control:</bold><br />
	 * 				A special container used to display informations below the content panel.
	 * 			</li>
	 * 			<li><bold>Scrollbars:</bold><br />
	 * 				Scrollbars are displayed at the right-hand side and/or bottom of a window
	 * 				and enables to scroll the content of the window.
	 * 			</li>
	 * 			<li><bold>Minimizing Button:</bold><br />
	 * 				Button used to minimize a window. Some <code>Window</code> properties
	 * 				allow to manage the minimized state of a window.
	 * 			</li>
	 * 			<li><bold>Maximizing Button:</bold><br />
	 * 				Button used to make a window take over the whole screen and become as
	 * 				large as possible.
	 * 			</li>
	 * 			<li><bold>Closing Button:</bold><br />
	 * 				Button generally used to remove the window from the application.
	 * 				As the <code>Window</code> class implement the <code>ClosableObject</code>
	 * 				interface, when users click on the closing button, the resulting action
	 * 				will depend on the <code>defaultCloseOperation</code> property settings.
	 * 			</li>
	 * 		</ul>
	 * 	</p>
	 * 
	 * 	<p>
	 * 		The following figure shows the main parts of a <code>Window</code> instance for
	 * 		the SPAS 3.0 WTK:
	 *	</p>
	 * 	<p><img src = "../../../doc-images/window_parts.jpg" alt="SPAS 3.0 window parts." /></p>
	 * 
	 * 	<p>To get more details about SPAS 3.0 <code>>WTK</code> metrics, see the
	 * 	<a href="wtk/AWM.html" title="AWM metrics figure">AWM metrics figure</a>.</p>
	 * 
	 * 	<p>The following list indicates possible interactions with a <code>Window</code>
	 * 	instance:
	 * 		<ul>
	 * 			<li>To move the window, place the mouse pointer on the title bar,
	 * 				hold down the left button, and move the mouse.</li>
	 * 			<li>To change the size of the window, do the same thing but with
	 * 				the pointer on the left, top, right, or bottom border of the
	 * 				window.</li>
	 * 			<li>To close the window, click once on the close button (the button
	 * 				with the X(cross) symbol) or double-click on the control menu
	 * 				button.</li>
	 * 		</ul>
	 * 	</p>
	 * 
	 *  @includeExample WindowExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Window extends AWM implements UIWindow, Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Window</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	label	Text to appear on the title bar of the <code>Window</code>
		 * 					instance. 
		 * 	@param	width	The width of the <code>Window</code> instance, in pixels. 
		 * 	@param	height	The height of the <code>Window</code> instance, in pixels.
		 */
		public function Window(label:String = "", width:Number = 150, height:Number = 80) {
			super();
			initObj(label, width, height);
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
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The alternate text to be displayed by the minimizing button of this
		 * 	<code>Window</code> instance.
		 * 
		 * 	@default WTKLocaleUs.MINIMIZE
		 */
		public var minimizeAlt:String = $btnLocalization.MINIMIZE;
		
		/**
		 * 	The alternate text to be displayed by the maximizing button of this
		 * 	<code>Window</code> instance.
		 * 
		 * 	@default WTKLocaleUs.MAXIMIZE
		 */
		public var maximizeAlt:String = $btnLocalization.MAXIMIZE;
		
		/**
		 * 	The alternate text to be displayed by the restoring button of this
		 * 	<code>Window</code> instance.
		 * 
		 * 	@default WTKLocaleUs.RESTORE
		 */
		public var retoreAlt:String = $btnLocalization.RESTORE;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set buttonsClassName(value:String):void {
			$closeButton.className = _minimizeButton.className =
			_maximizeButton.className = $buttonsClassName = value;
		}
		
		private var _chromelessMode:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get chromelessMode():Boolean {
			return _chromelessMode;
		}
		public function set chromelessMode(value:Boolean):void {
			_chromelessMode = value;
		}
		
		private var _defaultMinimizeOperation:String = MinimizableProperties.MINIMIZE_ON_CALL;
		/**
		 * 	@inheritDoc
		 */
		public function get defaultMinimizeOperation():String {
			return _defaultMinimizeOperation;
		}
		public function set defaultMinimizeOperation(value:String):void {
			_defaultMinimizeOperation = value;
		}
		
		private var _enabledFullScreen:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get enabledFullScreen():Boolean {
			return _enabledFullScreen;
		}
		public function set enabledFullScreen(value:Boolean):void {
			_enabledFullScreen = value;
		}
		
		/**
		 * @private
		 */
		override public function set glow(value:Boolean):void {
			super.glow = $closeButton.boxhelp.glow =
			_minimizeButton.boxhelp.glow = _maximizeButton.boxhelp.glow = value;
		}
		
		/**
		 * @private
		 */
		override public function set invalidateRefresh(value:Boolean):void {
			$invalidateRefresh = value;
			if (!value && $state == WindowState.MAXIMIZED) displayMaximizedWindow(true);
			else if (!value && $state == WindowState.NORMAL) saveWindowSize();
		}
		
		private var _maximizeButton:WindowButton;
		/**
		 * 	@inheritDoc
		 */
		public function get maximizeButton():WindowButton {
			return _maximizeButton;
		}
		
		private var _minimizeButton:WindowButton;
		/**
		 * 	@inheritDoc
		 */
		public function get minimizeButton():WindowButton {
			return _minimizeButton;
		}
		
		[Inspectable(defaultValue="true", name="shadow")]
		/**
		 * @private
		 */
		override public function set shadow(value:Boolean):void {
			super.shadow = $closeButton.boxhelp.shadow =
			_minimizeButton.boxhelp.shadow = _maximizeButton.boxhelp.shadow = value;
		}
		
		private var _showMaximizeButton:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get showMaximizeButton():Boolean {
			return _showMaximizeButton;
		}
		public function set showMaximizeButton(value:Boolean):void {
			_maximizeButton.visible = _showMaximizeButton = value;
			setRefresh();
		}
		
		private var _showMinimizeButton:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get showMinimizeButton():Boolean {
			return _showMinimizeButton;
		}
		public function set showMinimizeButton(value:Boolean):void {
			_minimizeButton.visible = _showMinimizeButton = value;
			setRefresh();
		}
		
		private var _resizable:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get resizable():Boolean {
			return _resizable;
		}
		public function set resizable(value:Boolean):void {
			_resizable = value;
			setRefresh();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set state(value:String):void {
			switch(value) {
				case WindowState.NORMAL :
					$minimized = $maximized = false;
					break;
				case WindowState.MINIMIZED :
					$minimized = true;
					$maximized = false;
					break;
				case WindowState.MAXIMIZED :
					$maximized = true;
					$minimized = false;
					break;
			}
			spas_internal::lafDTO.state = $state = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set quality(value:String):void {
			$quality = value;
			_isGoodQuality = getQuality() >= 2;
		}
		
		private var _maxViewPort:Rectangle;
		/**
		 * 	
		 */
		public function get maximizedViewPort():Rectangle {
			return _maxViewPort;
		}
		public function set maximizedViewPort(value:Rectangle):void {
			_maxViewPort = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */	
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!$displayed) {
				createUIObject(x, y);
				doStartEffect(setToTopLevel);
			}
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$evtColl.removeEvent(_resizer, ResizerEvent.RESIZE_START, sizeStartHandler);
			$evtColl.removeEvent(_resizer, ResizerEvent.RESIZE_UPDATE, sizeUpdateHandler);
			$evtColl.removeEvent(_resizer, ResizerEvent.RESIZE_FINISH, sizeFinishHandler);
			spas_internal::uioSprite.removeChild(_resizer);
			_resizer.finalize();
			_resizer = null;
			spas_internal::lafDTO.maximizeButton = null;
			spas_internal::lafDTO.minimizeButton = null;
			_maximizeButton.finalize();
			_maximizeButton = null;
			_minimizeButton.finalize();
			_minimizeButton = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function createContainers():void {
			_buttonsContainer = new Sprite();
			$titleBarContainer.addChild(_buttonsContainer);
			_minimizeButton.alt = minimizeAlt;
			_maximizeButton.alt = maximizeAlt;
			fixMinimizeButtonIcon();
			_minimizeButton.target = _maximizeButton.target = _buttonsContainer;
			_minimizeButton.display();
			_maximizeButton.display();
			
			setButtonsBehavior();
			$windowArea = new Sprite();
			spas_internal::lafDTO.windowArea = $windowArea;
			spas_internal::uioSprite.addChild($windowArea);
		}
		
		/**
		 * 	@private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			displayIcon();
			move(x, y);
			$scrollableArea.display();
			refresh();
			initWindowBounds();
			setLAFPositions();
		}
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			fixSize();
			if($maximized && !_chromelessMode && _enabledFullScreen) {
				_chromelessMode ? displayChromelessWindow() : displayMaximizedWindow();
				_resizer.visible = false;
			} else if($minimized) {
				displayMinimizedWindow();
				_resizer.visible = false;
			} else {
				displayWindow();
				_resizer.visible = true;
			}
			$scrollableArea.resize($width, $height);
			fixMaximizeButtonIcon();
			setTitleBarProperties();
			if (_resizable && !$minimized && !$maximized && !_invalidateMetricsChanged) {
				updateResizer();
			}
			setEffects();
			if (_eventToDispatch != null) {
				deactivateRefresh();
				dispatchEvent(_eventToDispatch);
				_eventToDispatch = null;
			}
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			super.setSpecificLafChanges();
			fixButtonsLaf();
			if (displayed && _resizable && !$minimized && !$maximized && !_invalidateMetricsChanged) {
				updateResizer();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _eventToDispatch:WindowEvent = null;
		private var _buttonsContainer:Sprite;
		private var _windowX:Number;
		private var _windowY:Number;
		private var _storedWinWidth:Number;
		private var _storedWinHeight:Number;
		/**
		 * 	@private
		 * 	Prevents stored metrics updates when state is "maximized" and layout
		 * 	metrics are updated due to internal elements display list changes.
		 */
		private var _lockStoredMetrics:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Window resizing management
		//
		//--------------------------------------------------------------------------
		
		private var _resizer:Resizer;
		private var _invalidateMetricsChanged:Boolean;
		private var _hOffset:Number;
		private var _wOffset:Number;
		private var _resizeType:String;
		private var _isGoodQuality:Boolean
		
		private function initResizer():void {
			_invalidateMetricsChanged = false;
			var cont:Sprite = spas_internal::uioSprite;
			_resizer = new Resizer(cont, $width, $height);
			$evtColl.addEvent(_resizer, ResizerEvent.RESIZE_START, sizeStartHandler);
			$evtColl.addEvent(_resizer, ResizerEvent.RESIZE_UPDATE, sizeUpdateHandler);
			$evtColl.addEvent(_resizer, ResizerEvent.RESIZE_FINISH, sizeFinishHandler);
			cont.addChild(_resizer);
		}
		
		private function updateResizer():void {
			_resizer.resize(0, 0, $outerWidth, $outerHeight);
			_resizer.refresh();
		}
		
		private function sizeStartHandler(e:ResizerEvent):void {
			fixTopLevel();
			dispatchWindowEvent(WindowEvent.RESIZE_STARTED);
			_hOffset = $outerHeight - $height;
			_wOffset = $outerWidth - $width;
			_invalidateMetricsChanged = true;
			_resizeType = _resizer.getCursorType();
			if (!_isGoodQuality) {
				spas_internal::deactivateShadow();
				spas_internal::deactivateGlow();
			}
		}
		
		private function sizeUpdateHandler(e:ResizerEvent):void {
			updateSize();
			if (_isGoodQuality) {
				fixSize();
				displayWindow();
				setTitleBarProperties();
				$scrollableArea.resize($width, $height);
				doReflection();
			} else {
				var windowBounds:Rectangle = spas_internal::lafDTO.windowBounds;
				$width += windowBounds.x;
				$height += windowBounds.y;
				fixSize();
				windowBounds.width = $outerWidth;
				windowBounds.height = $outerHeight;
				lookAndFeel.drawWindowArea();
			}
			dispatchUIOEvent(UIOEvent.RESIZED);
			dispatchWindowEvent(WindowEvent.RESIZE);
		}
		
		private function sizeFinishHandler(e:ResizerEvent):void {
			_invalidateMetricsChanged = false;
			updateSize();
			fixSize();
			if (!_isGoodQuality) {
				spas_internal::reactivateShadow();
				spas_internal::reactivateGlow();
				spas_internal::lafDTO.windowArea.graphics.clear();
				
				var windowBounds:Rectangle = spas_internal::lafDTO.windowBounds;
				var cont:Sprite = spas_internal::uioSprite;
				cont.x += windowBounds.x;
				cont.y += windowBounds.y;
				initWindowBounds();
			}
			displayWindow();
			setTitleBarProperties();
			$scrollableArea.resize($width, $height);
			doReflection();
			updateResizer();
			dispatchResizeFinishedEvent();
		}
		
		private function setMinWidth():void {
			spas_internal::lafDTO.width = $width = $minWidth;
		}
		
		private function setMinHeight():void {
			spas_internal::lafDTO.height = $height = $minHeight;
		}
		
		private function updateSize():void {
			var windowBounds:Rectangle = spas_internal::lafDTO.windowBounds;
			var s:Rectangle = _resizer.getSizeRect();
			var resizerValue:Number;
			var altValue:Number;
			var cont:Sprite = spas_internal::uioSprite;
			var contPos:Number;
			switch(_resizeType) {
				case CursorType.N_RESIZE_CURSOR :
					resizerValue = s.top;
					contPos = cont.y;
					altValue = $height - (resizerValue - contPos);
					if (altValue > $minHeight) {
						$height = altValue;
						_isGoodQuality ?
							cont.y = resizerValue : windowBounds.y = resizerValue - contPos;
					} else setMinHeight();
					break;
				case CursorType.NW_RESIZE_CURSOR :
					resizerValue = s.top;
					contPos = cont.y;
					altValue = $height - (resizerValue - contPos);
					if (altValue > $minHeight) {
						$height = altValue;
						_isGoodQuality ?
							cont.y = resizerValue : windowBounds.y = resizerValue - contPos;
					} else setMinHeight();
					resizerValue = s.left;
					contPos = cont.x;
					altValue = $width - (resizerValue - contPos);
					if (altValue > $minWidth) {
						$width = altValue;
						_isGoodQuality ? 
							cont.x = resizerValue : windowBounds.x = resizerValue - contPos;
					} else setMinWidth();
					break;
				case CursorType.NE_RESIZE_CURSOR :
					resizerValue = s.top;
					altValue = $height - (resizerValue - cont.y);
					if (altValue > $minHeight) {
						$height = altValue;
						_isGoodQuality ? 
							cont.y = resizerValue : windowBounds.y = resizerValue - contPos;
					} else setMinHeight();
					resizerValue = s.width;
					altValue = resizerValue - _wOffset - cont.x;
					if (altValue > $minWidth) {
						$width = altValue;
					} else setMinWidth();
					break;
				case CursorType.W_RESIZE_CURSOR :
					resizerValue = s.left;
					contPos = cont.x;
					altValue = $width - (resizerValue - contPos);
					if (altValue > $minWidth) {
						$width = altValue;
						_isGoodQuality ? 
							cont.x = resizerValue : windowBounds.x = resizerValue - contPos;
					} else setMinWidth();
					break;
				case CursorType.SW_RESIZE_CURSOR :
					resizerValue = s.left;
					contPos = cont.x;
					altValue = $width - (resizerValue - contPos);
					if (altValue > $minWidth) {
						$width = altValue;
						_isGoodQuality ? 
							cont.x = resizerValue : windowBounds.x = resizerValue - contPos;
					} else setMinWidth();
					resizerValue = s.height;
					altValue = cont.y;
					if(resizerValue - altValue > _hOffset + $minHeight) {
						$height = resizerValue - _hOffset - altValue;
					} else setMinHeight();
					break;
				case CursorType.S_RESIZE_CURSOR :
					resizerValue = s.height;
					altValue = cont.y;
					if(resizerValue - altValue > _hOffset + $minHeight) {
						$height = resizerValue - _hOffset - altValue;
					} else setMinHeight();
					break;
				case CursorType.SE_RESIZE_CURSOR :
					resizerValue = s.height;
					altValue = cont.y;
					if(resizerValue - altValue > _hOffset + $minHeight) {
						$height = resizerValue - _hOffset - altValue;
					} else setMinHeight();
					resizerValue = s.width;
					altValue = resizerValue - _wOffset - cont.x;
					if (altValue > $minWidth) {
						$width = altValue;
					} else setMinWidth();
					break;
				case CursorType.E_RESIZE_CURSOR :
					resizerValue = s.width;
					altValue = resizerValue - _wOffset - cont.x;
					if (altValue > $minWidth) {
						$width = altValue;
					} else setMinWidth();
					break;
			}
			
		}
		
		private function dispatchResizeFinishedEvent():void {
			deactivateRefresh();
			dispatchWindowEvent(WindowEvent.RESIZE_FINISHED);
		}
		
		//--------------------------------------------------------------------------
		//
		//  WindowButton event management
		//
		//--------------------------------------------------------------------------
		
		private function setButtonsBehavior():void {
			$evtColl.addEvent(_maximizeButton, UIMouseEvent.PRESS, maxDownHandler);
			$evtColl.addEvent(_maximizeButton, UIMouseEvent.RELEASE, maxUpHandler);
			$evtColl.addEvent(_minimizeButton, UIMouseEvent.PRESS, minDownHandler);
			$evtColl.addEvent(_minimizeButton, UIMouseEvent.RELEASE, minUpHandler);
		}
		
		private function maxDownHandler(e:UIMouseEvent):void {
			setButtonCommonBehavior(e);
		}
		
		private function maxUpHandler(e:UIMouseEvent):void {
			if ($minimized) {
				$minimized = false;
				dispatchRestoreEvent();
			} else if ($maximized) {
				$maximized = false;
				restoreWindowSize(); 
				dispatchRestoreEvent();
			} else {
				$maximized = true;
				spas_internal::lafDTO.state = $state = WindowState.MAXIMIZED;
			}
			setRefresh();
		}
			
		private function minDownHandler(e:UIMouseEvent):void {
			setButtonCommonBehavior(e);
		}
		
		private function minUpHandler(e:UIMouseEvent):void {
			switch(_defaultMinimizeOperation) {
				case MinimizableProperties.MINIMIZE_ON_CALL :
					$minimized = true;
					spas_internal::lafDTO.state = $state = WindowState.MINIMIZED;
					if ($maximized) {
						$maximized = false;
						restoreWindowSize();
					}
					setRefresh();
					break;
				case MinimizableProperties.DO_NOTHING_ON_CALL :
					dispatchWindowEvent(WindowEvent.MINIMIZE_BUTTON_CLICKED);
					break;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number):void {
			init(label, width, height);
			_isGoodQuality = getQuality() >= 2;
			initMinSize(100, 0);
			createWindowButtons();
			super.createContainers();
			initResizer();
			createContainers();
			createTitleBarItems();
			createTitleBar();
			spas_internal::setSelector(Selectors.WINDOW);
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
		
		private function deactivateRefresh():void {
			if($content.numChildren > 0) {
				$invalidateRefresh = true;
				if ($layout != null)
					$evtColl.addEvent($layout, LayoutEvent.LAYOUT_FINISHED, reactivateRefresh);
				spas_internal::updateLayout();
			}
		}
		
		private function reactivateRefresh(e:LayoutEvent):void {
			if ($layout != null)
				$evtColl.removeEvent($layout, LayoutEvent.LAYOUT_FINISHED, reactivateRefresh);
			$invalidateRefresh = false;
		}
		
		private function dispatchRestoreEvent():void {
			spas_internal::lafDTO.state = $state = WindowState.NORMAL;
			_eventToDispatch = new WindowEvent(WindowEvent.RESTORE);
		}
		
		private function displayWindow():void {
			lookAndFeel.drawWindow();
			if($height>=$topOffset+$bottomOffset) {
				$borderDecorator.drawBackground();
				if($innerPanel) lookAndFeel.drawInnerPanel();
				$borderDecorator.drawBorders();
				drawMask();
				$footer.visible = $header.visible = $scrollableContainer.visible = true;
			} else {
				$innerPanelContainer.graphics.clear();
				$borderDecorator.clearBorders();
				$borderDecorator.clearBackground();
				$footer.visible = $header.visible = $scrollableContainer.visible = false;
			}
			_minimizeButton.visible = _showMinimizeButton;
			_maximizeButton.alt = maximizeAlt;
			lookAndFeel.drawTitleBar();
		}
		
		private function displayMinimizedWindow():void {
			lookAndFeel.drawMinimizedWindow();
			$borderDecorator.clearBackground();
			$innerPanelContainer.graphics.clear();
			$borderDecorator.clearBorders();
			$footer.visible = $header.visible = _minimizeButton.visible =
				$scrollableContainer.visible = false;
			_maximizeButton.alt = retoreAlt;
			lookAndFeel.drawTitleBar();
			_eventToDispatch = new WindowEvent(WindowEvent.MINIMIZE);
		}
		
		/**
		 * @private
		 */
		override protected function doubleClickHandler(e:MouseEvent):void {
			if ($maximized) {
				restoreWindowSize();
				$maximized = false;
				dispatchRestoreEvent();
			} else if ($minimized) $minimized = false;
			else $maximized = _enabledFullScreen ? true : false;
			$state = $maximized ? WindowState.MAXIMIZED : WindowState.NORMAL;
			setRefresh();
			super.doubleClickHandler(e);
		}
		
		/**
		 * @private
		 * 
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	@param	invalidateRefreshCaller
		 */
		private function displayMaximizedWindow(invalidateRefreshCaller:Boolean = false):void {
			var hasViewPort:Boolean = (_maxViewPort != null);
			if (!invalidateRefreshCaller && !_lockStoredMetrics) {
				saveWindowSize();
				_windowX = spas_internal::uioSprite.x;
				_windowY = spas_internal::uioSprite.y;
				if (hasViewPort) {
					spas_internal::uioSprite.x = _maxViewPort.x;
					spas_internal::uioSprite.y = _maxViewPort.y;
				} else spas_internal::uioSprite.x = spas_internal::uioSprite.y = 0;
				$evtColl.addEvent($stage, Event.RESIZE, redrawMaximizedWindow);
			}
			var hh:Number = $header.displayed ? $header.height : 0;
			var fh:Number = $footer.displayed ? $footer.height : 0;
			if (hasViewPort) {
				$width = _maxViewPort.width - $leftOffset - $rightOffset - $ipOffset - _maxViewPort.x;
				$height = _maxViewPort.height - $titleBarHeight - $topOffset - $bottomOffset - $ipOffset - hh - fh - _maxViewPort.y;
			} else {
				if($parent == $stage) {
					var s:Stage = $parent as Stage;
					$width = s.stageWidth - $leftOffset - $rightOffset - $ipOffset;
					$height = s.stageHeight - $titleBarHeight - $topOffset - $bottomOffset - $ipOffset - hh - fh;
				} else {
					$width = $parent.width - $leftOffset - $rightOffset - $ipOffset;
					$height = $parent.height - $titleBarHeight - $topOffset - $bottomOffset - $ipOffset - hh - fh;
				}
			}
			fixSize();
			lookAndFeel.drawWindow();
			$borderDecorator.drawBackground();
			if($innerPanel) lookAndFeel.drawInnerPanel();
			$borderDecorator.drawBorders();
			drawMask();
			lookAndFeel.drawTitleBar();
			$footer.visible = $header.visible = $scrollableContainer.visible = true;
			initializeScrollableContainer();
			_maximizeButton.alt = retoreAlt;
			if(!invalidateRefreshCaller) _eventToDispatch = new WindowEvent(WindowEvent.MAXIMIZE);
		}
		
		private function displayChromelessWindow():void {
			saveWindowSize();
			_windowX = spas_internal::uioSprite.x;
			_windowY = spas_internal::uioSprite.y;
			spas_internal::uioSprite.x = spas_internal::uioSprite.y = 0;
			if($parent == $stage) {
				var s:Stage = $parent as Stage;
				$width = s.stageWidth - $leftOffset - $rightOffset - $ipOffset;
				$height = s.stageHeight - $titleBarHeight - $topOffset - $bottomOffset - $ipOffset;
			} else {
				$width = $parent.width - $leftOffset - $rightOffset - $ipOffset;
				$height = $parent.height - $titleBarHeight - $topOffset - $bottomOffset - $ipOffset;
			}
			fixSize();
			//lookAndFeel.drawChromelessWindow();
			$borderDecorator.drawBackground();
			if($innerPanel) lookAndFeel.drawInnerPanel();
			drawMask();
			//lookAndFeel.drawTitleBar();
			$footer.visible = $header.visible = $scrollableContainer.visible = true;
			initializeScrollableContainer();
			_eventToDispatch = new WindowEvent(WindowEvent.FULLSCREEN)
		}
		
		private function restoreWindowSize():void {
			$evtColl.removeEvent($stage, Event.RESIZE, redrawMaximizedWindow);
			$width = _storedWinWidth;
			$height = _storedWinHeight;
			spas_internal::lafDTO.spas_internal::setSize($width, $height);
			spas_internal::uioSprite.x = _windowX;
			spas_internal::uioSprite.y = _windowY;
			_lockStoredMetrics = false;
		}
		
		private function saveWindowSize():void {
			_storedWinWidth = $width;
			_storedWinHeight = $height;
			_lockStoredMetrics = true;
		}
		
		private function redrawMaximizedWindow(e:Event):void {
			setRefresh();
		}
		
		private function getButtonsWidth():Number {
			var w:Number = $outerWidth-closeButton.x;
			if(_showMinimizeButton && _minimizeButton.visible) w = $outerWidth-_minimizeButton.x;
			else {
				if (_showMaximizeButton && _maximizeButton.visible)
					w = $outerWidth - _maximizeButton.x;
			}
			return w;
		}
		
		private function setTitleBarProperties():void {
			setContentPosition();
			lookAndFeel.setCloseButtonPosition();
			lookAndFeel.setButtonsPosition();
			$buttonsWidth = getButtonsWidth();
			setTitleProperties();
		}
		
		private function createWindowButtons():void {
			_maximizeButton = new WindowButton();
			_minimizeButton = new WindowButton();
			spas_internal::lafDTO.maximizeButton = _maximizeButton;
			spas_internal::lafDTO.minimizeButton = _minimizeButton;
		}
		
		private function fixButtonsLaf():void {
			_maximizeButton.lockLaf(lookAndFeel.getButtonLaf(), true);
			_minimizeButton.lockLaf(lookAndFeel.getButtonLaf(), true);
			fixMaximizeButtonIcon();
			fixMinimizeButtonIcon();
			_maximizeButton.width = _maximizeButton.height =
			_minimizeButton.width = _minimizeButton.height = $buttonsSize;
		}
		
		private function fixMaximizeButtonIcon():void {
			var r:Rectangle = getIconBounds(_maximizeButton);
			state == WindowState.NORMAL ?
				_maximizeButton.drawIcon(lookAndFeel.getMaximizeButtonBrush(), r) :
				_maximizeButton.drawIcon(lookAndFeel.getRestoreButtonBrush(), r);
		}
		
		private function fixMinimizeButtonIcon():void {
			_minimizeButton.drawIcon(lookAndFeel.getMinimizeButtonBrush(), getIconBounds(_minimizeButton));
		}
		
		private function initWindowBounds():void {
			spas_internal::lafDTO.windowBounds = new Rectangle(0, 0, $outerWidth, $outerHeight);
		}
	}
}