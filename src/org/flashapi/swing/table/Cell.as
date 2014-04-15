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

package org.flashapi.swing.table {
	
	// -----------------------------------------------------------
	// Cell.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 23/11/2008 22:25
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Box;
	import org.flashapi.swing.constants.CellType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.Text;
	
	use namespace spas_internal;
	
	/**
	 * 	[This class is under development.]
	 * 	
	 * 	The <code>Cell</code> class is the base class for creating cells within
	 * 	SPAS 3.0 <code>Table</code> objects.
	 * 
	 * <p><strong><code>Cell</code> instances support the following CSS properties:</strong></p>
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
	 * 			<td><code class="css">text-align</code></td>
	 * 			<td>Sets the alignment of the text displayed within this object.</td>
	 * 			<td>Valid values are <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code>.</td>
	 * 			<td><code>textAlign</code></td>
	 * 			<td><code>Properties.TEXT_ALIGN</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@see org.flashapi.swing.Table
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Cell extends Box {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Cell</code> object with the specified
		 * 	properties.
		 * 
		 * 	@param	borderStyle	The type of border for this <code>Cell</code> object.
		 * 						Possible values are constants of the <code>BorderStyle</code>
		 * 						class.
		 * 	@param	type	The type of <code>Cell</code>. Possible values are constants
		 * 					of the <code>CellType</code> class.
		 */
		public function Cell(borderStyle:String, type:String) {
			super(DEFAULT_WIDTH, DEFAULT_HEIGHT, borderStyle);
			initObj(type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The default width of a <code>Cell</code> object, in pixels.
		 */
		public static const DEFAULT_WIDTH:Number = 100;
		
		/**
		 * 	The default height of a <code>Cell</code> object, in pixels.
		 */
		public static const DEFAULT_HEIGHT:Number = 22;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set buttonMode(value:Boolean):void {
			spas_internal::uioSprite.buttonMode = value;
			spas_internal::uioSprite.mouseChildren = !value;
		}
		
		/**
		 * 	Sets or gets the type of node represented by this <code>Cell</code> object.
		 * 	[This functionality is under development and cannot be set.]
		 * 
		 * 	@default CellType.TEXT_NODE
		 */
		public function get nodeType():String {
			return $type;
		}
		public function set nodeType(value:String):void {
			/*switch(value) {
				case CellType.TEXT_NODE : if (!spas_internal::textObject_int.displayed) addText(); break;
				case CellType.ELEMENT_NODE : if (spas_internal::textObject_int.displayed) removeText(); break;
				default : throw new InvalidArgumentException("value must be a CellType class constant");
			}
			_type = value;*/
			$type = CellType.TEXT_NODE;
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
		 * 	Sets or gets the text displayed within the <code>Cell</code> object when
		 * 	the <code>nodeType</code> property is <code>CellType.TEXT_NODE</code>.
		 * 
		 * 	@see #nodeType
		 */
		public function get text():String {
			return $text;
		}
		public function set text(value:String):void {
			$text = value;
			spas_internal::textObject.text = value;
			/*if (_type == CellType.ELEMENT_NODE) {
				finalizeElements();
				nodeType = CellType.TEXT_NODE;
			}*/
			//spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		spas_internal var tblRow:TableRow = null;
		/**
		 * 	Returns a reference to the parent <code>TableRow</code> instance for 
		 * 	this <code>Cell</code> object.
		 */
		public function get tableRow():TableRow {
			return spas_internal::tblRow; 
		}
		
		//--------------------------------------------------------------------------
		//
		//  Text format getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		//public function get textFormat():UITextFormat { return spas_internal::textObject_int.textFormat; }
		//public function set textFormat(value:UITextFormat):void { return spas_internal::textObject_int.textFormat = value; }
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the text displayed within
		 * 	the <code>Cell</code> object is boldface (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@see #text
		 */
		public function get boldFace():Boolean {
			return spas_internal::textObject.boldFace;
		}
		public function set boldFace(value:Boolean):void {
			spas_internal::textObject.boldFace = value;
			//setRefresh();
		}
		
		/**
		 *	A <code>Boolean</code> value that indicates whether the user can edit the text 
		 * 	displayed within the <code>Cell</code> object (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #text
		 */
		public function get editable():Boolean {
			return spas_internal::textObject.editable;
		}
		public function set editable(value:Boolean):void {
			spas_internal::textObject.editable = value;
		}
		
		/**
		 *  Sets or gets the color of the text displayed within the <code>Cell</code>
		 * 	object.
		 * 
		 * 	@see #text
		 */
		public function get fontColor():* {
			return spas_internal::textObject.color;
		}
		public function set fontColor(value:*):void {
			spas_internal::textObject.color = value;
			//setRefresh();
		}
		
		/**
		 *  Sets or gets the point size of the text displayed within the <code>Cell</code>
		 * 	object.
		 * 
		 * 	@see #text
		 */
		public function get fontSize():* {
			return spas_internal::textObject.fontSize;
		}
		public function set fontSize(value:*):void {
			spas_internal::textObject.fontSize = value;
			//setRefresh();
		}
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the text displayed within
		 * 	the <code>Cell</code> object is italicized (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #text
		 */
		public function get italicized():Boolean {
			return spas_internal::textObject.italicized;
		}
		public function set italicized(value:Boolean):void {
			spas_internal::textObject.italicized = value;
			//setRefresh(); 
		}
		
		/**
		 *	A <code>Boolean</code> value that specifies whether the text displayed within
		 * 	the <code>Cell</code> object can be selected (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #text
		 */
		public function get selectable():Boolean {
			return spas_internal::textObject.selectable;
		}
		public function set selectable(value:Boolean):void {
			spas_internal::textObject.selectable = value;
		}
		
		/**
		 * 	Indicates the alignment of the text displayed within the <code>Cell</code>
		 * 	object. Valid values are:
		 * 	<ul>
		 * 		<li>TextAlign.LEFT,</li>
		 * 		<li>TextAlign.CENTER,</li>
		 * 		<li>TextAlign.RIGHT.</li>
		 * 	</ul>
		 * 
		 *	@default TextAlign.LEFT
		 * 
		 * 	@see #text
		 */
		public function get textAlign():String {
			return spas_internal::textObject.textAlign;
		}
		public function set textAlign(value:String):void {
			spas_internal::textObject.textAlign = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			spas_internal::textObject.finalize();
			spas_internal::textObject = null;
			spas_internal::tblRow = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var textObject:Text;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(type:String):void {
			spas_internal::invalidateLayoutUpdate = true;
			$borderColor = 0;
			$padding = 0;
			spas_internal::textObject = new Text();
			spas_internal::textObject.autoHeight = true;
			addText();
			//this.nodeType = type;
			spas_internal::isInitialized(2);
		}
		
		private function addText():void {
			this.addElement(spas_internal::textObject);
		}
		
		private function removeText():void {
			this.removeElement(spas_internal::textObject);
		}
	}
}