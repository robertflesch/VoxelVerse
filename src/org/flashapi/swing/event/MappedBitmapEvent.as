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
	// MappedBitmapEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 12/05/2011 21:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	
	/**
	 *  The <code>MappedBitmapEvent</code> class represents event objects specific to 
	 *  the <code>BitmapMapper</code> class.
	 * 
	 * 	@see org.flashapi.swing.tools.BitmapMapper
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MappedBitmapEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>MappedBitmapEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function MappedBitmapEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>MappedBitmapEvent.COMPLETE</code> constant defines the value of the 
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
		 *  The <code>MappedBitmapEvent.MAP_CHANGED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>mapChanged</code>
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
		 *  @eventType mapChanged
		 */
		public static const MAP_CHANGED:String = "mapChanged";
		
		/**
		 *  The <code>MappedBitmapEvent.BITMAP_CHANGED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>bitmapChanged</code>
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
		 *  @eventType bitmapChanged
		 */
		public static const BITMAP_CHANGED:String = "bitmapChanged";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new MappedBitmapEvent(type, bubbles, cancelable);
		}
	}
}