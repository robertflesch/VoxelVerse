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
	// TextFXEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 12/05/2011 21:42
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>TextFXEvent</code> class represents event objects specific to 
	 *  <code>TextEffect</code> objects.
	 * 
	 * 	@see org.flashapi.swing.fx.textfx.TextEffect
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextFXEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>TextFXEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param duration	The current playing time of the text effect.
		 *  @param currentCount	Indicates the current letter count of the text effect.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function TextFXEvent(type:String, duration:Number, currentCount:int, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			initObj(duration, currentCount);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		spas_internal var duration:Number;
		/**
		 * 	The current playing time of the text effect.
		 */
		public function get duration():Number {
			return spas_internal::duration;
		}
		
		spas_internal var currentCount:int;
		/**
		 * 	Indicates the current letter count of the text effect.
		 */
		public function get currentCount():Number {
			return spas_internal::currentCount;
		}
		
		//public var totalCount:int;
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>TextFXEvent.CHANGED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>changed</code>
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
		 *		<tr>
		 * 			<td><code>duration</code></td><td>The current playing time of the text
		 * 			effect.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>currentCount</code></td><td>Indicates the current letter count
		 * 			of the text effect.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType changed
		 */
		public static const CHANGED:String = "changed";
		
		/**
		 *  The <code>TextFXEvent.FINISHED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>finished</code>
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
		 *		<tr>
		 * 			<td><code>duration</code></td><td>The current playing time of the text
		 * 			effect.</td>
		 * 		</tr>
		 *		<tr>
		 * 			<td><code>currentCount</code></td><td>Indicates the current letter count
		 * 			of the text effect.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType finished
		 */
		public static const FINISHED:String = "finished";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new TextFXEvent(type, spas_internal::duration, spas_internal::currentCount, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(duration:Number, currentCount:int):void {
			spas_internal::duration = duration;
			spas_internal::currentCount = currentCount;
		}
	}
}