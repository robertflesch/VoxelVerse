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
	// LAFValidator.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/07/2007 11:25
	* @see http://www.flashapi.org/
	*/

	import flash.utils.describeType;
	import org.flashapi.swing.exceptions.LookAndFeelException;
	import org.flashapi.swing.exceptions.NullPointerException;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>LAFValidator</code> utility class is an all-static class with methods
	 * 	for working with <code>LookAndFeel</code> objects within the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.core.LafRenderer
	 * 	@see org.flashapi.swing.plaf.LookAndFeel
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LAFValidator {
		
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
		 * 				LAFValidator instance.
		 */
		public function LAFValidator() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>validate()</code> is used within the SPAS 3.0 API to determine
		 * 	whether an object implements the <code>LookAndFeel</code> interface, or
		 * 	not.
		 * 
		 * 	@param	o	An object for which you need to know if it implements the
		 * 				<code>LookAndFeel</code> interface.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.NullPointerException
		 * 				A <code>NullPointerException</code> if the object passed as 
		 * 				value for the <code>o</code> parameter is <code>null</code>.
		 *  @throws 	org.flashapi.swing.exceptions.NullPointerException
		 * 				A <code>LookAndFeelException</code> if the object passed as 
		 * 				value for the <code>o</code> parameter does not implement the
		 * 				<code>LookAndFeel</code> interface.
		 * 
		 * 	@see org.flashapi.swing.plaf.LookAndFeel
		 */
		public static function validate(o:Object):void {
			if (o == null) throw new NullPointerException(o.toString());
			if (describeType(o)..implementsInterface.@type.toXMLString().search("org.flashapi.swing.plaf::LookAndFeel") == -1)
				throw new LookAndFeelException(Locale.spas_internal::ERRORS.LAF_ERROR + o);
		}
	}
}