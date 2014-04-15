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
	// DisplayList.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/07/2007 17:28
	* @see http://www.flashapi.org/
	*/

	import flash.display.DisplayObjectContainer;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/*[Deprecated(
		replacement = "org.flashapi.swing.util.DisplayListUtil instead",
		since = "SPAS 3.0 alpha"
	)]*/
	/**
	 * 	The <code>DisplayList</code> class is a utility class that defines all-static
	 * 	methods for working with display list of <code>DisplayObjectContainer</code>.
	 * 
	 * 	@see org.flashapi.swing.util.DisplayListUtil
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DisplayList {
		
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
		 * 				DisplayList instance.
		 */
		public function DisplayList() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Removes all child objects contained within the specified
		 * 	<code>DisplayObjectContainer</code>.
		 * 
		 * 	@param	obj	The <code>DisplayObjectContainer</code> from which to remove
		 * 				all child objects.
		 */
		public static function removeAllChildren(obj:DisplayObjectContainer):void {
			var startNum:uint = obj.numChildren;
			var i:uint = 0;
			for (; i < startNum; ++i) obj.removeChildAt(i);
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the specified
		 * 	<code>DisplayObjectContainer</code> has child objects (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@param	obj	The <code>DisplayObjectContainer</code> to check whether it
		 * 				has child objects.
		 * 
		 * 	@return	<code>true</code> if the <code>DisplayObjectContainer</code>
		 * 			has child objects; <code>false</code> otherwise.
		 */
		public static function hasChildren(obj:DisplayObjectContainer):Boolean {
			return obj.numChildren > 0 ? true : false;
		}
	}
}