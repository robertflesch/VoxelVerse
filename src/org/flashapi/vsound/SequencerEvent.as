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

package org.flashapi.vsound {
	
	// -----------------------------------------------------------
	// SequencerEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 12/05/2011 19:00
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	
	/**
	 * 	The <code>SequencerEvent</code> class defines events that are dipatched
	 * 	by <code>VSoundSequencer</code> objects.
	 * 	<p>There is one type of sequencer event:</p>
	 * 	<ul>
	 * 		<li>SequencerEvent.LIBRARY_UPDATE</li>
	 * 	</ul>
	 * 
	 * 	@see org.flashapi.vsound.VSoundSequencer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class SequencerEvent extends Event {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SequencerEvent</code> instance.
		 * 
		 * 	@param	type	The type of the event, accessible as <code>SequencerEvent.type</code>.
		 * 	@param	bubbles	Determines whether the <code>SequencerEvent</code> object
		 * 					participates in the bubbling stage of the event flow. The
		 * 					default value is <code>false</code>.
		 * 	@param	cancelable	Determines whether the <code>SequencerEvent</code>
		 * 						object can be canceled. The default values is <code>false</code>.
		 */
		public function SequencerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines the value of the type property of a <code>libraryUpdate</code>
		 * 	event object.
		 * 
		 * 	<p>This event has the following properties:</p>
		 *	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Property</th>
		 * 			<th>Value</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td><code>bubbles</code></td>
		 * 			<td><code>false</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>cancelable</code></td>
		 * 			<td><code>false</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>currentTarget</code></td>
		 * 			<td>The <code>VSoundSequencer</code> that is actively processing the 
		 * 			<code>Event</code> object with an event listener.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>target</code></td>
		 * 			<td>Any <code>DisplayObject</code> instance with a listener
		 * 			registered for the <code>libraryUpdate</code> event.</td>
		 * 		</tr>
		 * 	</table> 
		 */
		public static const LIBRARY_UPDATE:String = "libraryUpdate";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new SequencerEvent(type, bubbles, cancelable);
		}
	}
}