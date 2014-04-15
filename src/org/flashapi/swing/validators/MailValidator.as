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

package org.flashapi.swing.validators {
	
	// -----------------------------------------------------------
	// MailValidator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/11/2008 16:04
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.localization.validation.mail.MailLocaleUs;
	
	/**
	 * 	The <code>MailValidator</code> class validates that a <code>String</code>
	 * 	has a single <code>&#64;</code> sign, a period in the domain name and that 
	 * 	the top-level domain suffix has two, three, four, or six characters.
	 * 	<span class="hide"> IP domain names are valid if they are enclosed in
	 * 	square brackets.</span> The validator does not check whether the domain
	 * 	and user name actually exist.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MailValidator extends AbstractValidator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>MailValidator</code> instance.
		 */
		public function MailValidator() {
			super(MailLocaleUs);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function validate(value:String):Boolean {
			var rxp:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return rxp.test(value);
		}
	}
}