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
	// ArrayUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 30/11/2009 14:08
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>ArrayUtil</code> class is a utility class that defines all-static
	 * 	methods for working with <code>Array</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ArrayUtil {
		
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
		 * 				ArrayUtil instance.
		 */
		public function ArrayUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Makes and returns a copy of an array.
		 * 
		 * 	@param	array	The array to copy.
		 * 
		 * 	@return	A copy of the array passed as <code>array</code> parameter.
		 */
		public static function clone(array:Array):Array {
			return array.concat();
		}
		
		/**
		 * 	Swaps the order of the two elements of the <code>array</code> parameter at
		 * 	the indexes specified by <code>index1</code> and <code>index2</code>. All
		 * 	other elements in the array remain in the same index positions.
		 * 
		 * 	@param	array	The <code>Array</code> which contains the elements to
		 * 					swap from their indexes.
		 * 	@param	index1	The index of the first element.
		 * 	@param	index2	The index of the second element.
		 * 
		 * 	@return	The original, array after having been modified.
		 */
		public static function swapValuesAt(array:Array, index1:uint, index2:uint):Array {
			var obj1:Object = array[index1];
			var obj2:Object = array[index2];
			array[index1] = obj2;
			array[index2] = obj1;
			return array;
		}
	}
}