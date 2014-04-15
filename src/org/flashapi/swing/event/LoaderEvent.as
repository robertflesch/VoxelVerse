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
	// LoaderEvent.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 12/05/2011 21:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.net.UILoader;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>LoaderEvent</code> class represents event objects specific to 
	 *  data loading processes.
	 * 
	 * 	@see rg.flashapi.swing.net.UILoader
	 * 	@see rg.flashapi.swing.net.DataLoader
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LoaderEvent extends SpasEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>LoaderEvent</code> with the specified
		 * 	parameters.
		 *
		 *  @param type 	The event type; indicates the action that caused the event.
		 *  @param data		The set of data loaded by the <code>UILoader</code> object.
		 *  @param loader	The <code>UILoader</code> object that is used to load data.
		 *  @param bubbles 	Specifies whether the event can bubble up the display list
		 * 					hierarchy.
		 *  @param cancelable 	Specifies whether the behavior associated with the event
		 * 						can be prevented.
		 */
		public function LoaderEvent(type:String, data:* = null, loader:UILoader = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			initObj(data, loader);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var dataRef:*;
		/**
		 * 	The set of data loaded by the <code>UILoader</code> object.
		 */
		public function get data():* {
			return spas_internal::dataRef;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var uiloaderRef:UILoader;
		/**
		 * 	The <code>UILoader</code> object that is used to load data.
		 */
		public function get uiloader():UILoader {
			return spas_internal::uiloaderRef;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event types
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The <code>LoaderEvent.INIT</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>init</code>
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
		 * 			<td><code>data</code></td><td><code>null</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType init
		 */
		public static const INIT:String = "init";
		
		/**
		 *  The <code>LoaderEvent.COMPLETE</code> constant defines the value of the 
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
		 * 		<tr>
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType complete
		 */
		public static const COMPLETE:String = "complete";
		
		/**
		 *  The <code>LoaderEvent.XML_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>xmlComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType xmlComplete
		 */
		public static const XML_COMPLETE:String = "xmlComplete";
		
		/**
		 *  The <code>LoaderEvent.HTML_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>htmlComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType htmlComplete
		 */
		public static const HTML_COMPLETE:String = "htmlComplete";
		
		/**
		 *  The <code>LoaderEvent.CSS_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>cssComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType cssComplete
		 */
		public static const CSS_COMPLETE:String = "cssComplete";
		
		/**
		 *  The <code>LoaderEvent.CSV_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>csvComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType csvComplete
		 */
		public static const CSV_COMPLETE:String = "csvComplete";
		
		/**
		 *  The <code>LoaderEvent.TEXT_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>textComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType textComplete
		 */
		public static const TEXT_COMPLETE:String = "textComplete";
		
		/**
		 *  The <code>LoaderEvent.GRAPHIC_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>graphicComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType graphicComplete
		 */
		public static const GRAPHIC_COMPLETE:String = "graphicComplete";
		
		/**
		 *  The <code>LoaderEvent.CACHED_GRAPHIC_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>cachedGraphicComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType cachedGraphicComplete
		 */
		public static const CACHED_GRAPHIC_COMPLETE:String = "cachedGraphicComplete";
		
		/**
		 *  The <code>LoaderEvent.VARIABLES_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>graphicComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType graphicComplete
		 */
		public static const VARIABLES_COMPLETE:String = "graphicComplete";
		
		/**
		 *  The <code>LoaderEvent.IO_ERROR</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>ioError</code>
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
		 * 			<td><code>data</code></td><td><code>null</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType ioError
		 */
		public static const IO_ERROR:String = "ioError";
		
		/**
		 *  The <code>LoaderEvent.SECURITY_ERROR</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>securityError</code>
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
		 * 			<td><code>data</code></td><td><code>null</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType securityError
		 */
		public static const SECURITY_ERROR:String = "securityError";
		
		/**
		 *  The <code>LoaderEvent.FONT_COMPLETE</code> constant defines the value of the 
		 *  <code>type</code> property of the event object for a <code>fontComplete</code>
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
		 * 			<td><code>data</code></td><td>The set of data loaded by the
		 * 			<code>UILoader</code> object.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>uiloader</code></td><td>The <code>UILoader</code> object that
		 * 			is used to load data.</td>
		 * 		</tr>
		 *  </table>
		 *
		 *  @eventType fontComplete
		 */
		public static const FONT_COMPLETE:String = "fontComplete";
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Event methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private 
		 */
		override public function clone():Event {
			return new LoaderEvent(type, spas_internal::dataRef, spas_internal::uiloaderRef, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(data:*, loader:UILoader):void {
			spas_internal::uiloaderRef = loader;
			spas_internal::dataRef = data;
		}
	}
}