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

package org.flashapi.swing.button.core {
	
	// -----------------------------------------------------------
	// ABM.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.3.0, 23/02/2010 15:09
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.flashapi.swing.BoxHelp;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.TextDecoration;
	import org.flashapi.swing.core.IconTextFieldLayout;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.ContainerEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.reflect.ObjectTranslator;
	import org.flashapi.swing.skin.Skinable;
	import org.flashapi.swing.state.ButtonStateUtil;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.state.FontState;
	import org.flashapi.swing.state.UnderlineState;
	import org.flashapi.swing.text.FontFormat;
	import org.flashapi.swing.ui.analytics.AnalyticsType;
	import org.flashapi.swing.util.FontFormatUtil;
	import org.flashapi.swing.util.TextMetricsUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ABM</code> class (for Abstract Button Methods) is the base class
	 * 	for all buttons.
	 * 	
	 * 	<p>The <code>paddingLeft</code>, <code>paddingTop</code>, <code>paddingRight</code>
	 * 	and <code>paddingBottom</code> properties of the <code>ABM</code> class are set to
	 * 	<code>0</code>.</p>
	 * 
	 * 	<p>Note that the <code>buttonMode</code> property cannot be set, and always
	 * 	returns <code>true</code>.</p>
	 * 
	 * 	<p><strong><code>ABM</code> instances support the following CSS properties:</strong></p>
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
	 * 			<td><code class="css">horizontal-align</code></td>
	 * 			<td>Specifies the horizontal alignment of this object.</td>
	 * 			<td>Possible values are <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code>.</td>
	 * 			<td><code>horizontalAlignment</code></td>
	 * 			<td><code>Properties.HORIZONTAL_ALIGN</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">icon</code></td>
	 * 			<td>Add an icon to this object.</td>
	 * 			<td>Must be a valid URI to an image or a SWF file.</td>
	 * 			<td>The <code>setIcon()</code> method.</td>
	 * 			<td><code>Properties.ICON</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">icon-color</code></td>
	 * 			<td>Sets the color of the icon displayed within this object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>iconColor</code></td>
	 * 			<td><code>Properties.ICON_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">text-decoration</code></td>
	 * 			<td>Sets the text decoration of the object.</td>
	 * 			<td>Valid values are <code class="css">normal</code> or
	 * 			<code class="css">underline</code>.</td>
	 * 			<td><code>textDecoration</code></td>
	 * 			<td><code>Properties.TEXT_DECORATION</code></td>
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
	 * 	<p><strong>In addition to the preceding CSS properties, <code>ABM</code> instances 
	 * 	support the following CSS pseudo-classes:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS pseudo-class</th>
	 * 			<th>Description</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">up</code></td>
	 * 			<td>The <code class="css">:up</code> pseudo-class applies if an
	 * 			element appears with its default state.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">over</code></td>
	 * 			<td>The <code class="css">:over</code> pseudo-class applies while the
	 * 			user designates an element (with some pointing device), but does not
	 * 			activate it.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">down</code></td>
	 * 			<td>The <code class="css">:down</code> pseudo-class applies while the
	 * 			user presses the mouse button over an element (with some pointing device),
	 * 			to activate it.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">disabled</code></td>
	 * 			<td>The <code class="css">:disabled</code> pseudo-class applies if an
	 * 			element is disabled; tipically elements are disabled when the
	 * 			<code>UOIbject.active</code> property is <code>false</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">selected</code></td>
	 * 			<td>The <code class="css">:selected</code> pseudo-class applies if an
	 * 			element is selected; tipically button elements are selected when the
	 * 			<code>Button.selected</code> property is <code>true</code>.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>Default value of the <code>analyticsType</code> property for <code>ABM</code>
	 * 	instances is <code>AnalyticsType.CLICK</code>.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ABM extends UIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ABM</code> instance.
		 */
		public function ABM() { 
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The default value in pixels of the <code>width</code> property when the
		 * 	<code>autoSize</code> property is <code>true</code> and the <code>text</code>
		 * 	property is <code>""</code> (an empty string).
		 */
		public static const DEFAULT_WIDTH:Number = 60;
		
		/**
		 * 	The default value in pixels of the <code>height</code> property when the
		 * 	<code>autoSize</code> property is <code>true</code> and the <code>text</code>
		 * 	property is <code>""</code> (an empty string).
		 */
		public static const DEFAULT_HEIGHT:Number = 22;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A reference to the <code>Icon</code> instance for the specified button.
		 * 
		 * 	@see org.flashapi.swing.Icon
		 */
		public var icon:Icon;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>alt</code> property.
		 * 
		 * 	@see #alt
		 */
		protected var $alt:String = null;
		/**
		 * 	The alternate text for the <code>Button</code> instance. The alternate
		 * 	text is displayed in a <code>Boxhelp</code> tooltip when the user rolls
		 * 	the mouse over the button; it is removed when the user rolls the mouse out.
		 * 	To disable the alternate text, set the <code>alt</code> property to
		 * 	<code>null</code>.
		 * 
		 * 	@default null
		 * 
		 * 	@see #boxhelp
		 * 	@see org.flashapi.swing.BoxHelp
		 */
		public function get alt():String {
			return $alt;
		}
		public function set alt(value:String):void {
			if(value == null) {
				$alt = null;
				if (_boxhelp == null) return;
				else {
					_boxhelp.remove();
					_boxhelp = null;
					return;
				}
			}
			if(_boxhelp == null) _boxhelp = new BoxHelp();
			_boxhelp.label = $alt = value;
		}
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Deactivates the buttonMode property.
		 */
		override public function get buttonMode():Boolean {
			return true;
		}
		override public function set buttonMode(value:Boolean):void { }
		
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
			$boldFace = $boldFaces.up = $boldFaces.down =
			$boldFaces.over = $boldFaces.disabled = value;
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
		 * 	state of the button.
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
		
		private var _boxhelp:BoxHelp = null;
		/**
		 *  A reference to the <code>BoxHelp</code> instance that displays the 
		 * 	button alternate text.
		 * 
		 * 	@default null
		 * 
		 * 	@see #alt
		 */
		public function get boxhelp():BoxHelp {
			return _boxhelp;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>dotted</code> property.
		 * 
		 * 	@see #dotted
		 */
		protected var $dotted:Boolean = false;
		/**
		 * 	Draws a thick dashed border line around the <code>Button</code> instance
		 * 	if set to <code>true</code>.
		 * 
		 * 	@default false
		 */
		public function get dotted():Boolean {
			return $dotted;
		}
		public function set dotted(value:Boolean):void {
			$dotted = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>emphasized</code> property.
		 * 
		 * 	@see #emphasized
		 */
		protected var $emphasized:Boolean = false;
		[Inspectable(defaultValue=false, name="emphasized")]
		/**
		 * 	Draws a thick border around the <code>Button</code> instance if set
		 * 	to <code>true</code>.
		 * 
		 * 	@default false
		 */
		public function get emphasized():Boolean {
			return $emphasized;
		}
		public function set emphasized(value:Boolean):void {
			$emphasized = value;
			$emphasized ? lookAndFeel.drawEmphasizedState() : lookAndFeel.clearEmphasizedState();
			//if(_hasDrawnIcon)_emphasized ? _iconBrush.drawEmphasizedState() : _iconBrush.clearEmphasizedState();
			setRefresh();
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
		 * 	Sets or gets the size of the <code>Button</code> text, in pixels.
		 * 	The default value is specified by the current Look and Feel.
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
		 * 	text for each state of the <code>Button</code> instance.
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
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>greyTint</code> property.
		 * 
		 * 	@see #greyTint
		 */
		protected var $greyTint:Boolean = false;
		/**
		 *  A <code>Boolean</code> value that indicates whether the button text
		 * 	is rendered with a grey tinted color (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get greyTint():Boolean {
			return $greyTint;
		}
		public function set greyTint(value:Boolean):void {
			$greyTint = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>hasMouseOver</code> property.
		 * 
		 * 	@see #hasMouseOver
		 */
		protected var $hasMouseOver:Boolean = false;
		/**
		 * 	Indicates if the mouse is over the button when called.
		 */
		public function get hasMouseOver():Boolean {
			return $hasMouseOver;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>horizontalAlignment</code> property.
		 * 
		 * 	@see #horizontalAlignment
		 */
		protected var $hAlign:String;
		/**
		 * 	Gets or sets the horizontal alignment applied to the text and the icon
		 * 	displayed on the button face.
		 * 	<p>Valid values are the constants of the <code>HorizontalAlignment</code> class:</p>
		 * 	<ul>
		 * 		<li><code>HorizontalAlignment.LEFT</code>,</li>
		 * 		<li><code>HorizontalAlignment.CENTER</code>,</li>
		 * 		<li><code>HorizontalAlignment.RIGHT</code>.</li>
		 * 	</ul>
		 * 
		 * 	@see #verticalAlignment
		 * 	@see org.flashapi.swing.constants.HorizontalAlignment
		 */
		public function get horizontalAlignment():String {
			return $hAlign;
		}
		public function set horizontalAlignment(value:String):void {
			$hAlign = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			$autoHeight = isNaN(value);
			setAutoSize();
			spas_internal::lafDTO.height = $height = value;
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		private var _iconColor:*;
		/**
		 *  Sets or gets the color of the icon displayed by this <code>Button</code>
		 * 	instance. The icon color is applied only if the icon uses a reference to
		 * 	a programatic <code>Brush</code> to be rendered.
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
		 *  @see org.flashapi.swing.Icon
		 *  @see org.flashapi.swing.brushes.Brush
		 *  @see #iconColors
		 */
		public function get iconColor():* {
			return _iconColor;
		}
		public function set iconColor(value:*):void {
			var val:* = value == StateObjectValue.NONE ? StateObjectValue.NONE : getColor(value);
			_iconColor = $iconColors.up = $iconColors.down = $iconColors.over =
			$iconColors.disabled = $iconColors.selected = val;
			if (_iconBrush != null) _iconBrush.colors = $iconColors;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>iconColors</code> property.
		 * 
		 * 	@see #iconColors
		 */
		protected var $iconColors:ColorState;
		/**
		 * 	A <code>ColorState</code> object that sets and gets the color of the icon
		 * 	for each state of the button. <code>ColorState</code> instances define
		 * 	five different states:
		 * 	<ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>.</li>
		 *  	<li><code>ColorState.selected</code>.</li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are
		 * 	the same as the values used for for the <code>color</code> property.
		 * 	The default value for each state is <code>StateObjectValue.NONE</code>.
		 * 	To unset a color state value, use the <code>StateObjectValue.NONE</code>
		 * 	constant.</p>
		 *  
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 * 	@see #iconColor
		 */
		public function get iconColors():ColorState {
			return $iconColors;
		}
		public function set iconColors(value:ColorState):void { 
			$iconColors = value;
			if (_iconBrush != null) _iconBrush.colors = $iconColors;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>isPressed</code> property.
		 * 
		 * 	@see #isPressed
		 */
		protected var $isPressed:Boolean = false;
		/**
		 * 	Returns a <code>Boolean</code> that indicates whether the button is
		 * 	pressed when called (<code>true</code>), or not (<code>false</code>).
		 */
		public function get isPressed():Boolean {
			return $isPressed;
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
		 * 	A <code>Boolean</code> that indicates whether the button text
		 * 	is italic (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get italicized():Boolean {
			return $italicized;
		}
		public function set italicized(value:Boolean):void {
			$italicized = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontColor</code> property.
		 * 
		 * 	@see #fontColor
		 */
		protected var $fontColor:* = StateObjectValue.NONE;
		[Inspectable(defaultValue="#000000", name="fontColor", type="Color")]
		/**
		 *  Sets or gets the text color for this <code>Button</code>.
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
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #fontColors
		 */
		public function get fontColor():* {
			return $fontColor;
		}
		public function set fontColor(value:*):void {
			var val:* = value == StateObjectValue.NONE ? StateObjectValue.NONE : getColor(value);
			$fontColor = $fontColors.up = $fontColors.down = $fontColors.over =
			$fontColors.disabled = $fontColors.selected = val;
			setRefresh();
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
		 * 	and gets the text color of the button for each state. <code>ColorState</code>
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
		 *  <code>"none"</code>. To unset a color state value, use the <code>StateObjectValue.NONE</code>
		 * 	constant.</p>
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
			$fontColor = "none";
			spas_internal::lafDTO.fontColors = $fontColors = value;
			setRefresh();
		}
		
		private var _iconBrush:StateBrush = null;
		/**
		 * 	Returns a reference of the <code>StateBrush</code> object used by the button,
		 * 	if it has been defined. If no <code>StateBrush</code> object has been defined,
		 * 	returns <code>null</code>.
		 * 
		 * 	@default null
		 */
		public function get iconBrush():StateBrush {
			return _iconBrush;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>iconOffset</code> property.
		 * 
		 * 	@see #iconOffset
		 */
		protected var $iconOffset:Number = NaN;
		/**
		 * 	Sets or gets the offset between the icon and the text of the button.
		 */
		public function get iconOffset():Number {
			return $iconOffset;
		}
		public function set iconOffset(value:Number):void {
			$iconOffset = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>label</code> property.
		 * 
		 * 	@see #label
		 */
		protected var $label:String = null;
		[Inspectable(defaultValue="Label", name="label")]
		/**
		 *  The <code>label</code> property specifies the plain text displayed
		 * 	on the face of the button.
		 * 
		 *  @default null
		 */
		public function get label():String {
			return $label;
		}
		public function set label(value:String):void {
			$label = _displayedLabel = value;
			if ($useDefaultSizes) {
				spas_internal::lafDTO.width = $width = NaN;
				spas_internal::lafDTO.height = $height = NaN;
				$autoWidth = $autoHeight = true;
				$useDefaultSizes = false;
				setAutoSize();
			}
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
		 *  Indicates whether the button should render the HTML representation of the text contents
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 *  @default false
		 */
		public function get html():Boolean {
			return $html;
		}
		public function set html(value:Boolean):void {
			$html = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>labelPlacement</code> property.
		 * 
		 * 	@see #labelPlacement
		 */
		protected var $labelPlacement:String;
		[Inspectable(enumeration="left,right,top,bottom", defaultValue="right", name="labelPlacement")]
		/**
		 * 	Position of the button label relative to the button icon.
		 * 	Valid properties are the following constants:
		 * 	<ul>
		 * 	<li><code>LabelPlacement.RIGHT</code>,</li>
		 *  <li><code>LabelPlacement.LEFT</code>,</li>
		 *  <li><code>LabelPlacement.BOTTOM</code>,</li>
		 *  <li><code>LabelPlacement.TOP</code>.</li>
		 * 	</ul>
		 * 
		 * 	@default LabelPlacement.RIGHT
		 */
		public function get labelPlacement():String {
			return $labelPlacement;
		}
		public function set labelPlacement(value:String):void {
			$labelPlacement = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selected</code> property.
		 * 
		 * 	@see #selected
		 */
		protected var $selected:Boolean = false;
		[Inspectable(defaultValue=false, name="selected")]
		/**
		 * 	A <code>Boolean</code> value that indicates whether the button is
		 * 	selected(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get selected():Boolean {
			return $selected;
		}
		public function set selected(value:Boolean):void {
			$selected = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selectedStateColor</code> property.
		 * 
		 * 	@see #selectedStateColor
		 */
		protected var $selectedStateColor:Number = NaN;
		/**
		 * 	Sets or gest the button color when the <code>selected</code> property is
		 * 	set to <code>true</code>.
		 * 
		 * 	@default NaN
		 *  
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 */
		public function get selectedStateColor():* {
			return $selectedStateColor;
		}
		public function set selectedStateColor(value:*):void {
			$selectedStateColor = getColor(value);
		}
		
		/**
		 * 	Sets or gets the current state of the button.
		 * 	<p>Valid values are defined by the <code>ButtonState</code> class constants:
		 * 	<ul>
		 * 		<li><code>ButtonState.UP</code>,</li>
		 * 		<li><code>ButtonState.OVER</code>,</li>
		 * 		<li><code>ButtonState.DOWN</code>,</li>
		 * 		<li><code>ButtonState.SELECTED</code>,</li>
		 * 		<li><code>ButtonState.DISABLED</code>.</li>
		 * 	</ul>
		 * 	</p>
		 * 
		 * 	@default ButtonState.UP
		 */
		public function get state():String {
			return _stateObj.s;
		}
		public function set state(value:String):void {
			$active = true;
			_isMouseOver = $isPressed = false;
			_stateObj.s = value;
			switch(value) {
				case ButtonState.DISABLED :
					$active = false;
					break;
				case ButtonState.SELECTED :
					$selected = true;
					break;
				case ButtonState.DOWN :
					_isMouseOver = $isPressed = true;
					break;
				case ButtonState.OVER :
					_isMouseOver = true;
					break;
				case ButtonState.UP :
					break;
				default :
			}
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>toggle</code> property.
		 * 
		 * 	@see #toggle
		 */
		protected var $toggle:Boolean = false;
		[Inspectable(defaultValue=false, name="toggle")]
		/**
		 * 	Controls whether a <code>Button</code> can be toggled (<code>true</code>),
		 * 	or not (<code>false</code>). If <code>true</code>, clicking the button toggles
		 * 	it between both "selected" and "unselected" states.
		 * 	<p>You can define the "selected" state programmatically by using the
		 * 	<code>selected</code> property. If <code>false</code>, the button does
		 * 	not stay pressed after the user releases it.</p>
		 * 
		 * 	@default false
		 */
		public function get toggle():Boolean {
			return $toggle;
		}
		public function set toggle(value:Boolean):void {
			$toggle = value;
			if(!value) $selected = false;
			setRefresh();
		}
		
		/**
		 *	A <code>Boolean</code> value that indicates to the Flash Player to display the
		 * 	hand cursor when the mouse rolls over a button, if set to <code>true</code>.
		 * 	If set to <code>false</code>, the arrow pointer cursor is displayed instead
		 * 	of the hand cursor.
		 * <p>You can change the <code>useHandCursor</code> property at any time; the
		 * 	modified button will immediately use the new cursor. </p>
		 * 
		 * 	@default true
		 */
		override public function get useHandCursor():Boolean {
			return $hitArea.useHandCursor;
		}
		override public function set useHandCursor(value:Boolean):void {
			$hitArea.buttonMode = $hitArea.useHandCursor = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>verticalAlignment</code> property.
		 * 
		 * 	@see #verticalAlignment
		 */
		protected var $vAlign:String;
		/**
		 * 	Gets or sets the vertical alignment applied to the text and the icon
		 * 	displayed on the button face.
		 * 	<p>Valid values are the constants of the <code>VerticalAlignment</code> class:</p>
		 * 	<ul>
		 * 		<li><code>VerticalAlignment.TOP</code>,</li>
		 * 		<li><code>VerticalAlignment.MIDDLE</code>,</li>
		 * 		<li><code>VerticalAlignment.BOTTOM</code>.</li>
		 * 	</ul>
		 * 
		 * 	@see #horizontalAlignment
		 * 	@see org.flashapi.swing.constants.VerticalAlignment
		 */
		public function get verticalAlignment():String {
			return $vAlign;
		}
		public function set verticalAlignment(value:String):void {
			$vAlign = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void { 
			$autoWidth = isNaN(value);
			setAutoSize();
			spas_internal::lafDTO.width = $width = value;
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		private var _truncateLabel:Boolean = true;
		/**
		 * 	A <code>Boolean</code> that indicates whether the button text can be
		 * 	truncated (<code>true</code>), or not(<code>false</code>).
		 * 
		 * 	<p>The button text is truncated when it is too long to be totally displayed.
		 * 	In that case, an ellipse is displayed on the button face to indicate  
		 * 	that some parts of the text are hidden.</p>
		 * 
		 * 	@default true
		 */
		public function get truncateLabel():Boolean {
			return _truncateLabel;
		}
		public function set truncateLabel(value:Boolean):void {
			_truncateLabel = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textDecoration</code> property.
		 * 
		 * 	@see #textDecoration
		 */
		protected var $decoration:String = TextDecoration.NONE;
		/**
		 * 	A string value that specifies the text decoration of this button text.
		 * 	<p>Valid values are the constants of the <code>TextDecoration</code> class:</p>
		 * 	<ul>
		 * 		<li><code>TextDecoration.NONE</code>,</li>
		 * 		<li><code>TextDecoration.UNDERLINE</code>.</li>
		 * 	</ul>
		 * 	
		 * 	@default TextDecoration.NONE
		 * 
		 * 	@see org.flashapi.swing.constants.TextDecoration
		 * 	@see #textDecorations
		 */
		public function get textDecoration():String {
			return $decoration;
		}
		public function set textDecoration(value:String):void {
			$decoration = $decorations.up = $decorations.down =
			$decorations.over = $decorations.disabled = value;
			setRefresh(); 
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textDecorations</code> property.
		 * 
		 * 	@see #textDecorations
		 */
		protected var $decorations:UnderlineState;
		/**
		 *  An <code>UnderlineState</code> object that specifies the decoration of
		 * 	the text for each state of the button.
		 *	<p>Valid values for each state of the button are the constants of the
		 * 	<code>TextDecoration</code> class:</p>
		 * 	<ul>
		 * 		<li><code>TextDecoration.NONE</code>,</li>
		 * 		<li><code>TextDecoration.UNDERLINE</code>.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.constants.TextDecoration
		 * 	@see #textDecoration
		 * 	@see org.flashapi.swing.state.UnderlineState
		 */
		public function get textDecorations():UnderlineState {
			return $decorations;
		}
		public function set textDecorations(value:UnderlineState):void {
			$decorations = value;
			setRefresh();
		}
		
		/*public function set wordWrap(value:Boolean):void { spas_internal::textRef.wordWrap = value; setRefresh(); }
		public function get wordWrap():Boolean { return spas_internal::textRef.wordWrap; }*/
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Removes an icon added to a button by using the <code>drawIcon()</code> method.
		 * 
		 * 	@see #drawIcon()
		 */
		public function clearIcon():void {
			_hasDrawnIcon = $iconAdjustement = false;
			if(displayed) icon.clear();
			drawInitialState();
			dispatchMetricsEvent();
		}
			
		/**
		 * 	Removes an icon added to a button by using the <code>setIcon()</code> method.
		 * 
		 * 	@see #setIcon()
		 */
		public function deleteIcon():void {
			$icon = $iconAdjustement = false;
			if(displayed) icon.removeIcon();
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		/**
		 * 	Draws an icon on the button face with the specified <code>StateBrush</code> object.
		 * 	To remove an icon added with the <code>drawIcon()</code> method, use the
		 * 	<code>clearIcon()</code>.
		 * 	
		 * 	@param	brush 	The <code>StateBrush</code> object specified to draw the icon.
		 * 	@param	rect 	The rectangle area within to draw the icon.
		 * 
		 * 	@see #clearIcon()
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		public function drawIcon(brush:Class, rect:Rectangle = null):void {
			_hasDrawnIcon = $iconAdjustement = true;
			_iconBrush = icon.setBrush(brush, rect, spas_internal::lafDTO) as StateBrush;
			_iconBrush.colors = $iconColors;
			icon.display();
			icon.paint();
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		/**
		 * 	Adds an icon on the button face with the specified <code>Element</code> object.
		 * 	<p>Valid <code>Element</code> objects are the same as elements used by the
		 * 	<code>Icon.addElement()</code> method.</p>
		 * 	<p>To remove an icon added with the <code>setIcon()</code> method, use the
		 * 	<code>deleteIcon()</code>.</p>
		 * 	
		 * 	@param	value The element to add as an icon for this button.
		 * 
		 * 	@see #deleteIcon()
		 * 	@see org.flashapi.swing.Icon
		 */
		public function setIcon(value:*):void {
			$icon = $iconAdjustement = true;
			icon.eventCollector.addEvent(icon, ContainerEvent.ELEMENT_LOADED, setIconProperties);
			icon.addIcon(value);
			icon.display();
		}
		
		/**
		 * 	Indicates whether an icon has been added to the button by using both
		 * 	<code>setIcon()</code> or <code>drawIcon()</code> methods (returns
		 * 	<code>true</code>), or not (returns <code>false</code>).
		 * 	The value returned by default is <code>false</code>.
		 * 
		 * 	@return A <code>Boolean</code> that indicates if the button has an icon
		 * 			displayed on his face.
		 * 
		 * 	@see #setIcon()
		 * 	@see #drawIcon()
		 */
		public function get hasIcon():Boolean {
			return icon.hasIcon;
		}
		
		/**
		 * 	Returns a copy of the object used as icon for this button.
		 * 	Possible returned values are:
		 * 	<ul>
		 * 		<li><code>null</code> when the button has no icon,</li>
		 * 		<li>a <code>StateBrush</code> when an icon has been added
		 * 		by using the <code>drawIcon()</code> method,</li>
		 * 		<li>a string that represents the URL of an external element
		 * 		when an icon has been added by using the <code>setIcon()</code>
		 * 		method,</li>
		 *		<li>an element when an icon has been added by using the
		 * 		<code>setIcon()</code> method.</li>
		 * 	</ul>
		 * 
		 * 	@return A copy of the object used as icon for this button.
		 * 
		 * 	@see #setIcon()
		 * 	@see #drawIcon()
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		public function getIconCopy():* {
			if (!icon.hasIcon) return null;
			else if (_hasDrawnIcon) return ObjectTranslator.objectToInstance(_iconBrush, icon.brushRef);
			else {
				var src:* = icon.src;
				return src is String ? src : new src();
			}
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			initTextFormat();
			initIconColors();
		}
		
		/**
		 * @private
		 */
		override public function set skin(value:Skinable):void {
			if ($hasSkin) spas_internal::background.removeChildAt(0);
			super.skin = value;
			if($skinObject) {
				spas_internal::background.graphics.clear();
				spas_internal::background.addChildAt($skinObject.spas_internal::getBitmapClip(), 0);
			}
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			spas_internal::lafDTO.fontColors = null
			$evtColl.finalize();
			$evtColl = null;
			if (icon != null) {
				spas_internal::lafDTO.icon = null;
				icon.finalizeElements();
				icon.finalize();
				icon = null;
			}
			if (_boxhelp != null) {
				_boxhelp.finalize();
				_boxhelp = null;
			}
			spas_internal::lafDTO.textField = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected porperties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The reference to the internal text format for this button object.
		 */
		protected var $format:TextFormat = new TextFormat();
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the button
		 * 	metrics need to be adjusted, due to the addition of an icon (<code>true</code>),
		 * 	or not (<code>false</code>).
		 */
		protected var $iconAdjustement:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the button
		 * 	has an icon (<code>true</code>), or not (<code>false</code>).
		 */
		protected var $icon:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The internal reference to sprite container for the icon within this 
		 * 	button object.
		 */
		protected var $iconContainer:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the button
		 * 	uses the default height an width values to be displayed (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@see #DEFAULT_HEIGHT
		 * 	@see #DEFAULT_WIDTH
		 */
		protected var $useDefaultSizes:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function init(label:String, width:Number, height:Number, html:Boolean):void {
			spas_internal::textRef = new TextField();
			spas_internal::lafDTO.textfield = spas_internal::textRef;
			createBackground();
			spas_internal::lafDTO.currentTarget = spas_internal::background;
			$label = _displayedLabel = label;
			if (!spas_internal::isComponent) {
				spas_internal::lafDTO.width = $width = width;
				spas_internal::lafDTO.height = $height = height;
			}
			$autoWidth = isNaN($width);
			$autoHeight = isNaN($height);
			setAutoSize();
			if($autoSize && $label == "") {
				spas_internal::lafDTO.width = $width = DEFAULT_WIDTH;
				spas_internal::lafDTO.height = $height = DEFAULT_HEIGHT;
				$useDefaultSizes = true;
			}
			$html = html;
			setButtonBehaviour();
			createIconContainer();
			createColorsObj();
			createBorderColorsObj();
			$iconColors = new ColorState(this);
			$fontColors = new ColorState(this);
			spas_internal::lafDTO.fontColors = $fontColors;
			$boldFaces = new FontState(this);
			$fontSizes = new FontState(this);
			$decorations = new UnderlineState(this);
		}
		
		/**
		 * @private
		 */
		protected function setButtonBehaviour():void {
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_OVER, mouseOverHandler);
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_OUT, mouseOutHandler);
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_DOWN, mouseDownHandler);
			$evtColl.addEvent($hitArea, MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		/**
		 * @private
		 */
		protected function initTextFormat():void {
			fixTextFormat();
		}
		
		/**
		 * @private
		 */
		protected function initTextField():void {
			initTextFormat();
			spas_internal::textRef.selectable = spas_internal::textRef.mouseWheelEnabled = false;
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			spas_internal::uioSprite.addChild($hitArea);
			setButtonProperties();
		}
		
		/**
		 * @private
		 */
		protected function drawInitialState():void {
			var iconCont:Sprite = getIconCont();
			var skinObj:Object = getSkinObj();
			if ($label != "" && $icon) {
				_iconGap = !isNaN($iconOffset) ? $iconOffset : skinObj.getIconDelay();
			} else _iconGap = 0;
			if($active) {
				if (!$selected) {
					if(_isMouseOver) {
						_stateObj = $isPressed ? { s:ButtonState.DOWN, c:1 } : { s:ButtonState.OVER, c:2 }
					} else _stateObj = { s:ButtonState.UP, c:3 };
				} else _stateObj = { s:ButtonState.SELECTED, c:4 };
			} else _stateObj = { s:ButtonState.DISABLED, c:5 };
			function setActiveCase():void {
				setDottedLine();
				skinObj.drawActiveIcon();
			}
			setLabel(skinObj, iconCont, _stateObj.s);
			setItemPositions(skinObj, iconCont);
			fixTruncatedLabel();
			_displayedLabel = $html ? textField.htmlText : textField.text;
			switch (_stateObj.c) {
				case 1: skinObj.drawPressedState();
						if (_hasDrawnIcon) _iconBrush.drawPressedState();
						setActiveCase();
						break;
				case 2: skinObj.drawOverState();
						if (_hasDrawnIcon) _iconBrush.drawOverState();
						setActiveCase();
						break;
				case 3: skinObj.drawOutState();
						if (_hasDrawnIcon) _iconBrush.drawOutState();
						setActiveCase();
						break;
				case 4: skinObj.drawSelectedState();
						if (_hasDrawnIcon) _iconBrush.drawSelectedState();
						setActiveCase();
						break;
				case 5: skinObj.drawInactiveState();
						_hasDrawnIcon ? _iconBrush.drawInactiveState() : skinObj.drawInactiveIcon();
						break;
			}
			setButtonProperties();
			doReflection();
			dispatchChangeEvent();
		}
		
		/**
		 * @private
		 */
		protected function setIconProperties(e:ContainerEvent):void {
			icon.eventCollector.removeEvent(icon, ContainerEvent.ELEMENT_LOADED, setIconProperties);
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			drawInitialState();
			setEffects();
		}
		
		/**
		 * @private
		 */
		protected function initIconColors():void {
			$iconColors.up = lookAndFeel.getOutIconColor();
			$iconColors.down = lookAndFeel.getPressedIconColor();
			$iconColors.over = lookAndFeel.getOverIconColor();
			$iconColors.disabled = lookAndFeel.getInactiveIconColor();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden SPAS 3.0 mouse events
		//
		//--------------------------------------------------------------------------
		//--> ABM mouse events are fired faster when UIObject mouse events are deactivated.
		
		/**
		 *  @private
		 */
		override protected function onReleaseEvent(e:MouseEvent):void { }
		
		/**
		 *  @private
		 */
		override protected function onPressEvent(e:MouseEvent):void { }
		
		/**
		 *  @private
		 */
		override protected function onClick(e:MouseEvent):void { }
		
		/**
		 *  @private
		 */
		protected function getIconCont():Sprite {
			return $icon ? $iconContainer : icon.spas_internal::uioSprite;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private porperties
		//
		//--------------------------------------------------------------------------
		
		private var textW:Number;
		private var textH:Number;
		private var _iconGap:Number;
		private var _hasDrawnIcon:Boolean = false;
		//private var _changeIconProperties:Boolean = false;
		private var _isMouseOver:Boolean = false;
		private var _displayedLabel:String;
		private var _stateObj:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			this.borderAlpha = 1;
			$hitArea = new Sprite();
			createTextureManager(spas_internal::uioSprite);
			$padL = $padR = $padT = $padB = 0;
			$analitycsObj.analyticsType = AnalyticsType.CLICK;
		}
		
		private function createIconContainer():void {
			$iconContainer = new Sprite();
			spas_internal::uioSprite.addChild($iconContainer);
			icon = new Icon();
			spas_internal::lafDTO.icon = icon;
			icon.target = $iconContainer;
		}
		
		private function setButtonProperties():void {
			var bnds:Rectangle = spas_internal::uioSprite.getBounds(null);
			var w:Number = isNaN($width) ? bnds.width : $width;
			var h:Number = isNaN($height) ? bnds.height : $height;
			with(Figure.setFigure($hitArea)) {
				clear();
				beginFill(0xFF0000, 0);
				drawRectangle(0, 0, w, h);
				endFill();
			}
		}
		
		private function setItemPositions(skinObj:Object, iconCont:Sprite):void {
			var t:TextField = spas_internal::textRef;
			var topOffset:Number = skinObj.getTopOffset();
			var leftOffset:Number = skinObj.getLeftOffset();
			var rightOffset:Number = skinObj.getRightOffset();
			var bottomOffset:Number = skinObj.getBottomOffset();
			var iconWidth:Number= 0;
			var iconHeight:Number = 0;
			if (($icon || _hasDrawnIcon) && ($autoSize || $autoWidth)) {
				if ($labelPlacement != LabelPlacement.RIGHT || $labelPlacement != LabelPlacement.LEFT) {
					iconWidth = iconCont.width +rightOffset + leftOffset + $padL + $padR;
					if(iconWidth > $width) spas_internal::lafDTO.width = $width = iconWidth; //_width + iconCont.width + _iconGap
				}
			}
			if (($icon || _hasDrawnIcon) && ($autoSize || $autoHeight)) {
				if ($labelPlacement != LabelPlacement.TOP || $labelPlacement != LabelPlacement.BOTTOM) {
					iconHeight = iconCont.height + _iconGap + topOffset + bottomOffset + $padT + $padB;
					if(iconHeight > $height) spas_internal::lafDTO.height = $height = iconHeight// : _height + iconCont.height + _iconGap;
				}
			}
			
			var buttonWidth:Number = $width  + iconWidth - rightOffset - leftOffset - $padL - $padR;
			var buttonHeight:Number = $height + iconHeight - topOffset - bottomOffset - $padT - $padB;
			
			function hideTextField():void {
				t.text = "";
				textW = textH = t.x = t.y = 0 ;
			}
			
			/*textW = (t.width + rightOffset + leftOffset + _padL + _padR > buttonWidth) ? buttonWidth : t.width;
			textH = (t.height + topOffset + bottomOffset + _padT + _padB > buttonHeight) ? buttonHeight : t.height;*/
			
			textW = (t.width  > buttonWidth) ? buttonWidth : t.width;
			textH = (t.height > buttonHeight) ? buttonHeight : t.height;
			if (textW < 0) textW = 0;
			if (textH < 0) textH = 0;
			
			if($icon || _hasDrawnIcon) {
				var vLayout:Boolean = ($labelPlacement==LabelPlacement.RIGHT || $labelPlacement==LabelPlacement.LEFT);
				var hLayout:Boolean = ($labelPlacement==LabelPlacement.TOP || $labelPlacement==LabelPlacement.BOTTOM);
				if ($label == "") hideTextField();
				else if (iconCont.width+_iconGap >= buttonWidth && vLayout) hideTextField();
				else if (iconCont.height+_iconGap >= buttonHeight && hLayout) hideTextField();
				else {
					if (iconCont.width + _iconGap + t.width + $padL + $padR > buttonWidth && vLayout)
						textW = buttonWidth - iconCont.width - _iconGap - $padL - $padR;
					else if (iconCont.height + _iconGap + t.height + $padT + $padB > buttonHeight && hLayout)
						textH = buttonHeight - iconCont.height - _iconGap - $padT - $padB;
				}
			}
			t.autoSize = TextFieldAutoSize.NONE;
			t.width = textW;
			var itfl:IconTextFieldLayout = new IconTextFieldLayout();
			var btnArea:Rectangle = new Rectangle(leftOffset + $padL, topOffset + $padT, $width - rightOffset - $padR - leftOffset - $padL, $height - bottomOffset - $padB - topOffset - $padT);
			var vGap:Number = $icon ? _iconGap+$verticalGap : $verticalGap;
			var hGap:Number = $icon ? _iconGap + $horizontalGap : $horizontalGap;
			itfl.spas_internal::setLayoutProperties(btnArea, $vAlign, $hAlign, vGap, hGap);
			switch($labelPlacement) {
				case LabelPlacement.RIGHT :
					itfl.spas_internal::setLayout(icon.spas_internal::uioSprite, t, LayoutOrientation.HORIZONTAL);
					break;
				case LabelPlacement.LEFT :
					itfl.spas_internal::setLayout(t, icon.spas_internal::uioSprite, LayoutOrientation.HORIZONTAL);
					break;
				case LabelPlacement.TOP :
					itfl.spas_internal::setLayout(icon.spas_internal::uioSprite, t);
					break;
				case LabelPlacement.BOTTOM :
					itfl.spas_internal::setLayout(t, icon.spas_internal::uioSprite);
					break;
			}
			itfl.spas_internal::finalize();
			itfl = null;
		}
		
		private function setLabelProperties(state:String = "up"):void {
			fixTextFormat(state);
			doReflection();
		}
		
		private function setLabel(skinObj:Object, iconCont:Sprite, state:String):void {
			_displayedLabel = $label;
			$format.italic = $italicized;
			var t:TextField = spas_internal::textRef;
			t.autoSize = TextFieldAutoSize.CENTER;
			t.multiline = true;
			fixTextFormat(state);
			var iconSize:Number;
			if ($autoSize || isNaN($width)) {
				iconSize = ($labelPlacement == LabelPlacement.RIGHT || $labelPlacement == LabelPlacement.LEFT) ?
					iconCont.width + _iconGap : 0;
				spas_internal::lafDTO.width = $width = t.width + skinObj.getRightOffset() + skinObj.getLeftOffset() + $padL + $padR + iconSize;
			}
			if ($autoSize || isNaN($height)) {
				iconSize = ($labelPlacement == LabelPlacement.TOP || $labelPlacement == LabelPlacement.BOTTOM) ?
					iconCont.height + _iconGap : 0;
				spas_internal::lafDTO.height = $height = t.height + skinObj.getTopOffset() + skinObj.getBottomOffset() + $padT + $padB + iconSize;
			}
		}
		
		private function fixTruncatedLabel():void {
			if ($autoSize || isNaN($width) || !_truncateLabel) return;
			else TextMetricsUtil.truncateToFit($label, spas_internal::textRef, spas_internal::textRef.width, $html);
		}
		
		private function setDottedLine():void {
			if ($dotted) lookAndFeel.drawDottedLine();
		}
		
		private function setAutoSize():void {
			$autoSize = ($autoWidth && $autoHeight);
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			_isMouseOver = true;
			if ($active && $enabled) {
				setOverStateProperties();
				if(_boxhelp != null) _boxhelp.display();
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			_isMouseOver = false;
			if($active && $enabled) onMouseOut();
			if(_boxhelp != null) _boxhelp.remove();
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if($active && $enabled) {
				doMouseDownAction();
				if(_boxhelp != null) _boxhelp.remove();
				$isPressed = true;
				dispatchButtonEvent(UIMouseEvent.PRESS);
			}
		}
		
		private	function mouseUpHandler(e:MouseEvent):void {
			if ($active && $enabled) {
				setOverStateProperties();
				dispatchButtonEvent(UIMouseEvent.RELEASE);
				if ($isPressed) {
					if ($analitycsObj.analyticsRef) $analitycsObj.analyticsRef.updateAnalysis($analitycsObj);
					dispatchButtonEvent(UIMouseEvent.CLICK);
				}
				$isPressed = false;
			}
		}
		
		private	function doMouseDownAction():void {
			if ($toggle) $selected = (!$selected);
			var skinObj:Object = getSkinObj();
			skinObj.drawPressedState();
			if(_hasDrawnIcon) _iconBrush.drawPressedState();
			setDottedLine();
			setLabelProperties(ButtonState.DOWN);
		}
		
		private	function onMouseOut():void {
			var skinObj:Object = getSkinObj();
			if($selected) {
				skinObj.drawSelectedState();
				if (_hasDrawnIcon) _iconBrush.drawSelectedState();
				setLabelProperties(ButtonState.SELECTED);
			} else {
				skinObj.drawOutState();
				if (_hasDrawnIcon) _iconBrush.drawOutState();
				setLabelProperties();
			}
			$hasMouseOver = false;
			setDottedLine();
		}
		
		private	function setOverStateProperties():void {
			var skinObj:Object = getSkinObj();
			if(!$selected) {
				skinObj.drawOverState();
				if (_hasDrawnIcon) _iconBrush.drawOverState();
				setLabelProperties(ButtonState.OVER);
			} else {
				skinObj.drawSelectedState();
				if (_hasDrawnIcon) _iconBrush.drawSelectedState();
				setLabelProperties(ButtonState.SELECTED);
			}
			$hasMouseOver = true;
			setDottedLine();
		}
		
		private function fixTextFormat(state:String = "up"):void {
			var skinObj:Object = getSkinObj();
			var fmt:FontFormat;
			switch(state) {
				case ButtonState.UP: 	fmt = skinObj.getUpFontFormat();
										break;
				case ButtonState.OVER: 	fmt = skinObj.getOverFontFormat();
										break;
				case ButtonState.DOWN: 	fmt = skinObj.getDownFontFormat();
										break;
				case ButtonState.SELECTED: 	fmt = skinObj.getSelectedFontFormat();
											break;
				case ButtonState.DISABLED: 	fmt = skinObj.getDisabledFontFormat();
											break;
			}
			FontFormatUtil.copy($format, fmt);
			
			if ($greyTint) $format.color = skinObj.getGrayTintColor();
			else {
				var c:Object = ButtonStateUtil.getStateProperty($fontColors, state);
				$format.color = c == "none" ? getColor(fmt.color) : c;
			}
			
			var b:Object = ButtonStateUtil.getStateProperty($boldFaces, state);
			$format.bold = b == "none" ? fmt.bold : b;
			
			var fs:Object = ButtonStateUtil.getStateProperty($fontSizes, state);
			$format.size = fs == "none" ? fmt.size : fs;
			
			var un:Object = ButtonStateUtil.getStateProperty($decorations, state);
			$format.underline = un == "none" ? false : true;
			
			spas_internal::textRef.defaultTextFormat = $format;
			$html ? spas_internal::textRef.htmlText = _displayedLabel :
					spas_internal::textRef.text = _displayedLabel;
		}
	}
}