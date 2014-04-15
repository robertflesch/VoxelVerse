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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// ATM.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 08/04/2010 09:48
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import org.flashapi.swing.border.AbstractBorder;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.BoxHelp;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.CSSGateway;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.net.UILoader;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched each time the text object changes due to keyboard actions.
	 *
	 *  @eventType org.flashapi.swing.event.TextEvent.EDITED
	 */
	[Event(name = "edited", type = "org.flashapi.swing.event.TextEvent")]
	
	/**
	 *  Dispatched each time the text object is active and the user presses the
	 * 	"enter" key.
	 *
	 *  @eventType org.flashapi.swing.event.TextEvent.VALIDATED
	 */
	[Event(name = "validated", type = "org.flashapi.swing.event.TextEvent")]
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>ATM</code> class (for Abstract Text Methods) is the base class for 
	 * 	all SPAS 3.0 <code>Text</code> classes.
	 * 
	 * 	<p>SPAS 3.0 <code>Text</code> objects can display an icon on their face, like
	 * 	buttons for example. Icons can be displayed on the right-hand or on the left-hand  
	 * 	side of the text. Use the <code>UIObject.horizontalGap</code> property to set
	 * 	the distance between the icon and the text field. The default value for 
	 * 	the distance between the text and the icon is <code>5</code> pixels.</p>
	 * 
	 * <p><strong><code>ATM</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
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
	 * 			<td><code class="css">text-align</code></td>
	 * 			<td>Sets the alignment of the text displayed within this object.</td>
	 * 			<td>Valid values are <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code>.</td>
	 * 			<td><code>textAlign</code></td>
	 * 			<td><code>Properties.TEXT_ALIGN</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">vertical-align</code></td>
	 * 			<td>Specifies the vertical alignment of this object.</td>
	 * 			<td>Possible values are <code class="css">top</code>, <code class="css">middle</code>
	 * 			and <code class="css">bottom</code>.</td>
	 * 			<td><code>verticalAlignment</code></td>
	 * 			<td><code>Properties.VERTICAL_ALIGN</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ATM extends AbstractBorder implements Border {
		
		//--> TODO: check paddingLeft and paddingRight props for all text objects
		//--> TODO: Use defaultTextFormat instead of setTextFormat
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ATM</code> object.
		 */
		public function ATM() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _alt:String = null;
		/**
		 * 	A <code>String</code> that represents the alternate text property of the
		 * 	text object. This text is displayed on the face of a <code>BoxHelp</code>
		 * 	instance. When <code>null</code>, the boxhelp is not active.
		 * 
		 * 	@default null
		 * 
		 * 	@see #boxhelp
		 * 	@see org.flashapi.swing.BoxHelp
		 */
		public function get alt():String {
			return _alt;
		}
		public function set alt(value:String):void {
			_alt = value;
			if (_alt != null) {
				$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.ROLL_OVER, rollOverHandler);
				$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.ROLL_OUT, rollOutHandler);
				_boxhelp.label = _alt;
			} else {
				$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.ROLL_OVER, rollOverHandler);
				$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.ROLL_OUT, rollOutHandler);
			}
		}
		
		/**
		 * 	When <code>true</code> and the text field has not the focus, Flash Player
		 * 	highlights the selection in the text field. When <code>false</code> and the
		 * 	text field has the focus, Flash Player does not highlight the selection
		 * 	in the text field.
		 * 
		 * 	@default fasle
		 */
		public function get alwaysShowSelection():Boolean {
			return spas_internal::textRef.alwaysShowSelection;
		}
		public function set alwaysShowSelection(value:Boolean):void {
			spas_internal::textRef.alwaysShowSelection = value;
		}
		
		/**
		 * 	Returns a reference to the <code>BoxHelp</code> instance used by
		 * 	this text object to display the text specified by the <code>alt</code>
		 * 	property.
		 * 
		 * 	@see #alt
		 */
		public function get boxhelp():BoxHelp {
			return _boxhelp;
		}
		
		/**
		 *  @private
		 */
		override public function get backgroundWidth():Number {
			var w:Number = spas_internal::icon != null ? spas_internal::icon.width : 0;
			var gp:Number = spas_internal::icon != null ? $horizontalGap : 0;
			return isNaN($width) || $embedIcon ?
				spas_internal::textRef.width + w + gp + $padL + $padR : $width - w - gp;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>boldFace</code> property.
		 * 
		 * 	@see #boldFace
		 */
		protected var $boldFace:Boolean = undefined;
		/**
		 *	A <code>Boolean</code> value that specifies whether the text is
		 * 	boldface (<code>true</code>), or not (<code>false</code>). 
		 * 
		 * 	@default false
		 */
		public function get boldFace():Boolean {
			return $textFormat.bold;
		}
		public function set boldFace(value:Boolean):void {
			$textFormat.bold = $boldFace = value;
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		/**
		 *  The index of the insertion point (caret) position. If no insertion point
		 * 	is displayed, the value is the position the insertion point would be if
		 * 	you would restore focus to the field (typically where the insertion point
		 * 	was the last time, or <code>0</code> if the field has not had focus).
		 * 	
		 * 	<p>Selection span indexes are zero-based (for example, the first position
		 * 	is <code>0</code>, the second position is <code>1</code>, and so on).</p>
		 */
		public function get caretIndex():int {
			return spas_internal::textRef.caretIndex;
		}
		
		/**
		 * 	A <code>Boolean</code> value that specifies whether extra white space
		 * 	(spaces, line breaks, and so on) in a text field with HTML text should
		 * 	be removed.
		 * 
		 * 	<p>You must set the <code>condenseWhite</code> property before using
		 * 	<code>htmlText</code> property.</p>
		 * 	
		 * 	@default false
		 */
		public function get condenseWhite():Boolean {
			return spas_internal::textRef.condenseWhite;
		}
		public function set condenseWhite(value:Boolean):void {
			spas_internal::textRef.condenseWhite = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>editable</code> property.
		 * 
		 * 	@see #editable
		 */
		protected var $editable:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the user can edit
		 * 	the text (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get editable():Boolean {
			return $editable;
		}
		public function set editable(value:Boolean):void {
			setEditableMode(value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>embedIcon</code> property.
		 * 
		 * 	@see #embedIcon
		 */
		protected var $embedIcon:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the icon should
		 * 	be displayed within (embeded) the text field (<code>true</code>), or 
		 * 	next to it (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get embedIcon():Boolean {
			return $embedIcon;
		}
		public function set embedIcon(value:Boolean):void {
			$embedIcon = value;
			setRefresh();
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text object
		 * 	has the focus (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get focus():Boolean {
			return ($stage.focus == spas_internal::textRef);
		}
		public function set focus(value:Boolean):void {
			$stage.focus = value ? spas_internal::textRef : null;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontColor</code> property.
		 * 
		 * 	@see #fontColor
		 */
		protected var $fontColor:* = NaN;
		/**
		 *  Sets or gets the color of text previously defined by the Look and Feel
		 * 	text format. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	<p>In <code>NaN</code> the color of the text is defined by the current
		 * 	Look and Feel.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 *  @default NaN
		 */
		public function get fontColor():* {
			return $textFormat.color;
		}
		public function set fontColor(value:*):void {
			/*var c:uint;
			switch(true) {
				case (value == Color.DEFAULT): _fontColor = NaN; c = lookAndFeel.getTextFormat().color; break;
				case isNaN(value): c = lookAndFeel.getTextFormat().color; break;
				default: c = getColor(value);
			}
			_textFormat.color = c;
			needsTextFormatUpdate = true;
			setRefresh();*/
			$fontColor = getColor(value);
			$textFormat.color = $fontColor;
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontSize</code> property.
		 * 
		 * 	@see #fontSize
		 */
		protected var $fontSize:Number = NaN;
		/**
		 *  Sets or gets the point size of text previously defined by the Look
		 * 	and Feel text format.
		 * 
		 *  @default The Look and Feel text format font size.
		 */
		public function get fontSize():* {
			return $textFormat.size;
		}
		public function set fontSize(value:*):void {
			$textFormat.size = $fontSize = value;
			$needsTextFormatUpdate = true;
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
		 * 	A <code>Boolean</code> value that indicates whether the text object
		 * 	renders HTML tags (<code>true</code>), or not (<code>false</code>).
		 * 
		 *  @default false
		 */
		public function get html():Boolean {
			return $html;
		}
		public function set html(value:Boolean):void {
			$html = value;
			$needsTextUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>italicized</code> property.
		 * 
		 * 	@see #italicized
		 */
		protected var $italicized:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text object
		 * 	is italicized (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get italicized():Boolean {
			return $italicized;
		}
		public function set italicized(value:Boolean):void {
			$textFormat.italic = $italicized = value;
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>text</code> property.
		 * 
		 * 	@see #text
		 */
		protected var $text:String = null;
		/**
		 * 	Sets or gets the plain text that is displayed by the text control.
		 * 	If <code>null</code>, no text is displayed.
		 * 
		 * 	@default null
		 */
		public function get text():String {
			return $text;
		}
		public function set text(value:String):void {
			$text = (value == null) ? "" : value;
			$needsTextUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>labelPlacement</code> property.
		 * 
		 * 	@see #labelPlacement
		 */
		protected var $labelPlacement:String = LabelPlacement.RIGHT;
		[Inspectable(enumeration="left,right", defaultValue="right", name="labelPlacement")]
		/**
		 * 	Position of the text in relation to the specified icon. Valid values are
		 *  <code>LabelPlacement.RIGHT</code> or <code>LabelPlacement.LEFT</code>.
		 * 
		 * 	@default LabelPlacement.RIGHT
		 */
		public function get labelPlacement():String {
			return $labelPlacement;
		}
		public function set labelPlacement(value:String):void {
			$labelPlacement = value;
			$needsHorizontalIconUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	The maximum number of characters that the text field can contain, as
		 * 	entered by a user. A script can insert more text than <code>maxChars</code>
		 * 	allows; the <code>maxChars</code> property indicates only how much text a
		 * 	user can enter. If the value of this property is <code>0</code>, a user
		 * 	can enter an unlimited amount of text.
		 * 
		 * 	@default 0
		 */
		public function get maxChars():int {
			return spas_internal::textRef.maxChars;
		}
		public function set maxChars(value:int):void {
			spas_internal::textRef.maxChars = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether Flash Player should
		 * 	automatically scroll multiline text fields when the user clicks a text
		 * 	and rolls the mouse wheel (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get mouseWheelEnabled():Boolean {
			return spas_internal::textRef.mouseWheelEnabled;
		}
		public function set mouseWheelEnabled(value:Boolean):void {
			spas_internal::textRef.mouseWheelEnabled = value;
		}
		
		/**
		 * 	Indicates the set of characters that a user can type into the text field.
		 * 	<ul>
		 * 		<li>If <code>null</code>, you can enter any character.</li>
		 * 		<li>If it is an empty string, you cannot enter characters.</li>
		 * 		<li>If it is a string of characters, you can enter only characters
		 * 		specified by this string.</li>
		 * 	</ul>
		 * 
		 * 	<p>The string is scanned from left to right. You can specify a range by
		 * 	using the hyphen (<code>-</code>) character. This only restricts user
		 * 	interaction; a script may put any text into the text field. This property 
		 * 	does not synchronize with the "embed font" options in the Property inspector.</p>
		 * 
		 * 	<p>If the string begins with a caret (<code>^</code>) character, all characters
		 * 	are initially accepted and succeeding characters in the string are excluded
		 * 	from the set of accepted characters. </p>
		 * 
		 * 	<p>See <a href="http://livedocs.adobe.com/labs/flex/3/langref/flash/text/TextField.html#restrict">TextField.restrict</a>
		 * 	in the 'ActionScript 3.0 Language and Components Reference' for examples.</p>
		 * 
		 * 	@default null
		 */
		public function get restrict():String {
			return spas_internal::textRef.restrict;
		}
		public function set restrict(value:String):void {
			spas_internal::textRef.restrict = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selectable</code> property.
		 * 
		 * 	@see #selectable
		 */
		protected var $selectable:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text displayed
		 * 	within the text object can be selected (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	<p>If <code>false</code>, the text displayed within the text object does 
		 * 	not respond to selection commands from the mouse or keyboard and cannot 
		 * 	be copied with the Copy command.</p>
		 * 
		 * 	@default true
		 */
		public function get selectable():Boolean {
			return $selectable;
		}
		public function set selectable(value:Boolean):void {
			$selectable = value;
			if(!$editable) spas_internal::textRef.selectable = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textAlign</code> property.
		 * 
		 * 	@see #textAlign
		 */
		protected var $textAlign:String = undefined;
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
			return $textFormat.align;
		}
		public function set textAlign(value:String):void {
			$textFormat.align = $textAlign = value;
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textFormat</code> property.
		 * 
		 * 	@see #textFormat
		 */
		protected var $textFormat:UITextFormat;
		/**
		 *  Sets or gets the text format of the text object, previously defined
		 * 	by the Look and Feel text format.
		 * 
		 *  @default The default Look and Feel text format.
		 */
		public function get textFormat():UITextFormat {
			return $textFormat;
		}
		public function set textFormat(value:UITextFormat):void {
			$textFormat = value;
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>verticalAlignment</code> property.
		 * 
		 * 	@see #verticalAlignment
		 */
		protected var $vAlignment:String = VerticalAlignment.MIDDLE;
		/**
		 * 	Sets or get the vertical alignment of the icon and the text within
		 * 	the text object. Valid values are:
		 * 	<ul>
		 * 		<li>VerticalAlignment.TOP,</li>
		 * 		<li>VerticalAlignment.MIDDLE,</li>
		 * 		<li>VerticalAlignment.BOTTOM.</li>
		 * 	</ul>
		 * 
		 * 	@default VerticalAlignment.MIDDLE
		 */
		public function get verticalAlignment():String {
			return $vAlignment;
		}
		public function set verticalAlignment(value:String):void {
			$vAlignment = value;
			$needsVerticalIconUpdate = true;
			if(spas_internal::icon != null) setVerticalAlignment();
		}
		
		/**
		 * @private
		 */
		override public function set width(value:Number):void {
			spas_internal::metricsChanged = $needsHorizontalIconUpdate = true;
			super.width = value;
		}
		
		/**
		 * @private
		 */
		override public function set height(value:Number):void {
			spas_internal::metricsChanged = $needsVerticalIconUpdate = true;
			super.height = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Specifies whether the <code>TextField</code> instance within the
		 * 	text object has a border (<code>true</code>), or not
		 * 	(<code>false</code>).
		 */
		public function get showBorder():Boolean {
			return spas_internal::textRef.border;
		}
		public function set showBorder(value:Boolean):void {
			spas_internal::textRef.border = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontFace</code> property.
		 * 
		 * 	@see #fontFace
		 */
		protected var $fontFace:String;
		/**
		 * 	Sets or gets the name of the font for text in this text format,
		 * 	previously defined by the Look and Feel text format, as a string.
		 * 
		 *  @default The Look and Feel text format font name.
		 */
		public function get fontFace():String {
			return $fontFace;
		}
		public function set fontFace(value:String):void {
			$fontFace = value;
			if (value == null) $textFormat.font = lookAndFeel.getTextFormat().font;
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Inserts a the text, specified as a string by the <code>value</code> parameter,
		 * 	at the selected index.
		 * 
		 * 	@param	value	The text to insert at the specified index.
		 * 	@param	index	The zero-based index value for the start position of the
		 * 					text insertion.
		 */
		public function addTextAt(value:String, index:int = 0):void {
			var txt:String = spas_internal::textRef.text;
			var before:String = txt.substr(0, index);
			var after:String = txt.substr(index);
			$text = before + value + after;
			$needsTextUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	Removes the enrire text from the text object without redrawing it.
		 */
		public function clear():void {
			$text = spas_internal::textRef.text = "";
		}
		
		/**
		 *  Returns a <code>String</code> that represent a copy of the text specified
		 * 	by current selection.
		 * 
		 * 	@return	The currently selected text.
		 * 
		 * 	@see #setSelection()
		 * 	@see #selectAll()
		 */
		public function getSelectedText():String {
			return spas_internal::textRef.text.substring(
				spas_internal::textRef.selectionBeginIndex,
				spas_internal::textRef.selectionEndIndex);
		}
		
		/**
		 * 	Replaces the current selection with the text contained within the one
		 * 	specified by the <code>value</code> parameter. The text is inserted at
		 * 	the position of the current selection, using the current default
		 * 	character format and default paragraph format. The text is not treated
		 * 	as HTML.
		 * 
		 * 	<p>You can use the <code>replaceSelectedText()</code> method to insert
		 * 	and delete text without disrupting the character and paragraph formatting 
		 * 	of the rest of the text.</p>
		 * 
		 * 	<p><strong>Note:</strong> This method will not work if a style sheet is
		 * 	applied to the text object.</p>
		 * 
		 * 	@param	value	The string used to replace the currently selected text.
		 * 
		 * 	@throws Error	This method cannot be used on a text field with a style sheet.
		 * 
		 * 	@see #replaceText()
		 */
		public function replaceSelectedText(value:String):void {
			//---> TextField.replaceSelectedText("") doesn't work !
			//spas_internal::textRef.replaceSelectedText(value);
			spas_internal::textRef.replaceText(spas_internal::textRef.selectionBeginIndex, spas_internal::textRef.selectionEndIndex, value);
			//updateTextFormat();
		}
		
		/**
		 * 	Replaces the range of characters, specified by the <code>beginIndex</code> and
		 * 	<code>endIndex</code> parameters, by the text defined by the <code>newText</code>.
		 * 
		 * 	<p><strong>Note:</strong> This method will not work if a style sheet is applied
		 * 	to the text field.</p>
		 * 
		 * 	@param	beginIndex	The zero-based index value for the start position of the
		 * 						replacement range.
		 * 	@param	endIndex	The zero-based index value for the end position of the
		 * 						replacement range.
		 * 	@param	newText		The text used to replace the specified range of characters. 
		 * 
		 * 	@throws Error	This method cannot be used on a text field with a style sheet.
		 * 
		 * 	@see #replaceSelectedText()
		 */
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void {
			spas_internal::textRef.replaceText(beginIndex, endIndex, newText);
			//updateTextFormat();
		}
		
		/**
		 * 	Selects and highlights the entire text displayed within this text object.
		 * 
		 * 	@see #setSelection()
		 * 	@see #getSelectedText()
		 */
		public function selectAll():void {
			spas_internal::textRef.setSelection(0, spas_internal::textRef.length);
			$stage.focus = spas_internal::textRef;
		}
		
		/**
		 * 	Selects the text for which the index values of the first and last 
		 * 	characters are specified by the <code>beginIndex</code> and <code>endIndex</code>
		 * 	parameters. If both parameter values are the same, this method sets the  
		 * 	insertion point as if you just set the <code>caretIndex</code> property.
		 * 
		 * 	@param	beginIndex	The zero-based index value of the first character in the
		 * 						selection (e.g, the first character is <code>0</code>,
		 * 						the second character is <code>1</code>, and so on).
		 * 	@param	endIndex	The zero-based index value of the last character in the
		 * 						selection.
		 */
		public function setSelection(beginIndex:int, endIndex:int):void {
			spas_internal::textRef.setSelection(beginIndex, endIndex);
		}
		
		/**
		 * 	Clears an icon displayed (drawn) by using the <code>drawIcon()</code>
		 * 	method.
		 * 
		 * 	@see #drawIcon()
		 */
		public function clearIcon():void {
			finalizeIcon();
		}
			
		/**
		 * 	Removes an icon displayed (added) by using the the <code>setIcon()</code>
		 * 	method.
		 * 
		 * 	@see #setIcon()
		 */
		public function deleteIcon():void {
			finalizeIcon();
		}
		
		/**
		 * 	Adds (draws) an icon next to the text object with the specified
		 * 	<code>StateBrush</code> object.
		 * 	
		 * 	@param	brush 	The <code>StateBrush</code> object used to add (draw)
		 * 					the icon.
		 * 	@param	rect 	The rectangle area used to add (draw) the icon.
		 * 
		 * 	@see #clearIcon()
		 * 	@see #setIcon()
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		public function drawIcon(brush:Class, rect:Rectangle = null):void {
			createIcon();
			spas_internal::icon.setBrush(brush, rect, spas_internal::lafDTO) as StateBrush;
			spas_internal::icon.paint();
			$needsVerticalIconUpdate = $needsHorizontalIconUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	Adds an icon next to the text object, using the specified element.
		 * 	<p>Valid elements are the same as elements that can be used with the
		 * 	<code>Icon.addElement()</code> method.</p>
		 * 	
		 * 	@param	value The element to add as an icon to this text object.
		 * 
		 * 	@see #deleteIcon()
		 * 	@see #drawIcon()
		 * 	@see org.flashapi.swing.Icon
		 */
		public function setIcon(value:*):void {
			createIcon();
			spas_internal::icon.addIcon(value);
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_boxhelp.finalize();
			finalizeIcon();
			if ($borderDecorator != null) $borderDecorator.finalize();
			if (_cssLoader != null) {
				_cssLoader.finalize();
				_cssLoader = null;
			}
			_styleSheet = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Style management
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>StyleSheet</code> object that currently used by this
		 * 	text object. Returns <code>null</code> if no style are defined for this
		 * 	text object.
		 * 
		 * 	@return The <code>StyleSheet</code> used by this text object, if exists;
		 * 			<code>null</code> otherwise.
		 * 
		 * 	@default null
		 */
		public function getStyle():StyleSheet {
			return spas_internal::textRef.styleSheet;
		}
		
		/**
		 * 	Sets the <code>StyleSheet</code> object to use with this text object.
		 * 
		 * 	@param	value	A <code>StyleSheet</code> object or a URI which links
		 * 					to a valid CSS file.
		 */
		public function setStyle(value:*):void {
			if (value == null) {
				_styleSheet = null;
				$needsTextFormatUpdate = true;
				setRefresh();
				return;
			}
			if (_styleSheet == null) _styleSheet = new StyleSheet();
			switch(true) {
				case value is String:
					loadAndSetStyle(value);
					break;
				case value is StyleSheet:
					getAndSetStyle(value);
					break;
			}
		}
		
		//--> Private API:
		
		private function loadAndSetStyle(value:String):void {	
			if (_cssLoader != null) _cssLoader.finalize();
			_cssLoader = new UILoader(this, DataFormat.CSS);
			_cssLoader.load(value);
			//_cssLoader.addEventListener(LoaderEvent.INIT, cssInitEvent);
			$evtColl.addOneShotEvent(this, LoaderEvent.CSS_COMPLETE, cssCompleteEvent);
		}
		
		private function cssCompleteEvent(e:LoaderEvent):void {
			_styleSheet.parseCSS(e.data);
			_styleSheet = CSSGateway.convertForColorKeywordCompatibility(_styleSheet);
			$needsTextFormatUpdate = true;
			setRefresh();
		}
		
		private function getAndSetStyle(style:StyleSheet):void {
			_styleSheet = CSSGateway.convertForColorKeywordCompatibility(style);
			$needsTextFormatUpdate = true;
			setRefresh();
			//dispatchAttachChildEvents(_styleSheet);
		}
		
		/**
		 * 	@private
		 */
		protected function applyStyleSheet(redrawUIObject:Boolean = false):void {
			//_styleSheet != null ? (spas_internal::textRef.styleSheet = _styleSheet) : spas_internal::textRef.setTextFormat(_textFormat);
			if (_styleSheet != null) spas_internal::textRef.styleSheet = _styleSheet;
			else spas_internal::textRef.defaultTextFormat = $textFormat;
			if(redrawUIObject) setRefresh();
		}
		
		private var _styleSheet:StyleSheet = null;
		private var _cssLoader:UILoader;
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal value that indicates whether the text displayed within the
		 * 	text object is a password text field (<code>true</code>), or not
		 * 	(<code>false</code>).
		 */
		protected var $password:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal value that indicates whether the text specified by the
		 * 	<code>$text</code> property must be updated (<code>true</code>),
		 * 	or not (<code>false</code>).
		 */
		protected var $needsTextUpdate:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal value that indicates whether the text format of
		 * 	this text object must be updated (<code>true</code>), or not 
		 * 	(<code>false</code>).
		 */
		protected var $needsTextFormatUpdate:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal value that indicates whether the horizontal alignment,
		 * 	relative to the icon position, must be updated (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@see #$needsVerticalIconUpdate
		 */
		protected var $needsHorizontalIconUpdate:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal value that indicates whether the vertical alignment,
		 * 	relative to the icon position, must be updated (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@see #$needsHorizontalIconUpdate
		 */
		protected var $needsVerticalIconUpdate:Boolean = false;
		
		/**
		 *	@private
		 */
		spas_internal var isBorderInstance:Boolean = false;
		
		/**
		 *	@private
		 */
		spas_internal var icon:Icon = null;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function initTextFormat():void {
			$textFormat = lookAndFeel.getTextFormat().clone();
			if ($fontFace != null) $textFormat.font = $fontFace;
			if (!isNaN($fontSize)) $textFormat.size = $fontSize;
			if(!isNaN($fontColor)) $textFormat.color = $fontColor;
			if($boldFace) $textFormat.bold = $boldFace;
			if ($textAlign) $textFormat.align = $textAlign;
			//--> TODO: _italicized: peut être mettre null en valeur par défaut.
			if ($italicized) $textFormat.italic = $italicized;
			spas_internal::textRef.defaultTextFormat = $textFormat;
		}
		
		/**
		 *  @private
		 */
		protected function textChangedHandler(e:Event):void {
			$text = spas_internal::textRef.text;
			dispatchTextEvent(TextEvent.EDITED);
		}
		
		/**
		 *  @private
		 */
		protected function doEventDispatching(e:KeyboardEvent):void {
			textChangedHandler(e);
			if(e.keyCode == Keyboard.ENTER) dispatchTextEvent(TextEvent.VALIDATED);
		}
		
		/**
		 *  @private
		 */
		protected function dispatchTextEvent(type:String):void {
			dispatchEvent(new TextEvent(type));
		}
		
		/**
		 *  @private
		 */
		protected function updateTextFormat():void {
			spas_internal::textRef.defaultTextFormat = $textFormat;
			//if (_styleSheet == null) spas_internal::textRef.defaultTextFormat = _textFormat;
		}
		
		/**
		 *  @private
		 */
		protected function updateText():void {
			if (!$needsTextUpdate && !$needsTextFormatUpdate) return;
			if (!$html) {
				if($needsTextFormatUpdate) spas_internal::textRef.defaultTextFormat = $textFormat;
				spas_internal::textRef.text = $text;
			} else {
				applyStyleSheet();
				if ($needsTextUpdate) spas_internal::textRef.htmlText = $text;
			}
			$needsTextUpdate = $needsTextFormatUpdate = false;
		}
		
		/**
		 *  @private
		 */
		protected function setEditableMode(value:Boolean):void {
			$editable = value;
			if(value) {
				spas_internal::textRef.type = TextFieldType.INPUT;
				spas_internal::textRef.selectable = $selectable;
				$evtColl.addEvent(spas_internal::textRef, KeyboardEvent.KEY_UP, doEventDispatching);
			} else {
				$evtColl.removeEvent(spas_internal::textRef, KeyboardEvent.KEY_UP, doEventDispatching);
				spas_internal::textRef.type = TextFieldType.DYNAMIC;
			}
		}
		
		/**
		 *  @private
		 */
		protected function createBorderIstanceContainer():void {
			createBackgroundTextureManager(spas_internal::background);
			$borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			spas_internal::uioSprite.addChild(spas_internal::background);
			spas_internal::uioSprite.addChild(spas_internal::borders);
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			initTextFormat();
		}
		
		/**
		 *  @private
		 */
		protected function getTextWidth():Number {
			return spas_internal::icon == null ? $width :
				$width - spas_internal::icon.width - $horizontalGap - $padL - $padR;
		}
		
		/**
		 *  @private
		 */
		protected function setPositions():void {
			if ($autoSize || $autoWidth || $needsHorizontalIconUpdate) {
				var xPos:Number = 0;
				if (spas_internal::icon != null) {
					switch($labelPlacement) {
						case LabelPlacement.LEFT :
							spas_internal::icon.x = isNaN($width) ?
								spas_internal::textRef.width + $horizontalGap :
								getTextWidth() + $horizontalGap;
							break;
						case LabelPlacement.RIGHT :
							spas_internal::icon.x = $padL;
							xPos = spas_internal::icon.width + $horizontalGap + $padL;
							break;
					}
				}
				spas_internal::textRef.x = xPos;
				if (spas_internal::isBorderInstance && !$embedIcon) {
					spas_internal::background.x = xPos;
					$borderDecorator.spas_internal::fixBorderOrigin(xPos, spas_internal::borders.y);
				}
				$needsHorizontalIconUpdate = false;
			}
			setVerticalAlignment();
		}
		
		/**
		 *  @private
		 */
		protected function setVerticalAlignment():void {
			if (!$autoSize && !$autoHeight && !$needsVerticalIconUpdate) return;
			if (spas_internal::icon == null) {
				spas_internal::textRef.y = 0;
				$needsVerticalIconUpdate = false;
				return;
			}
			var yPos:Number = 0;
			var delta:Number = spas_internal::textRef.height - spas_internal::icon.height;
			switch($vAlignment) {
				case VerticalAlignment.TOP :
					spas_internal::icon.y = spas_internal::textRef.y = yPos;
					return;
					break;
				case VerticalAlignment.MIDDLE :
					yPos = delta / 2;
					break;
				case VerticalAlignment.BOTTOM :
					yPos = delta;
					break;
			}
			if (delta >= 0) {
				spas_internal::textRef.y = 0;
				spas_internal::icon.y = Math.abs(yPos);
			} else {
				spas_internal::textRef.y = Math.abs(yPos);
				spas_internal::icon.y = 0;
			}
			$needsVerticalIconUpdate = false;
		}
		
		/**
		 *  @private
		 */
		protected function updateButtonMode():void {
			if (!_buttonMode) return;
			var hz:Figure = Figure.setFigure($hitArea);
			hz.clear();
			var bnds:Rectangle = spas_internal::uioSprite.getBounds(null);
			var w:Number = isNaN($width) ? bnds.width : $width;
			var h:Number = isNaN($height) ? bnds.height : $height;
			hz.beginFill(0xFF0000, 0);
			hz.drawRectangle(0, 0, w, h);
			hz.endFill();
		}
		
		/**
		 *  @private
		 */
		protected var _buttonMode:Boolean = false;
		/**
		 *  @private
		 */
		override public function get buttonMode():Boolean {
			return _buttonMode;
		}
		override public function set buttonMode(value:Boolean):void {
			_buttonMode = spas_internal::uioSprite.buttonMode = $hitArea.buttonMode = value;
			manageHitArea();
			updateButtonMode();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _boxhelp:BoxHelp;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$textFormat = new UITextFormat();
			createHitArea();
			spas_internal::textRef = new TextField();
			$horizontalGap = 5;
			$padL = $padR = 0;
			_boxhelp = new BoxHelp();
			$needsHorizontalIconUpdate = true;
		}
		
		private function createIcon():void {
			if (spas_internal::icon == null) {
				spas_internal::icon = new Icon();
				spas_internal::icon.eventCollector.addEvent(
					spas_internal::icon, LoaderEvent.COMPLETE, setIconProperties
				);
				spas_internal::icon.target = spas_internal::uioSprite;
				spas_internal::icon.display();
			}
		}
		
		private function finalizeIcon():void {
			if (spas_internal::icon != null) {
				spas_internal::icon.removeElements();
				spas_internal::icon.clear();
				spas_internal::icon.remove();
				spas_internal::icon.finalize();
				spas_internal::icon = null;
				$needsVerticalIconUpdate = $needsHorizontalIconUpdate = true;
				setRefresh();
			}
		}
		
		private function setIconProperties(e:LoaderEvent):void {
			$needsVerticalIconUpdate = $needsHorizontalIconUpdate = true;
			setRefresh();
		}
		
		private function manageHitArea():void {
			var flag:Boolean = spas_internal::uioSprite.contains($hitArea);
			if (_buttonMode && !flag) spas_internal::uioSprite.addChild($hitArea);
			else if (!_buttonMode && flag) spas_internal::uioSprite.removeChild($hitArea);
		}
		
		private function rollOverHandler(e:MouseEvent):void {
			if (_alt != null) {
				_boxhelp.shadow = $dropShadow;
				_boxhelp.glow = $glowFilter;
				_boxhelp.label = _alt;
				_boxhelp.display();
			}
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			_boxhelp.remove();
		}
	}
}