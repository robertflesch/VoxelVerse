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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// UIDescriptor.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/02/2011 14:47
	* @see http://www.flashapi.org/
	*/
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>UIDescriptor</code> class provides methods for defining the current
	 * 	SPAS 3.0 API and accessing the related API manager.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class UIDescriptor {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		public function UIDescriptor() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// 	Public methods
		//
		//--------------------------------------------------------------------------
		
		private static var _interfaceName:String;
		/**
		 * 	Teturns the name of the SPAS 3.0 API specified by this <code>UIDescriptor</code>
		 * 	instance.
		 * 
		 * 	@return	The name of the SPAS 3.0 API specified by this <code>UIDescriptor</code>
		 * 	instance.
		 */
		public static function getInterfaceName():String {
			return _interfaceName;
		}
		
		private static var _managerRef:*;
		/**
		 * 	Returns a reference to the <code>IUIManager</code> class that is used to
		 * 	managed the current SPAS 3.0 API.
		 * 
		 * 	@return	A reference to the <code>IUIManager</code> class that is used to
		 * 			managed the current SPAS 3.0 API.
		 */
		public static function getUIManager():* {
			return _managerRef;
		}
		
		//--------------------------------------------------------------------------
		//
		// 	Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal static const SPAS_XML_NAMESPACE:String = "http://www.flashapi.org/spas";
		
		/**
		 * @private
		 */
		spas_internal static const SPAS_URL:String = "http://www.flashapi.org/";
		
		//--------------------------------------------------------------------------
		//
		// 	Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function initDescriptor(interfaceName:String, managerRef:Class):void {
			_interfaceName = interfaceName;
			_managerRef = managerRef;
			UIObject.spas_internal::setUIManager(managerRef);
		}
	}
}