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

package org.flashapi.swing.localization {
	
	// -----------------------------------------------------------
	// ISO639.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/09/2011 14:01
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ISO639</code> class creates an object that contains all information
	 * 	about a country name, according to the ISO 639 standard.
	 * 
	 * 	@see org.flashapi.swing.constants.LanguageName
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 6.1
	 */
	public class ISO639 {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ISO639</code> instance with the
		 * 					specified parameters.
		 * 
		 * @param	name		The name of the language this <code>ISO639</code>
		 * 						instance.
		 * @param	alpha2Code	The two-letter language name code this <code>ISO639</code>
		 * 						instance.
		 * @param	alpha3Code	The three-letter language name code this <code>ISO639</code>
		 * 						instance.
		 */
		public function ISO639(name:String, alpha2Code:String, alpha3Code:String) {
			super();
			initObj(name, alpha2Code, alpha3Code);
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		/**
		 * 	Returns the name of the language for this <code>ISO639</code> instance.
		 */
		public function get name():String {
			return _name;
		}
		
		private var _alpha2:String;
		/**
		 *  Returns the two-letter language name code for this <code>ISO639</code> 
		 * 	instance, which is used most prominently for the Internet's language name 
		 * 	code top-level domains.
		 */
		public function get alpha2Code():String {
			return _alpha2;
		}
		
		private var _alpha3:String;
		/**
		 *  Returns the three-letter language name code for this <code>ISO639</code> 
		 * 	instance, which allow a better visual association between the code and the
		 * 	language name name than the <code>alpha2Code</code>.
		 */
		public function get alpha3Code():String {
			return _alpha3;
		}
		
		/**
		 * 	Returns the <strong>ISO 639-2</strong> standard language name code for 
		 * 	this <code>ISO639</code> instance.
		 */
		public function get ISO639_2Code():String {
			return "ISO 639-2:" + _alpha2;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(name:String, alpha2Code:String, alpha3Code:String):void {
			_name = name;
			_alpha2 = alpha2Code;
			_alpha3 = alpha3Code;
		}
	}
}