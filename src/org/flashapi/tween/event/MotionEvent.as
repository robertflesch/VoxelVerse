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

package org.flashapi.tween.event {
	
	// -----------------------------------------------------------
	// MotionEvent.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/05/2011 22:47
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	
	/**
	 *  The <code>MotionEvent</code> class represents event objects specific to 
	 *  <code>ITween</code> classes.
	 * 
	 * 	@see org.flashapi.tween.core.ITween
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MotionEvent extends Event {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>MotionEvent</code> with the specified
		 * 					parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function MotionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The object that must be affected by the motion tween.
		 * 
		 * 	@default null
		 */
		public var listener:Object;
		
		/**
		 * 	An object that contains the value computed by the motion tween, or the
		 * 	value itself.
		 * 
		 * 	@default null
		 */
		public var value:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>MotionEvent.START</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>start</code>
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
		 *  @eventType start
		 */
		public static const START:String  = "start";
		
		/**
		 *  The <code>MotionEvent.UPDATE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>update</code>
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
		 * 			<td><code>listener</code></td><td>The object that must be affected by
		 * 			the motion tween.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>value</code></td><td>An object that contains the value computed
		 * 			by the motion tween, or the value itself.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType update
		 */
		public static const UPDATE:String = "update";
		
		/**
		 *  The <code>MotionEvent.PAUSE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>pause</code>
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
		 *  @eventType pause
		 */
		public static const PAUSE:String   = "pause";
		
		/**
		 *  The <code>MotionEvent.FINISH</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>finish</code>
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
		 * 			<td><code>listener</code></td><td>The object that must be affected by
		 * 			the motion tween.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>value</code></td><td>An object that contains the value computed
		 * 			by the motion tween, or the value itself.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType finish
		 */
		public static const FINISH:String = "finish";
		
		/**
		 *  The <code>MotionEvent.STOP</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>stop</code>
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
		 * 			<td><code>listener</code></td><td>The object that must be affected by
		 * 			the motion tween.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>value</code></td><td>An object that contains the value computed
		 * 			by the motion tween, or the value itself.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType stop
		 */
		public static const STOP:String = "stop";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			var e:MotionEvent = new MotionEvent(this.type, this.bubbles, this.cancelable);
			e.listener = this.listener;
			e.value = this.value;
			return e;
		}
	}
}