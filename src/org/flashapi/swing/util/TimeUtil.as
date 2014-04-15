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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// TimeUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/08/2009 12:37
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>TimeUtil</code> class is a utility class that defines all-static
	 * 	methods for time formatting.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	*/
	public class TimeUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				TimeUtil instance.
		 */
		public function TimeUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Formats an integer object, representing a number of milliseconds, and
		 * 	converts it to a string under the form <code>"mm:ss"</code>, where 
		 * 	<code>mm</code> is the number of minutes and <code>ss</code> the number
		 * 	of seconds.
		 * 
		 *	@param time An integer that represents a number of milliseconds.
		 *
		 *	@return A literal representation of the specified <code>time</code>.
		 */
		public static function formatTime(time:int):String {
			var s:int = Math.round(time);
			var m:int = 0;
			if (s > 0) {
				while (s > 59) {
					m++;
					s -= 60;
				}
				return String((m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s);
			}
			return "00:00";
		}
		
		/**
		 * 	Converts a duration, in the format HH:MM:SS or MM:SS, into milliseconds
		 * 	and returns the corresponding time value.
		 * 
		 * 	@param	value	A string that specifies a duration in the format
		 * 					HH:MM:SS or MM:SS, where HH represents the hours,
		 * 					MM represents the minutes and SS represents the seconds.
		 * 
		 * 	@return	The specified duration, in milliseconds.
		 */
		public static function durationToTime(value:String):Number {
			var time:Number = 0;
			var buffer:Array = value.split(":");
			var l:int = buffer.length -1;
			var ratio:Array = l == 1 ? [60000, 1000] : [3600000, 60000, 1000];
			for (; l >= 0; l--) time += Number(buffer[l]) * ratio[l];
			return time;
		}
	}
}