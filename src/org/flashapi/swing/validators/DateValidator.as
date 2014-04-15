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
	// IPAdressValidator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/03/2011 00:27
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.localization.validation.date.DateFormatLocaleUs;
	
	/**
	 * 	The <code>DateValidator</code> class validates a <code>String</code>
	 * 	that represents a date in the following formats:
	 * 	<ul>
	 * 		<li><code>DD/MM/YY</code>,</li>
	 * 		<li><code>DD/MM/YYYY</code>,</li>
	 * 		<li><code>MM/DD/YY</code>,</li>
	 * 		<li><code>MM/DD/YYYY</code>.</li>
	 * 	</ul>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class DateValidator extends AbstractValidator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DateValidator</code> instance.
		 */
		public function DateValidator() {
			super(DateFormatLocaleUs);
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
			var rxp:RegExp = /^(\d{1,2})\/(\d{1,2})\/(\d{2}|(19|20)\d{2})$/;
			return rxp.test(value);
		}
	}
}