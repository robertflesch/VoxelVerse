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
	// TLGBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 15/04/2011 02:22
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>TLGBase</code> class is the base class for creating objects
	 * 	composed of a "label" and an "editable" text controls. The "label"
	 * 	control allows to display the text specified by the <code>title</code>
	 * 	property. "Editable" text controls are defined by sub-classes to
	 * 	provide users specific interfaces to edit the editable-label object.
	 * 
	 * 	<p>The resulting components are closely similar to "labelized" input
	 * 	fields displayed within form controls.</p>
	 * 
	 * 	<p><strong><code>TLGBase</code> instances support the following CSS
	 * 	properties:</strong></p>
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
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class TLGBase extends UIObject implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>TLGBase</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	defaultLaf	The default Look and Feel class reference for this
		 * 						<code>TLGBase</code> object.
		 * 	@param	selector	The CSS selector for this <code>TLGBase</code> object.
		 * 	@param	title		The text displayed within the label control.
		 * 	@param	defaultText	The default text displayed within the text control.
		 * 	@param	width		The width of this <code>TLGBase</code> object, in pixels.
		 * 	@param	baseline	The <code>x</code> position value of the text control.
		 * 	@param	height		The height of this <code>TLGBase</code> object, in pixels.
		 */
		public function TLGBase(defaultLaf:Class, selector:String, title:String, defaultText:String, width:Number, baseline:Number, height:Number) {
			super();
			initObj(defaultLaf, selector, title, defaultText, width, baseline, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>title</code> property.
		 * 
		 * 	@see #title
		 */
		protected var $title:String;
		/**
		 * 	Sets or gets the plain text that is displayed by the label control.
		 * 
		 * 	@see #labelControl
		 */
		public function get title():String {
			return $title;
		}
		public function set title(value:String):void {
			$labCtrl.text = $title = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>baseline</code> property.
		 * 
		 * 	@see #baseline
		 */
		protected var $baseline:Number;
		/**
		 *  Sets or gets the <code>x</code> position value of the text control.
		 */
		public function get baseline():Number {
			return $baseline;
		}
		public function set baseline(value:Number):void {
			$baseline = $editableText.x = value;
		}
		
		/**
		 * 	[Undocumented]
		 */
		public function set index(value:int):void {
			spas_internal::setIndex(value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>labelControl</code> property.
		 * 
		 * 	@see #labelControl
		 */
		protected var $labCtrl:Label;
		/**
		 * 	Returns a reference to the control that is used to display the tilte
		 * 	text of this editable-label object.
		 * 
		 * 	@see #editableText
		 */
		public function get labelControl():Label {
			return $labCtrl;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>editableText</code> property.
		 * 
		 * 	@see #editableText
		 */
		protected var $editableText:ATM;
		/**
		 * 	Returns a reference to the ediatble text control of this
		 * 	editable-label object.
		 * 
		 * 	@see #editableText
		 */
		public function get editableText():ATM {
			return $editableText;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>editable</code> property.
		 * 
		 * 	@see #editable
		 */
		protected var $editable:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the user can edit
		 * 	the text displayed within the text control (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get editable():Boolean {
			return $editable;
		}
		public function set editable(value:Boolean):void {
			if (!value && $editableText.focus) $editableText.focus = false;
			$editable = value;
		}
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the text 
		 * 	displayed within the label control can be selected
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@see #labelControl
		 */
		public function get selectable():Boolean {
			return $labCtrl.selectable;
		}
		public function set selectable(value:Boolean):void {
			$labCtrl.selectable = value;
		}
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the text 
		 * 	displayed within the label control is boldface (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@see #labelControl
		 * 
		 * 	@default false
		 */
		public function get boldFace():Boolean {
			return $labCtrl.boldFace;
		}
		public function set boldFace(value:Boolean):void {
			$labCtrl.boldFace = value;
		}
		
		/**
		 *  Sets or gets the color of text displayed within the label 
		 * 	control, previously defined by its Look and Feel text format.
		 * 	
		 *  @default The Look and Feel text format color of the 
		 * 				label control.
		 * 
		 * 	@see #labelControl
		 */
		public function get fontColor():* {
			return $labCtrl.fontColor;
		}
		public function set fontColor(value:*):void {
			$labCtrl.fontColor = value;
		}
		
		/**
		 *  Sets or gets the point size of text displayed within the label
		 *  control, previously defined by its Look and Feel text format.
		 * 	
		 * 
		 *  @default 	The Look and Feel text format font size of the 
		 * 				label control.
		 * 
		 * 	@see #labelControl
		 */
		public function get fontSize():* {
			return $labCtrl.fontSize;
		}
		public function set fontSize(value:*):void {
			$labCtrl.fontSize = $editableText.fontSize = value;
		}
		
		/**
		 * 	Sets or get the horizontal alignment of the text displayed within 
		 *  the label control. Valid values are:
		 * 	<ul>
		 * 		<li>TextAlign.LEFT,</li>
		 * 		<li>TextAlign.CENTER,</li>
		 * 		<li>TextAlign.RIGHT.</li>
		 * 	</ul>
		 * 
		 *	@default TextAlign.LEFT
		 * 
		 * 	@see #labelControl
		 */
		public function get textAlign():String {
			return $labCtrl.textAlign;
		}
		public function set textAlign(value:String):void {
			$labCtrl.textAlign = $editableText.textAlign = value;
		}
		
		/**
		 *  @private
		 */
		override public function set focusColor(value:*):void {
			$focusColor = $editableText.focusColor = value;
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			$height = $labCtrl.height = $editableText.height = value;
			dispatchMetricsEvent();
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			$width = $labCtrl.width = $editableText.width = value;
			dispatchMetricsEvent();
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text control
		 * 	has the focus (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get focus():Boolean {
			return $editableText.focus;
		}
		public function set focus(value:Boolean):void {
			$editableText.focus = value;
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
			$labCtrl.finalize();
			$labCtrl = null;
			$editableText.finalize();
			$editableText = null;
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if($displayed) {
				unload();
				if ($editableText.focus) $editableText.focus = false;
			}
		}
		
		/**
		 *  Resets this editable-label object.
		 */
		public function reset():void {
			$editableText.text = "";
			if($editableText.focus) $editableText.focus = false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  Stores an internal reference to the default text displayed by the text
		 * 	control.
		 */
		protected var $defaultText:String;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function setLabelLaf():void {
			$labCtrl.lockLaf(lookAndFeel.getTextLaf(), true);
		}
		
		/**
		 *  @private
		 */
		protected function createEditableText(width:Number):void { }
		
		/**
		 *  @private
		 */
		protected function createEditableTextEvents():void {
			$evtColl.addEvent($editableText, TextEvent.VALIDATED, dispatchValidationEvent);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(defaultLaf:Class, selector:String, title:String, defaultText:String, width:Number, baseline:Number, height:Number):void {
			$title = title;
			$width = width;
			$baseline = baseline;
			$defaultText = defaultText;
			$height = height;
			$horizontalGap = 10;
			createControls();
			initLaf(defaultLaf);
			spas_internal::setSelector(selector);
		}
		
		private function createControls():void {
			var bh:Number = $baseline + $horizontalGap;
			$labCtrl = new Label($title, $baseline);
			$labCtrl.boldFace = true;
			$labCtrl.selectable = false;
			createEditableText($width - bh);
			$editableText.verticalAlignment = VerticalAlignment.TOP;
			$labCtrl.target = $editableText.target = spas_internal::uioSprite;
			$labCtrl.display();
			$editableText.display(bh);
		}
		
		private function dispatchValidationEvent(e:TextEvent):void {
			this.dispatchEvent(new TextEvent(TextEvent.VALIDATED));
		}
	}
}