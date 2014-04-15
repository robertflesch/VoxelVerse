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

package org.flashapi.collector.core {
	
	// -----------------------------------------------------------
	// EventListnerProxy.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 15/06/2011 13:08
	* @see http://www.flashapi.org/
	*/
	
	use namespace collector_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>EventListnerProxy</code> class creates proxy objects that are used
	 * 	within <code>EventCollector</code> instances to easilly manage <code>EventListner</code>
	 *  objects.
	 * 
	 * 	@see org.flashapi.collector.EventCollector
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class EventListnerProxy {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>EventListnerProxy</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	obj	The <code>EventDispatcher</code> object for this <code>EventListnerProxy</code>.
		 * 	@param	event	The type of event for this <code>EventListnerProxy</code>.
		 * 	@param	func	The listener function associated with the <code>EventDispatcher</code>
		 * 					object specified by the <code>obj</code> parameter.
		 */
		public function EventListnerProxy(obj:Object, event:String, func:Function) {
			super();
			initObj(obj, event, func);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		collector_internal var objRef:Object;
		/**
		 * 	The <code>EventDispatcher</code> that is embedded by this <code>EventListnerProxy</code>
		 * 	object.
		 */
		public function get obj():Object {
			return collector_internal::objRef;
		}
		
		/**
		 * 	@private
		 */
		collector_internal var eventRef:String;
		/**
		 * 	The type of event for this <code>EventListnerProxy</code> object.
		 */
		public function get event():String {
			return collector_internal::eventRef;
		}
		
		/**
		 * 	@private
		 */
		collector_internal var funcRef:Function;
		/**
		 * 	The listener function associated with the <code>EventDispatcher</code> object
		 * 	embedded by this <code>EventListnerProxy</code>.
		 */
		public function get func():Function {
			return collector_internal::funcRef;
		}
		
		/**
		 * 	Deletes this <code>EventListnerProxy</code> instance.
		 */
		public function finalize():void {
			collector_internal::objRef = null;
			collector_internal::eventRef = null;
			collector_internal::funcRef = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(obj:Object, event:String, func:Function):void {
			collector_internal::objRef = obj;
			collector_internal::eventRef = event;
			collector_internal::funcRef = func;
		}
	}
}