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

package org.flashapi.swing.databinding {
	
	// -----------------------------------------------------------
	//  EasingProviderDto.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 12/07/2011 14:12
	 *  @see http://www.flashapi.org/
	 */
	
	/**
	 * 	The <code>EasingProviderDto</code> class creates transfert objects for storing
	 * 	the properties of an <code>Easing</code> object within an <code>EasingProvider</code>
	 * 	instance.
	 * 
	 * 	@see org.flashapi.tween.core.Easing
	 * 	@see org.flashapi.swing.databinding.EasingProvider
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 6.1
	 */
	public class EasingProviderDto extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>EasingProviderDto</code> instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	easing	The class reference to the <code>Easing</code> function.
		 * 	@param	type	The type of <code>Easing</code> function. Possible values
		 * 					are constants of the <code>EasingType</code> class.
		 * 	@param	name	The name of the <code>Easing</code> function.
		 */
		public function EasingProviderDto(easing:Class, type:String, name:String) {
			super();
			initObj(easing, type, name);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The name of the <code>Easing</code> function.
		 */
		public var name:String;
		
		/**
		 * 	The class reference to the <code>Easing</code> function.
		 */
		public var easing:Class;
		
		/**
		 * 	The type of <code>Easing</code> function. Possible values are constants
		 * 	of the <code>EasingType</code> class.
		 * 
		 * 	@see org.flashapi.tween.constant.EaseType
		 */
		public var type:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(easing:Class, type:String, name:String):void {
			this.easing = easing;
			this.type = type;
			this.name = name;
		}
	}
}