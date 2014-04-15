/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2009 DevelopmentArc LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 * ***** END MIT LICENSE BLOCK ***** */
package com.developmentarc.core.utils
{
	import mx.effects.easing.Back;
	
	/**
	 * The AdjustableDate Class is a utility that provides a proxy wrapper around
	 * a Date object and contains utility methods intended for helping manage the
	 * Date instance.  The Date object is a Final class so a proxy pattern must be
	 * used to expose the date methods on the AdjustableDate.
	 * 
	 * <p>The AdjustableDate provides helper methods to quickly change the date value
	 * by milliseconds, seconds, minutes, hours, days, months and years.  Instead of
	 * having to set the values you can offset a Date by 4 months by using the offsetYears()
	 * method and passing in 4 as the argument.  This will then move the date forward by
	 * 4 years.</p>
	 * 
	 * <p>The AdjustableDate also can determine if the date is a leap year and also provides
	 * access to the internal date class.</p>
	 * 
	 * @author James Polanco
	 * 
	 */
	public class AdjustableDate
	{
		/* PRIVATE PROPERTIES */
		// internal date object that AdjustableDate wraps
		private var _date:Date;
		
		/* STATIC METHODS */
		/**
		 * Determines if the provided year is a leap year.
		 *  
		 * @param year The year to verify, should be in 4 digit YYYY format.
		 * @return True if year is a leap year, false if not.
		 * 
		 */		
		static public function isLeapYear(year:Number):Boolean
		{
			return ( 0 == (year % 4) && 0 != (year % 100) || 0 == (year % 400)) ? true : false;
		}
		
		/* CONSTRUCTOR */
		/**
		 * @copy Date#Date
		 * 
		 */
		public function AdjustableDate(yearOrTime:Object = null, month:Number=undefined, date:Number=1, hour:Number=0, minute:Number=0, second:Number=0, millisecond:Number=0)
		{
			if(!yearOrTime) {
				// create date based on now
				_date = new Date();
			} else if(month >= 0) {
				// this is probably a year
				_date = new Date(yearOrTime, month, date, hour, minute, second, millisecond);
			} else {
				// create date based on object/time
				_date = new Date(yearOrTime);
			}
		}

		/* PUBLIC METHODS */
		/**
		 * Provides access to the internal date instance.
		 *  
		 * 
		 */
		public function get dateInstance():Date
		{
			return _date;
		}
		
		/**
		 * The number of seconds since midnight January 1, 1970, 
		 * universal time, for a Date object. Use this method to 
		 * represent a specific instant in time when comparing 
		 * two or more AdjustableDate objects.
		 *  
		 * @return 
		 * 
		 */
		public function get sinceEpoch():Number
		{
			return (_date.time / 1000);
		}
		
		/**
		 * Change the current AdjustableDate's milliseconds value
		 * by passing in a postitive or negative number.
		 * 
		 * <p>For example: To set the current time back 500 milliseconds
		 * you would pass in -500.  To set the current time forward 500
		 * milliseconds you would pass in 500.</p>
		 * 
		 * @param amount The number of milliseconds to change the current time by.
		 * 
		 */
		public function offsetMilliseconds(amount:Number):void
		{
			if(amount == 0) return;
			_date.time += amount;			
		}
		
		/**
		 * Change the current AdjustableDate's seconds value
		 * by passing in a postitive or negative number.
		 * 
		 * <p>For example: To set the current time back 10 seconds
		 * you would pass in -10.  To set the current time forward 10
		 * seconds you would pass in 10.</p>
		 * 
		 * @param amount The number of seconds to change the current time by.
		 * 
		 */
		public function offsetSeconds(amount:int):void
		{
			if(amount == 0) return;
			_date.time += (amount * 1000);	
		}
		
		/**
		 * Change the current AdjustableDate's minutes value
		 * by passing in a postitive or negative number.
		 * 
		 * <p>For example: To set the current time back 20 minutes
		 * you would pass in -20.  To set the current time forward 20
		 * minutes you would pass in 20.</p>
		 * 
		 * @param amount The number of minutes to change the current time by.
		 * 
		 */
		public function offsetMinutes(amount:int):void
		{
			if(amount == 0) return;
			_date.time += (amount * 60000);	
		}
		
		/**
		 * Change the current AdjustableDate's hours value
		 * by passing in a postitive or negative number.
		 * 
		 * <p>For example: To set the current time back 5 hours
		 * you would pass in -5.  To set the current time forward 5
		 * hours you would pass in 5.</p>
		 * 
		 * @param amount The number of hours to change the current time by.
		 * 
		 */
		public function offsetHours(amount:int):void
		{
			if(amount == 0) return;
			_date.time += (amount * 3600000);
		}
		
		/**
		 * Change the current AdjustableDate's days value
		 * by passing in a postitive or negative number.
		 * 
		 * <p>For example: To set the current time back 5 days
		 * you would pass in -5.  To set the current time forward 5
		 * days you would pass in 5.</p>
		 * 
		 * @param amount The number of days to change the current time by.
		 * 
		 */
		public function offsetDays(amount:int):void
		{
			if(amount == 0) return;
			_date.time += (amount * 86400000);
		}
		
		/**
		 * Change the current AdjustableDate's months value
		 * by passing in a postitive or negative number. This method
		 * proplery adjusts the months as they pass over years, leap
		 * years, etc.
		 * 
		 * <p>For example: To set the current time back 5 months
		 * you would pass in -5.  To set the current time forward 5
		 * months you would pass in 5.</p>
		 * 
		 * @param amount The number of months to change the current time by.
		 * 
		 */
		public function offsetMonths(amount:int):void
		{
			// get the number of months
			if(amount == 0) return;
			var count:Number = Math.abs(amount);
			var backward:Boolean = (amount < 0) ? true : false;
			
			var currentMonth:Number = _date.month;
			var currentDay:Number = _date.date;
			var currentYear:Number = _date.fullYear;
			
			// offset the months and the years
			for(var i:uint = 0; i < count; i++)
			{
				// get the new month
				(backward) ? currentMonth-- : currentMonth++;
				
				// offset the years
				if(currentMonth > 11) 
				{
					currentMonth = 0;
					currentYear++;
				} else if(currentMonth < 0)  {
					currentMonth = 11;
					currentYear--;
				}
			}
			
			// verify the day is not beyond 28
			var febDays:Number = AdjustableDate.isLeapYear(currentYear) ? 29 : 28;
			if(currentDay > febDays)
			{
				switch(currentMonth)
				{
					case 1:
						// set it to the current month
						currentDay = febDays;
					break;
					
					case 3:
					case 5:
					case 8:
					case 10:
						// set it less the 31
						currentDay = (currentDay > 30) ? 30 : currentDay;
					break;
				}
			}
			
			// update the date
			_date.date = currentDay;
			_date.month = currentMonth;
			_date.fullYear = currentYear;
		}
		
		/**
		 * Change the current AdjustableDate's years value
		 * by passing in a postitive or negative number.
		 * 
		 * <p>For example: To set the current time back 5 years
		 * you would pass in -5.  To set the current time forward 5
		 * years you would pass in 5.</p>
		 * 
		 * @param amount The number of years to change the current time by.
		 * 
		 */
		public function offsetYears(amount:int):void
		{
			if(amount == 0) return;
			_date.fullYear = _date.fullYear + amount;
		}
		
		/* PROXY METHODS */		
		/**
		 * The day of the month (an integer from 1 to 31) specified by a 
		 * Date object according to local time. Local time is determined 
		 * by the operating system on which Flash Player is running.
		 * 
		 * @param value
		 * 
		 */
		 
		public function get date():Number
		{
			return _date.date;
		}
		
		public function set date(value:Number):void
		{
			_date.date = value;
		}
		
		/**
		 * The day of the month (an integer from 1 to 31) of a Date object 
		 * according to universal time (UTC).
		 * 
		 */
		public function get dateUTC():Number {
			return _date.dateUTC;
		}
		
		public function set dateUTC(value:Number):void {
			_date.dateUTC = value;
		}
		
		/**
		 * The day of the week (0 for Sunday, 1 for Monday, and so on) specified 
		 * by this Date according to local time. Local time is determined by the 
		 * operating system on which Flash Player is running.
		 * 
		 */		
		public function get day():Number {
			return _date.day;
		}
		
		/**
		 * The day of the week (0 for Sunday, 1 for Monday, and so on) of this Date 
		 * according to universal time (UTC).
		 * 
		 */		
		public function get dayUTC():Number {
			return _date.dayUTC;
		}
		
		/**
		 * The full year (a four-digit number, such as 2000) of a Date object 
		 * according to local time. Local time is determined by the operating 
		 * system on which Flash Player is running.
		 * 
		 */
		public function get fullYear():Number {
			return _date.fullYear;
		}
		
		public function set fullYear(value:Number):void {
			_date.fullYear = value;
		}
		
		/**
		 * The four-digit year of a Date object according to universal time (UTC).
		 * 
		 */
		public function get fullYearUTC():Number {
			return _date.fullYearUTC;
		}
		
		public function set fullYearUTC(value:Number):void {
			_date.fullYearUTC = value;
		}
		
		/**
		 * The hour (an integer from 0 to 23) of the day portion of a Date 
		 * object according to local time. Local time is determined by the 
		 * operating system on which Flash Player is running.
		 * 
		 */
		public function get hours():Number {
			return _date.hours;
		}
		
		public function set hours(value:Number):void {
			_date.hours = value;
		}
		
		/**
		 * The hour (an integer from 0 to 23) of the day of a Date object 
		 * according to universal time (UTC).
		 * 
		 */
		public function get hoursUTC():Number {
			return _date.hoursUTC;
		}
		
		public function set hoursUTC(value:Number):void {
			_date.hoursUTC = value;
		}
		
		/**
		 * The milliseconds (an integer from 0 to 999) portion of a Date 
		 * object according to local time. Local time is determined by 
		 * the operating system on which Flash Player is running
		 * 
		 */
		public function get milliseconds():Number {
			return _date.milliseconds;
		}
		
		public function set milliseconds(value:Number):void {
			_date.milliseconds = value;
		}
		
		/**
		 * The milliseconds (an integer from 0 to 999) portion of a Date 
		 * object according to universal time (UTC).
		 * 
		 */
		public function get millisecondsUTC():Number {
			return _date.millisecondsUTC;
		}
		
		public function set millisecondsUTC(value:Number):void {
			_date.millisecondsUTC = value;
		}
		
		/**
		 * The minutes (an integer from 0 to 59) portion of a Date object 
		 * according to local time. Local time is determined by the 
		 * operating system on which Flash Player is running.
		 */
		public function get minutes():Number {
			return _date.minutes;
		}
		
		public function set minutes(value:Number):void {
			_date.minutes = value;
		}
		
		/**
		 * The minutes (an integer from 0 to 59) portion of a Date 
		 * object according to universal time (UTC).
		 */
		public function get minutesUTC():Number {
			return _date.minutesUTC;
		}
		
		public function set minutesUTC(value:Number):void {
			_date.minutesUTC = value;
		}

		/**
		 * The month (0 for January, 1 for February, and so on) portion of 
		 * a Date object according to local time. Local time is determined 
		 * by the operating system on which Flash Player is running. 
		 * 
		 */
		public function get month():Number
		{
			return _date.month;
		}
		
		public function set month(value:Number):void
		{
			_date.month = value;
		}
		
		/**
		 * The month (0 [January] to 11 [December]) portion of a Date object 
		 * according to universal time (UTC).
		 * 
		 */
		public function get monthUTC():Number
		{
			return _date.monthUTC;
		}
		
		public function set monthUTC(value:Number):void
		{
			_date.monthUTC = value;
		}
		
		/**
		 * The seconds (an integer from 0 to 59) portion of a Date object 
		 * according to local time. Local time is determined by the 
		 * operating system on which Flash Player is running.
		 * 
		 */
		public function get seconds():Number
		{
			return _date.seconds;
		}
		
		public function set seconds(value:Number):void
		{
			_date.seconds = value;
		}
		
		/**
		 * The seconds (an integer from 0 to 59) portion of a Date object 
		 * according to universal time (UTC).
		 * 
		 */
		public function get secondsUTC():Number
		{
			return _date.secondsUTC;
		}
		
		public function set secondsUTC(value:Number):void
		{
			_date.secondsUTC = value;
		}
		
		/**
		 * The number of milliseconds since midnight January 1, 1970, 
		 * universal time, for a Date object. Use this method to 
		 * represent a specific instant in time when comparing 
		 * two or more AdjustableDate objects.
		 * 
		 * @param value The new time in milliseconds.
		 * 
		 */
		public function get time():Number
		{
			return _date.time;
		}
		
		public function set time(value:Number):void
		{
			_date.time = value;
		}
		
		/**
		 * The difference, in minutes, between universal time (UTC) and 
		 * the computer's local time. Specifically, this value is the 
		 * number of minutes you need to add to the computer's local time 
		 * to equal UTC. If your computer's time is set later than UTC, 
		 * the value will be negative. 
		 * 
		 */
		public function get timezoneOffset():Number {
			return _date.timezoneOffset;
			
		}
		
		/**
		 * Returns a string representation of the day and date only, and does 
		 * not include the time or timezone. Contrast with the following methods:
		 * <ul>
		 * 	<li>AdjustableDate.toTimeString(), which returns only the time and timezone</li>
		 * 	<li>AdjustableDate.toString(), which returns not only the day and date, but also the time and timezone.</li>
		 * </ul> 
		 * 
		 * @return The string representation of day and date only.
		 * 
		 */
		public function toDateString():String {
			return _date.toDateString();
		}
		
		/**
		 * Returns a String representation of the day, date, time, given in local time. 
		 * Contrast with the AdjustableDate.toString() method, which returns the same information 
		 * (plus the timezone) with the year listed at the end of the string.
		 * 
		 * @return The string representation of time and timezone only.
		 * 
		 */
		public function toLocaleString():String {
			return _date.toLocaleString()
		}
		
		/**
		 * Returns a String representation of the day and date only, and does not include 
		 * the time or timezone. This method returns the same value as AdjustableDate.toDateString. 
		 * Contrast with the following methods:
		 * <ul>
		 * 	<li>AdjustableDate.toTimeString(), which returns only the time and timezone</li>
		 * 	<li>AdjustableDate.toString(), which returns not only the day and date, but also the time and timezone.</li>
		 * </ul>
		 * 
		 * @return The String representation of day and date only.
		 * 
		 */
		public function toLocaleDateString():String {
			return _date.toLocaleDateString();
		}
		
		/**
		 * Returns a String representation of the time only, and does not include the day, 
		 * date, year, or timezone. Contrast with the Date.toTimeString() method, 
		 * which returns the time and timezone. 
		 * 
		 * @return The string representation of time and timezone only.
		 * 
		 */
		public function toLocaleTimeString():String {
			return _date.toLocaleTimeString();
		}
		
		/**
		 * Returns a String representation of the day, date, time, and timezone. 
		 * The date format for the output is:
		 * 
		 * <block><code>Day Mon Date HH:MM:SS TZD YYYY</code></block>
		 * 
		 * <p>For example:
		 * <block><code>Wed Apr 12 15:30:17 GMT-0700 2006</code></block>
		 * </p>
		 * 
		 * @return The string representation of a Date object.
		 * 
		 * 
		 */
		public function toString():String {
			return _date.toString();
		}
		
		/**
		 * Returns a String representation of the time and timezone only, 
		 * and does not include the day and date. Contrast with the AdjustableDate.toDateString() 
		 * method, which returns only the day and date. 
		 * 
		 * @return The string representation of time and timezone only.
		 * 
		 */
		public function toTimeString():String {
			return _date.toTimeString();
		}
		
		/**
		 * Returns a String representation of the day, date, and time in 
		 * universal time (UTC). For example, the date February 1, 2005 
		 * is returned as Tue Feb 1 00:00:00 2005 UTC.
		 *  
		 * @return The string representation of a Date object in UTC time.
		 * 
		 */
		public function toUTCString():String {
			return _date.toUTCString();
		}
	}
}