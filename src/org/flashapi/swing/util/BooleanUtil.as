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
	// BooleanUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 31/12/2010 19:08
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>BooleanUtil</code> class is a utility class that defines all-static
	 * 	methods for converting <code>String</code> to <code>Boolean</code> primitive
	 * 	values and vice versa.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BooleanUtil extends Object {
		
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
		 * 				BooleanUtil instance.
		 */
		public function BooleanUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Evaluates the <code>value</code> parameter and returns the corresponding
		 * 	<code>Boolean</code>. Possible values can be:
		 * 	<ul>
		 * 		<li>
		 * 			A <code>String</code> which is a literal representation of a
		 * 			<code>Boolean</code> value: either <code>"true"</code> or
		 * 			<code>"false"</code>.
		 * 		</li>
		 * 		<li>
		 * 			A <code>String</code> which is a literal representation of an
		 * 			integer value: either <code>"1"</code> or <code>"0"</code>.
		 * 		</li>
		 * 		<li>
		 * 			An integer value: either <code>1</code> or <code>0</code>.
		 * 		</li>
		 * 		<li>
		 * 			A <code>Boolean</code> value: either <code>true</code> or
		 * 			<code>false</code>.
		 * 		</li>
		 * 	</ul>
		 * 
		 * 	@param	value	The string, number or boolean to evaluate.
		 * 
		 * 	@return	Either <code>true</code> or <code>false</code>, depending on the
		 * 			specified <code>value</code> parameter.
		 * 
		 * 	@see #encodeToString()
		 */
		public static function decode(value:*):Boolean {
			if (value is Boolean) return value;
			var v:Boolean;
			switch(value) {
				case "true" :
				case "1" :
				case 1 :
					v = true;
					break;
				case "false" :
				case "0" :
				case 0 :
					v = false;
					break;
			}
			return v;
		}
		
		/**
		 * 	Converts a <code>Boolean</code> value to its string representation.
		 * 	Returned values are:
		 * 	<ul>
		 * 		<li>
		 * 			<code>"true"</code> if the <code>value</code> parameter is
		 * 			<code>true</code>,
		 * 		</li>
		 * 		<li>
		 * 			<code>"false"</code> if the <code>value</code> parameter is
		 * 			<code>false</code>.
		 * 		</li>
		 * 	</ul>
		 * 	
		 * 	@param	value	The <code>Boolean</code> value to convert to a literal
		 * 					representation.
		 * 
		 * 	@return	Either <code>"true"</code> or <code>"false"</code>, depending on 
		 * 			the specified <code>value</code> parameter.
		 * 
		 * 	@see #decode()
		 */
		public static function encodeToString(value:Boolean):String {
			var v:String;
			switch(value) {
				case true :
					v = "true";
					break;
				case false :
					v = "false";
					break;
			}
			return v;
		}
	}
}