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

package org.flashapi.swing.calendar {
	
	// -----------------------------------------------------------
	// SimpleDateButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 16/11/2011 10:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 	The <code>SimpleDateButton</code> class represents the default set of
	 * 	interactive date buttons used by datepicker objects.
	 * 
	 * 	@see org.flashapi.swing.DatePicker
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleDateButton extends Sprite implements InteractiveDateRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Constructor. Creates a new <code>SimpleDateButton</code> instance.
		 */
		public function SimpleDateButton() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An object that describes the date represented by this date button.
		 * 	<p>The following table lists the attributes defined by the <code>date</code>
		 * 	object:</p>
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Attribute</th>
		 * 			<th>Type</th>
		 * 			<th>Description</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td><code>day</code></td>
		 * 			<td><code>Number</code></td>
		 * 			<td>The number of day within the current month specified by this
		 * 			date object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>month</code></td>
		 * 			<td><code>Number</code></td>
		 * 			<td>The the month (<code>0</code> for January, <code>1</code>
		 * 				for February, and so on) portion of this date object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>year</code></td>
		 * 			<td><code>Number</code></td>
		 * 			<td>The full year specified by this date object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>dayPosition</code></td>
		 * 			<td><code>Number</code></td>
		 * 			<td>The day of the week (<code>0</code> for Sunday, <code>1</code>
		 * 				for Monday, and so on) specified by this date object.</td>
		 * 			
		 * 		</tr>
		 * 	</table> 
		 */
		public var date:Object;
		
		/**
		 * 	The number of day within the current month specified by this date object.
		 */
		public var day:Number;
		
		/**
		 * 	The the month (<code>0</code> for January, <code>1</code> for February, and
		 * 	so on) portion of this date object.
		 */
		public var month:Number;
		
		/**
		 * 	The full year specified by this date object.
		 */
		public var year:Number;
		
		/**
		 * The day of the week (<code>0</code> for Sunday, <code>1</code> for Monday,
		 * 	and so on) specified by this date object.
		 */
		public var dayPosition:Number;
		
		/**
		 * 	Indicates whether the interactive date button is selected (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public var selected:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the specific date for this interactive date button.
		 * 
		 * 	@param	day The number of day within the current month specified by this
		 * 				date object.
		 * 	@param	month	The the month (<code>0</code> for January, <code>1</code>
		 * 					for February, and so on) portion of this date object.
		 * 	@param	year	The full year specified by this date object.
		 * 	@param	dayPosition The day of the week (<code>0</code> for Sunday, 
		 * 						<code>1</code> for Monday, and so on) specified by
		 * 						this date object.
		 */
		public function setDate(day:Number, month:Number, year:Number, dayPosition:Number):void {
			this.date = { day:day, month:month, year:year, dayPosition:dayPosition };
			this.day = day;
			this.month = month;
			this.year = year;
			this.dayPosition = dayPosition;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			this.removeChild(_textField);
			_textField = null;
		}
		
		/**
		 * 	Sets the height of the text field displayed by the date button, in pixels.
		 * 
		 * 	@param	height	The new height for this <code>SimpleDateButton</code>
		 * 					instance.
		 * 
		 * 	@see #setWidth()
		 */
		public function setHeight(height:Number):void {
			_textField.height = height;
		}
		
		/**
		 * 	Sets the width of the text field displayed by the date button, in pixels.
		 * 
		 * 	@param	width	The new width for this <code>SimpleDateButton</code>
		 * 					instance.
		 * 
		 * 	@see #setHeight()
		 */
		public function setWidth(width:Number):void {
			_textField.width = width;
		}
		
		/**
		 * 	Changes the text the date button.
		 * 
		 * 	@param	text	The new text value for this <code>SimpleDateButton</code>
		 * 					instance.
		 */
		public function setText(text:String):void {
			_textField.text = this.name = text;
		}
		
		/**
		 * 	Sets the default text format of the text field displayed by the date button.
		 * 
		 * 	@param	fmt	The new default text format for this <code>SimpleDateButton</code>
		 * 				instance.
		 */
		public function setTextFormat(fmt:TextFormat):void {
			_textField.defaultTextFormat = fmt;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _textField:TextField;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_textField = new TextField();
			_textField.selectable = this.selected = false;
			addChild(_textField);
		}
	}
}