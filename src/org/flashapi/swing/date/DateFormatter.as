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

package org.flashapi.swing.date {
	
	// -----------------------------------------------------------
	// DateFormatter.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 21/01/2011 13:46
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import org.flashapi.swing.constants.DateFormat;
	import org.flashapi.swing.constants.DateOrder;
	import org.flashapi.swing.constants.DateSeparator;
	import org.flashapi.swing.constants.YearFormat;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.localization.date.DateLocaleUs;
	
	/**
	 * 	The <code>DateFormatter</code> class creates objects for date formatting.
	 * 	<code>DateFormatter</code> instances provides all methods an properties to
	 * 	format date objects according to locale specifications.
	 * 
	 * 	<p>Default locale specifications for <code>DateFormatter</code> objects are
	 * 	US-English formated dates.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DateFormatter extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DateFormatter</code> instance.
		 */
		public function DateFormatter() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _order:String = DateOrder.MDY;
		/**
		 * 	Sets or gets the format order, between days, months an years, within
		 * 	a date object. Possible values are the <code>DateOrder</code> class
		 * 	constant values.
		 * 
		 * 	@default DateOrder.MDY
		 */
		public function get order():String {
			return _order;
		}
		public function set order(value:String):void {
			_order = value;
		}
		
		private var _yearFormat:String = YearFormat.FOUR_DIGITS;
		/**
		 * 	Sets or gets the format of the year within a date object. Possible values
		 * 	are the <code>YearFormat</code> class constant values.
		 * 
		 * 	@default YearFormat.FOUR_DIGITS
		 */
		public function get yearFormat():String {
			return _yearFormat;
		}
		public function set yearFormat(value:String):void {
			_yearFormat = value;
		}
		
		private var _separator:String = DateSeparator.SLASH;
		/**
		 * 	Specifies the type of separator used to format a date object. Possible 
		 * 	values are the <code>DateSeparator</code> class constant values.
		 * 
		 * 	@default DateSeparator.SLASH
		 */
		public function get separator():String {
			return _separator;
		}
		public function set separator(value:String):void {
			_separator = value;
		}
		
		private var _space:Boolean = false;
		/**
		 * 	[Not implemented yet.]
		 */
		public function get space():Boolean {
			return _space;
		}
		public function set space(value:Boolean):void {
			_space = value;
		}
		
		private var _monthFormat:String = DateFormat.NUMBER;
		/**
		 * 	A <code>String</code> value that indicates whether the month value
		 * 	within the date object is its name (<code>DateFormat.STRING</code>),
		 * 	or its number (<code>DateFormat.NUMBER</code>).
		 * 
		 * 	@default DateFormat.NUMBER
		 * 
		 * 	@see #monthLength
		 */
		public function get monthFormat():String {
			return _monthFormat;
		}
		public function set monthFormat(value:String):void {
			_monthFormat = value;
		}
		
		private var _dayFormat:String = DateFormat.NUMBER;
		/**
		 * 	A <code>String</code> value that indicates whether the day value
		 * 	within the date object is its name (<code>DateFormat.STRING</code>),
		 * 	or its number (<code>DateFormat.NUMBER</code>).
		 * 
		 * 	@see #dayLength
		 * 
		 * 	@default DateFormat.NUMBER
		 */
		public function get dayFormat():String {
			return _dayFormat;
		}
		public function set dayFormat(value:String):void {
			_dayFormat = value;
		}
		
		private var _monthLength:int = 3;
		/**
		 * 	Sets or gets the number of pattern letters used within the date object
		 * 	when the <code>monthFormat</code> property is <code>DateFormat.STRING</code>.
		 * 	If set to <code>-1</code>, the full name of the month is used.
		 * 
		 * 	@default 3
		 * 
		 * 	@see #monthFormat
		 * 	@see #months
		 */
		public function get monthLength():int {
			return _monthLength;
		}
		public function set monthLength(value:int):void {
			_monthLength = value;
		}
		
		private var _dayLength:int = -1;
		/**
		 * 	Sets or gets the number of pattern letters used within the date object
		 * 	when the <code>dayFormat</code> property is <code>DateFormat.STRING</code>.
		 * 	If set to <code>-1</code>, the full name of the day is used.
		 * 
		 * 	@default -1
		 * 
		 * 	@see #dayFormat
		 * 	@see #days
		 */
		public function get dayLength():Number {
			return _dayLength;
		}
		public function set dayLength(value:Number):void {
			_dayLength = value;
		}
		
		private var _months:Array = DateLocaleUs.MONTHS;
		/**
		 * 	Sets or gets an <code>Array</code> that contains the twelve month names
		 * 	for the specified localization.
		 * 
		 * 	@default DateLocaleUs.MONTHS
		 */
		public function get months():Array {
			return _months;
		}
		public function set months(value:Array):void {
			_months = value;
		}
		
		private var _days:Array = DateLocaleUs.DAYS;
		/**
		 * 	Sets or gets an <code>Array</code> that contains the seven day names
		 * 	for the specified localization.
		 * 
		 * 	@default DateLocaleUs.DAYS
		 */
		public function get days():Array {
			return _days;
		}
		public function set days(value:Array):void {
			_days = value;
		}
		
		private var _yearSymbol:String = "";
		/**
		 * 	Sets of get an additional year symbol than can be used in languages 
		 * 	such like Japanese. Default value is an empty string.
		 * 
		 * 	@default ""
		 */
		public function get yearSymbol():String {
			return _yearSymbol;
		}
		public function set yearSymbol(value:String):void {
			_yearSymbol = value;
			fixYearSymbol();
		}
		
		private var _truncateMonthDigit:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the month number
		 * 	is zero-padded (<code>false</code>), or not (<code>true</code>);
		 * 
		 * 	@default false
		 */
		public function get truncateMonthDigit():Boolean {
			return _truncateMonthDigit;
		}
		public function set truncateMonthDigit(value:Boolean):void {
			_truncateMonthDigit = value;
		}
		
		private var _truncateDayDigit:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the day number
		 * 	is zero-padded (<code>false</code>), or not (<code>true</code>);
		 * 
		 * 	@default false
		 */
		public function get truncateDayDigit():Boolean {
			return _truncateDayDigit;
		}
		public function set truncateDayDigit(value:Boolean):void {
			_truncateDayDigit = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_dateOrder = null;
			_dateObject = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Partially implemented.] Generates a date-formatted <code>String</code>
		 * 	from either a date-formatted <code>String</code> or <code>Date</code>a
		 * 	object.
		 * 
		 * 	@param	date	Date to format.
		 * 
		 * 	@return The date-formatted <code>String</code>.
		 */
		public function format(date:Object):String {
			if(checkDateObject(date)) {
				formatDay();
				formatMonth();
				formatYear();
				_date = _dateOrder[_order.substr(0, 1)] + _separator + 
						_dateOrder[_order.substr(1, 1)] + _separator +
						_dateOrder[_order.substr(2, 1)];
				return _date;
			}
			return _date;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _day:String;
		private var _month:String;
		private var _year:String;
		private var _dateObject:Object;
		private var _date:String;
		private var _dateOrder:Object;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_dateOrder = { };
		}
		
		private function formatDay():void {
			switch(_dayFormat) {
				case DateFormat.STRING : 
					var tempDay:String = _days[_dateObject.dayPosition];
					_day = _dayLength == -1 ? tempDay : tempDay.substr(0, _dayLength);
					break;	
				case DateFormat.NUMBER : 
					_day = fixLength(String(_dateObject.day), _truncateDayDigit);
					break;
			}
			_dateOrder["D"] = _day;
		}
		
		private function formatMonth():void {
			switch(_monthFormat) {
				case DateFormat.STRING :
					var tempMonth:String = _months[_dateObject.month-1];
					_month = _monthLength == -1 ? tempMonth : tempMonth.substr(0, _monthLength);
					break;	
				case DateFormat.NUMBER :
					_month = fixLength(String(_dateObject.month), _truncateMonthDigit);
					break;
			}
			_dateOrder["M"] = _month;
		}
		
		private function formatYear():void {
			var tempYear:String = String(_dateObject.year);
			switch(_yearFormat) {
				case YearFormat.TWO_DIGITS :
					_year = tempYear.substr(0, 2);
					break;	
				case YearFormat.FOUR_DIGITS :
					_year = tempYear;
					break;
			}
			fixYearSymbol();
		}
		
		private function fixLength(value:String, truncate:Boolean):String {
			if(!truncate && value.length == 1) value = "0" + value;
			return value;
		}
		
		private function fixYearSymbol():void {
			_dateOrder["Y"] = _year + _yearSymbol;
		}
		
		private function checkDateObject(date:Object):Boolean {
			/*trace(isNaN(date.day), date.day, typeof(date._day));
			if(isNaN(date.day) || isNaN(date.month)|| isNaN(date.year) || isNaN(date.dayPosition)) {
				_date = "Warning: Invalid date format!";
				return false;
			}*/
			_dateObject = date;
			return true;
		}
		
		/*
		public static function getDateIso8601Long(date:Date):String {
				var str:String = date.getFullYear().toString()
				str = str +"-"+ ((String((date.getMonth()+1)).length == 1)?"0"+(date.getMonth()+1):(date.getMonth()+1)).toString()
				str = str +"-"+ ((date.getDate().toString().length == 1)?"0"+date.getDate():date.getDate()).toString()
				str = str +"T"+ ((date.getHours().toString().length == 1)?"0"+date.getHours():date.getHours()).toString()
				str = str +":"+ ((date.getMinutes().toString().length == 1)?"0"+date.getMinutes():date.getMinutes()).toString()
				str = str +":"+ ((date.getSeconds().toString().length == 1)?"0"+date.getSeconds():date.getSeconds()).toString()
				var ms:String = date.getMilliseconds().toString()
				while (ms.length < 3)
					ms = "0"+ms
				str = str+"."+ms
				var offsetMinute:Number = date.getTimezoneOffset()
				var direction:Number = (offsetMinute<0)?1:-1
				var offsetHour:Number = Math.floor(offsetMinute/60)
				offsetMinute = offsetMinute-(offsetHour*60)

				var offsetHourStr:String = offsetHour.toString()
				while (offsetHourStr.length < 2)
					offsetHourStr = "0"+offsetHourStr
				var offsetMinuteStr:String = offsetMinute.toString()
				while (offsetMinuteStr.length < 2)
					offsetMinuteStr = "0"+offsetMinuteStr
				str = str+((direction == -1)?"-":"+")+offsetHourStr+":"+offsetMinuteStr
				return str 
			} 
		 */
	}
}