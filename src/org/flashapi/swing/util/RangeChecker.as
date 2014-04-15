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
	// RangeChecker.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/01/2008 16:02
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.IndexOutOfBoundsException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>RangeChecker</code> class is a utility class that defines all-static
	 * 	methods to determine whether some values are in a specific range.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RangeChecker {
		
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
		 * 				RangeChecker instance.
		 */
		public function RangeChecker() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Checks whether the integer specified by the <code>value</code> parameter
		 * 	is between the specified <code>maxRange</code>, exclusive, and <code>minRange</code>,
		 * 	exclusive, values.
		 * 
		 * 	@param	value	The integer value to check.
		 * 	@param	maxRange	The maximum integer range value.
		 * 	@param	minRange	The minimum integer range value.
		 * 	@param	variableName	The name of the variable to check, relative to the
		 * 							<code>value</code> parameter.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.IndexOutOfBoundsException
		 * 				An <code>IndexOutOfBoundsException</code> error if the <code>value</code>
		 * 				parameter is not in the admissible range.
		 * 
		 * 	@see #checkNum()
		 * 	@see #test()
		 * 	@see #testNum()
		 */
		public static function check(value:uint, maxRange:uint, minRange:uint = 0, variableName:String="index"):void {
			if (value < minRange || value > maxRange)
				throw new IndexOutOfBoundsException(
					Locale.spas_internal::ERRORS["GET_OUT_OF_RANGE_ERROR"](variableName, value)
					);
		}
		
		/**
		 * 	Checks whether the number specified by the <code>value</code> parameter
		 * 	is between the specified <code>maxRange</code>, exclusive, and <code>minRange</code>,
		 * 	exclusive, values.
		 * 
		 * 	@param	value	The number value to check.
		 * 	@param	maxRange	The maximum number range value.
		 * 	@param	minRange	The minimum number range value.
		 * 	@param	variableName	The name of the variable to check, relative to the
		 * 							<code>value</code> parameter.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.IndexOutOfBoundsException
		 * 				An <code>IndexOutOfBoundsException</code> error if the <code>value</code>
		 * 				parameter is not in the admissible range.
		 * 
		 * 	@see #check()
		 * 	@see #test()
		 * 	@see #testNum()
		 */
		public static function checkNum(value:Number, maxRange:Number, minRange:Number = 0, variableName:String="index"):void {
			if (value < minRange || value > maxRange)
				throw new IndexOutOfBoundsException(
					Locale.spas_internal::ERRORS["GET_OUT_OF_RANGE_ERROR"](variableName, value)
					)
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the integer 
		 * 	specified by the <code>value</code> parameter is between the specified 
		 * 	<code>maxRange</code> and <code>minRange</code>, both exclusives,
		 * 	 values (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@param	value	The integer value to test.
		 * 	@param	maxRange	The integer number range value.
		 * 	@param	minRange	The integer number range value.
		 * 
		 * 	@return	<code>true</code> if the <code>value</code> parameter is in the
		 * 	admissible range; <code>false</code> otherwise.
		 * 
		 * 	@see #checkNum()
		 * 	@see #check()
		 * 	@see #testNum()
		 */
		public static function test(value:uint, maxRange:uint, minRange:uint = 0):Boolean {
			return (value < minRange || value > maxRange);
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the number 
		 * 	specified by the <code>value</code> parameter is between the specified 
		 * 	<code>maxRange</code> and <code>minRange</code>, both exclusives,
		 * 	values (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@param	value	The number value to test.
		 * 	@param	maxRange	The number number range value.
		 * 	@param	minRange	The number number range value.
		 * 
		 * 	@return	<code>true</code> if the <code>value</code> parameter is in the
		 * 	admissible range; <code>false</code> otherwise.
		 * 
		 * 	@see #checkNum()
		 * 	@see #check()
		 * 	@see #test()
		 */
		public static function testNum(value:Number, maxRange:Number, minRange:uint = 0):Boolean {
			return (value < minRange || value > maxRange);
		}
	}
}