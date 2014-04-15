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
	// InterfaceValidator.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 26/03/2009 23:19
	* @see http://www.flashapi.org/
	*/

	import flash.utils.describeType;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.exceptions.InvalidInheritanceException;
	import org.flashapi.swing.exceptions.NullPointerException;
	
	/**
	 * 	The <code>InterfaceValidator</code> class is a utility class that defines
	 * 	a method for checking whether a <code>Class</code> object implements
	 * 	a specific interface.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class InterfaceValidator {
		
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
		 * 				InterfaceValidator instance.
		 */
		public function InterfaceValidator() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>InterfaceValidator.validate()</code> method throws an
		 * 	<code>InvalidInheritanceException</code> error if the <code>Class</code>
		 * 	object specified by the <code>obj</code> parameter does not implement
		 * 	the interface specified by the <code>interfaceName</code> parameter.
		 * 
		 * 	<p>The <code>interfaceName</code> parameter must be the fully qualified
		 * 	name of the interface. For example, to check an object for the implementation
		 * 	of the <code>AnalizerLibrary</code> interface, <code>interfaceName</code>
		 * 	must be: <code>"org.flashapi.swing.sound.analizer::AnalizerLibrary"</code>.</p>
		 * 
		 * 	@param	obj	A <code>Class</code> object.
		 * 	@param	interfaceName	The qualified full name of an interface.
		 * 	@param	errorMessage	The error message to be displayed if the <code>Class</code>
		 * 							object does not implement the specified interface.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.NullPointerException
		 * 				A <code>NullPointerException</code> error if the <code>obj</code>
		 * 				parameter is <code>null</code>.
		 *  @throws 	org.flashapi.swing.exceptions.InvalidInheritanceException
		 * 				A <code>InvalidInheritanceException</code> error if the <code>obj</code>
		 * 				parameter does not implement the interface specified by the 
		 * 				<code>interfaceName</code> parameter.
		 */
		public static function validate(obj:Object, interfaceName:String, errorMessage:String):void {
			if (obj == null) throw new NullPointerException(obj.toString());
			if (describeType(obj)..implementsInterface.@type.toXMLString().search(interfaceName) == -1)
				throw new InvalidInheritanceException(errorMessage + obj);
		}
	}
}