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
	// DateRange.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/12/2011 11:48
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DateRange</code> class represents a range of dates. It provides the
	 * 	API to work with the dates defined in the range.
	 * 
	 * 	@see org.flashapi.swing.DatePicker#selectedRanges
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 6.2
	 */
	public class DateRange {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>DateRange</code> instance.
		 * 
		 * 	@param	startDate	The first date in the range of dates.
		 * 	@param	endDate		The last date in the range of dates. If <code>null</code>,
		 * 						the <code>endDate</code> property is automatically 
		 * 						set to the value of the <code>startDate</code> parameter.
		 * 						Default value is <code>null</code>.
		 * 
		 * 	@throws 	Error An error if the <code>startDate</code> date object
		 * 				is greater than the <code>endDate</code> date object.
		 */
		public function DateRange(startDate:Date, endDate:Date = null) {
			super();
			initObj(startDate, endDate);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _startDate:Date;
		/**
		 * 	Sets or gets the first date in the range of dates.
		 * 
		 * 	@throws Error An error if the <code>startDate</code> date object
		 * 			is greater than the <code>endDate</code> date object.
		 */
		public function get startDate():Date {
			return _startDate;
		}
		public function set startDate(value:Date):void {
			_startDate = value;
			checkDates();
		}
		
		private var _endDate:Date;
		/**
		 * 	Sets or gets the last date in the range of dates.
		 * 
		 * 	@throws Error An error if the <code>startDate</code> date object
		 * 			is greater than the <code>endDate</code> date object.
		 */
		public function get endDate():Date {
			return _endDate;
		}
		public function set endDate(value:Date):void {
			setEndDate(value);
			checkDates();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		public function toString():String {
			var d:String = "-";
			var s:String =
				"[object, DateRange]\nFrom: " + startDate.fullYear + d + startDate.month + d + startDate.date + 
				", To: " + endDate.fullYear + d + endDate.month + d + endDate.date;
			return s;
		}
		
		/**
		 * 	Returns the number of days, the length, in this range of dates.
		 * 
		 * 	@return The length of this <code>DateRange</code> instance.
		 */
		public function getLength():int {
			return _length;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _length:int;
		private static const MS_PER_DAY:Number = 86400000;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(start:Date, end:Date):void {
			_startDate = start;
			setEndDate(end);
			checkDates();
			setLength();
		}
		
		private function setEndDate(end:Date):void {
			_endDate = end == null ? _startDate : end;
		}
		
		private function setLength():void {
			var ms:Number = Math.floor(endDate.time - startDate.time);
			_length = ms / MS_PER_DAY + 1;
		}
		
		private function checkDates():void {
			if (_startDate.getTime() < _startDate.getTime()) {
				throw new Error(Locale.spas_internal::ERRORS.BITMAP_INVALID_MAP_ERROR);
			}
		}
	}
}