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

package org.flashapi.swing.event {
	
	// -----------------------------------------------------------
	// ApplicationLoaderEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 12/05/2011 18:05
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>ApplicationLoaderEvent</code> class represents event objects specific to 
	 *  the <code>ApplicationLoader</code> class.
	 * 
	 * 	@see org.flashapi.swing.ApplicationLoader
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ApplicationLoaderEvent extends Event {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>ApplicationLoaderEvent</code> with the 
		 * 	specified parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function ApplicationLoaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The number of items or bytes loaded when the listener processes the event.
		 */
		public function get bytesLoaded():uint {
			return spas_internal::loaded;
		}
		
		/**
		 * 	The total number of items or bytes that will be loaded if the loading
		 * 	process succeeds.
		 */
		public function get bytesTotal():uint {
			return spas_internal::total;
		}
		
		/**
		 * 	A referece to the loaded application until the <code>complete</code> event
		 * 	is dispatched.
		 */
		public function get application():DisplayObject {
			return spas_internal::app;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var app:DisplayObject;
		
		/**
		 * 	@private
		 */
		spas_internal var loaded:uint;
		
		/**
		 * 	@private
		 */
		spas_internal var total:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>ApplicationLoaderEvent.COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>complete</code>
		 * 	event.
		 * 
		 *  <p>The properties of the event object have the following values:</p>
		 *  <table class="innertable">
		 * 		<tr>
		 * 			<th>Property</th><th>Value</th>
		 *		</tr>
		 *		<tr>
		 * 			<td><code>bubbles</code></td><td><code>false</code></td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>application</code></td><td>A referece to the loaded
		 * 			application.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>cancelable</code></td><td><code>false</code></td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>currentTarget</code></td><td>The <code>Object</code> that 
		 *      defines the event listener that handles the event.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>target</code></td><td>The <code>Object</code> that dispatched
		 * 			the event; it is not always the <code>Object</code> listening for the
		 * 			event. Use the <code>currentTarget</code> property to always access the 
		 *			<code>Object</code> listening for the event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType complete
		 */
		public static const COMPLETE:String = "complete";
		
		/**
		 *  The <code>ApplicationLoaderEvent.PROGRESS</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>progress</code>
		 * 	event.
		 * 
		 *  <p>The properties of the event object have the following values:</p>
		 *  <table class="innertable">
		 * 		<tr>
		 * 			<th>Property</th><th>Value</th>
		 *		</tr>
		 *		<tr>
		 * 			<td><code>bubbles</code></td><td><code>false</code></td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>bytesLoaded</code></td><td>The number of items or
		 * 			bytes loaded at the time the listener processes the event.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>bytesTotal</code></td><td>The total number of items
		 * 			or bytes that ultimately will be loaded if the loading process
		 * 			succeeds.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>cancelable</code></td><td><code>false</code></td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>currentTarget</code></td><td>The <code>Object</code> that 
		 *      defines the event listener that handles the event.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>target</code></td><td>The <code>Object</code> that dispatched
		 * 			the event; it is not always the <code>Object</code> listening for the
		 * 			event. Use the <code>currentTarget</code> property to always access the 
		 *			<code>Object</code> listening for the event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType progress
		 */
		public static const PROGRESS:String = "progress";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			var e:ApplicationLoaderEvent = new ApplicationLoaderEvent(type, bubbles, cancelable);
			e.spas_internal::app = spas_internal::app;
			e.spas_internal::loaded = spas_internal::loaded;
			e.spas_internal::total = spas_internal::total;
			return e;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::app = null;
			spas_internal::loaded = spas_internal::total = 0;
		}
	}
}