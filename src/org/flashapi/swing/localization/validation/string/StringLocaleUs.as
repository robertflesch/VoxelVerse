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

package org.flashapi.swing.localization.validation.string {
	
	// -----------------------------------------------------------
	// StringLocaleUs.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/01/2011 16:45
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.localization.validation.LocaleValidation;
	
	/**
	 * 	The <code>StringLocaleUs</code> class is used by <code>StringValidator</code>
	 * 	objects to display error messages in English-US.
	 * 
	 * 	<p>This is the default language class for string validation services within
	 * 	the SPAS 3.0 API.</p>
	 * 
	 * 	@see org.flashapi.swing.validators.StringValidator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class StringLocaleUs implements LocaleValidation {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>StringLocaleUs</code> object.
		 */
		public function StringLocaleUs() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function compose(obj:Object = null):String {
			var msg:String;
			switch(obj.errorType) {
				case 1:
					msg = "This string is shorter than the minimum allowed length. This must be at least " + 
					String(obj.minLength) + " characters long."; 
					break;
				case 2:
					msg = "This string is longer than the maximum allowed length. This must be less than " +
					String(obj.maxLength) + " characters long.";
					break;
			}
			return msg;
		}
	}
}