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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// DepthManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 15:25
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DepthManager</code> class is an all-static class with methods for
	 * 	working with the depth of <code>UIObject</code> within the SPAS 3.0 API.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DepthManager {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				DepthManager instance.
		 */
		public function DepthManager() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The maximum depth that you can assign to a <code>UIObject</code>.
		 */
		public static const MAX_DEPTH:uint = 1048575;
		
		/**
		 * 	The minimum depth that you can assign to a <code>UIObject</code>.
		 */
		public static const MIN_DEPTH:uint = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the current depth of the <code>UIObject</code> instance specified
		 * 	by the <code>uio</code> parameter.
		 * 	
		 * 	@param	uio The <code>UIObject</code> instance for which to get the current
		 * 				depth.
		 * 
		 * 	@return	The current depth of a <code>UIObject</code> instance.
		 */
		public static function getDepth(uio:UIObject):uint {
			return uio.parent.getChildIndex(uio.spas_internal::uioSprite);
		}
		
		/**
		 * 	Returns the maximum depth at which a <code>UIObject</code> instance can be
		 * 	displayed within its parent container.
		 * 	
		 * 	@param	uio The <code>UIObject</code> instance for which to get the maximum
		 * 				depth.
		 * 
		 * 	@return	The maximum depth of a <code>UIObject</code> instance within its
		 * 			parent container.
		 */
		public static function getParentMaxDepth(uio:UIObject):uint {
			return uio.parent.numChildren-1;
		}
		
		/**
		 * 	Changes the depth of the <code>UIObject</code> instance, specified
		 * 	by the <code>uio</code> parameter, to display it under all other
		 * 	display objects within the same parent container.
		 * 
		 * 	@param	uio	The <code>UIObject</code> instance to display under all 
		 * 			other display objects within its parent container.
		 */
		public static function setUnderAll(uio:UIObject):void {
			uio.parent.setChildIndex(uio.spas_internal::uioSprite, 0);
		}
		
		/**
		 * 	Changes the depth of the <code>UIObject</code> instance, specified
		 * 	by the <code>uio</code> parameter, to display it over all other
		 * 	display objects within the same parent container.
		 * 
		 * 	@param	uio	The <code>UIObject</code> instance to display over all 
		 * 			other display objects within its parent container.
		 */
		public static function setOverAll(uio:UIObject):void {
			uio.parent.setChildIndex(uio.spas_internal::uioSprite, uio.parent.numChildren-1);
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether a <code>UIObject</code>
		 * 	instance is displayed over all other display objects within the same parent
		 * 	container (<code>true</code>), not (<code>false</code>).
		 * 
		 * 	@param	uio The <code>UIObject</code> to check to know if it is displayed over
		 * 				all other display objects within the same parent container.
		 * 
		 * 	@return	<code>true</code> if the <code>UIObject</code> is displayed over all
		 * 			other display objects within the same parent container.
		 */
		public static function isOverAll(uio:UIObject):Boolean {
			return(uio.parent.getChildAt(uio.parent.numChildren - 1) == uio.spas_internal::uioSprite);
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether a <code>UIObject</code>
		 * 	instance is displayed under all other display objects within the same parent
		 * 	container (<code>true</code>), not (<code>false</code>).
		 * 
		 * 	@param	uio The <code>UIObject</code> to check to know if it is displayed under
		 * 				all other display objects within the same parent container.
		 * 
		 * 	@return	<code>true</code> if the <code>UIObject</code> is displayed under all
		 * 			other display objects within the same parent container; <code>false</code> 
		 * 			otherwise.
		 */
		public static function isUnderAll(uio:UIObject):Boolean {
			return(uio.parent.getChildAt(0) == uio.spas_internal::uioSprite);
		}
		
		/**
		 * 	[Not available yet.]
		 * 	Returns a <code>Boolean</code> value that indicates whether the 
		 * 	<code>UIObject</code> specified by the <code>firstObj</code> parameter 
		 * 	is displayed under the <code>UIObject</code> specified by the <code>secondObj</code> 
		 * 	parameter (<code>true</code>), not (<code>false</code>).
		 * 
		 * 	@param	firstObj 	The <code>UIObject</code> to check to know if it 
		 * 						is displayed over the second one.
		 * 	@param	secondObj 	The <code>UIObject</code> to check to know if it  
		 * 						is displayed under the first one.
		 * 
		 * 	@return	<code>true</code> if <code>firstObj</code> is displayed over
		 * 			<code>secondObj</code>; <code>false</code> otherwise.
		 */
		public static function isAbove(firstObj:UIObject , secondObj:UIObject):Boolean {
			return isBelow(secondObj, firstObj);
		}
		
		/**
		 * 	[Not available yet.]
		 */
		public static function isBelow(firstObj:UIObject , secondObj:UIObject):Boolean {
			//return (secondObj.getChildIndex()-firstObj.getChildIndex()==1);
			return true;
		}
		
		/**
		 * 	[Not available yet.]
		 */
		public static function invert(a:UIObject, b:UIObject):void {
			//a.parent.swapChildren(a, b);
		}
		
		/**
		 * 	[Not available yet.]
		 */
		public static function compareDepth(a:UIObject, b:UIObject):Number {
			//if(a.getChildIndex()>b.getChildIndex()) return -1;
			//else return 1;
			return 1;
		}
	}
}