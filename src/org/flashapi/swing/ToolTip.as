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
	//  ToolTip.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.2, 18/06/2009 21:10
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ToolTip.png")]
	
	/**
	 * 	<img src="ToolTip.png" alt="ToolTip" width="18" height="18"/>
	 * 
	 * 	The <code>ToolTip</code> class lets you create controls to display
	 * 	helpful information to users. Contrary to <code>BubbleHelp</code> instances,
	 * 	which can display any kind of display objects, <code>ToolTip</code> 
	 * 	instances only display plain text.
	 * 
	 * <p><strong><code>ToolTip</code> instances support the following CSS
	 * 	properties:</strong></p>
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
	 * 	@includeExample ToolTipExample.as
	 * 
	 * 	@see org.flashapi.swing.BubbleHelp
	 * 	@see org.flashapi.swing.BoxHelp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ToolTip extends BubbleHelp implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>ToolTip</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>ToolTip</code> instance, in pixels.
		 * 	@param	height	The height of the <code>ToolTip</code> instance, in pixels.
		 */
		public function ToolTip(width:Number = 100, height:Number = 50) {
			super(width, height);
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
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Sets or gets the plain text displayed within this <code>ToolTip</code>
		 * 	instance.
		 */
		public function get text():String {
			return _textUI.text;
		}
		public function set text(value:String):void {
			_textUI.text = value;
		}
		
		/**
		 *	A <code>Boolean</code> value that indicates whether the text displayed
		 * 	within this <code>ToolTip</code> instance is boldface (<code>true</code>), 
		 * 	or not (<code>false</code>). 
		 * 
		 * 	@default false
		 */
		public function get boldFace():Boolean {
			return _textUI.boldFace;
		}
		public function set boldFace(value:Boolean):void {
			_textUI.boldFace = value;
		}
		
		/**
		 *  Sets or gets the color of text the text displayed within this
		 * 	<code>ToolTip</code> instance. If <code>NaN</code> the text color is
		 * 	defined by the current Look and Feel.
		 * 
		 *  @default NaN
		 */
		public function get fontColor():* {
			return _textUI.fontColor;
		}
		public function set fontColor(value:*):void {
			_textUI.fontColor = value;
		}
		
		/**
		 *  Sets or gets the point size of text specified displayed within this
		 * 	<code>ToolTip</code> instance. The default value is defined by the
		 * 	current Look and Feel.
		 */
		public function get fontSize():* {
			return _textUI.fontSize;
		}
		public function set fontSize(value:*):void {
			_textUI.fontSize = value;
		}
		
		/**
		 * 	Indicates the alignment of the text displayed within this
		 * 	<code>ToolTip</code> instance. Valid values are:
		 * 	<ul>
		 * 		<li><code>TextAlign.LEFT</code>,</li>
		 * 		<li><code>TextAlign.CENTER</code>,</li>
		 * 		<li><code>TextAlign.RIGHT</code>.</li>
		 * 	</ul>
		 * 
		 *	@default TextAlign.LEFT
		 */
		public function get textAlign():String {
			return _textUI.textAlign;
		}
		public function set textAlign(value:String):void {
			_textUI.textAlign = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a reference to the <code>Text</code> instance that is used to
		 * 	display the text within this <code>ToolTip</code> instance.
		 */
		public function getTextField():Text {
			return _textUI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addElement(value:*, type:String = "graphic", constraints:Object = null):Element {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function addElementAt(value:*, index:uint, type:String = "graphic", constraints:Object = null):Element {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function addGraphicElements(... rest):void {}
		
		/**
		 * 	@private
		 */
		override public function removeElement(value:*):* {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function removeElementAt(index:int):* {
			return null;
		}
		
		/**
		 * 	@private
		 */
		override public function finalizeElements():void {}
		
		/**
		 * 	@private
		 */
		override public function removeElements():void { }
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			super.finalizeElements();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textUI:Text;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createTextField();
			$showAnchor = true;
			spas_internal::isInitialized(2);
		}
		
		private function createTextField():void {
			_textUI = new Text();
			_textUI.fixToParentWidth = _textUI.fixToParentHeight = true;
			super.addElement(_textUI);
		}
	}
}