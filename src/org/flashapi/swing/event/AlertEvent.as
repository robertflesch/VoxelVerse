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
	// AlertEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 12/05/2011 18:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>AlertEvent</code> class represents event objects specific to 
	 *  the <code>Alert</code> class.
	 * 
	 * 	@see org.flashapi.swing.Alert
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AlertEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>AlertEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *	@param action 	The action that defines this event. Possible values are
		 * 					<code>AlertEvent.NONE</code>, <code>AlertEvent.ACTION</code>,
		 * 					<code>AlertEvent.CHOICE</code> and <code>AlertEvent.CANCEL</code>.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function AlertEvent(type:String, action:uint = 0, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			initObj(action);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var action:uint
		/**
		 * 	The user action that causes this event. Possible values are
		 * 	<code>AlertEvent.NONE</code>, <code>AlertEvent.ACTION</code>,
		 * 	<code>AlertEvent.CHOICE</code> and <code>AlertEvent.CANCEL</code>.
		 */
		public function get action():uint {
			return spas_internal::action;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Not implemented yet.] Specifies that no action is specified by the user.
		 */
		public static const NONE:uint = 0;
		
		/**
		 * 	Specifies that the user selects the action operation.
		 */
		public static const ACTION:uint = 1;
		
		/**
		 * 	Specifies that the user selects the choice operation.
		 */
		public static const CHOICE:uint = 2;
		
		/**
		 * 	Specifies that the user selects the cancel operation.
		 */
		public static const CANCEL:uint = 3;
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>AlertEvent.BUTTON_CLICK</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>buttonClick</code>
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
		 * 			<td><code>action</code></td><td>The value of the action that defines
		 * 			this event.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>target</code></td><td>The <code>Object</code> that dispatched
		 * 			the event; it is not always the <code>Object</code> listening for the
		 * 			event. Use the <code>currentTarget</code> property to always access the 
		 *			<code>Object</code> listening for the event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType buttonClick
		 */
		public static const BUTTON_CLICK:String = "buttonClick";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new AlertEvent(type, spas_internal::action, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(action:uint):void {
			spas_internal::action = action;
		}
	}
}