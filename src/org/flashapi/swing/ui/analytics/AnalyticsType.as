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

package org.flashapi.swing.ui.analytics {
	
	// -----------------------------------------------------------
	// AnalyticsType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2011 17:41
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>AnalyticsType</code> class is an enumeration of constant  
	 * 	values that you can use to set the <code>type</code> property of the
	 * 	<code>AnalyticsObject</code> class.
	 * 
	 * 	@see org.flashapi.swing.ui.analytics.AnalyticsObject#type
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */	
	public class AnalyticsType {
		
		//--------------------------------------------------------------------------
		//
		// 	Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				AnalyticsType instance.
		 */
		public function AnalyticsType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// 	Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Value that represents the default value of <code>AnalitycsInteractiveObject</code>
		 * 	instances.
		 */
		public static const UNDEFINED:String = "undefined";
		
		/**
		 * 	Value that indicates that the <code>AnalyticsObject</code> instance represents
		 * 	the main SPAS 3.0 application.
		 */
		public static const APPLICATION:String = "application";
		
		/**
		 * 	Value that indicates that the <code>AnalyticsObject</code> instance represents
		 * 	a complex view displayed within the SPAS 3.0 application.
		 */
		public static const VIEW:String = "view";
		
		/**
		 * 	Value that indicates that the <code>AnalyticsObject</code> instance represents
		 * 	a SPAS 3.0 control, such as navigation buttons.
		 */
		public static const CONTROL:String = "control";
		
		/**
		 * 	Value that indicates that the <code>AnalyticsObject</code> instance represents
		 * 	a SPAS 3.0 control that has produced an Analytics action after being clicked.
		 */
		public static const CLICK:String = "click";
		
		/**
		 * 	Value that indicates that the <code>AnalyticsObject</code> instance represents
		 * 	an object that stores data.
		 */
		public static const DATA:String = "data";
		
		/**
		 * 	Value that indicates that the <code>AnalyticsObject</code> instance represents
		 * 	a <code>CapabilitiesDTO</code> instance.
		 * 
		 * 	@see org.flashapi.swing.ui.analytics.CapabilitiesDTO
		 */
		public static const SYSTEM:String = "system";
		
		/**
		 * 	
		 */
		public static const EXTERNAL_URL:String = "externalUrl";
		
		/**
		 * 	
		 */
		public static const MAIN_URL:String = "mainUrl";
	}
}