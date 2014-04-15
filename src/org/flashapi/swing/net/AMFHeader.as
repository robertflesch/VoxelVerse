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

package org.flashapi.swing.net {
	
	// -----------------------------------------------------------
	// AMFHeader.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/03/2009 17:00
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	A <code>AMFHeader</code> object encapsulates a context header for the AMF
	 * 	packet structure.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AMFHeader {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AMFHeader</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	operation	Identifies the header and the ActionScript object
		 * 						data associated with it.
		 * 	@param	mustUnderstand	A value of <code>true</code> indicates that the
		 * 							server must understand and process this header
		 * 							before it handles any of the following headers
		 * 							or messages.
		 * 	@param	param	Any ActionScript object.
		 */
		public function AMFHeader(operation:String, mustUnderstand:Boolean = false, param:Object = null) {
			super();
			initObj(operation, mustUnderstand, param);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>operation</code> property.
		 * 
		 * 	@see #operation
		 */
		protected var $operation:String;
		/**
		 * 	Returns a <code>String</code> that identifies the header and the ActionScript 
		 * 	object data associated with this <code>AMFHeader</code> instance.
		 */
		public function get operation():String {
			return $operation;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>mustUnderstand</code> property.
		 * 
		 * 	@see #mustUnderstand
		 */
		protected var $mustUnderstand:Boolean;
		
		/**
		 * 	Returns a <code>Boolean</code> value indicates whether the server must
		 * 	understand and process this header before it handles any of the
		 * 	following headers or messages (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get mustUnderstand():Boolean {
			return $mustUnderstand;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>param</code> property.
		 * 
		 * 	@see #param
		 */
		protected var $param:Object;
		/**
		 * 	Returns any ActionScript object passed as <code>param</code> parameter
		 * 	into the constructor funtion of this <code>AMFHeader</code> instance.
		 * 
		 * 	@default null
		 */
		public function get param():Object {
			return $param;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(operation:String, mustUnderstand:Boolean, param:Object):void {
			$operation = operation;
			$mustUnderstand = mustUnderstand;
			$param = param;
		}
	}
}