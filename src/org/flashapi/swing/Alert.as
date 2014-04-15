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
	// Alert.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.2, 28/02/2011 15:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.flashapi.swing.constants.AlertMode;
	import org.flashapi.swing.constants.ClosableProperties;
	import org.flashapi.swing.constants.LayoutHorizontalAlignment;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.AlertEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.event.WindowEvent;
	import org.flashapi.swing.localization.alert.AlertLocaleUs;
	import org.flashapi.swing.plaf.libs.AlertUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Alert.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a button is clicked within the <code>Alert</code> instance.
	 * 	The "buttonClick" event has an <code>action</code> which indicates what 
	 * 	button have been clicked by the user.
	 *
	 *  @eventType org.flashapi.swing.event.AlertEvent.BUTTON_CLICK
	 */
	[Event(name = "buttonClick", type = "org.flashapi.swing.event.AlertEvent")]
	
	/**
	 *  Dispatched each time the <code>Alert</code> instance is removed, independently
	 * 	from a user or programmatic action.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.REMOVED
	 */
	[Event(name = "removed", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 * 	<img src="Alert.png" alt="Alert" width="18" height="18"/>
	 * 
	 * 	The <code>Alert</code> class is a pop-up dialog box that can contain a
	 * 	message, a title, buttons (any combination of OK, Cancel, Yes, and No)
	 * 	and an icon.
	 * 	The <code>Alert</code> control is modal, which means it will retain focus
	 * 	until the user closes it.
	 * 
	 * 	<p>The <code>Alert</code> instance closes when you select a button whithin 
	 * 	the object, or press the Escape key.</p>
	 * 
	 * 	<p><strong><code>Alert</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">html</code></td>
	 * 			<td>Indicates whether the text displayed within this object support HTML entities, or not.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>html</code></td>
	 * 			<td><code>Properties.HTML</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">horizontal-gap</code></td>
	 * 			<td>Sets the horizontal gap value for this object.</td>
	 * 			<td>Possible values are valid numbers.</td>
	 * 			<td><code>horizontalGap</code></td>
	 * 			<td><code>Properties.HORIZONTAL_GAP</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@see org.flashapi.swing.ModalObject
	 * 
	 *  @includeExample AlertExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	//TODO: complete button management.
	public class Alert extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Alert</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	title 	The text displayed within the title bar of the 
		 * 					<code>Alert</code> instance.
		 * 	@param	width	The width of the <code>Alert</code> instance, in pixels.
		 */
		public function Alert(title:String = "", width:Number = 250) {
			super();
			initObj(title, width);
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
		
		/**
		 * 	@private
		 */
		override public function set horizontalGap(value:Number):void {
			_txtCont.horizontalGap = super.horizontalGap = value;
		}
		
		private var _btnWidth:Number = 100;
		/**
		 * 	Sets or gets the width for all buttons used within this <code>Alert</code>
		 * 	popup. 
		 * 
		 * 	@default 100
		 */
		public function get buttonsWidth():Number {
			return _btnWidth;
		}
		public function set buttonsWidth(value:Number):void {
			_btnWidth = value;
			var __autoWidth:Boolean = isNaN(_btnWidth);
			_actionBtn.autoWidth = _choiceBtn.autoWidth =
				_cancelBtn.autoWidth = __autoWidth;
			if (!__autoWidth) {
				_actionBtn.width = _choiceBtn.width = _cancelBtn.width = _btnWidth;
			}
		}
		
		private var _message:String = "";
		/**
		 * 	The text to be displayed by the dialog box of this <code>Alert</code>
		 * 	instance. 
		 * 
		 * 	@default ""
		 */
		public function get message():String {
			return _message;
		}
		public function set message(value:String):void {
			_message = value;
			_text.text = _message;
		}
		
		/**
		 *  @private
		 */
		override public function set target(value:*):void { }
		
		private var _title:String;
		/**
		 * 	The text to display within the title bar of the <code>Alert</code>
		 * 	instance. 
		 * 
		 * 	@default ""
		 */
		public function get title():String {
			return _title;
		}
		public function set title(value:String):void {
			_title = _popup.label = value;
		}
		
		/**
		 * 	Returns a reference to the <code>Icon</code> instance used by this
		 * 	<code>Alert</code> instance. 
		 * 
		 * 	@see org.flashapi.swing.Icon
		 */
		public function get icon():Icon {
			return _icon;
		}
		
		/**
		 * 	Returns a reference to the modal <code>Popup</code> instance used by this
		 * 	<code>Alert</code> instance. 
		 * 
		 * 	@see org.flashapi.swing.Popup
		 */
		public function get popup():Popup {
			return _popup;
		}
		
		/**
		 * 	Returns a reference to the <code>Text</code> instance used by this
		 * 	<code>Alert</code> instance. 
		 * 
		 * 	@see org.flashapi.swing.Text
		 */
		public function get text():Text {
			return _text;
		}
		
		private var _alertMode:String = AlertMode.ALERT;
		/**
		 * 	Sets or gets the type of alert you choose for this <code>Alert</code> instance.
		 * 	<p>Possible values are constants defined by the <code>AlertMode</code> class:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Value</th>
		 * 			<th>Description</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td><code>AlertMode.NONE</code></td>
		 * 			<td>Default. Indicates that no button is displayed within the 
		 * 			<code>Alert</code> instance.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>AlertMode.ALERT</code></td>
		 * 			<td>Enables an OK button within the <code>Alert</code> instance.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>AlertMode.CHOICE</code></td>
		 * 			<td>Enables both, YES and NO buttons, within the <code>Alert</code>
		 * 			instance.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>AlertMode.CANCELABLE</code></td>
		 * 			<td>Enables YES, NO and Cancel buttons within the <code>Alert</code>
		 * 			instance.</td>
		 * 		</tr>
		 * 	</table> 
		 * 	</p>
		 * 
		 * 	@see org.flashapi.swing.constants.AlertMode
		 */
		public function get alertMode():String {
			return _alertMode;
		}
		public function set alertMode(value:String):void {
			if (_alertMode == value) return;
			_alertMode = value;
			createButtons();
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			$width = _popup.width = value;
		}
		
		private var _autoRemove:Boolean = true;
		/**
		 *  A <code>Boolean</code> that indicates whether the <code>Alert</code>
		 * 	instance will be automatically removed when the user click one of the
		 * 	displayed buttons (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	<p>This property is useful for creating successive alert messages by 
		 * 	using only one modal <code>Alert</code> object.</p>
		 * 
		 * 	@default true
		 */
		public function get autoRemove():Boolean {
			return _autoRemove;
		}
		public function set autoRemove(value:Boolean):void {
			_autoRemove = value;
		}
		
		/**
		 *  A <code>Boolean</code> that indicates whether the text displayed within
		 * 	this <code>Alert</code> instance is HTML (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get html():Boolean {
			return _text.html;
		}
		public function set html(value:Boolean):void {
			_text.html = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				$displayed = true;
				$evtColl.addEvent($stage, KeyboardEvent.KEY_DOWN, alertKeyDown);
				_modalObj.display();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			if ($displayed) {
				_modalObj.remove();
				$evtColl.removeEvent($stage, KeyboardEvent.KEY_DOWN, alertKeyDown);
				$displayed = false;
				dispatchUIOEvent(UIOEvent.REMOVED);
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function finalize():void {
			$evtColl.finalize();
			$evtColl = null;
			_txtCont.finalizeElements();
			_text = null;
			_icon = null;
			_btnCont.finalizeElements();
			_actionBtn = null;
			_cancelBtn = null;
			_choiceBtn = null;
			_popup.finalizeElements();
			_txtCont = null;
			_btnCont = null;
			_popup.finalize();
			_popup = null;
			_modalObj.finalize();
			_modalObj = null;
			super.finalize();
		}
		
		/**
		 * 	Sets the text displayed on the face of all buttons displayed whithin the
		 * 	<code>Alert</code> instance. Developers can use any string values to
		 * 	customize <code>Alert</code> objects. Use the "alert" localization API
		 * 	(see the <code>org.flashapi.swing.localization.alert</code> package) to 
		 * 	implement globalization for <code>Alert</code> objects.
		 * 
		 * 	<p>When a parameter of the <code>setLabels()</code> method is <code>null</code>,
		 * 	the button relative to this parameter will use the previous defined text.</p>
		 * 
		 * 	@param	actionLabel	The label for the <code>Alert</code> action button.
		 * 	@param	choiceLabel	The label for the <code>Alert</code> choice button.
		 * 	@param	cancelLabel	The label for the <code>Alert</code> cancel button.
		 * 
		 * 	@see org.flashapi.swing.localization.alert.AlertLocaleUs
		 */
		public function setLabels(actionLabel:String = null, choiceLabel:String = null, cancelLabel:String = null):void {
			if (!isNull(actionLabel)) _actionBtn.label = actionLabel;
			if (!isNull(choiceLabel)) _choiceBtn.label = choiceLabel;
			if (!isNull(cancelLabel)) _cancelBtn.label = cancelLabel;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_popup.lockLaf(lookAndFeel.getWindowLaf(), true);
			_text.lockLaf(lookAndFeel.getTextLaf(), true);
			if(_actionBtn != null) _actionBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _modalObj:ModalObject;
		private var _popup:Popup;
		private var _text:Text;
		private var _icon:Icon;
		private var _btnCont:Canvas;
		private var _txtCont:Canvas;
		private var _actionBtn:Button;
		private var _choiceBtn:Button;
		private var _cancelBtn:Button;
		private var _btnHeight:Number = NaN;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(title:String, width:Number):void {
			_title = title;
			$width = width;
			initMinSize(50, 0);
			createControls();
			createButtons();
			initLaf(AlertUIRef);
			spas_internal::setSelector(Selectors.ALERT);
			spas_internal::isInitialized(1);
		}
		
		private function createButtons():void {
			_btnCont.removeElements();
			switch(_alertMode) {
				case AlertMode.NONE:
					break;
				case AlertMode.ALERT:
					_btnCont.addElement(_actionBtn);
					break;
				case AlertMode.CHOICE:
					_btnCont.addGraphicElements(_actionBtn, _choiceBtn);
					break;
				case AlertMode.CANCELABLE:
					_btnCont.addGraphicElements(_actionBtn, _choiceBtn, _cancelBtn);
					break;
			}
		}
		
		private function removeButtons():void {
			_popup.removeElement(_actionBtn);
		}
		
		private function removeAlert(e:Event = null):void {
			this.remove();
		}
		
		private function createControls():void {
			_popup = new Popup(_title, $width);
			_popup.backgroundAlpha = .7;
			_popup.padding = 15;
			_popup.verticalGap = _popup.horizontalGap = 10;
			_popup.layout.orientation = LayoutOrientation.VERTICAL;
			_popup.layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			_popup.defaultCloseOperation = ClosableProperties.DO_NOTHING_ON_CLOSE;
			$evtColl.addEvent(_popup, WindowEvent.CLOSE_BUTTON_CLICKED, removeAlert);
			_text = new Text();
			_icon = new Icon();
			_txtCont = new Canvas();
			horizontalGap = 10;
			_btnCont = new Canvas();
			_txtCont.autoAdjustSize = _btnCont.autoAdjustSize = false;
			_txtCont.autoHeight = _txtCont.fixToParentWidth = 
			_btnCont.autoHeight = _btnCont.fixToParentWidth = _text.fixToParentWidth = _text.autoHeight = _popup.autoHeight = true;
			_text.textFormat.align = TextAlign.CENTER;
			_btnCont.layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			_txtCont.addGraphicElements(_icon, _text);
			_popup.addGraphicElements(_txtCont, _btnCont);
			_actionBtn = new Button(AlertLocaleUs.ACTION, _btnWidth, _btnHeight);
			_choiceBtn = new Button(AlertLocaleUs.CHOICE, _btnWidth, _btnHeight);
			_cancelBtn = new Button(AlertLocaleUs.CANCEL, _btnWidth, _btnHeight);
			$evtColl.addEvent(_actionBtn, UIMouseEvent.CLICK, btnClickHandler);
			$evtColl.addEvent(_choiceBtn, UIMouseEvent.CLICK, btnClickHandler);
			$evtColl.addEvent(_cancelBtn, UIMouseEvent.CLICK, btnClickHandler);
			_modalObj = new ModalObject(_popup);
		}
		
		private function btnClickHandler(e:UIMouseEvent):void {
			var a:uint;
			switch(e.target) {
				case _actionBtn:
					a = AlertEvent.ACTION;
					break;
				case _choiceBtn:
					a = AlertEvent.CHOICE;
					break;
				case _cancelBtn:
					a = AlertEvent.CANCEL;
					break;
			}
			this.dispatchEvent(new AlertEvent(AlertEvent.BUTTON_CLICK, a));
			if (_autoRemove) removeAlert();
		}
		
		private function alertKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == 27) this.removeAlert();
		}
	}
}