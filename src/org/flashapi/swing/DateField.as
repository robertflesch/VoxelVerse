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
	// DateField.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.5, 15/03/2010 21:22
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.FocusEvent;
	import flash.geom.Point;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.DateEventDispatcher;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.CalendarEvent;
	import org.flashapi.swing.event.SpasEvent;
	import org.flashapi.swing.plaf.libs.DateFieldUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DateField.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the date value of this <code>DateField</code> instance has
	 * 	changed due to mouse interaction with its <code>DatePicker</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.SpasEvent.DATA_CHANGED
	 */
	[Event(name = "dataChanged", type = "org.flashapi.swing.event.SpasEvent")]
	
	/**
	 *  Dispatched when the date value of this <code>DateField</code> instance has
	 * 	changed due to mouse interaction with its <code>DatePicker</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.CalendarEvent.DATE_CHANGED
	 */
	[Event(name = "dateChanged", type = "org.flashapi.swing.event.CalendarEvent")]
	
	/**
	 * 	<img src="DateField.png" alt="DateField" width="18" height="18"/>
	 * 
	 * 	The <code>DateField</code> class provides a Date entry field which is an 
	 * 	occurrence of the <code>TextInput</code> class. When the user clicks inside
	 * 	the bounding box of the <code>DateField</code> object, it pops up a
	 * 	<code>DatePicker</code> instance. Then users can select a <code>Date</code>
	 * 	using the datepicker.
	 * 
	 * 	<p><code>TextInput</code> and <code>DatePicker</code> instances can be
	 * 	accessed through the <code>textInput</code> and <code>datePicker</code>
	 * 	properties of the <code>DateField</code> instance.</p>
	 * 
	 *  @includeExample DateFieldExample.as
	 * 
	 * 	@see org.flashapi.swing.DatePicker
	 * 	@see org.flashapi.swing.TextInput
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DateField extends UIObject implements Observer, LafRenderer, DateEventDispatcher, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DateField</code> instance with the specified
		 * 	parameter.
		 * 
		 * 	@param	width	The width of the <code>DateField</code> instance, in pixels.
		 */
		public function DateField(width:Number = 100) {
			super();
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
		 *  @inheritDoc
		 */
		public function get date():String {
			return _datePicker.date;
		}
		
		/**
		 *  @private
		 */
		private var _textInput:TextInput;
		/**
		 * 	Returns a reference to the <code>TextInput</code> control of this 
		 * 	<code>DateField</code> instance.
		 * 
		 * 	@see #datePicker
		 */
		public function get textInput():TextInput {
			return _textInput;
		}
		
		/**
		 *  @private
		 */
		private var _datePicker:DatePicker;
		/**
		 * 	Returns a reference to the <code>DatePicker</code> control of this 
		 * 	<code>DateField</code> instance.
		 * 
		 * 	@see #textInput
		 */
		public function get datePicker():DatePicker {
			return _datePicker;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				_textInput.display();
				doStartEffect();
			}
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_datePicker.finalize();
			_textInput.finalize();
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if($displayed) {
				_textInput.remove();
				unload();
			}
		}
		
		/**
		 *  Resets the date field object.
		 */
		public function reset():void {
			_textInput.text = "";
			_datePicker.reset();
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
			_textInput.lockLaf(lookAndFeel.getTextInputLaf(), true);
			_textInput.drawIcon(lookAndFeel.getUpIcon());
			_datePicker.lockLaf(lookAndFeel.getDatePickerLaf(), true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function focusInHandler(e:FocusEvent):void {
			var pt:Point = getChoods();
			_datePicker.display(pt.x, pt.y);
		}
		
		/**
		 * @private
		 */
		override protected function focusOutHandler(e:FocusEvent):void {
			if (!_datePicker.container.hitTestPoint (_datePicker.mouseX, _datePicker.mouseY))
				removeCalendar();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createUIObjects();
			initLaf(DateFieldUIRef);
			createEvents();
			$verticalGap = $horizontalGap = 10;
			spas_internal::setSelector(Selectors.DATE_FIELD);
			spas_internal::isInitialized(1);
		}
		
		private function createEvents():void {
			$evtColl.addEvent(_textInput, FocusEvent.FOCUS_IN, focusInHandler);
			$evtColl.addEvent(_textInput, FocusEvent.FOCUS_OUT, focusOutHandler);
			$evtColl.addEvent(_datePicker, CalendarEvent.DATE_CHANGED, dateChangedHandler);
		}
		
		private function dateChangedHandler(e:CalendarEvent):void {
			removeCalendar();
			this.dispatchEvent(new SpasEvent(SpasEvent.DATA_CHANGED));
			this.dispatchEvent(new CalendarEvent(CalendarEvent.DATE_CHANGED));
		}
		
		private function removeCalendar():void {
			_textInput.text = _datePicker.date;
			_datePicker.remove();
		}
		
		private function getChoods():Point {
			return spas_internal::uioSprite.localToGlobal(
				new Point(_textInput.width + $horizontalGap, 0)
			);
		}
		
		private function createUIObjects():void {
			_datePicker = new DatePicker();
			_datePicker.target = $stage;
			_textInput = new TextInput();
			_textInput.labelPlacement = LabelPlacement.RIGHT;
			_textInput.verticalAlignment = VerticalAlignment.MIDDLE;
			_textInput.target = spas_internal::uioSprite;
			_textInput.editable = false;
		}
	}
}