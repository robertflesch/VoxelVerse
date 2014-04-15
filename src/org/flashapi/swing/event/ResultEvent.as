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
	// ResultEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 12/05/2011 21:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>ResultEvent</code> class represents event objects specific to 
	 *  the remoting service objects.
	 * 
	 * 	@see org.flashapi.swing.net.remoting.AbstractRemotingService
	 * 	@see org.flashapi.swing.event.FaultEvent
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public final class ResultEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>FaultEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *	@param result 	The object that contains the details of what caused
		 * 					this event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function ResultEvent(type:String, result:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
			super (type, bubbles, cancelable);
			initObj(result);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var result:Object;
		/**
		 * 	The object that contains the details of what caused this event.
		 */
		public function get result():Object {
			return spas_internal::result;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>ResultEvent.RESULT</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>result</code>
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
		 * 			<td><code>fault</code></td><td>The object that contains the details
		 * 			of what caused this event.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType result
		 */
		public static const RESULT:String = "result";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new ResultEvent(type, spas_internal::result, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(result:Object):void {
			spas_internal::result = result;
		}
	}
}