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
	// ImageMapEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 12/05/2011 18:55
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.draw.ImageMap;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>ImageMapEvent</code> class represents event objects specific to 
	 *  the <code>ImageMap</code> class.
	 * 
	 * 	@see org.flashapi.swing.ImageMap
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ImageMapEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>ImageMapEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param map 		The <code>ImageMap</code> object that causes this effect.
		 *  @param obj 		An object that contains information concerning the map area
		 * 					that has been presed within the <code>ImageMap</code> object
		 * 					specied by the <code>map</code> parameter.
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function ImageMapEvent(map:ImageMap, obj:Object, type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			initObj(map, obj);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var map:ImageMap;
		/**
		 * 	The <code>ImageMap</code> object that has caused this effect.
		 */
		public function get map():ImageMap {
			return spas_internal::map;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var name:String;
		/**
		 * 	The name of the map area that has been pressed within the <code>ImageMap</code>
		 * 	object which has caused this effect.
		 */
		public function get name():String {
			return spas_internal::name;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var href:String;
		/**
		 * 	The link associated with the map area that has been pressed within the 
		 * 	<code>ImageMap</code> object which has caused this effect.
		 */
		public function get href():String {
			return spas_internal::href;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var alt:String;
		/**
		 * 	The alternate text of the map area that has been pressed within the 
		 * 	<code>ImageMap</code> object which has caused this effect.
		 */
		public function get alt():String {
			return spas_internal::alt;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var data:*;
		/**
		 * 	The data associated with the map area that has been pressed within the 
		 * 	<code>ImageMap</code> object which has caused this effect.
		 */
		public function get data():* {
			return spas_internal::data;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>CalendarEvent.MAP_CLICKED</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>mapClicked</code>
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
		 *  @eventType mapClicked
		 */
		public static const MAP_CLICKED:String = "mapClicked";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			var obj:Object = {
				name:spas_internal::name,
				href:spas_internal::href,
				alt:spas_internal::alt,
				data:spas_internal::data
			}
			var e:ImageMapEvent = new ImageMapEvent(spas_internal::map, obj, type, bubbles, cancelable);
			return e;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(map:ImageMap, obj:Object):void {
			spas_internal::map = map;
			spas_internal::name = obj.name;
			spas_internal::href = obj.href;
			spas_internal::alt = obj.alt;
			spas_internal::data = obj.data;
		}
	}
}