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

package org.flashapi.tween.constant {
	
	// -----------------------------------------------------------
	// TweenExceptionType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/05/2011 15:22
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>TweenExceptionType</code> class is an enumeration of constant 
	 * 	values that are internally used by <code>ITween</code> objects to throw
	 * 	specific exceptions.
	 * 
	 * 	@see org.flashapi.tween.exception.TweenException
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TweenExceptionType {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 */
		public function TweenExceptionType() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The message displayed when the types of <code>start</code> and 
		 * 	<code>end</code> parameters of a tween object do not match.
		 */
		public static const DATA_TYPE_MISMATCH:String = 
			"'start' end 'end' data types must match.";
		
		/**
		 * 	The message displayed when the lengths of <code>start</code> and
		 * 	<code>end</code> array parameters of a tween object do not match.
		 */
		public static const DATA_LENGTH_MISMATCH:String = 
			"'start' end 'end' data lengths must match.";
		
		/**
		 * 	The message displayed when the <code>start</code> or the
		 * 	<code>end</code> parameter of a tween object is <code>null</code>.
		 */
		public static const NULL_DATA_EXCEPTION:String = 
			"'start' or 'end' data must not be null.";
	}
}