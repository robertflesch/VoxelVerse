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
	// Dock.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 15/03/2010 21:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.flashapi.swing.constants.DockPosition;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.libs.DockUIRef;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Dock.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>Dock</code> instance changes value due to
	 * 	mouse interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name="listChanged", type="org.flashapi.swing.event.ListEvent")]
	
	/**
	 * 	<img src="Dock.png" alt="Dock" width="18" height="18"/>
	 * 
	 * 	The <code>Dock</code> control is a bar of icons that sits at the bottom
	 * 	or side of your screen. It enables users to organize their shortcuts and
	 * 	running tasks into an attractive animated graphical user interface feature.
	 * 
	 * 	<p>
	 * 		To add an icon item to a <code>Dock</code> instance, use the <code>addItem()</code>
	 * 		method by passing an object as the <code>value</code> parameter. <code>value</code>
	 * 		objects must define the followig properties:
	 * 	</p>
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>label</code> to be displayed
	 * 		with the specified icon item,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the image used as icon for this 
	 * 		item; can be a string that represents a valid URL to an image file or
	 * 		a <code>DisplayObject</code> instance.</li>
	 * 	</ul>
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>Dock</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following
	 * 	properties:
	 * 	</p>
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>label</code> property defined by
	 * 		the <code>value</code> parameter of the <code>Dock.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter of
	 * 		the <code>Dock.addItem()</code> method,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the <code>icon</code> property defined by
	 * 		the <code>value</code> parameter of the <code>Dock.addItem()</code> method.</li>
	 * 	</ul>
	 * 
	 * 	<p><strong><code>Dock</code> instances support the following CSS properties:</strong></p>
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
	 * 	</table>
	 * 
	 * 	@includeExample DockExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Dock extends ALM implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Dock</code> instance.
		 * 
		 *	@param	position	Indicates how the <code>Dock</code> instance is
		 * 						positionate on the screen. Valid values are:
		 * 						<code>DockPosition</code> class constants.
		 * 						Default value is <code>DockPosition.BOTTOM</code>.
		 *	@param	iconSize	The default size of the icons displayed within this
		 * 						<code>Dock</code> instance.
		 * 	@param	iconMin		The default minimum size of the icons displayed within 
		 * 						this <code>Dock</code> instance.
		 * 	@param	iconMax		The default maximum size of the icons displayed within 
		 * 						this <code>Dock</code> instance.
		 * 	@param	iconPadding	The default padding value for the icons displayed  
		 * 						within this <code>Dock</code> instance.
		 */
		public function Dock(position:String = "bottom", iconSize:Number = 128, iconMin:Number = 32, iconMax:Number = 96, iconPadding:Number = 4) {
			super();
			initObj(position, iconSize, iconMin, iconMax, iconPadding);
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
		
		private var _dockPosition:String;
		/**
		 * 	Sets or gets the position of the <code>Dock</code> instance within the
		 * 	application. Possible values are:
		 * 	<ul>
		 * 		<li><code>DockPosition.TOP</code>,</li>
		 * 		<li><code>DockPosition.BOTTOM</code>,</li>
		 * 		<li><code>DockPosition.LEFT</code>,</li>
		 * 		<li><code>DockPosition.RIGHT</code>.</li>
		 * 	</ul>
		 * 
		 * 	@default <code>DockPosition.BOTTOM</code>
		 */
		public function get dockPosition():String {
			return _dockPosition;
		}
		public function set dockPosition(value:String):void {
			_dockPosition = value;
			setLayout();
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		protected var _fontColor:* = null;
		/**
		 *  Sets or gets the text color for this <code>Dock</code> instance.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a>
		 * 	recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> 
		 *  section of the document to get valid SVG color keyword names.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 *  @default The color specified by the current Look and Feel.
		 */
		public function get fontColor():* {
			return _format.color;
		}
		public function set fontColor(value:*):void {
			_fontColor = getColor(value);
			_format.color = _fontColor;
			setRefresh();
		}
		
		private var _iconMax:Number;
		/**
		 * 	Sets or gets the maximum size of icon items displayed within this
		 * 	this <code>Dock</code> instance, in pixels. The <code>iconMax</code> 
		 * 	property represents the maximum size of the icon when the mouse
		 * 	is over it.
		 * 
		 * 	@default 96
		 * 
		 * 	@see #iconMin
		 * 	@see #iconSize
		 */
		public function get iconMax():Number {
			return _iconMax;
		}
		public function set iconMax(value:Number):void {
			_iconMax = value;
			setRefresh();
		}
		
		private var _iconMin:Number;
		/**
		 * 	Sets or gets the minimum size of icon items displayed within this
		 * 	this <code>Dock</code> instance, in pixels. The <code>iconMin</code> 
		 * 	property represents the minimum size of the icon when the mouse is 
		 * 	not over it.
		 * 
		 * 	@default 32
		 * 
		 * 	@see #iconMax
		 * 	@see #iconSize
		 */
		public function get iconMin():Number {
			return _iconMin;
		}
		public function set iconMin(value:Number):void {
			_iconMin = value;
			setRefresh();
		}
		
		private var _iconPadding:Number;
		/**
		 *  Sets or gets the padding value for all icon items displayed within 
		 * 	this <code>Dock</code> instance, in pixels.
		 * 
		 * 	@default 4
		 */
		public function get iconPadding():Number {
			return _iconPadding;
		}
		public function set iconPadding(value:Number):void {
			_iconPadding = value;
			setRefresh();
		}
		
		private var _iconSize:Number;
		/**
		 * 	Sets or gets the real size of the icon items displayed within this
		 * 	<code>Dock</code> instance, in pixels.
		 * 
		 * 	@default 128
		 * 
		 * 	@see #iconMax
		 * 	@see #iconMin
		 */
		public function get iconSize():Number {
			return _iconSize;
		}
		public function set iconSize(value:Number):void {
			_iconSize = value;
			setRefresh();
		}
		
		private var _thickness:Number = NaN;
		/**
		 * 	Sets or gets the thickness of the <code>Dock</code> instance, in pixels.
		 * 	If <code>NaN</code>, the thickness is computed from the <code>iconMin</code>
		 * 	and <code>iconPadding</code> properties.
		 * 	
		 * 	@default NaN
		 */
		public function get thickness():Number {
			return _thickness;
		}
		public function set thickness(value:Number):void {
			_thickness = value;
			getHeight();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			var ic:Icon = new Icon();
			ic.target = _iconContainer;
			ic.addIcon(value.icon);
			var li:ListItem = new ListItem(ic, $objList, getLabel(value), data);
			ic = null;
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			var ic:Icon = new Icon();
			ic.target = _iconContainer;
			ic.addIcon(value.icon);
			var li:ListItem = new ListItem(ic, $objList, getLabel(value), data, index);
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!$displayed) {
				createUIObject(x, y);
				doStartEffect();
				$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, monitorDock);
				$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, resetDock);
				$evtColl.addEvent(_dockTimer, TimerEvent.TIMER, updateDock);
			}
		}
		
		/**
		 * @private
		 */
		override public function remove():void {
			if($displayed) {
				$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, monitorDock);
				$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, resetDock);
				$evtColl.removeEvent(_dockTimer, TimerEvent.TIMER, updateDock);
				unload();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			var ic:Icon = item.item;
			//removeHandlers(ic);
			if(ic.displayed) ic.remove();
			var id:int = $dataStack.splice($dataStack.indexOf(ic), 1);
			$objList.remove(item);
			$listItem = null, $value = $data = null;
			updateItemList();
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return _storedBounds;
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return _storedBounds;
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
			setRatio();
			getMetrix();
			updateTray();
			_storedBounds = spas_internal::uioSprite.getBounds(spas_internal::uioSprite);
			setEffects();
		}
		
		/**
		 * @private
		 */
		override protected function updateItemList():void {
			$dataList = new Dictionary();
			_origins = [];
			var it:Iterator = $objList.iterator;
			spas_internal::lafDTO.width = $width =
				$objList.size * _iconPadding + $objList.size * _iconMin;
			var left:Number = _iconPadding;
			var ic:Icon;
			while (it.hasNext()) {
				ic = it.next().item;
				if (ic.displayed) ic.remove();
			}
			it.reset();
			var i:uint = 0;
			var xPos:Number;
			var yPos:Number = 0;
			var next:ListItem;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				ic = next.item;
				$dataList[ic] = next;
				xPos = left + i * (_iconMin + _iconPadding) + _iconPadding;
				ic.y = _paddingFactor*_iconPadding;
				_origins.push(xPos);
				ic.x = xPos;
				ic.scaleX = ic.scaleY = _iconMin/_iconSize;
				ic.rotation = -spas_internal::uioSprite.rotation;
				if (_dockPosition == DockPosition.BOTTOM || _dockPosition == DockPosition.RIGHT)
					yPos = _iconMin - ic.height;
				ic.display(xPos, _factor * yPos + _paddingFactor * _iconPadding);
				$evtColl.addEvent(ic, UIMouseEvent.ROLL_OVER, setLabelValue);
				$evtColl.addEvent(ic, UIMouseEvent.ROLL_OUT, removeLabelValue);
				$evtColl.addEvent(ic, UIMouseEvent.CLICK, dockClickHandler);
				i++;
			}
			it.reset();
			_firstItem = $objList.get(0).item;
			_lastItem = $objList.get($objList.size - 1).item;
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_format = lookAndFeel.getTextFormat().clone();
			if(_fontColor != null) _format.color = _fontColor;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _storedBounds:Rectangle;
		private var _positions:Array;
		private var _iconContainer:Sprite;
		private var _tray:Sprite;
		private var _amplitude:Number;
		private var _span:Number;
		private var _ratio:Number;
		private var _xmouse:Number;
		private var _ymouse:Number;
		private var _factor:Number;
		private var _paddingFactor:Number;
		private var _scale:Number = Number.NEGATIVE_INFINITY;
		private var _trend:Number = 0;
		private var _origins:Array;
		private var _dockTimer:Timer;
		private var _resetDock:Boolean = false;
		private var _firstItem:Icon;
		private var _lastItem:Icon;
		private var _mouseOverItem:ListItem = null;
		private var _format:UITextFormat;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(position:String, iconSize:Number, iconMin:Number, iconMax:Number, iconPadding:Number):void {
			initLaf(DockUIRef);
			_storedBounds = new Rectangle();
			createContainers();
			_dockPosition = position;
			_iconSize = iconSize;
			_iconMin = iconMin;
			_iconMax = iconMax;
			_iconPadding = iconPadding;
			setParameters();
			setLayout();
			_dockTimer = new Timer(5);
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			spas_internal::setSelector(Selectors.DOCK);
			spas_internal::isInitialized(1);
		}
		
		private function setLayout():void {
			var r:Number;
			switch(_dockPosition) {
				case DockPosition.LEFT :
				case DockPosition.RIGHT :
					_paddingFactor = -1;
					r = 90;
					_tray.y -= _iconMin + 2 * _iconPadding;
					break;
				case DockPosition.TOP :
				case DockPosition.BOTTOM :
					_paddingFactor = 1;
					r = _tray.y = 0;
					break;
			}
			_factor = 	_dockPosition == DockPosition.BOTTOM ||
						_dockPosition == DockPosition.LEFT ? 1 : -1;
			spas_internal::uioSprite.rotation = r;
			spas_internal::textRef.rotation = -r;
		}
		
		private function createContainers():void {
			_iconContainer = new Sprite();
			_tray = new Sprite();
			spas_internal::uioSprite.addChild(_tray);
			spas_internal::lafDTO.currentTarget = _tray;
			spas_internal::uioSprite.addChild(_iconContainer);
			spas_internal::textRef = new TextField();
			spas_internal::textRef.selectable = false;
			spas_internal::textRef.autoSize = TextFieldAutoSize.CENTER;
		}
		
		private function getMetrix():void {
			getHeight();
			spas_internal::lafDTO.width = $width = $width + 2 * _iconPadding;
		}
		
		private function getHeight():void {
			spas_internal::lafDTO.height = $height =
				isNaN(_thickness) ? _iconMin + 2 * _iconPadding : _thickness;
		}
		
		private function setParameters():void {
			_span = getSpan();
			_amplitude = getAmplitude();
		}
		
		private function getAmplitude():Number {
			return 2 * (_iconMax - _iconMin + _iconPadding);
		}
		
		private function getSpan():Number {
			return (_iconMin - 16) * (240 - 60) / (96 - 16) + 60;
		}
		
		private function setRatio():void {
			_ratio =  Math.PI / 2 / _span;
		}
		
		/*private function removeHandlers(ic:Icon):void {
			si.addEventListener(UIMouseEvent.PRESS, pressHandler);
			si.addEventListener(UIMouseEvent.CLICK, releaseHandler);
		}*/
		
		private function getLabel(value:Object):String {
			return value.label ? value.label : "";
		}
		
		private function checkBoundary():Boolean {
			var r:Rectangle = spas_internal::uioSprite.getRect(null);
			return (_xmouse >= r.x && _ymouse >= r.y &&
					_xmouse <= r.width + _tray.x &&
					_ymouse <= r.height);
		}
		
		private function updateTray():void {
			if ($objList.size == 0) return;
			var x:Number = _firstItem.x - _iconPadding;
			var w:Number = _lastItem.x + _lastItem.width + _iconPadding;
			_tray.x = x;
			spas_internal::lafDTO.width = $width = w - x;
			lookAndFeel.drawTray();
			//setEffects();
		}
		
		private function dataProviderChangedHandler(e:ListEvent):void {
			var it:Iterator = $dataProvider.iterator;
			while(it.hasNext()) {
				var obj:Object = it.next();
				var ic:Icon = new Icon();
				ic.target = _iconContainer;
				if(obj.icon != null) ic.addIcon(obj.icon);
				var li:ListItem = new ListItem(ic, $objList, obj.label, obj.data);
				ic = null;
			}
			it.reset();
			updateItemList();
			getMetrix();
			updateTray();
		}
		
		private function setLabelValue(e:UIMouseEvent):void {
			_mouseOverItem = $dataList[e.target];
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			spas_internal::textRef.text = _mouseOverItem.value;
			spas_internal::textRef.setTextFormat(_format);
		}
		
		private function removeLabelValue(e:UIMouseEvent):void {
			_mouseOverItem = null;
			spas_internal::textRef.text = "";
			spas_internal::uioSprite.removeChild(spas_internal::textRef);
			
		}
		
		private function dockClickHandler(e:UIMouseEvent):void {
			var li:ListItem = $dataList[e.target];
			$listItem = li;
			$value = li.value;
			$data = li.data;
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
		}
		
		private function monitorDock(e:MouseEvent):void {
			_dockTimer.start();
		}
		
		private function resetDock(e:MouseEvent):void {
			_resetDock = true;
		}
		
		private function updateDock(e:TimerEvent = null):void {
			if (_xmouse == spas_internal::uioSprite.mouseX &&
				_ymouse == spas_internal::uioSprite.mouseY) return;
			var dx:Number;
			var dy:Number;
			var dim:Number;
			var f:Number;
			_xmouse = spas_internal::uioSprite.mouseX;
			_ymouse = spas_internal::uioSprite.mouseY;
			_trend = (_trend == 0)  ? (checkBoundary() ? 0.25 : -0.25) : _trend;
			_scale += _trend;
			if( (_scale < 0.02) || (_scale > 0.98) ) _trend = 0;
			_scale = Math.min(1, Math.max(0, _scale));
			var it:Iterator = $objList.iterator;
			var ic:Icon;
			var i:uint = 0;
			var yPos:Number = 0;
			var next:ListItem;
			var delay:Number;
			var xPos:Number;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				ic = next.item;
				xPos = _origins[i];
				dx = xPos - _xmouse;
				dx = Math.min(Math.max(dx, -_span), _span);
				dim = _iconMin + (_iconMax - _iconMin) * Math.cos(dx * _ratio) * (Math.abs(dx) > _span ? 0 : 1) * _scale;
				ic.x = xPos + _scale * _amplitude * Math.sin(dx * _ratio)-_iconPadding;
				ic.scaleX = ic.scaleY = dim / _iconSize;
				if (_dockPosition == DockPosition.BOTTOM || _dockPosition == DockPosition.RIGHT)
					yPos = _iconMin - ic.height;
				ic.y  = _factor*yPos+_paddingFactor*_iconPadding;
				if(_mouseOverItem) {
					if(spas_internal::textRef.text == _mouseOverItem.value) {
						delay = _dockPosition == DockPosition.RIGHT ?
							spas_internal::textRef.height/2 : 0;
						spas_internal::textRef.y = -_factor*_iconContainer.height+delay;
					}
					spas_internal::textRef.x = _xmouse - spas_internal::textRef.width/2;
				}
				i++;
			}
			it.reset();
			if (_scale == 0 && _resetDock) {
				_dockTimer.stop();
				_resetDock = false;
			}
			updateTray();
		}
	}
}