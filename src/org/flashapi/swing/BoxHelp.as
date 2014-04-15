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
	// BoxHelp.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 07/04/2011 13:16
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.BoxHelpUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("BoxHelp.png")]
	
	/**
	 * 	<img src="BoxHelp.png" alt="BoxHelp" width="18" height="18"/>
	 * 
	 * 	A box-like <code>BubbleHelp</code> implementation. The <code>BoxHelp</code>
	 * 	class can display a single string or a html text.
	 * 
	 * 	<p>To create more complex tooltips, use the <code>ToolTip</code> class.</p>
	 * 
	 * 	<p>You can use the <code>UIManager.setBoxHelpLaf()</code> method to set a
	 * 	new common Look and Feel to all <code>BoxHelp</code> instances within
	 * 	a SPAS 3.0 application.</p>
	 * 
	 * <p><strong><code>BoxHelp</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">color</code></td>
	 * 			<td>Sets the background color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>color</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-color</code></td>
	 * 			<td>Sets the font color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>fontColor</code></td>
	 * 			<td><code>Properties.FONT_COLOR</code></td>
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
	 *  @includeExample BoxHelpExample.as
	 * 
	 * 	@see org.flashapi.swing.ToolTip
	 * 	@see org.flashapi.swing.UIManager#setBoxHelpLaf()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BoxHelp extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BoxHelp</code> instance with the
		 * 	specified parameters.
		 * 
		 *	@param	label 	The plain text that will be displayed by this
		 * 					<code>BoxHelp</code> instance.
		 * 					Default value is <code>""</code> (an empty string).
		 * 	@param	delay 	The amount of time, in milliseconds, before showing the
		 * 					<code>BoxHelp</code> instance. Default value is
		 * 					<code>500</code>.
		 */
		public function BoxHelp(label:String = "", delay:int = 500) {
			super();
			initObj(label, delay);
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
		
		private var _delay:int;
		/**
		 * 	Sets or retrieves the amount of time, in milliseconds, before showing
		 * 	the boxhelp.
		 * 	
		 * 	@default 500
		 */
		public function get delay():int {
			return _delay;
		}
		public function set delay(value:int):void {
			_delay = value;
			if(_timer != null) _timer.delay = _delay;
		}
		
		private var _mouseObject:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the boxhelp coordinates
		 * 	depends on the mouse position (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get mouseObject():Boolean {
			return _mouseObject;
		}
		public function set mouseObject(value:Boolean):void {
			_mouseObject = value;
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void { }
		
		private var _label:String;
		/**
		 *  Sets or gets the plain text displayed within the boxhelp.
		 * 
		 * 	@default An empty String.
		 */
		public function get label():String {
			return _label;
		}
		public function set label(value:String):void {
			_label = value;
			setRefresh();
		}
		
		private var _fontColor:*;
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
			return _fontColor.color;
		}
		public function set fontColor(value:*):void {
			var c:uint;
			switch(true) {
				case isNaN(value) :
				case (value == Color.DEFAULT) :
					_fontColor = NaN;
					c = lookAndFeel.getTextFormat().color;
					break;
				default: c = getColor(value);
			}
			_fmt.color = c;
			spas_internal::textRef.defaultTextFormat = _fmt;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
            if(!$displayed) {
				$evtColl.addEvent(_timer, TimerEvent.TIMER, createObject);
				_timer.start();
			}
		}
		
		/**
		 * @private
		 */
		override public function remove():void {
			lookAndFeel.clearBoxHelp();
			deleteTimerEvent();
			if($displayed) unload();
		}
		
		/**
		 *  @private
		 */
		override public function move(x:Number, y:Number):void {
			if (_mouseObject) {
				var c:Sprite = spas_internal::uioSprite;
				var sw:Number = $stage.stageWidth;
				var sh:Number = $stage.stageHeight;
				var smx:Number = $stage.mouseX;
				var smy:Number = $stage.mouseY;
				var w:Number = spas_internal::textRef.width;
				var h:Number = spas_internal::textRef.height;
				c.x = (sw - (w + smx + _mouseXOffset) <= 0) ? smx - w - 5 : smx + _mouseXOffset;
				c.y = (sh - (h + smy + _mouseYOffset) <= 0) ? smy - h - 5 : smy + _mouseYOffset;
			} else super.move(x, y);
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_timer.stop();
			deleteTimerEvent();
			_timer = null;
			spas_internal::uioSprite.removeChild(spas_internal::textRef);
			_fmt = null;
			spas_internal::textRef = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			spas_internal::textRef.htmlText = _label;
			!$width ?
				setTxtProp(false, TextFieldAutoSize.LEFT, TextAlign.LEFT) :
				setTxtProp(true, TextFieldAutoSize.CENTER, TextAlign.CENTER);
			move(x, y);
			spas_internal::lafDTO.spas_internal::setSize(
				spas_internal::textRef.width, spas_internal::textRef.height);
			lookAndFeel.drawBoxHelp();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_fmt = lookAndFeel.getTextFormat();
			if (!isNaN(_fontColor)) _fmt.color = _fontColor;
			spas_internal::textRef.defaultTextFormat = _fmt;
			spas_internal::textRef.x = lookAndFeel.getHorizontalOffset();
			spas_internal::textRef.y = lookAndFeel.getVerticalOffset();
			_mouseYOffset = lookAndFeel.getYMouseOffset();
			_mouseXOffset = lookAndFeel.getXMouseOffset();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _timer:Timer;
		private var _mouseXOffset:Number;
		private var _mouseYOffset:Number;
		private var _fmt:TextFormat;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, delay:int):void {
			_mouseObject = true;
			_fontColor = NaN;
			_label = label;
			$parent = $stage;
			spas_internal::textRef = new TextField();
			spas_internal::textRef.selectable = false;
			spas_internal::textRef.multiline = true;
			initLaf(BoxHelpUIRef);
			_delay = delay;
			_timer = new Timer(_delay, 1);
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			spas_internal::setSelector(Selectors.BOXHELP);
			spas_internal::lafDTO.currentTarget = spas_internal::uioSprite;
			spas_internal::isInitialized(1);
		}
		
		private function setTxtProp(wordWrap:Boolean, autoSize:String, align:String):void {
			spas_internal::textRef.wordWrap = wordWrap;
			spas_internal::textRef.defaultTextFormat.align = align;
			spas_internal::textRef.autoSize = autoSize;
		}
		
		private function createObject(e:TimerEvent):void {
			doStartEffect();
			refresh();
		}
		
		private function deleteTimerEvent():void {
			if ($evtColl.hasRegisteredEvent(_timer, TimerEvent.TIMER, createObject)) {
				$evtColl.removeEvent(_timer, TimerEvent.TIMER, createObject);
			}
		}
	}
}