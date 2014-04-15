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
	// AnalitycsInteractiveObject.as
	// -----------------------------------------------------------
	
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/03/2011 23:22
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>AnalitycsInteractiveObject</code> interface defines the basic set 
	 * 	of APIs that you must implement to create objects that can directly interact 
	 * 	with the SPAS 3.0 analitycs API.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public interface AnalitycsInteractiveObject {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>analitycsData</code> property lets you pass a value to this
		 * 	<code>AnalitycsInteractiveObject</code> instance.
		 * 
		 * 	@default null
		 * 
		 * 	@see org.flashapi.swing.ui.analytics.AnalyticsObject#data
		 */
		function get analitycsData():*;
		function set analitycsData(value:*):void;
		
		/**
		 * 	Gets or sets the <code>AnalitycsInteractiveObject</code> identifier.
		 * 
		 *  @default null
		 * 
		 * 	@see org.flashapi.swing.ui.analytics.AnalyticsObject#id
		 */
		function get id():String;
		function set id(value:String):void;
		
		/**
		 * 	Gets or sets the type of data that is collected by this 
		 * 	<code>AnalitycsInteractiveObject</code> instance.
		 * 
		 *  @default AnalyticsType.UNDEFINED
		 * 
		 * 	@see org.flashapi.swing.ui.analytics.AnalyticsObject#analyticsType
		 */
		function get analitycsType():String;
		function set analitycsType(value:String):void;
		
		/**
		 * 	Gets or sets the <code>Analytics</code> instance which is associated
		 * 	to this <code>AnalitycsInteractiveObject</code> instance. If not <code>null</code>,
		 * 	this <code>AnalitycsInteractiveObject</code> instance is automatically
		 * 	integrated to the Analytics flow. If <code>null</code>, it is ignored by
		 * 	the Analytics API and can be integrated to the Analytics flow by using the
		 * 	Analytics programmatic API.
		 * 
		 *  @default null
		 * 
		 * 	@see org.flashapi.swing.ui.analytics.AnalyticsObject#analyticsRef
		 */
		function get analitycsRef():Analytics;
		function set analitycsRef(value:Analytics):void;
		
		/**
		 * 	Returns a reference to the <code>AnalyticsObject</code> instance that defines  
		 * 	this <code>AnalitycsInteractiveObject</code> instance as an integrated producer 
		 * 	element to be used by the Analytics flow.
		 */
		function get analitycsObj():AnalyticsObject;
		//function set analitycsObj(value:AnalyticsObject):void;
	}
}