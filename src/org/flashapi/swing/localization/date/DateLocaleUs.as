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
	// DateLocaleUs.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/01/2011 19:13
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DateLocaleUs</code> class is an enumeration of constant values
	 * 	that contains US english date denominations, such as days or months names,
	 * 	to be used within the SPAS 3.0 API.
	 * 
	 * 	<p>The <code>DateLocaleUs</code> class is the default class for date
	 * 	denominations within the SPAS 3.0 API.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DateLocaleUs {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new DateLocaleUs
		 * 				instance.
		 */
		public function DateLocaleUs() {
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
		 * 		<li>January,</li>
		 * 		<li>February,</li>
		 * 		<li>March,</li>
		 * 		<li>April,</li>
		 * 		<li>May,</li>
		 * 		<li>June,</li>
		 * 		<li>July,</li>
		 * 		<li>August,</li>
		 * 		<li>September,</li>
		 * 		<li>October,</li>
		 * 		<li>November,</li>
		 * 		<li>December.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.date.DateFormatter#months
		 */
		public static const MONTHS:Array = 
			["January", "February", "March", "April", "May", "June", "July",
			"August", "September", "October", "November", "December"];
		
		/**
		 * 	An <code>Array</code> that contains the days name references from Monday 
		 * 	(<code>0</code>) to Sunday (<code>6</code>). Values are:
		 * 	<ul>
		 * 		<li>Monday,</li>
		 * 		<li>Tuesday,</li>
		 * 		<li>Wednesday,</li>
		 * 		<li>Thursday,</li>
		 * 		<li>Friday,</li>
		 * 		<li>Saturday,</li>
		 * 		<li>Sunday.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.date.DateFormatter#days
		 */
		public static const DAYS:Array =
			["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday",
			"Sunday"];
	}
}