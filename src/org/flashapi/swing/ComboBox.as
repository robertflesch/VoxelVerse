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
	// ComboBox.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.3.0, 05/03/2011 13:47
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.KeyObserverEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.list.DropListBase;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.plaf.libs.ComboBoxUIRef;
	import org.flashapi.swing.state.ButtonStateUtil;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.state.FontState;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ComboBox.png")]
	
	/**
	 * 	<img src="ComboBox.png" alt="ComboBox" width="18" height="18"/>
	 * 
	 * 	The <code>ComboBox</code> class contains a drop-down list from which the user
	 * 	can select a single value. Its functionality is very similar to that of the
	 * 	<code>SELECT</code> form element in HTML. The <code>ComboBox</code> can be
	 * 	edited, in which case the user can type entries into the <code>TextInput</code>
	 * 	portion of the <code>ComboBox</code> that are not in the list.
	 * 	
	 * 	<p>
	 * 		[<strong>Since SPAS 3.0 alpha 5.5, the <code>ListBox</code> class has been totally
	 * 		rewrotten for better performances. Please use the SPAS 3.0 Bug Manager to tell us
	 * 		about bugs you could find when using the new <code>ListBox</code> (version 3.0.0).
	 * 		</strong>]
	 * 	</p>
	 * 
	 * 	<p>As for all Listable objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>ComboBox</code> instance. Each item for <code>DataProvider</code>
	 * 	object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value</code> parameter of the
	 * 		<code>ComboBox.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter
	 * 		of the <code>ComboBox.addItem()</code> method,</li>
	 * 		<li><code>className:String</code>; the <code>className</code> parameter
	 * 		for the <code>ComboBox</code> item,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the icon rendered by the
	 * 		<code>ComboBox</code> item.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to
	 * 	a <code>ComboBox</code> instance:</p>
	 * 	<p>
	 * 		- using the <code>ComboBox.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var c:ComboBox = new ComboBox();
	 * 
	 * 			c.addItem("Label 1", myData1);
	 * 			c.addItem("Label 2", myData2);
	 * 			var li3:ListItem = c.addItem("Label 3", myData3);
	 * 			li3.item.setIcon("myIcon.jpg");
	 * 			var li4:ListItem = c.addItem("Label 4", myData4);
	 * 			li4.item.setIcon("myIcon.jpg");
	 * 
	 * 			c.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ComboBox.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var c:ComboBox = new ComboBox();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 			dp.addAll(  { label:"Label 1", data:myData1 },
	 * 						{ label:"Label 2", data:myData2 },
	 * 						{ label:"Label 3", data:myData3, icon:"myIcon.jpg" },
	 * 						{ label:"Label 4", data:myData4, icon:"myIcon.jpg" });
	 * 			c.dataProvider = dp;
	 * 
	 * 			c.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ComboBox.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item label="Label 1" data="myData1" /&gt;
	 *								&lt;item label="Label 2" data="myData2" /&gt;
	 *								&lt;item label="Label 3" data="myData3" icon="myIcon.jpg" /&gt;
	 * 								&lt;item label="Label 4" data="myData4" icon="myIcon.jpg" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var c:ComboBox = new ComboBox();
	 * 			c.xmlQuery = request;
	 * 
	 * 			c.display();
	 * 		</listing>
	 * 	</p>
	 * 
	 * 	<p><strong><code>ComboBox</code> instances support the following CSS properties:
	 * 	</strong></p>
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
	 * 			<td>A valid color keywords, a CSS hexadecimal color value
	 * 			(e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>fontColor</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">font-size</code></td>
	 * 			<td>Sets the font size of the object.</td>
	 * 			<td>Recognized values are positive integers.</td>
	 * 			<td><code>fontSize</code></td>
	 * 			<td><code>Properties.FONT_SIZE</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-style</code></td>
	 * 			<td>Sets the font style of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">italic</code>.</td>
	 * 			<td><code>italicized</code></td>
	 * 			<td><code>Properties.FONT_STYLE</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-weight</code></td>
	 * 			<td>Sets the font weight of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">bold</code>.</td>
	 * 			<td><code>boldFace</code></td>
	 * 			<td><code>Properties.FONT_WEIGHT</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 *  @includeExample ComboBoxExample.as
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.list.ALM#xmlQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 * 	@see org.flashapi.swing.plaf.ComboBoxUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ComboBox extends DropListBase implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ComboBox</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	label	Text to display within the <code>ComboBox</code> instance.
		 * 	@param	width	The width of the <code>ComboBox</code> instance, in pixels.
		 * 	@param	size	The number of items displayed within the drop-down list
		 * 					object.
		 */
		public function ComboBox(label:String = "", width:Number = 150, size:uint = 5) {
			super(label, width, size, "ComboBox");
			initObj();
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
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>boldFace</code> property.
		 * 
		 * 	@see #boldFace
		 */
		protected var $boldFace:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that specifies whether the text font weight
		 * 	is bold (<code>true</code>), or not (<code>false</code>).
		 * 	
		 * 	@default false
		 * 
		 * 	@see #boldFaces
		 */
		public function get boldFace():Boolean {
			return $boldFace;
		}
		public function set boldFace(value:Boolean):void {
			$boldFace = $boldFaces.up = $boldFaces.down = $boldFaces.over =
			$boldFaces.disabled = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>boldFaces</code> property.
		 * 
		 * 	@see #boldFaces
		 */
		protected var $boldFaces:FontState;
		/**
		 *  A <code>FontState</code> object that specifies the text font weight for each 
		 * 	state of the combobox.
		 * 
		 * 	@see #boldFace
		 */
		public function get boldFaces():FontState {
			return $boldFaces;
		}
		public function set boldFaces(value:FontState):void {
			$boldFaces = value;
			setRefresh();
		}
		
		private var _buttonMode:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the drop-down 
		 * 	list is called by only clicking the arrow button (<code>true</code>),
		 * 	or the body of the <code>ComboBox</code> itself (<code>false</code>).
		 * 
		 * 	@default false
		 */
		override public function get buttonMode():Boolean {
			return _buttonMode;
		}
		override public function set buttonMode(value:Boolean):void {
			_buttonMode = value;
			$evtColl.removeAllEvents();
			setButtonBehaviour();
			refresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set cornerRadius(value:Number):void {
			spas_internal::lafDTO.cornerRadius = super.cornerRadius = value;
		}
		
		private var _editable:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>ComboBox</code>
		 * 	instance can be edited by the user (<code>true</code>) or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #editedLabel
		 */
		public function get editable():Boolean {
			return _editable;
		}
		public function set editable(value:Boolean):void {
			_editable = value;
		}
		
		private var _editedLabel:String = "";
		/**
		 * 	Returns the label displayed by the <code>TextInput</code> instance 
		 * 	when the <code>editable</code> property is <code>true</code>.
		 * 
		 * 	@default ""
		 * 
		 * 	@see #editable
		 */
		public function get editedLabel():String {
			if(_textInput.displayed) return _textInput.text;
			else return _editedLabel;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontSize</code> property.
		 * 
		 * 	@see #fontSize
		 */
		protected var $fontSize:Number;
		/**
		 * 	Sets or gets the size of the <code>ComboBox</code> text, in pixels.
		 * 
		 * 	@see #fontSizes
		 */
		public function get fontSize():* {
			return $fontSize;
		}
		public function set fontSize(value:*):void {
			$fontSizes.up = $fontSizes.down = $fontSizes.over =
			$fontSizes.disabled = $fontSize = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontSizes</code> property.
		 * 
		 * 	@see #fontSizes
		 */
		protected var $fontSizes:FontState;
		/**
		 *  A <code>FontState</code> object that specifies the size of the
		 * 	text for each state of the <code>ComboBox</code> instance.
		 * 
		 * 	@see #fontSize
		 */
		public function get fontSizes():FontState {
			return $fontSizes;
		}
		public function set fontSizes(value:FontState):void {
			$fontSizes = value;
			setRefresh();
		}
		
		private var _greyTint:Boolean = false;
		/**
		 *  A <code>Boolean</code> value that indicates whether the label of the 
		 * 	combobox is rendered with a grey tinted color (<code>true</code>), 
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get greyTint():Boolean {
			return _greyTint;
		}
		public function set greyTint(value:Boolean):void {
			_greyTint = value;
			setRefresh();
		}
		
		private var _italicized:Boolean;
		/**
		 * 	Returns a <code>Boolean</code> that indicates whether the label of the 
		 * 	combobox is italic (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get italicized():Boolean {
			return _italicized;
		}
		public function set italicized(value:Boolean):void {
			_italicized = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontColor</code> property.
		 * 
		 * 	@see #fontColor
		 */
		protected var $fontColor:*;
		/**
		 *  Sets or gets the text color for this <code>ComboBox</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #fontColors
		 */
		public function get fontColor():* {
			return $fontColor;
		}
		public function set fontColor(value:*):void {
			var val:* = value == StateObjectValue.NONE ? StateObjectValue.NONE : getColor(value);
			$fontColor = $fontColors.up = $fontColors.down =
			$fontColors.over = $fontColors.disabled = $fontColors.selected = val;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontColors</code> property.
		 * 
		 * 	@see #fontColors
		 */
		protected var $fontColors:ColorState;
		/**
		 *	A <code>ColorState</code> object. The <code>fontColors</code> property sets
		 * 	and gets the text color of the combobox for each state. <code>ColorState</code>
		 * 	instances define five different states:
		 * 	<ul>
		 * 		<li>ColorState.disabled</li>
		 * 		<li>ColorState.selected</li>
		 * 		<li>ColorState.down</li>
		 * 		<li>ColorState.over</li>
		 *  	<li>ColorState.up</li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are the same as
		 *  valid values for the color property. The default value for each state is
		 *  <code>StateObjectValue.NONE</code>. To unset a color state value, use the
		 * 	<code>StateObjectValue.NONE</code> constant.</p>
		 * 
		 * 	<p>When you use the <code>fontColors</code> property, the <code>fontColor</code>
		 * 	property is automatically set to <code>StateObjectValue.NONE</code>.</p>
		 *  
		 * 	@see #fontColor
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get fontColors():ColorState {
			return $fontColors;
		}
		public function set fontColors(value:ColorState):void {
			spas_internal::lafDTO.fontColors = $fontColors = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			spas_internal::lafDTO.width =
			IUIObject($itemsList).width = super.width = value;
			setButtonProperties();
		}
		
		/**
		 * 	@private
		 */
		override public function set label(value:String):void {
			$label = value;
			setLabel();
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
			if(!$displayed) {
				move(x, y);
				createUIObject();
				refresh();
				doStartEffect();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			$itemsList.remove();
			$listContainer.remove();//$stage.removeChild(listContainer);
			UIDescriptor.getUIManager().topLevelManager.spas_internal::removeObject($listContainer);
			if($displayed) unload();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			spas_internal::lafDTO.fontColors = null;
			_icon.finalize();
			$listContainer.removeElements();
			$itemsList.finalize();
			$listContainer.finalize();
			_textInput.finalize();
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
		override protected function createItemsList():void {
			$itemsList = new ListBox($width, $size);
			ListBox($itemsList).unselectEnabled = false;
			$evtColl.addEvent($itemsList, KeyObserverEvent.ENTER_KEY_UP, onEnterKeyUp);
			$evtColl.addEvent($itemsList, KeyObserverEvent.ESCAPE_KEY_UP, onEscapeKeyUp);
		}
		
		/**
		 * 	@private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			refresh();
			setButtonProperties();
		}
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			setLafTarget(spas_internal::uioSprite);
			lookAndFeel.drawOutState();
			setIconState();
			fixButtonPosition();
			setLabel();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_lafFmt = lookAndFeel.getTextFormat().clone();
			IUIObject($itemsList).lockLaf(lookAndFeel.getListLaf(), true);
			_textInput.lockLaf(lookAndFeel.getTextInputLaf(), true);
			initTextFormat();
			_icon.setBrush(lookAndFeel.getIcon(), _iconBounds);
			initIconColors();
			setIconColors(true);
		}
		
		/**
		 * @private
		 */
		override protected function resetAppearence():void {
			setIconState();
		}
		
		/**
		 * @private
		 */
		override protected function setLabel():void {
			_fmt.italic = _italicized;
			setLabelProperties();
			var t:TextField = spas_internal::textRef;
			var bd:Number = lookAndFeel.getButtonDelay();
			var tp:Number = lookAndFeel.getTextPadding();
			//t.border = true;
			t.multiline = false;
			t.text = $defaultLabel == null ? $label : $defaultLabel;
			t.setTextFormat(_fmt);
			t.height = lineHeight;
			t.y = ($height-t.height)/2;
			var W:Number = _icon.x + _iconBounds.width + bd;
			var isBtnToRight:Boolean = buttonPosition == DropButtonPosition.RIGHT;
			t.x = isBtnToRight ? tp : W;
			t.width = isBtnToRight ? _button.x-bd-tp : $width-tp-W;
			t = null;
		}
		
		/**
		 * @private
		 */
		override protected function setIconColors(defineStateIcon:Boolean):void {
			if (_icon.brush is StateIcon) {
				if(defineStateIcon) $stateIcon = _icon.brush as StateIcon;
				(_icon.brush as StateBrush).colors = $iconColors;
			} else {
				if(defineStateIcon) $stateIcon = null;
				_icon.brush.color = $iconColors.up;
			}
			setIconState();
		}
		
		/**
		 * @private
		 */
		/*override protected function initListForDisplay():void {
			ListBox($itemsList).vscrollValue = 0;
		}*/
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//--- TODO:
		//private var _emphasized:Boolean;
		private var _fmt:UITextFormat;
		private var _lafFmt:UITextFormat;
		private var _textInput:TextInput;
		private var _icon:Icon;
		private var _button:Sprite;
		private var _iconBounds:Rectangle;
		private static const BTN_BOUNDS:Number = 22;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_iconBounds = new Rectangle(0, 0, BTN_BOUNDS, BTN_BOUNDS);
			createHitArea();
			$fontColors = new ColorState(this);
			spas_internal::lafDTO.fontColors = $fontColors;
			$boldFaces = new FontState(this);
			$fontSizes = new FontState(this);
			_textInput = new TextInput();
			_icon = new Icon();
			_icon.target = _textInput.target = spas_internal::uioSprite;
			_icon.display();
			createButton();
			initLaf(ComboBoxUIRef);
			setButtonBehaviour();
			initTextField();
			spas_internal::setSelector(Selectors.COMBOBOX);
			spas_internal::isInitialized(1);
		}
		
		private function createButton():void {
			_button = new Sprite();
			spas_internal::uioSprite.addChild(_button);
		}
		
		private function fixButtonPosition():void {
			var pt:Point = lookAndFeel.getButtonPosition();
			_button.x = pt.x;
			_button.y = pt.y;
			_icon.move(pt.x, ($height-_iconBounds.height) /2);
		}
		
		private function setButtonBehaviour():void {
			if(!_buttonMode) {
				$evtColl.addEvent($hitArea, MouseEvent.MOUSE_OVER, mouseOverHandler);
				$evtColl.addEvent($hitArea, MouseEvent.MOUSE_OUT, mouseOutHandler);
				$evtColl.addEvent($hitArea, MouseEvent.MOUSE_DOWN, comboBoxMouseDownHandler);
				$evtColl.addEvent($hitArea, MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				$evtColl.addEvent(_button, MouseEvent.MOUSE_OVER, mouseOverHandler);
				$evtColl.addEvent(_button, MouseEvent.MOUSE_OUT, mouseOutHandler);
				$evtColl.addEvent(_button, MouseEvent.MOUSE_DOWN, comboBoxMouseDownHandler);
				$evtColl.addEvent(_button, MouseEvent.MOUSE_UP, mouseUpHandler);
				if(_editable) $evtColl.addEvent($hitArea, MouseEvent.MOUSE_DOWN, editHandler);
			}
		}
		
		private function pressOutsideHandler(e:UIMouseEvent):void {
			editionIsFinished();
		}
		
		private function validateHandler(e:TextEvent):void {
			editionIsFinished();
		}
		
		private function editedTextChangedHandler(e:TextEvent):void {
			_editedLabel = $label = _textInput.text;
		}
		
		private function editionIsFinished():void {
			_editedLabel = $label = _textInput.text;
			setLabel();
			_textInput.remove();
			spas_internal::textRef.visible = true;
			this.dispatchEvent(new ListEvent(ListEvent.EDITED));
			$evtColl.removeEvent(_textInput, UIMouseEvent.PRESS_OUTSIDE, pressOutsideHandler);
			$evtColl.removeEvent(_textInput, TextEvent.EDITED, editedTextChangedHandler);
			$evtColl.removeEvent(_textInput, TextEvent.VALIDATED, validateHandler);
		}
		
		private function editHandler(e:MouseEvent):void {
			if($active && $enabled) {
				spas_internal::textRef.visible = false;
				_textInput.editable = true;
				_textInput.text = $label;
				_textInput.width = spas_internal::textRef.width;
				_textInput.display(spas_internal::textRef.x, spas_internal::textRef.y);
				if($autoFocus) _textInput.focus = true;
				$evtColl.addEvent(_textInput, UIMouseEvent.PRESS_OUTSIDE, pressOutsideHandler);
				$evtColl.addEvent(_textInput, TextEvent.EDITED, editedTextChangedHandler);
				$evtColl.addEvent(_textInput, TextEvent.VALIDATED, validateHandler);
				if($itemsList.displayed) hideList();
			}
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if ($active && $enabled) drawBoxState(ButtonState.OVER);
			setIconState();
		}
		
		private function mouseOutHandler(e:MouseEvent):void { 
			if ($active && $enabled) drawBoxState();
			setIconState();
		}
		
		private function mouseUpHandler(e:MouseEvent):void { 
			if ($active && $enabled) {
				drawBoxState(ButtonState.OVER);
				if (!$isListHidden) 
					$evtColl.addEvent($stage, MouseEvent.MOUSE_DOWN, dropListMouseOutsideHandler);
			}
			setIconState();
		}
		
		private function comboBoxMouseDownHandler(e:MouseEvent):void { 
			if ($active && $enabled) {
				drawBoxState(ButtonState.DOWN);
				$itemsList.displayed ? hideList() : showList();
			}
			setIconState();
		}
		
		private function drawBoxState(state:String = "up"):void {//ButtonState.UP
			setLafTarget(spas_internal::uioSprite);
			switch(state) {
				case ButtonState.UP :
					lookAndFeel.drawOutState();
					break;
				case ButtonState.OVER :
					lookAndFeel.drawOverState();
					break;
				case ButtonState.DOWN :
					lookAndFeel.drawPressedState();
					break;
			}
			setLabelProperties(state);
		}
		
		//*******************************************
		
		private function setLafTarget(tgt:Sprite):void {
			spas_internal::lafDTO.currentTarget = tgt;
		}
		
		//*******************************************
		
		private function setLabelProperties(state:String = "up"):void {//ButtonState.UP
			
			if (_greyTint) _fmt.color = lookAndFeel.getGrayTintColor();
			else {
				var c:Object = ButtonStateUtil.getStateProperty($fontColors, state);
				_fmt.color = c == StateObjectValue.NONE ? getColor(_lafFmt.color) : c;
			}
			
			var b:Object = ButtonStateUtil.getStateProperty($boldFaces, state);
			_fmt.bold = b==StateObjectValue.NONE ? _lafFmt.bold : b;
			
			var fs:Object = ButtonStateUtil.getStateProperty($fontSizes, state);
			_fmt.size = fs==StateObjectValue.NONE ? _lafFmt.size : fs;
			
			spas_internal::textRef.setTextFormat(_fmt);
		}
		
		private function initTextFormat():void {
			//iconDelay = lookAndFeel.getIconDelay();
			_fmt = _lafFmt.clone();
			_italicized = _fmt.italic;
			$fontColors.up = fontColor = _fmt.color;
			$fontSize = $fontSizes.up = _fmt.size;
			$boldFace = $boldFaces.up = _fmt.bold;
		}
		
		private function initTextField():void {
			spas_internal::textRef = new TextField();
			spas_internal::textRef.selectable =
				spas_internal::textRef.mouseWheelEnabled = false;
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			spas_internal::uioSprite.addChild($hitArea);
		}
		
		private function setButtonProperties():void {
			drawButton();
			var hz:Figure = Figure.setFigure($hitArea);
			hz.clear();
			hz.beginFill(0xff0000, 0);
			var bd:Number = lookAndFeel.getButtonDelay();
			if(!_buttonMode) hz.drawRectangle(0, 0, $width, $height);
			else {
				buttonPosition == DropButtonPosition.RIGHT ?
					hz.drawRectangle(0, 0, _button.x - bd, height) :
					hz.drawRectangle(_button.x + _button.width + bd, 0, width, height);
			}
			hz.endFill();
		}
		
		private function drawButton():void {
			with (_button.graphics) {
				clear();
				beginFill(0, 0);
				drawRect(0, 0, BTN_BOUNDS, $height);
				endFill();
			}
		}
		
		private function onEnterKeyUp(e:KeyObserverEvent):void {
			$label = $itemsList.value;
			$value = $itemsList.value;
			$data = $itemsList["data"];
			$listItem = $itemsList.listItem;
			var ind:int = $itemsList["index"];
			spas_internal::setIndex(ind);
			$selectedIndex = ind;
			$validateChangedHandler = true;
			hideList();
			resetAppearence();
		}
		
		private function onEscapeKeyUp(e:KeyObserverEvent):void {
			hideList();
			resetAppearence();
		}
	}
}