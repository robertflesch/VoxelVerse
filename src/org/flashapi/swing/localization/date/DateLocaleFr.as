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

package org.flashapi.swing.localization.date {
	
	// -----------------------------------------------------------
	// DateLocaleFr.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/01/2011 19:14
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DateLocaleFr</code> class is an enumeration of constant values
	 * 	that contains french date denominations, such as days or months names,
	 * 	to be used within the SPAS 3.0 API.
	 * 
	 * 	<p>The default class for date denominations within the SPAS 3.0 API is the
	 * 	<code>DateLocaleEn</code> class.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DateLocaleFr {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new DateLocaleFr
		 * 				instance.
		 */
		public function DateLocaleFr() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An <code>Array</code> that contains the months name references from January 
		 * 	(<code>0</code>) to December (<code>11</code>). Values are:
		 * 	<ul>
		 * 		<li>janvier,</li>
		 * 		<li>fevrier,</li>
		 * 		<li>mars,</li>
		 * 		<li>avril,</li>
		 * 		<li>mai,</li>
		 * 		<li>juin,</li>
		 * 		<li>juillet,</li>
		 * 		<li>août,</li>
		 * 		<li>septembre,</li>
		 * 		<li>octobre,</li>
		 * 		<li>novembre,</li>
		 * 		<li>décembre.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.date.DateFormatter#months
		 */
		public static const MONTHS:Array = 
			["janvier", "fevrier", "mars", "avril", "mai", "juin", "juillet",
			"août", "septembre", "octobre", "novembre", "décembre"];
		
		/**
		 * 	An <code>Array</code> that contains the days name references from Monday 
		 * 	(<code>0</code>) to Sunday (<code>6</code>). Values are:
		 * 	<ul>
		 * 		<li>Lundi,</li>
		 * 		<li>Mardi,</li>
		 * 		<li>Mercredi,</li>
		 * 		<li>Jeudi,</li>
		 * 		<li>Vendredi,</li>
		 * 		<li>Samedi,</li>
		 * 		<li>Dimanche.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.date.DateFormatter#days
		 */
		public static const  DAYS:Array =
			["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];
	}
}