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
	// IndexEvent.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 12/05/2011 19:10
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>IndexEvent</code> class represents events that are dispatched when
	 * 	an index changes. Index events are tipically dispatech by <code>Listable</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.list.Listable
	 * 	@see org.flashapi.swing.event.ListEvent
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class IndexEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>IndexEvent</code> with the specified
		 * 					parameters.
		 * 
		 *  @param type 	The event type; indicates the action that caused the event.
		 * 	@param	newIndex	The zero-based index after the change. 
		 * 	@param	oldIndex	The zero-based index before the change.
		 * 	@param	relatedObject	The item associated with the index change.
		 * 	@param	triggerEvent	The event that triggered this event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function IndexEvent(type:String, newIndex:Number, oldIndex:Number = NaN, relatedObject:Object = null, triggerEvent:Event = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			initObj(newIndex, oldIndex, relatedObject, triggerEvent);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var newIndex:Number;
		/**
		 * 	The zero-based index after the change. 
		 */
		public function get newIndex():Number {
			return spas_internal::newIndex;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var oldIndex:Number;
		/**
		 * 	The zero-based index before the change.
		 */
		public function get oldIndex():Number {
			return spas_internal::oldIndex;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var relatedObject:Object;
		/**
		 * 	The child item associated with the index change.
		 */
		public function get relatedObject():Object {
			return spas_internal::relatedObject;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var triggerEvent:Event;
		/**
		 * 	The event that triggered this event.
		 */
		public function get triggerEvent():Event {
			return spas_internal::triggerEvent;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>CalendarEvent.INDEX_CHANGED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>indexChanged</code>
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
		 * 		<tr>
		 * 			<td><code>newIndex</code></td><td>The zero-based index before the change.
		 * 			</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>oldIndex</code></td><td>The zero-based index before the change.
		 * 			</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>relatedObject</code></td><td>The child item associated with the
		 * 			index change.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>triggerEvent</code></td><td>The event that triggered this event.
		 * 			</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType indexChanged
		 */
		public static const INDEX_CHANGED:String = "indexChanged";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new IndexEvent(
				type, spas_internal::newIndex, spas_internal::oldIndex, 
				spas_internal::relatedObject, spas_internal::triggerEvent, bubbles, cancelable
			);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(newIndex:Number, oldIndex:Number, relatedObject:Object, triggerEvent:Event):void {
			spas_internal::newIndex = newIndex;
			spas_internal::oldIndex = oldIndex;
			spas_internal::relatedObject = relatedObject;
			spas_internal::triggerEvent = triggerEvent;
		}
	}
}