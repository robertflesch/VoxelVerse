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
	// AccordionEvent.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 12/05/2011 18:00
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>AccordionEvent</code> class represents events specific to the
	 *  <code>Accordion</code> class.
	 * 
	 * 	@see org.flashapi.swing.Accordion
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class AccordionEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>AccordionEvent</code> with the specified
		 * 					parameters.
		 * 
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function AccordionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var oldItemIndex:Number;
		/**
		 * 	The zero-based index before the change. Default value is <code>NaN</code>.
		 * 
		 * 	@see #newIndex
		 */
		public function get oldIndex():Number {
			return spas_internal::oldItemIndex;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var newItemIndex:Number;
		/**
		 * 	The zero-based index after the change. Default value is <code>NaN</code>.
		 * 
		 * 	@see #oldIndex
		 */
		public function get newIndex():Number {
			return spas_internal::newItemIndex;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>AccordionEvent.HEADER_CLICK</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>headerClick</code>
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
		 * 			<td><code>oldIndex</code></td><td>The zero-based index before the change.
		 * 			</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>newIndex</code></td><td>The zero-based index after the change.
		 * 			</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>triggerEvent</code></td><td>The event that triggered this event.
		 * 			</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType headerClick
		 */
		public static const HEADER_CLICK:String = "headerClick";
		
		/**
		 *  The <code>AccordionEvent.ANIMATION_FINISH</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>animationFinish</code>
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
		 * 			<td><code>triggerEvent</code></td><td>The event that triggered this event.
		 * 			</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType animationFinish
		 */
		public static const ANIMATION_FINISH:String = "animationFinish";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			var e:AccordionEvent =  new AccordionEvent(type, bubbles, cancelable);
			e.spas_internal::oldItemIndex = spas_internal::oldItemIndex;
			e.spas_internal::newItemIndex = spas_internal::newItemIndex;
			return e;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::oldItemIndex = spas_internal::newItemIndex = NaN;
		}
	}
}