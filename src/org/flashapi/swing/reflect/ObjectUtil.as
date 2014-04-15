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

package org.flashapi.swing.reflect {
	
	// -----------------------------------------------------------
	// ObjectUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/04/2008 11:38
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 	A utility class to create deep copy of an object with the spefified type.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ObjectUtil extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ObjectUtil</code> instance with the
		 * 	specified properties.
		 * 
		 * 	@param	obj	The object to make a copy from.
		 * 	@param	type	The type fo the object specified by the <code>object</code>
		 * 					parameter.
		 */
		public function ObjectUtil(obj:Object, type:Class) {
			super();
			initObj(obj, type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a deep copy of the object specified as the <code>object</code>
		 * 	parameter of the constructor function.
		 * 
		 * 	@return	A deep copy of an object.
		 */
		public function clone():Object {
			var C:Class = getDefinitionByName(_type) as Class;
            var o:Object = new C();
			var ba:ByteArray = new ByteArray();
			ba.writeObject(_obj);
			ba.position = 0;
			var buffer:Object = ba.readObject();
			for(var prop:* in buffer) o[prop] = buffer[prop];
			buffer = null;
			C = null;
			ba = null;
			return o;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _obj:Object;
		private var _type:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(obj:Object, type:Class):void {
			_obj = obj;
			_type = getQualifiedClassName(type);
			//var description:XML = describeType(object);
			//trace(description);
		}
	}
}