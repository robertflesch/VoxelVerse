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
	// ISO3166.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/03/2011 02:09
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ISO3166</code> class creates an object that contains all information
	 * 	about a country name, according to the ISO 3166 standard.
	 * 
	 * 	@see org.flashapi.swing.constants.CountryName
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ISO3166 {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ISO3166</code> instance with the
		 * 					specified parameters.
		 * 
		 * @param	name		The name of the country this <code>ISO3166</code>
		 * 						instance.
		 * @param	alpha2Code	The two-letter country code this <code>ISO3166</code>
		 * 						instance.
		 * @param	alpha3Code	The three-letter country code this <code>ISO3166</code>
		 * 						instance.
		 * @param	numericCode	The three-digit country code this <code>ISO3166</code>
		 * 						instance.
		 */
		public function ISO3166(name:String, alpha2Code:String, alpha3Code:String, numericCode:String) {
			super();
			initObj(name, alpha2Code, alpha3Code, numericCode);
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		/**
		 * 	Returns the name of the country for this <code>ISO3166</code> instance.
		 */
		public function get name():String {
			return _name;
		}
		
		private var _alpha2:String;
		/**
		 *  Returns the two-letter country code for this <code>ISO3166</code> instance,
		 * 	which is used most prominently for the Internet's country code top-level
		 * 	domains.
		 */
		public function get alpha2Code():String {
			return _alpha2;
		}
		
		private var _alpha3:String;
		/**
		 *  Returns the three-letter country code for this <code>ISO3166</code> instance,
		 * 	which allow a better visual association between the code and the country
		 * 	name than the <code>alpha2Code</code>.
		 */
		public function get alpha3Code():String {
			return _alpha3;
		}
		
		private var _numericCode:String;
		/**
		 * 	Returns the three-digit country code for this <code>ISO3166</code> instance.
		 * 	The three-digit country code is identical to those developed and maintained
		 * 	by the United Nations Statistics Division.
		 */
		public function get numericCode():String {
			return _numericCode;
		}
		
		/**
		 * 	Returns the <strong>ISO 3166-2</strong> standard country code for this
		 * 	<code>ISO3166</code> instance.
		 */
		public function get ISO3166_2Code():String {
			return "ISO 3166-2:" + _alpha2;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(name:String, alpha2Code:String, alpha3Code:String, numericCode:String):void {
			_name = name;
			_alpha2 = alpha2Code;
			_alpha3 = alpha3Code;
			_numericCode = numericCode;
		}
	}
}