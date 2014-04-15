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

package org.flashapi.swing.localization.validation.date {
	
	// -----------------------------------------------------------
	// DateFormatLocaleFr.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/03/2011 15:47
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.localization.validation.LocaleValidation;
	
	/**
	 * 	The <code>DateFormatLocaleFr</code> class is used by <code>DateValidator</code>
	 * 	objects to display error messages in French.
	 * 
	 * 	<p>The default language class for date validation services within
	 * 	the SPAS 3.0 API is the <code>DateFormatLocaleUs</code> class.</p>
	 * 
	 * 	@see org.flashapi.swing.validators.DateValidator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class DateFormatLocaleFr implements LocaleValidation {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DateFormatLocaleFr</code> object.
		 */
		public function DateFormatLocaleFr() {
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
			return "La date date indiquée n'est pas valide. Les formats possibles sont : DD/MM/YY, DD/MM/YYYY, MM/DD/YY ou MM/DD/YYYY";
		}
	}
}