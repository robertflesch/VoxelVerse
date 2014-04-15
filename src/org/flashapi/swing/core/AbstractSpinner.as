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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// AbstractSpinner.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.6, 23/02/2010 14:44
	* @see http://www.flashapi.org/
	*/

	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import org.flashapi.swing.constants.SpinButtonAction;
	import org.flashapi.swing.constants.SpinnerButtonsPosition;
	import org.flashapi.swing.event.SpinnerEvent;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.IconizedButton;
	import org.flashapi.swing.TextInput;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------

	/**
	 *  Dispatched when the value of the spinner object changes as a result of
	 * 	user interaction.
	 *
	 *  @eventType org.flashapi.swing.event.SpinnerEvent.VALUE_CHANGED
	 */
	[Event(name="valueChanged", type="org.flashapi.swing.event.SpinnerEvent")]
	
	/**
	 * 	The <code>AbstractSpinner</code> class is the base class for all SPAS 3.0
	 * 	spinner controls. Spinner controls let users step through an allowed set
	 * 	of values and select a value by clicking up or down buttons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractSpinner extends UIObject {
		
		//--> TODO: Replace the spin buttons by a SpinnerButton object.
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractSpinner</code> instance.
		 * 
		 * 	@param	width	The width of the spinner, in pixels.
		 * 	@param	laf		The default Look And Feel class used fot this spinner.
		 */
		public function AbstractSpinner(width:Number, laf:Class) {
			super();
			initObj(width, laf);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>buttonsPosition</code> property.
		 * 
		 * 	@see #buttonsPosition
		 */
		protected var $buttonsPosition:String;
		/**
		 * 	Sets or gets the position of the button controls within this spinner object.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>SpinnerButtonsPosition.TOP</code>,</li>
		 * 		<li><code>SpinnerButtonsPosition.BOTTOM</code>,</li>
		 * 		<li><code>SpinnerButtonsPosition.RIGHT</code>,</li>
		 * 		<li><code>SpinnerButtonsPosition.LEFT</code>,</li>
		 * 	</ul>
		 * 
		 * 	@default SpinnerButtonsPosition.RIGHT
		 */
		public function get buttonsPosition():String {
			return $buttonsPosition;
		}
		public function set buttonsPosition(value:String):void {
			$buttonsPosition = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>decreaseButton</code> property.
		 * 
		 * 	@see #decreaseButton
		 */
		protected var $decreaseButton:IconizedButton;
		/**
		 *  A reference to the button that decrements the value when pressed.
		 */
		public function get decreaseButton():IconizedButton {
			return $decreaseButton;
		}
		
		/**
		 *  @private
		 */
		override public function get height():Number {
			return $textInput.height;
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void { }
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>increaseButton</code> property.
		 * 
		 * 	@see #increaseButton
		 */
		protected var $increaseButton:IconizedButton;
		/**
		 *  A reference to the button that increments the value when pressed.
		 */
		public function get increaseButton():IconizedButton {
			return $increaseButton;
		}
		
		/**
		 * 	Sets or gets the maximum number of characters that can be entered 
		 * 	in the field. A value of <code>0</code> means that any number of characters
		 * 	can be entered.
		 * 
		 *	@default 0
		 */
		public function get maxChars():int {
			return textRef.maxChars;
		}
		public function set maxChars(value:int):void {
			textRef.maxChars = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the spinner object can
		 * 	be edited (<code>true</code>), or not (<code>false</code>).
		 * 
		 *	@default true
		 */
		public function get editable():Boolean {
			return $textInput.editable;
		}
		public function set editable(value:Boolean):void {
			$textInput.editable = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textInput</code> property.
		 * 
		 * 	@see #textInput
		 */
		protected var $textInput:TextInput;
		/**
		 * 	A reference to the input text field that displays the current value
		 * 	within this spinner object.
		 */
		public function get textInput():TextInput {
			return $textInput;
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			$width = value;
			setTextWidth();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function finalize():void {
			_timer.stop();
			_timer = null;
			$textInput.finalize();
			$increaseButton.finalize();
			$decreaseButton.finalize();
			$textInput = null;
			$increaseButton = null;
			$decreaseButton = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the current value for this spinner object.
		 */
		protected var $currentValue:*;
		
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
			$textInput.display();
			$increaseButton.display();
			$decreaseButton.display();
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected  function refresh():void {
			$textInput.text = String($currentValue);
			setPositions();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		protected function getIncreasedValue():* {
			return $currentValue;
		}
		
		/**
		 *  @private
		 */
		protected function getDecreasedValue():* {
			return $currentValue;
		}
		
		/**
		 *  @private
		 */
		protected function getEditedValue():* {
			return $currentValue;
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			$textInput.lockLaf(lookAndFeel.geTextInputLaf(), true);
			$increaseButton.lockLaf(lookAndFeel.getButtonLaf(), true);
			$decreaseButton.lockLaf(lookAndFeel.getButtonLaf(), true);
			fixButtonsHeight();
			setIcons();
			setTextWidth();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private const BTN_SELECTOR:String = "spinnerbutton";
		
		private var _updateType:String;
		private var _timer:Timer;
		private var _focused:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, laf:Class):void {
			$width = width;
			createObjects();
			$buttonsPosition = SpinnerButtonsPosition.RIGHT;
			initLaf(laf);
			$autoFocus = true;
			_focused = false;
			_timer = new Timer(200, 1);
		}
		
		private function createObjects():void {
			$textInput = new TextInput("");
			$textInput.selectable = $textInput.editable = true;
			$textInput.autoFocus = false;
			$increaseButton = new IconizedButton();
			$decreaseButton = new IconizedButton();
			$increaseButton.spas_internal::setSelector(BTN_SELECTOR);
			$decreaseButton.spas_internal::setSelector(BTN_SELECTOR);
			$increaseButton.cornerRadius = $decreaseButton.cornerRadius = 0;
			$increaseButton.target = $decreaseButton.target =
			$textInput.target = spas_internal::uioSprite;
			$evtColl.addEvent($increaseButton, UIMouseEvent.PRESS, increaseValue);
			$evtColl.addEvent($decreaseButton, UIMouseEvent.PRESS, decreaseValue);
			$evtColl.addEvent($textInput, TextEvent.EDITED, textChanged);
			$evtColl.addEvent($textInput, FocusEvent.FOCUS_IN, focusIn);
			$evtColl.addEvent($textInput, FocusEvent.FOCUS_OUT, focusOut);
			$evtColl.addEvent($increaseButton, UIMouseEvent.RELEASE, stopAutoUpdate);
			$evtColl.addEvent($decreaseButton, UIMouseEvent.RELEASE, stopAutoUpdate);
		}
		
		private function setTextWidth():void {
			$textInput.width = $width - lookAndFeel.getButtonWidth() - lookAndFeel.getButtonDelay();
			//dispatchMetricsEvent();
		}
		
		private function increaseValue(e:UIMouseEvent):void {
			$currentValue = getIncreasedValue();
			//dispatchEvent(new SpinnerEvent(this, _currentValue, SpinnerEvent.CHANGED));
			setLabel();
			startAutoUpdate(SpinButtonAction.INCREASE);
			if($autoFocus && !_focused) _focused = true, lookAndFeel.drawEmphasizedState();
		}
		
		private function decreaseValue(e:UIMouseEvent):void {
			$currentValue = getDecreasedValue();
			//dispatchEvent(new SpinnerEvent(this, _currentValue, SpinnerEvent.CHANGED));
			setLabel();
			startAutoUpdate(SpinButtonAction.DECREASE);
			if($autoFocus && !_focused) _focused = true, lookAndFeel.drawEmphasizedState();
		}
		
		private function textChanged(e:TextEvent):void {
			$currentValue = getEditedValue();
			doReflection();
		}
		
		private function setLabel():void {
			$textInput.text = String($currentValue);
			doReflection();
		}
		
		private function focusIn(e:FocusEvent):void {
			if($autoFocus) lookAndFeel.drawEmphasizedState();
			doReflection();
		}
		
		private function focusOut(e:FocusEvent):void {
			if($autoFocus) lookAndFeel.clearEmphasizedState();
			doReflection();
		}
		
		private function setAutoUpdate(event:TimerEvent):void {
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoUpdate);
			$evtColl.addEvent(_timer, TimerEvent.TIMER, setDelayeUpdate);
			_timer.repeatCount = 0;
			_timer.delay = 50;
			_timer.start();
		}
		
		private	function setDelayeUpdate(event:TimerEvent):void {
			switch(_updateType) {
				case SpinButtonAction.INCREASE :
					increaseValue(null);
					break;
				case SpinButtonAction.DECREASE :
					decreaseValue(null);
					break;
			}
		}
		
		private function startAutoUpdate(updateType:String):void {
			_updateType = updateType;
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, onButtonsReleaseOutside);
			$evtColl.addEvent(_timer, TimerEvent.TIMER, setAutoUpdate);
			_timer.start();
		}
		
		private function setIcons():void {
			$increaseButton.drawIcon(lookAndFeel.getUpArrowBrush(), getIconBounds($increaseButton));
			$decreaseButton.drawIcon(lookAndFeel.getDownArrowBrush(), getIconBounds($increaseButton));
		}
		
		private function stopAutoUpdate(e:UIMouseEvent):void {
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoUpdate);
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setDelayeUpdate);
			_timer.repeatCount = 1, _timer.delay = 200;
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, onButtonsReleaseOutside);
			if ($autoFocus && _focused) {
				_focused = false;
				lookAndFeel.clearEmphasizedState();
			}
			doReflection();
			dispatchEvent(new SpinnerEvent(SpinnerEvent.VALUE_CHANGED, $currentValue));
		}
		
		private function onButtonsReleaseOutside(event:MouseEvent):void { stopAutoUpdate(null); }
		
		private function fixButtonsHeight():void {
			var h:Number = $textInput.getBounds(null).height / 2;
			$increaseButton.height = $decreaseButton.height = h;
			var buttonSizeCorrection:Number = $increaseButton.container.getBounds(null).height - $increaseButton.height;
			$increaseButton.height = $decreaseButton.height = h - buttonSizeCorrection;
		}
		
		private function setPositions():void {
			var d:Number = lookAndFeel.getButtonDelay();
			var r:Rectangle = $increaseButton.getBounds(null);
			switch($buttonsPosition) {
				case SpinnerButtonsPosition.TOP :	
					break;
				case SpinnerButtonsPosition.BOTTOM : 
					break;
				case SpinnerButtonsPosition.RIGHT :
					hAdjustment();
					$textInput.x = 0;
					$increaseButton.x = $decreaseButton.x = $textInput.width+d;
					break;
				case SpinnerButtonsPosition.LEFT :
					hAdjustment();
					$increaseButton.x = $decreaseButton.x = 0;
					$textInput.x = $increaseButton.width + d;
					break;
			}
			function hAdjustment():void {
				var xPos:Number = Math.abs(r.x);
				$increaseButton.y = xPos;
				$decreaseButton.y = r.height;
				$increaseButton.width = $decreaseButton.width = lookAndFeel.getButtonWidth();
			}
		}
		
		private function getIconBounds(btn:IconizedButton):Rectangle {
			var b:Rectangle = btn.getBounds(null);
			var to:Number = btn.lookAndFeel.getTopOffset();
			var lo:Number = btn.lookAndFeel.getLeftOffset();
			var rect:Rectangle = new Rectangle(lo - btn.lookAndFeel.getIconDelay(), to,
												b.width - btn.lookAndFeel.getRightOffset() - lo,
												b.height - to - btn.lookAndFeel.getBottomOffset());
			return rect;
		}
	}
}