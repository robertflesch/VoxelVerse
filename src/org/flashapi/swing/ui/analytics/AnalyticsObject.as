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
	// AnalyticsObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2011 17:35
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	<code>AnalyticsObject</code> objects are used by the <code>Analytics</code>
	 * 	class to store custom collected data.
	 * 
	 * 	@see org.flashapi.swing.ui.analytics.Analytics
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class AnalyticsObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>AnalyticsObject</code> instance with 
		 * 					the specified parameters.
		 * 
		 * 	@param	analyticsRef	The <code>Analytics</code> object which is associated
		 * 							with this <code>AnalyticsObject</code> instance.
		 * 	@param	analyticsType	Indicates the type of analytics object for this
		 * 							<code>AnalyticsObject</code> instance. Possible
		 * 							values are the constants of the <code>AnalyticsType</code>
		 * 							class. Default value is <code>AnalyticsType.UNDEFINED</code>.
		 * 	@param	id				The <code>AnalyticsObject</code> identifier.
		 * 	@param	data			A custom set of data that will be stored by this
		 * 							<code>AnalyticsObject</code> instance to be analysed.
		 */
		public function AnalyticsObject(analyticsRef:Analytics = null, analyticsType:String = "undefined", id:String = null, data:* = null) {
			super();
			initObj(analyticsRef, analyticsType, id, data);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates the type of analytics object for this <code>AnalyticsObject</code>
		 * 	instance. Possible values are the constants of the <code>AnalyticsType</code>
		 * 	class.
		 * 
		 * 	@default null
		 */
		public var analyticsType:String;
		
		/**
		 * 	The <code>Analytics</code> object which is associated with this
		 * 	<code>AnalyticsObject</code> instance.
		 * 
		 * 	@default null
		 */
		public var analyticsRef:Analytics;
		
		/**
		 * 	The <code>AnalyticsObject</code> identifier. The ID should be unique in
		 * 	a document. <strong>Note: </strong>identifiers are case insensitive.
		 * 
		 *  @default null
		 */
		public var id:String;
		
		/**
		 * 	The custom set of data that will be stored by this <code>AnalyticsObject</code>
		 * 	instance to be analysed.
		 * 
		 *  @default null
		 */
		public var data:*;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the time, in milliseconds, at which this <code>AnalyticsObject</code>
		 * 	 has been  registred within the <code>Analytics</code> instance specified 
		 * 	by the <code>analyticsRef</code> property. If the <code>AnalyticsObject</code>
		 * 	has not been added yet to an <code>Analytics</code> instance, the 
		 * 	<code>time</code> property returns <code>-1</code>.
		 * 
		 * 	@default -1
		 */
		public function get time():int {
			return spas_internal::timeRef;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of this <code>AnalyticsObject</code> instance are killed before you delete
		 * 	it.
		 * 
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to definitely kill it.</strong></p>
		 */
		public function finalize():void {
			analyticsRef = null;
			data = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var timeRef:int = -1;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private function initObj(analyticsRef:Analytics, analyticsType:String, id:String, data:*):void {
			this.analyticsRef = analyticsRef;
			this.id = id;
			this.analyticsType = analyticsType;
			this.data = data;
		}
	}
}