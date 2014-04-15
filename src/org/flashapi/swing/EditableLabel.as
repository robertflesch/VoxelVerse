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
	// EditableLabel.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 15/03/2010 22:41
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.plaf.libs.EditableLabelUIRef;
	import org.flashapi.swing.Text;
	import org.flashapi.swing.TextInput;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("EditableLabel.png")]
	
	/**
	 * 	<img src="EditableLabel.png" alt="EditableLabel" width="18" height="18"/>
	 * 
	 * 	The <code>EditableLabel</code> class provides a convenient ajax-like text
	 * 	edition control by swapping from a <code>Text</code> control to an editable
	 * 	<code>TextInput</code>, when user clicks (or double-clicks) on displayed text.
	 * 
	 * 	<p><code>TextInput</code> and <code>Text</code> instances can be accessed 
	 * 	through the <code>textInput</code> and <code>labelControl</code> properties.</p>
	 * 
	 * <p><strong><code>EditableLabel</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">font-size</code></td>
	 * 			<td>Sets the font size of the object.</td>
	 * 			<td>Recognized values are positive integers.</td>
	 * 			<td><code>fontSize</code></td>
	 * 			<td><code>Properties.FONT_SIZE</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-weight</code></td>
	 * 			<td>Sets the font weight of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">bold</code>.</td>
	 * 			<td><code>boldFace</code></td>
	 * 			<td><code>Properties.FONT_WEIGHT</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">text-align</code></td>
	 * 			<td>Sets the alignment of the text displayed within this object.</td>
	 * 			<td>Valid values are <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code>.</td>
	 * 			<td><code>textAlign</code></td>
	 * 			<td><code>Properties.TEXT_ALIGN</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@see org.flashapi.swing.Text
	 * 	@see org.flashapi.swing.TextInput
	 * 
	 * 	@includeExample EditableLabelExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class EditableLabel extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>EditableLabel</code> instance with the 
		 * 	specified parameters.
		 * 
		 * 	@param	label	The plain text to be displayed within this <code>EditableLabel</code>
		 * 					instance.
		 * 	@param	width	The width of the <code>EditableLabel</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>EditableLabel</code> instance, 
		 * 					in pixels.
		 */
		public function EditableLabel(label:String = "", width:Number = 150, height:Number = 20) {
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
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _label:String;
		/**
		 * 	Sets or gets text to be displayed within this <code>EditableLabel</code>
		 * 	instance.
		 * 
		 * 	@default An empty <code>String</code>.
		 */
		public function get label():String {
			return _label;
		}
		public function set label(value:String):void {
			_textCtrl.text = _label = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set index(value:int):void {
			spas_internal::setIndex(value);
		}
		
		/**
		 *  @private
		 */
		private var _textCtrl:Text;
		/**
		 * 	Returns a reference to the <code>Text</code> instance that is used
		 * 	by the <code>EditableLabel</code> to display the text label.
		 * 
		 * 	@see #textInput
		 */
		public function get textControl():Text {
			return _textCtrl;
		}
		
		/**
		 *  @private
		 */
		private var _input:TextInput;
		/**
		 * 	Returns a reference to the <code>TextInput</code> instance that is 
		 * 	used by the <code>EditableLabel</code> to edit the text label.
		 * 
		 * 	@see #textControl
		 */
		public function get textInput():TextInput {
			return _input;
		}
		
		/**
		 *  @private
		 */
		private var _editable:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the user can edit
		 * 	the text displayed by this <code>EditableLabel</code> instance (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get editable():Boolean {
			return _editable;
		}
		public function set editable(value:Boolean):void {
			if (!value && _input.focus) _input.focus = false;
			_editable = value;
		}
		
		/**
		 *  @private
		 */
		private var _doubleClickMode:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the user must double-click
		 * 	on the <code>EditableLabel</code> instance to edit the displayed text
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get doubleClickMode():Boolean {
			return _doubleClickMode;
		}
		public function set doubleClickMode(value:Boolean):void {
			_doubleClickMode = value;
			_clickEvtColl.removeAllEvents();
			var tpe:String = _doubleClickMode ? UIMouseEvent.DOUBLE_CLICK : UIMouseEvent.CLICK;
			_clickEvtColl.addEvent(_textCtrl, tpe, swapHandler);
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text displayed
		 * 	within the <code>EditableLabel</code> instance can be selected
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	<p>If <code>false</code>, the text displayed within the <code>EditableLabel</code>
		 * 	instance does not respond to selection commands from the mouse or keyboard
		 * 	and cannot be copied with the Copy command.</p>
		 * 
		 * 	@default true
		 */
		public function get selectable():Boolean {
			return _textCtrl.selectable;
		}
		public function set selectable(value:Boolean):void {
			_textCtrl.selectable = value;
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			$height = _textCtrl.height = _input.height = value;
			dispatchMetricsEvent();
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			$width = _textCtrl.width = _input.width = value;
			dispatchMetricsEvent();
		}
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the text is
		 * 	boldface (<code>true</code>), or not (<code>false</code>). 
		 * 
		 * 	@default false
		 */
		public function get boldFace():Boolean {
			return _textCtrl.boldFace;
		}
		public function set boldFace(value:Boolean):void {
			_textCtrl.boldFace = value;
		}
		
		/**
		 *  @private
		 */
		override public function set focusColor(value:*):void {
			$focusColor = _input.focusColor = value;
		}
		
		/**
		 *  Sets or gets the point size of text previously defined by the Look
		 * 	and Feel text format.
		 * 
		 *  @default The Look and Feel text format font size.
		 */
		public function get fontSize():* {
			return _textCtrl.fontSize;
		}
		public function set fontSize(value:*):void {
			_textCtrl.fontSize = _input.fontSize = value;
		}
		
		/**
		 * 	Sets or get the horizontal alignment of the text. Valid values are:
		 * 	<ul>
		 * 		<li><code>TextAlign.LEFT</code>,</li>
		 * 		<li><code>TextAlign.CENTER</code>,</li>
		 * 		<li><code>TextAlign.RIGHT</code>.</li>
		 * 	</ul>
		 * 
		 *	@default TextAlign.LEFT
		 */
		public function get textAlign():String {
			return _textCtrl.textAlign;
		}
		public function set textAlign(value:String):void {
			_textCtrl.textAlign = _input.textAlign = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *	A <code>Boolean</code> value that indicates whether a border is displayed
		 * 	around the <code>textControl</code> instance, to show text bounds,
		 * 	(<code>true</code>), or not (<code>false</code>). 
		 * 
		 * 	@default false
		 * 
		 * 	@see #textControl
		 */
		public function get showBorder():Boolean {
			return _textCtrl.showBorder;
		}
		public function set showBorder(value:Boolean):void {
			_textCtrl.showBorder = value;
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
			_textCtrl.finalize();
			_input.finalize();
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if($displayed) {
				unload();
				if (_input.focus) _input.focus = false;
			}
		}
		
		/**
		 *  Resets the editable label object.
		 */
		public function reset():void {
			_textCtrl.text = "";
			if(_input.focus) _input.focus = false;
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
			_input.lockLaf(lookAndFeel.getTextInputLaf(), true);
			_textCtrl.lockLaf(lookAndFeel.getTextLaf(), true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _clickEvtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number):void {
			_label = label;
			$width = width;
			$height = height;
			_clickEvtColl = new EventCollector();
			createControls();
			initLaf(EditableLabelUIRef);
			createEvents();
			spas_internal::setSelector(Selectors.EDITABLE_LABEL);
			spas_internal::isInitialized(1);
		}
		
		private function createControls():void {
			_textCtrl = new Text($width, $height);
			_textCtrl.text = _label;
			_textCtrl.selectable = false;
			_textCtrl.textField.doubleClickEnabled = true;
			_input = new TextInput();
			_input.verticalAlignment = VerticalAlignment.TOP;
			_textCtrl.target = _input.target = spas_internal::uioSprite;
			_textCtrl.display();
		}
		
		private function createEvents():void {
			doubleClickMode = true;
			$evtColl.addEvent(_input, UIOEvent.DISPLAYED, inputDisplayHandler);
		}
		
		private function swapHandler(e:Event):void {
			e.target == _textCtrl ? 
				swapControls(_textCtrl, _input) : swapControls(_input, _textCtrl);
		}
		
		private function swapControls(uio1:*, uio2:*):void {
			if (!_editable) return;
			_label = uio2.text = uio1.text;
			uio2.width = uio1.width;
			uio2.height = uio1.height;
			uio1.remove();
			uio2.display();
		}
		
		private function inputDisplayHandler(e:UIOEvent):void {
			_input.focus = true;
			$evtColl.addOneShotEvent(_input, TextEvent.TEXT_FOCUS_OUT, swapHandler);
		}
	}
}