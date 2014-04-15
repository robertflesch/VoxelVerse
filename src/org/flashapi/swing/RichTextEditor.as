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
	// RichTextEditor.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version beta 3.1, 17/03/2010 21:30
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.constants.LayoutHorizontalAlignment;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.LayoutVerticalAlignment;
	import org.flashapi.swing.constants.RteFormatType;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ColorPickerEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.icons.BoldIcon;
	import org.flashapi.swing.icons.BulletIcon;
	import org.flashapi.swing.icons.CenterAlignIcon;
	import org.flashapi.swing.icons.ItalicIcon;
	import org.flashapi.swing.icons.JustifyIcon;
	import org.flashapi.swing.icons.LeftAlignIcon;
	import org.flashapi.swing.icons.RightAlignIcon;
	import org.flashapi.swing.icons.UnderlineIcon;
	import org.flashapi.swing.plaf.libs.RichTextEditorUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("RichTextEditor.png")]
	
	/**
	 * 	<img src="RichTextEditor.png" alt="RichTextEditor" width="18" height="18"/>
	 * 
	 * 	[This class is under development.]
	 * 
	 * 	The <code>RichTextEditor</code> clas creates an integrated application
	 * 	that let users enter and format text.
	 * 
	 * 	<p>
	 * 	The text characteristics that users can vary include the font family, color,
	 * 	size, and style, and other properties such as text alignment, bullets and
	 * 	URL links. The control consists of a <code>Panel</code> instance with two
	 * 	direct children:
	 * 	<ul>
	 * 		<li>A <code>TextArea</code> instance where users can enter text.</li>
	 * 		<li>A container with format <code>Button</code> and <code>ComboBox</code>
	 * 		controls that let a user specify the text characteristics. The format
	 * 		controls affect text being typed or selected text.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>The following table describes the subcontrols that you can access and
	 * 	modify:</p>
	 * 
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Control Type</th>
	 * 			<th>ID</th>
	 * 			<th>Description</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>TextArea</code></td>
	 * 			<td></td>
	 * 			<td>Area where the user can enter text.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>ComboBox</code></td>
	 * 			<td></td>
	 * 			<td>Specifies the text font family. The <code>ComboBox</code> contains
	 * 			the following values:
	 * 			<ul>
	 * 				<li><code>Arial</code> (default)</li>
	 * 				<li><code>Arial Black</code></li>
	 * 				<li><code>Comic Sans MS</code></li>
	 * 				<li><code>Courier New</code></li>
	 * 				<li><code>Georgia</code></li>
	 * 				<li><code>Impact</code></li>
	 * 				<li><code>Symbol</code></li>
	 * 				<li><code>Times New Roman</code></li>
	 * 				<li><code>Trebuchet MS</code></li>
	 * 				<li><code>Verdana</code></li>
	 * 				<li><code>Webdings</code></li>
	 * 			</ul>
	 * 			</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>ComboBox</code></td>
	 * 			<td></td>
	 * 			<td>Specifies the font size. The <code>ComboBox</code> contains the
	 * 			following values: <code>8</code>, <code>9</code>, <code>10</code>,
	 * 			<code>11</code>, <code>12</code> (default), <code>14</code>,
	 * 			<code>16</code>, <code>18</code>, <code>20</code>, <code>24</code>,
	 * 			<code>26</code>, <code>28</code>, <code>36</code>, <code>48</code>,
	 * 			<code>72</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>Button</code></td>
	 * 			<td></td>
	 * 			<td>When toggled to selected, sets the font to bold.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>Button</code></td>
	 * 			<td></td>
	 * 			<td>When toggled to selected, sets the font to italic.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>Button</code></td>
	 * 			<td></td>
	 * 			<td>When toggled to selected, sets the font to underlined.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>ButtonBar</code></td>
	 * 			<td></td>
	 * 			<td>Specifies the text alignment. The <code>ButtonBar</code> allows 
	 * 			the following values:
	 * 			<ul>
	 * 				<li><code>left </code> (default)</li>
	 * 				<li><code>center</code></li>
	 * 				<li><code>center</code></li>
	 * 				<li><code>justify</code></li>
	 * 			</ul>
	 * 			</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>Button</code></td>
	 * 			<td></td>
	 * 			<td>When toggled to selected, sets the current line, or the
	 * 			selected line, to a list item, preceded by a bullet.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>TextInput</code></td>TextInput
	 * 			<td></td>
	 * 			<td>This field is enabled only when text is selected. When the
	 * 			user enters a URL in this field and presses the Enter key, an equivalent
	 * 			of an HTML <code>&lt;a href="user_text" target="blank"&gt;&lt;/a&gt;</code>
	 * 			tag is inserted in the <code>TextArea</code> subcontrol at around
	 * 			the currently selected text. This control is initially filled with
	 * 			the text specified by the <code>defaultLinkProtocol</code> property;
	 * 			users can append the rest of the link to this text, or replace it.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>ColorButton</code></td>
	 * 			<td></td>
	 * 			<td>Specifies the color of the text.</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 *  @includeExample RichTextEditorExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RichTextEditor extends UIObject implements Observer, LafRenderer, Initializable {
		
		//TODO: URL insertion management.
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>RichTextEditor</code> instance with
		 * 					the specified properties.
		 * 
		 * 	@param	width	The width of the<code>RichTextEditor</code> instance,
		 * 					in pixels.
		 * 	@param	height	The height of the<code>RichTextEditor</code> instance,
		 * 					in pixels.
		 */
		public function RichTextEditor(width:Number = 325, height:Number = 200) {
			super();
			initObj(width, height);
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
		//  Overriden getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _linkProtocol:String = "http://";
		/**
		 * 	Sets or gets the default protocol to use for formating HTML links.
		 * 
		 * 	@default "http://"
		 */
		public function get defaultLinkProtocol():String {
			return _linkProtocol;
		}
		public function set defaultLinkProtocol(value:String):void {
			_linkProtocol = value;
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
			_colorPicker.finalize();
			_btnCont.finalizeElements();
			_topCont.finalizeElements();
			_bottomCont.finalizeElements();
			_frame.finalizeElements();
			_frame.finalize();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function setSpecificLafChanges():void {
			var fld:TextField = _textArea.textField;
			_prevFmt = fld.defaultTextFormat;
			_textArea.lockLaf(lookAndFeel.getTextAreaLaf(), true);
			_fontBox.lockLaf(lookAndFeel.getComboBoxLaf(), true);
			_sizeBox.lockLaf(lookAndFeel.getComboBoxLaf(), true);
			_boldBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			_italicBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			_bulletBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			_underlineBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			_colorBtn.lockLaf(lookAndFeel.getColorButtonLaf(), true);
			_alignButtons.lockLaf(lookAndFeel.getButtonBarLaf(), true);
			_separator.lockLaf(lookAndFeel.getSeparatorLaf(), true);
			_linkTextInput.lockLaf(lookAndFeel.getTextInputLaf(), true);
			fld.defaultTextFormat = _prevFmt;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _topCont:Canvas;
		private var _bottomCont:Canvas;
		private var _btnCont:Canvas;
		private var _frame:Canvas;
		private var _textArea:TextArea;
		private var _fontBox:ComboBox;
		private var _sizeBox:ComboBox;
		private var _boldBtn:IconizedButton;
		private var _italicBtn:IconizedButton;
		private var _underlineBtn:IconizedButton;
		private var _colorBtn:ColorButton;
		private var _alignButtons:IconizedButtonBar;
		private var _bulletBtn:IconizedButton;
		private var _separator:Separator;
		private var _linkTextInput:TextInput;
		private var _colorPicker:WebsafeColorPicker;
		private var _fontSizes:Array;
		private var _fontTypes:Array;
		private var _prevFmt:TextFormat;
		private var _hasFmtChanged:Boolean;
		private var _lastCaretId:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			initSize(width, height);
			_lastCaretId = -1;
			_hasFmtChanged = false;
			createControls();
			initLaf(RichTextEditorUIRef);
			createEvents();
			spas_internal::setSelector(Selectors.UNDEFINED);
			spas_internal::isInitialized(1);
		}
		
		private function createControls():void {
			_fontSizes = [72, 48, 36, 28, 26, 24, 22, 20, 18, 16, 14, 12, 11, 10, 9, 8];
			_fontTypes = [
				WebFonts.WEBDINGS, WebFonts.VERDANA, WebFonts.TREBUCHET_MS,
				WebFonts.TIMES_NEW_ROMAN, WebFonts.SYMBOL, WebFonts.IMPACT,
				WebFonts.GEORGIA, WebFonts.COURIER_NEW, WebFonts.COMIC_SANS_MS,
				WebFonts.ARIAL_BLACK, WebFonts.ARIAL
				];
			_frame = new Canvas($width, $height);
			_frame.layout.orientation = LayoutOrientation.VERTICAL;
			_frame.layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			_frame.verticalGap = 10;
			_frame.target = spas_internal::uioSprite;
			_frame.display(x, y);
			_topCont = new Canvas($width);
			_bottomCont = new Canvas($width);
			fixContainerProp(_topCont);
			fixContainerProp(_bottomCont);
			_textArea = new TextArea();
			var fld:TextField = _textArea.textField;
			fld.alwaysShowSelection = _textArea.fixToParentWidth = true;
			_textArea.autoFocus = false;
			_prevFmt = fld.defaultTextFormat;
			_btnCont = new Canvas();
			_btnCont.height = 22;
			_btnCont.autoWidth = true;
			_boldBtn = new IconizedButton(BoldIcon, 20, 22);
			_italicBtn = new IconizedButton(ItalicIcon, 20, 22);
			_underlineBtn = new IconizedButton(UnderlineIcon, 20, 22);
			_btnCont.addGraphicElements(_boldBtn, _italicBtn, _underlineBtn);
			_fontBox = new ComboBox(_prevFmt.font);
			fillComboBox(_fontBox, _fontTypes);
			_sizeBox = new ComboBox(String(_prevFmt.size), 80);
			_sizeBox.editable = _sizeBox.buttonMode = true;
			fillComboBox(_sizeBox, _fontSizes);
			_colorPicker = new WebsafeColorPicker();
			_colorBtn = new ColorButton(_colorPicker);
			_alignButtons = new IconizedButtonBar();
			_alignButtons.toggleMode = true;
			_alignButtons.addItem(
				{width:20, height:22, selected:true, brush:LeftAlignIcon },
				TextAlign.LEFT );
            _alignButtons.addItem(
				{ width:20, height:22, brush:CenterAlignIcon },
				TextAlign.CENTER );
            _alignButtons.addItem(
				{ width:20, height:22, brush:RightAlignIcon },
				TextAlign.RIGHT);
			_alignButtons.addItem(
				{ width:20, height:22, brush:JustifyIcon },
				TextAlign.JUSTIFY);
			_bulletBtn = new IconizedButton(BulletIcon, 20, 22);
			_separator = new Separator(25);
			_linkTextInput = new TextInput(_linkProtocol, 150);
			_linkTextInput.active = false;
			_boldBtn.toggle = _italicBtn.toggle = _underlineBtn.toggle =
				_bulletBtn.toggle = true;
			_topCont.addGraphicElements(_fontBox, _sizeBox, _btnCont);
			_bottomCont.addGraphicElements(
				_alignButtons, _bulletBtn, _separator,
				_linkTextInput, _colorBtn
				);
			_frame.addGraphicElements(_topCont, _textArea, _bottomCont);
		}
		
		private function fixContainerProp(c:Canvas):void {
			c.layout.verticalAlignment = LayoutVerticalAlignment.MIDDLE;
			c.autoAdjustSize = false;
			c.fixToParentWidth = c.autoHeight = true;
			c.horizontalGap = 8;
			c.verticalGap = 4;
		}
		
		private function createEvents():void {
			$evtColl.addEventCollection([_boldBtn, _italicBtn, _underlineBtn, _bulletBtn], UIMouseEvent.RELEASE, formatChangedHandler);
			$evtColl.addEvent(_colorBtn, ColorPickerEvent.COLOR_CHANGED, formatChangedHandler);
			$evtColl.addEventCollection([_alignButtons, _fontBox, _sizeBox], ListEvent.LIST_CHANGED, formatChangedHandler);
			$evtColl.addEvent(_textArea.textField, KeyboardEvent.KEY_UP, callForStyleDetection);
			$evtColl.addEvent(_textArea.textField, KeyboardEvent.KEY_DOWN, swapTextFormats);
			$evtColl.addEvent(_textArea.textField, MouseEvent.MOUSE_DOWN, addMouseUpHandler);
		}
		
		private function fillComboBox(obj:ComboBox, data:Array):void {
			var l:int = data.length - 1;
			for (; l >= 0; l--) {
				//obj.invalidateListUpdate = true;
				obj.addItem(data[l].toString());
				//obj.invalidateListUpdate = false;
			}
		}
		
		private function formatChangedHandler(e:Event):void {
			var val:*;
			var prop:String;
			switch(e.target) {
				case _boldBtn:
					prop = RteFormatType.BOLD;
					val = _boldBtn.selected;
					break;
				case _italicBtn:
					prop = RteFormatType.ITALIC;
					val = _italicBtn.selected;
					break;
				case _underlineBtn:
					prop = RteFormatType.UNDERLINE;
					val = _underlineBtn.selected;
					break;
				case _bulletBtn:
					prop = RteFormatType.BULLET;
					val = _bulletBtn.selected;
					break;
				case _fontBox:
					prop = RteFormatType.FONT;
					val = _fontBox.value;
					break;
				case _sizeBox:
					prop = RteFormatType.SIZE;
					val = int(_sizeBox.value);
					break;
				case _alignButtons:
					prop = RteFormatType.ALIGN;
					val = _alignButtons.data;
					break;
				case _colorBtn:
					prop = RteFormatType.COLOR;
					val = _colorBtn.selectedColor;
					break;
			}
			setFormatChanges(prop, val);
		}
		
		private function setFormatChanges(type:String, value:Object = null):void {
			var fld:TextField = _textArea.textField;
			var startId:int = fld.selectionBeginIndex;
			var endId:int = fld.selectionEndIndex;
			var fmt:TextFormat = startId == -1 ? _prevFmt : new TextFormat();
			switch(type) {
				case RteFormatType.ALIGN:
				case RteFormatType.BULLET:
					if (startId == -1) {
						if (_lastCaretId == -1) _lastCaretId = 0;
						startId = endId = _lastCaretId;
						fmt = new TextFormat();
					}
					startId = fld.getFirstCharInParagraph(startId) - 1;
					startId = Math.max(0, startId);
					endId = fld.getFirstCharInParagraph(endId) + fld.getParagraphLength(endId) - 1;
					_prevFmt[type] = value;
					if (!endId) fld.defaultTextFormat = fmt;
					break;
				case RteFormatType.SIZE:
					if (value <= 0) throw new InvalidArgumentException();
					break;
				case RteFormatType.URL : 
					if (value != _linkProtocol && value != "") fmt.target = "_blank";
					else if (fmt[type] != "") {
						value = "";
						fmt.target = "";
					}
					break;
			}
			fmt[type] = value;
			_hasFmtChanged = true;
			startId == endId ? _prevFmt = fmt : fld.setTextFormat(fmt, startId, endId);
			var lineId:int = fld.getLineIndexOfChar(fld.caretIndex);
			while (lineId >= fld.bottomScrollV) {
				fld.scrollV++;
			}
			_textArea.focus = true;
		}
		
		private function swapTextFormats(e:KeyboardEvent):void {
			if (_hasFmtChanged) {
				_textArea.textField.defaultTextFormat = _prevFmt;
				_hasFmtChanged = false;
			}
		}
		
		private function callForStyleDetection(e:KeyboardEvent):void {
			var code:int = e.charCode;
			if (code == 0 || code == 8) getFormat();
		}
		
		private function addMouseUpHandler(e:MouseEvent):void {
			$evtColl.addOneShotEvent($stage, MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			var fld:TextField = _textArea.textField;
			if (_lastCaretId != fld.caretIndex) getFormat();
			else {
				_linkTextInput.active =
					fld.selectionBeginIndex == fld.selectionEndIndex ? false : true; 
			}	
		}
		
		private function getFormat():void {
			var fld:TextField = _textArea.textField;
			var startId:int = fld.selectionBeginIndex;
			var endId:int = fld.selectionEndIndex;
			var fmt:TextFormat;
			_linkTextInput.active = startId == endId ? false : true;
			if (startId == endId) {
				fmt = fld.defaultTextFormat;
				if (fmt.url != "") {
					var carId:int = fld.caretIndex;
					if (carId < fld.length) {
						var urlTf:TextFormat = fld.getTextFormat(carId, carId + 1);
						if (!urlTf.url || urlTf.url == "") fmt.url = fmt.target = "";
					} else fmt.url = fmt.target = ""; 
				}
			} else fmt = fld.getTextFormat(startId, endId);
			setComboProp(_fontBox, fmt.font);
			setComboProp(_sizeBox, fmt.size);
			if (_prevFmt.color != fmt.color) _colorBtn.selectedColor = Number(fmt.color);
			setButtonProp(_boldBtn, fmt.bold);
			setButtonProp(_italicBtn, fmt.italic);
			setButtonProp(_underlineBtn, fmt.underline);
			setButtonProp(_bulletBtn, fmt.bullet);
			if (!_prevFmt || _prevFmt.align != fmt.align) {
				var i:uint;
				switch(fmt.align) {
					case TextAlign.LEFT:
						i = 0;
						break;
					case TextAlign.CENTER:
						i = 1;
						break;
					case TextAlign.RIGHT:
						i = 2;
						break;
					case TextAlign.JUSTIFY:
						i = 3;
						break;
				}
				_alignButtons.selectedIndex = i;
			}
			if (!_prevFmt || _prevFmt.url != fmt.url) {
				_linkTextInput.text = (fmt.url == "" || fmt.url == null) ?
					_linkProtocol : fmt.url;
			}
			if (fld.defaultTextFormat != fmt) fld.defaultTextFormat = fmt;
			_prevFmt = fmt;
			_lastCaretId = fld.caretIndex;
		}
		
		private function setButtonProp(uio:ABM, value:Boolean):void {
			if(uio.selected != value) uio.selected = value;
		}
		
		private function setComboProp(uio:ComboBox, value:Object):void {
			var val:String = String(value).toLowerCase();
			var v:String = uio.value.toLowerCase();
			if (v == val) return;
			var l:int = uio.length - 1;
			for (; l >= 0; l--) {
				v = uio.getItemAt(l).value.toLowerCase();
				if (v == val) {
					uio.selectedIndex = l;
					return;
				}
			}
		}
	}
}