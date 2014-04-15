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

package org.flashapi.swing.core.crypto {
	
	// -----------------------------------------------------------
	// GUID.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/03/2011 17:14
	* @see http://www.flashapi.org/
	*/
	
	import flash.system.Capabilities;
	
	/**
	 *  Generates a GUID (Genuine Unique IDentifier) based on ActionScript
	 *  pseudo-random number generator and the current time.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class GUID extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Generates a new <code>GUID</code> instance.
		 */
		public function GUID() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>String</code> that represents a Genuine Unique IDentifier.
		 * 
		 * 	@return	A Genuine Unique IDentifier string representation.
		 */
		public function toString():String {
			return _uid;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static var _counter:uint = 0;
		private var _uid:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var id1:Number = new Date().getTime();
			var id2:Number = Math.random() * Number.MAX_VALUE;
			var id3:String = Capabilities.serverString;
			_uid = SHA1.encrypt(id1 + id3 + id2 + _counter++);
		}
	}
}