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
	// WebsafeColorPicker.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 14/11/2011 12:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.flashapi.swing.button.ColorSprite;
	import org.flashapi.swing.color.ColorPicker;
	import org.flashapi.swing.color.ColorPickerCreator;
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ColorPickerEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.plaf.libs.WebsafeColorPickerUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("WebsafeColorPicker.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the value of the selected color within the 
	 * 	<code>WebsafeColorPicker</code> instance changes.
	 *
	 *  @eventType org.flashapi.swing.event.ColorPickerEvent.COLOR_CHANGED
	 */
	[Event(name = "colorChanged", type = "org.flashapi.swing.event.ColorPickerEvent")]
	
	/**
	 * 	<img src="WebsafeColorPicker.png" alt="WebsafeColorPicker" width="18" height="18"/>
	 * 
	 * 	The <code>WebsafeColorPicker</code> class creates an list of color items
	 * 	that let user choose a color from. The color sheme of <code>WebsafeColorPicker</code>
	 * 	instances is based upon the 216 cross-browser color palette (a.k.a. Web
	 * 	safe color palette).
	 * 
	 * 	<p>The following image shows how sub-controls are laid out within a
	 * 	<code>WebsafeColorPicker</code> instance:</p>
	 * 
	 * 	<p><a name="awmMetrics"><img src = "../../../doc-images/wscp_controls.jpg"
	 * 	alt="WebsafeColorPicker controls." /></a></p>
	 * 
	 *  @includeExample WSCPExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WebsafeColorPicker extends UIObject implements Observer, ColorPicker, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>WebsafeColorPicker</code> instance
		 * 					with the specified properties.
		 * 
		 * 	@param	showPreview	Indicates whether the <code>WebsafeColorPicker</code>
		 * 						instance displays preview tools (<code>true</code>),
		 * 						or not (<code>false</code>).
		 * 	@param	barPresentation	Indicates whether the <code>WebsafeColorPicker</code>
		 * 							instance uses a bar-like presentation (<code>true</code>),
		 * 							or not (<code>false</code>).
		 */
		public function WebsafeColorPicker(showPreview:Boolean = true, barPresentation:Boolean = false) {
			super();
			initObj(showPreview, barPresentation);
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
		
		private var _barPresentation:Boolean;
		/**
		 *  A <code>Boolean</code> value that indicates whether the <code>WebsafeColorPicker</code>
		 * 	instance uses a bar-like presentation (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get barPresentation():Boolean {
			return _barPresentation;
		}
		public function set barPresentation(value:Boolean):void {
			if(value != _barPresentation) {
				_barPresentation = value;
				refreshColorTable();
				setColorPickerBounds();
				lookAndFeel.drawColorArea();
				setRefresh();
			}
		}
		
		private var _box:Box;
		/**
		 * 	Returns a reference to the <code>Box</code> container which contains
		 * 	this <code>WebsafeColorPicker</code> instance.
		 * 
		 * 	<p><strong>Note: </strong>when you changes any property of the <code>Box</code> ,
		 * 	container the color picker dispatches a <code>UIOEvent.CHANGED</code> event.</p>
		 */
		public function get boxContainer():Box {
			return _box;
		}
		
		private var _currentColor:String = null;
		/**
		 * 	Returns the a string representation of the hexadecimal value for the
		 * 	selected color within this <code>WebsafeColorPicker</code> instance.
		 * 	Returns <code>null</code> is no color has been selected yet.
		 * 
		 * 	@default null
		 */
		public function get colorName():String {
			return _currentColor;
		}
		
		/**
		 *  @private
		 */
		override public function get color():* {
			return _currentColor != null ? uint(_currentColor) : null;
		}
		override public function set color(value:*):void {
			if(_previousSelection) {
				spas_internal::lafDTO.currentButton = _previousSelection;
				lookAndFeel.drawOutState();
				_previousSelection = null;
			}
			var btnName:String = value is String ? value : ColorUtil.colorToRGB(value);
			_currentColor = "0x" + btnName;
			
			var col:uint = uint(_currentColor);
			setPreviewColor(col, _currentColor);
			spas_internal::lafDTO.currentButtonColor = col;
			if (_colorPanel.getChildByName(btnName)) {
				var btn:ColorSprite = _colorPanel.getChildByName(btnName) as ColorSprite;
				spas_internal::lafDTO.currentButton = _previousSelection = btn;
				lookAndFeel.drawPressedState();
			} else {
				spas_internal::lafDTO.currentButton = null;
			}
		}
		
		private var _creator:ColorPickerCreator = null;
		/**
		 * 	@inheritDoc
		 */
		public function get creator():ColorPickerCreator {
			return _creator;
		}
		public function set creator(value:ColorPickerCreator):void {
			_creator = value;
		}
		
		/**
		 *  @private
		 */
		override public function get height():Number {
			return _box.height;
		}
		
		private var _showPreview:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>WebsafeColorPicker</code>
		 * 	instance displays preview tools (<code>true</code>), or not (<code>false</code>).
		 * 	Preview tools are composed of a "selected color" preview panel, an "overflown color"
		 * 	preview panel and a text input that displays the value of the selected color.
		 * 
		 * 	@default true
		 */
		public function get showPreview():Boolean {
			return _showPreview;
		}
		public function set showPreview(value:Boolean):void {
			_showPreview = value;
			displayPreviewPanel();
			setColorPickerBounds();
			setRefresh();
		}
		
		private var _preview:TextInput;
		/**
		 *  Returns a reference to the <code>TextInput</code> which is used to display the
		 * 	value of the current color.
		 */
		public function get textInput():TextInput {
			return _preview;
		}
		
		/**
		 *  @private
		 */
		override public function get width():Number {
			return _box.width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function finalize():void {
			spas_internal::lafDTO.colorArea = null;
			spas_internal::lafDTO.selectedColorPanel = null;
			_creator = null;
			_preview.finalize();
			_preview = null;
			
			$content.removeChild(_colorArea);
			_colorArea = null;
			$content.removeChild(_colorPanel);
			deleteButtons();
			_colorPanel = null;
			_selectedColorPanel.removeChild(_colorPreview);
			_colorPreview = null;
			_selectedColorPanel.removeChild(_overflownColorPanel);
			_overflownColorPanel = null;
			
			if ($content.contains(_selectedColorPanel)) $content.removeChild(_selectedColorPanel);
			_selectedColorPanel = null;
			
			_colorTable = [];
			_colorTable = null;
			
			$evtColl.removeEvent(_box, UIOEvent.CHANGED, dispatchUIOChangeEvent);
			_box.removeElements();
			_box.finalize();
			_box = null;
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
		override protected function refresh():void {
			setBoxMetrics();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_box.lockLaf(lookAndFeel.getBoxLaf(), true);
			_box.borderStyle = lookAndFeel.getBorderStyle();
			_box.borderWidth = 1;
			_box.backgroundColor = lookAndFeel.getBackgroundColor();
			setUnit();
			lookAndFeel.drawPreviewPanel();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private static const HEXA_TABLE:Array = ["00", "33", "66", "99", "CC", "FF"];
		private static const FIRST_ROW:Array = ["000000", "333333", "666666", "999999",
												"CCCCCC", "FFFFFF", "FF0000", "00FF00",
												"0000FF", "FFFF00", "00FFFF", "FF00FF"];
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _colorTable:Array;
		private var _unit:Number;
		private var _previousSelection:ColorSprite;
		private var _colorPreview:ColorSprite;
		private var _overflownColorPanel:Sprite;
		private var _colorPanel:Sprite;
		private var _selectedColorPanel:Sprite;
		private var _colorArea:Sprite;
		private var _colorAreaHeight:Number;
		private var _colorAreaWidth:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(showPreview:Boolean, barPresentation:Boolean):void {
			_barPresentation = barPresentation;
			_showPreview = showPreview;
			
			createContainers();
			initContainers();
			initMetrics();
			
			createColorTable();
			initLaf(WebsafeColorPickerUIRef);
			setColorPickerBounds();
			lookAndFeel.drawColorArea();
			refreshColorTable(true);
			setPreviewColor(0, "0x000000");
			createPreviewPanel();
			displayPreviewPanel();
			
			spas_internal::setSelector(Selectors.WSCP);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			_colorTable = [];
			_overflownColorPanel = new Sprite();
			_colorPanel = new Sprite();
			_selectedColorPanel = new Sprite();
			spas_internal::lafDTO.selectedColorPanel = _selectedColorPanel;
			_colorArea = new Sprite();
			spas_internal::lafDTO.colorArea = _colorArea;
			_box = new Box();
			_box.setLayout();
			_box.target = spas_internal::uioSprite;
			$content = new Sprite();
			$content.x = _box.paddingLeft;
			$content.y = _box.paddingTop;
			_preview = new TextInput();
			_colorPreview = new ColorSprite();
		}
		
		private function initContainers():void {
			$content.addChild(_colorArea);
			$content.addChild(_colorPanel);
			_selectedColorPanel.addChild(_colorPreview);
			_selectedColorPanel.addChild(_overflownColorPanel);
			_box.addElement($content);
			$evtColl.addEvent(_box, UIOEvent.CHANGED, dispatchUIOChangeEvent);
			_box.display();
		}
		
		private function createColorTable():void {
			var r:String;
			var g:String;
			var b:String;
			var id:uint;
			var cursor:uint;
			var j:uint;
			var i:uint = 1;
			for(; i<=6; ++i) {
				var buffer:Array = [];
				r = HEXA_TABLE[i-1];
				id = 0;
				do {
					if((36-id)%6 == 0) cursor = 6-(36-id)/6;
					g = HEXA_TABLE[cursor];
					for(j=0; j<6; ++j) {
						b = HEXA_TABLE[j];
						buffer.push(r+g+b);
						++id;
					}
				} while(id < 36);
				_colorTable.push(buffer);
			}
		}
		
		private function createPreviewPanel():void {
			_currentColor = _currentColor != null ? _currentColor : "0x"+_colorTable[0][0];
			_preview.target = _selectedColorPanel;
			_preview.text = _currentColor;
			_preview.width = lookAndFeel.getPreviewWidth();
			_preview.textAlign = TextAlign.CENTER;
			_preview.selectable = true;
			_preview.editable = false;
			$evtColl.addEvent(_colorPreview, MouseEvent.CLICK, onclickHandler);
			var c:uint = uint(_currentColor);
			spas_internal::lafDTO.currentPreviewColor = c;
			spas_internal::lafDTO.currentPreviewButton = _overflownColorPanel;
			lookAndFeel.drawPreviewColorButton();
			_preview.display(_colorPreview.x,
					_selectedColorPanel.y + _selectedColorPanel.height + lookAndFeel.getBorderDelay());
		}
		
		private function displayPreviewPanel():void {
			_selectedColorPanel.visible = _showPreview;
			var isDisplayed:Boolean = $content.contains(_selectedColorPanel);
			if (_showPreview && !isDisplayed) {
				$content.addChild(_selectedColorPanel);
			} else if (isDisplayed && !_showPreview) {
				$content.removeChild(_selectedColorPanel);
			}
		}
		
		//--> Metrics:
		
		private function initMetrics():void {
			spas_internal::lafDTO.colorAreaWidth = spas_internal::lafDTO.colorAreaHeight = 0;
		}
		
		private function setUnit():void {
			_unit = lookAndFeel.getColorItemSize() + lookAndFeel.getColorItemDelay();
		}
		
		private function setColorPickerBounds():void {
			var gbd:Number = lookAndFeel.getBorderDelay();
			var cbd:Number = lookAndFeel.getColorItemDelay();
			var gpd:Number = lookAndFeel.getPreviewDelay();
			spas_internal::lafDTO.colorAreaWidth = _colorAreaWidth =
				_barPresentation ? 39*_unit+cbd : 20*_unit+cbd;
			spas_internal::lafDTO.colorAreaHeight = _colorAreaHeight =
				_barPresentation ? 6*_unit+cbd : 12*_unit+cbd;
			_colorArea.y = _colorArea.x = 0;
			$height = _colorAreaHeight;
			_colorPreview.y = 2 * lookAndFeel.getColorItemSize();
			if(_showPreview) {
				_selectedColorPanel.x = _barPresentation ? 39 * _unit + gbd + gpd : 20 * _unit + gbd + gpd;
				$width = _selectedColorPanel.x + lookAndFeel.getPreviewWidth() + 2 * cbd + gbd;
				_overflownColorPanel.x = _colorPreview.x = _overflownColorPanel.y = cbd;
				_selectedColorPanel.y = 0;
			} else $width = _colorArea.x + _colorAreaWidth + gbd;
		}
		
		private function setBoxMetrics():void {
			_box.width = $content.width + _box.paddingLeft + _box.paddingRight + _preview.borderWidth;
			var delayH:Number = _barPresentation ? _preview.borderWidth : 0;
			_box.height = $content.height + _box.paddingTop + _box.paddingBottom + delayH;
		}
		
		//--> Buttons management:
		
		private function refreshColorTable(createBtn:Boolean = false):void {
			_colorPanel.y = lookAndFeel.getColorItemDelay();
			_colorPanel.x = -lookAndFeel.getColorItemSize();
			var xDelay:Number;
			var yDelay:Number;
			var X:Number;
			var Y:Number;
			var len:int = FIRST_ROW.length;
			var i:int = 0;
			var xPos:Number, yPos:Number;
			for(; i<len; ++i) {
				var c:String = FIRST_ROW[i];
				if (_barPresentation && i >= FIRST_ROW.length / 2) {
					xDelay = _unit;
					yDelay = 6 * _unit;
				}
				else xDelay = yDelay = 0;
				xPos = _unit + xDelay;
				yPos = i * _unit - yDelay;
				if(createBtn) createButton(c, "_fr", xPos, yPos);
				else setButtonPosition(c + "_fr", xPos, yPos);
			}
			i = X = Y = 0;
			for(; i<=216; ++i, ++X) {
				c = _colorTable[Y][X - 1];
				if(c) {
					if (!_barPresentation && 36 / X < 1.9) {
						xDelay = 18 * _unit;
						yDelay = 6 * _unit;
					} else if(!_barPresentation) xDelay = yDelay = 0;
					else {
						xDelay = -_unit;
						yDelay = 0;
					}
					xPos = X * _unit - xDelay + 2 * _unit;
					yPos = Y * _unit + yDelay;
					if(createBtn) createButton(c, "", xPos, yPos);
					else setButtonPosition(c, xPos, yPos);
					if (X == 36) {
						Y++;
						X = 0;
					}
				}
			}
		}
		
		private function createButton(c:String, altName:String, xPos:Number, yPos:Number):void {
			var btn:ColorSprite = new ColorSprite();
			var btnColor:uint = uint("0x" + c);
			btn.name = c+altName;
			btn.hexa = "0x" + c;
			spas_internal::lafDTO.currentButtonColor = btn.color = btnColor;
			spas_internal::lafDTO.currentButton = btn;
			lookAndFeel.drawOutState();
			$evtColl.addEvent(btn, MouseEvent.ROLL_OVER, rollOverHandler);
			$evtColl.addEvent(btn, MouseEvent.ROLL_OUT, rollOutHandler);
			$evtColl.addEvent(btn, MouseEvent.CLICK, onclickHandler);
			btn.x = xPos;
			btn.y = yPos;
			_colorPanel.addChild(btn);
		}
		
		private function deleteButtons():void {
			do {
				var btn:DisplayObject = _colorPanel.removeChildAt(_colorPanel.numChildren - 1);
				$evtColl.removeEvent(btn, MouseEvent.ROLL_OVER, rollOverHandler);
				$evtColl.removeEvent(btn, MouseEvent.ROLL_OUT, rollOutHandler);
				$evtColl.removeEvent(btn, MouseEvent.CLICK, onclickHandler);
				btn = null;
			} while (_colorPanel.numChildren > 0)
		}
		
		private function setButtonPosition(c:String, _x:Number,  _y:Number):void {
			var btn:ColorSprite = _colorPanel.getChildByName(c) as ColorSprite;
			btn.x = _x;
			btn.y = _y;
		}
			
		private function rollOverHandler(e:MouseEvent):void {
			var tgt:* = e.target;
			var c:uint = tgt.color;
			spas_internal::lafDTO.currentPreviewColor = _colorPreview.color = c;
			_colorPreview.hexa = tgt.hexa;
			spas_internal::lafDTO.currentPreviewButton = _colorPreview;
			lookAndFeel.drawPreviewColorButton();
			spas_internal::lafDTO.currentButton = tgt;
			spas_internal::lafDTO.currentButtonColor = c;
			if(tgt.hexa != _currentColor) lookAndFeel.drawOverState();
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			if (e.target.hexa != _currentColor) {
				spas_internal::lafDTO.currentButton = e.target;
				spas_internal::lafDTO.currentButtonColor = e.target.color;
				lookAndFeel.drawOutState();
			}
		}
		
		private function setPreviewColor(col:uint, hexa:String):void {
			spas_internal::lafDTO.currentPreviewColor = col;
			spas_internal::lafDTO.currentPreviewButton = _overflownColorPanel;
			lookAndFeel.drawPreviewColorButton();
			spas_internal::lafDTO.currentPreviewButton = _colorPreview;
			lookAndFeel.drawPreviewColorButton();
			_preview.text = hexa;
		}
		
		private function onclickHandler(e:MouseEvent):void {
			var btn:ColorSprite = e.target as ColorSprite;
			var c:uint = btn.color;
			var h:String = btn.hexa;
			if (_previousSelection && btn != _colorPreview) {
				spas_internal::lafDTO.currentButton = _previousSelection;
				spas_internal::lafDTO.currentButtonColor = _previousSelection.color;
				lookAndFeel.drawOutState();
			}
			setPreviewColor(c, h);
			_currentColor = h;
			if(btn!=_colorPreview) {
				spas_internal::lafDTO.currentButton = _previousSelection = btn;
				spas_internal::lafDTO.currentButtonColor = c;
				lookAndFeel.drawPressedState();
			}
			//this.dispatchEvent(new ColorPickerEvent(ColorPickerEvent.ITEM_CLICKED, c));
			this.dispatchEvent(new ColorPickerEvent(ColorPickerEvent.COLOR_CHANGED, c));
		}
		
		private function dispatchUIOChangeEvent(e:UIOEvent):void {
			dispatchChangeEvent();
		}
	}
}