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
	// TextInput.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 22:29
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.FocusEvent;
	import flash.text.TextFieldAutoSize;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.plaf.libs.TextInputUIRef;
	import org.flashapi.swing.text.ASTM;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("TextInput.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>TextInput</code> receives the focus.
	 *
	 *  @eventType org.flashapi.swing.event.FocusEvent.FOCUS_IN
	 */
	[Event(name = "focusIn", type = "org.flashapi.swing.event.FocusEvent")]
	
	/**
	 *  Dispatched when the <code>TextInput</code> looses the focus.
	 *
	 *  @eventType org.flashapi.swing.event.FocusEvent.FOCUS_OUT
	 */
	[Event(name = "focusOut", type = "org.flashapi.swing.event.FocusEvent")]
	
	/**
	 * 	<img src="TextInput.png" alt="TextInput" width="18" height="18"/>
	 * 
	 * 	The <code>TextInput</code> class lets you create a single-line text
	 * 	field that is optionally editable. Use the <code>Label</code> class
	 * 	if you need only a single line of noneditable text. <code>TextInput</code> 
	 * 	instances support the HTML rendering capabilities of the Adobe Flash
	 * 	Player.
	 * 
	 * 	<p><code>TextInput</code> instances dispatch change and enter events.</p>
	 * 
	 * 	<p>To disallow editing the text, you set the <code>editable</code>
	 * 	property to <code>false</code>. To conceal the input text by displaying
	 * 	asterisks instead of the characters entered, you set the <code>password</code>
	 * 	property to true.</p>
	 * 
	 * 	<p>The <code>TextInput</code> class is used as a subcomponent in several
	 * 	other classes, such as <code>NumericStepper</code> or <code>ComboBox</code>
	 * 	classes.</p>
	 *
	 * 	@see org.flashapi.swing.Label
	 * 
	 *  @includeExample TextInputExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextInput extends ASTM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>TextInput</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	text	The plain text displayed within this <code>TextInput</code>
		 * 					instance by default.
		 * 	@param	width	The width of the <code>TextInput</code> instance, in pixels.
		 */
		public function TextInput(text:String = "", width:Number = 100) {
			super(text, width);
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
		 * 	A <code>Boolean</code> value that indicates whether this <code>TextInput</code>
		 * 	instance displays entered text as passwords (<code>true</code>), or not
		 * 	(<code>false</code>). If <code>true</code>, the field does not display
		 * 	entered text, instead, each text character appears as the character "*".
		 * 
		 * 	@default false
		 */
		public function get password():Boolean {
			return $password;
		}
		public function set password(value:Boolean):void {
			$password = value;
			spas_internal::textRef.displayAsPassword = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			$needsTextUpdate = $needsTextFormatUpdate = true;
			refresh();
			initStoredHeight();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			updateText();
			spas_internal::textRef.autoSize = TextFieldAutoSize.LEFT;
			if(!$autoSize || !isNaN($width) || $fixToParentWidth) {
				spas_internal::textRef.autoSize = TextFieldAutoSize.NONE;
				spas_internal::textRef.width = getTextWidth();
			} else $width = spas_internal::textRef.width +  $padL + $padR;
			setPositions();
			$borderDecorator.drawBackground();
			$borderDecorator.drawBorders();
			updateButtonMode();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setVerticalAlignment():void {
			if (!$autoHeight && !$autoSize && !$needsVerticalIconUpdate) return;
			var f:Boolean = Boolean(spas_internal::icon != null);
			var ih:Number = f ? spas_internal::icon.height : 0;
			var iPos:Number = 0;
			var tPos:Number = 0;
			var th:Number = spas_internal::textRef.height;
			var h:Number = isNaN($height) ? th : $height;
			switch($vAlignment) {
				case VerticalAlignment.TOP :
					break;
				case VerticalAlignment.MIDDLE :
					iPos = (h - ih) / 2;
					tPos = (h - th) / 2;
					break;
				case VerticalAlignment.BOTTOM :
					iPos = h - ih;
					tPos = h - th;
					break;
			}
			if (f) spas_internal::icon.y = iPos;
			spas_internal::textRef.y = tPos;
			$needsVerticalIconUpdate = false;
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			spas_internal::lafDTO.cornerRadius = $cornerRadius = lookAndFeel.getDefaultRadius();
			super.setSpecificLafChanges();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initLaf(TextInputUIRef);
			initTextFormat();
			$selectable = $autoFocus = true;
			spas_internal::isBorderInstance = true;
			createContainer();
			fixHeight();
			setEditableMode(true);
			$evtColl.addEvent(spas_internal::textRef, FocusEvent.FOCUS_IN, focusIn);
			$evtColl.addEvent(spas_internal::textRef, FocusEvent.FOCUS_OUT, focusOut);
			spas_internal::setSelector(Selectors.INPUT);
			spas_internal::isInitialized(1);
		}
		
		private function focusIn(e:FocusEvent):void {
			if($autoFocus) lookAndFeel.drawEmphasizedState();
			dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
			dispatchTextEvent(TextEvent.TEXT_FOCUS_IN);
		}
		
		private function focusOut(e:FocusEvent):void {
			lookAndFeel.clearEmphasizedState();
			dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
			dispatchTextEvent(TextEvent.TEXT_FOCUS_OUT);
		}
	}
}