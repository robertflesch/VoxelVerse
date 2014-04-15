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
	// DnDEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/05/2011 18:46
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.dnd.DnDOperation;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DnDEvent</code> class represents event objects that are dispatched
	 *  as part of a Drag and Drop operation.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DnDEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>DnDEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function DnDEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A reference to the current <code>DnDOperation</code> object for this
		 * 	event.
		 */
		public function get dragOperation():DnDOperation {
			return spas_internal::dragOp;
		}
		
		/**
		 * 	A reference to the current drop target <code>UIObject</code> for this
		 * 	event.
		 */
		public function get dropTarget():UIObject {
			return spas_internal::dropTgt;
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var dragOp:DnDOperation;
		
		/**
		 * 	@private
		 */
		spas_internal var dropTgt:UIObject;
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>DnDEvent.DND_MOUSE_DOWN</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndMouseDown</code>
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
		 *  </table>
		 *
		 *  @eventType dndMouseDown
		 */
		public static const DND_MOUSE_DOWN:String = "dndMouseDown";
		
		/**
		 *  The <code>DnDEvent.DND_MOUSE_MOVE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndMouseMove</code>
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
		 *  </table>
		 *
		 *  @eventType dndMouseMove
		 */
		public static const DND_MOUSE_MOVE:String = "dndMouseMove";
		
		/**
		 *  The <code>DnDEvent.DND_ENTER</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndEnter</code>
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
		 *  </table>
		 *
		 *  @eventType dndEnter
		 */
		public static const DND_ENTER:String = "dndEnter";
		
		/**
		 *  The <code>DnDEvent.DND_MOVE_OVER</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndMoveOver</code>
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
		 *  </table>
		 *
		 *  @eventType dndMoveOver
		 */
		public static const DND_MOVE_OVER:String = "dndMoveOver";
		
		/**
		 *  The <code>DnDEvent.DND_EXIT</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndExit</code>
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
		 * 			<td><code>dragOperation</code></td><td>A reference to the current
		 * 			<code>DnDOperation</code> object for this event.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>dropTarget</code></td><td>A reference to the current drop
		 * 			target <code>UIObject</code> for this event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType dndExit
		 */
		public static const DND_EXIT:String = "dndExit";
		
		/**
		 *  The <code>DnDEvent.DND_DROP</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndDrop</code>
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
		 *  </table>
		 *
		 *  @eventType dndDrop
		 */
		public static const DND_DROP:String = "dndDrop";
		
		//--> Events dispatched by the DnDOperation class:
		
		/**
		 *  The <code>DnDEvent.DND_DROP_ACCEPTED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndDropAccepted</code>
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
		 * 			<td><code>dragOperation</code></td><td>A reference to the current
		 * 			<code>DnDOperation</code> object for this event.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>dropTarget</code></td><td>A reference to the current drop
		 * 			target <code>UIObject</code> for this event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType dndDropAccepted
		 */
		public static const DND_DROP_ACCEPTED:String = "dndDropAccepted";
		
		/**
		 *  The <code>DnDEvent.DND_DROP_CANCELED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndDropCanceled</code>
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
		 * 			<td><code>dragOperation</code></td><td>A reference to the current
		 * 			<code>DnDOperation</code> object for this event.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>dropTarget</code></td><td>A reference to the current drop
		 * 			target <code>UIObject</code> for this event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType dndDropCanceled
		 */
		public static const DND_DROP_CANCELED:String = "dndDropCanceled";
		
		/**
		 *  The <code>DnDEvent.DND_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndComplete</code>
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
		 *  </table>
		 *
		 *  @eventType dndComplete
		 */
		public static const DND_COMPLETE:String = "dndComplete";
		
		/**
		 *  The <code>DnDEvent.DND_FINISH</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndFinish</code>
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
		 * 			<td><code>dragOperation</code></td><td>A reference to the current
		 * 			<code>DnDOperation</code> object for this event.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>dropTarget</code></td><td>A reference to the current drop
		 * 			target <code>UIObject</code> for this event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType dndFinish
		 */
		public static const DND_FINISH:String = "dndFinish";
		
		/**
		 *  The <code>DnDEvent.DND_START</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>dndStart</code>
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
		 * 			<td><code>dragOperation</code></td><td>A reference to the current
		 * 			<code>DnDOperation</code> object for this event.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>dropTarget</code></td><td>A reference to the current drop
		 * 			target <code>UIObject</code> for this event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType dndStart
		 */
		public static const DND_START:String = "dndStart";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			var e:DnDEvent = new DnDEvent(type, bubbles, cancelable);
			e.spas_internal::dragOp = spas_internal::dragOp;
			e.spas_internal::dropTgt = spas_internal::dropTgt;
			return e;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::dragOp = null;
			spas_internal::dropTgt = null;
		}
	}
}