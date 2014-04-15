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

package org.flashapi.swing.ui.analytics {
	
	// -----------------------------------------------------------
	// Analytics.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2011 15:50
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	import org.flashapi.swing.core.crypto.GUID;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched each time a custom data object is added to this <code>Analytics</code>
	 * 	instance, by using the <code>updateAnalysis()</code> method.
	 *
	 *  @eventType org.flashapi.swing.ui.analytics.AnalyticsEvent.ANALYSIS_UPDATE
	 */
	[Event(name = "analysisUpdate", type = "org.flashapi.swing.ui.analytics..AnalyticsEvent")]
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	 The <code>Analytics</code> class creates objects that provides the API for  
	 * 	 the measurement, collection, analysis and reporting of data for purposes of 
	 * 	 understanding and optimizing SPAS 3.0 applications.
	 * 	
	 * 	<p>When you create a new instance of the <code>Analytics</code> class, you
	 * 	start a new <strong>Analytics Session</strong>. Each Analytics Session
	 * 	can be identified by the Genuine Unique Identifier returned by the
	 * 	<code>getSessionID()</code> method.</p>
	 * 
	 * 	<p>The process used by the Analytics API to collect data is called the
	 * 	<strong>Analytics Flow</strong>. Each <code>Analytics</code> instance added to
	 * 	the Analytics Flow is an <strong>Analytics Flow Element</strong>. The first
	 * 	element collected by an Analytics Flow represents the main SPAS 3.0 application.
	 * 	The second element collected by an Analytics Flow represents the set of data
	 * 	defined by the <code>Capabilites</code> class. This set of data is stored
	 * 	within a <code>CapabilitesDTO</code> instance, accessible from the
	 * 	<code>data</code> property of the second element, or the <code>capabilities</code>
	 * 	of the <code>Analytics</code> instance.</p>
	 * 
	 * 	<p>When added to the Analytics Flow, for example by using the <code>updateAnalysis()</code>
	 * 	method, an Analytics Flow Element becomes an <strong>Analytics Action Producer</strong>.</p>
	 * 
	 * 	<p>The <code>Analytics</code> class has been designed to give developers a
	 * 	high level of flexibility and granularity for collecting users actions.</p>
	 * 	
	 * 	<p><strong>Because of the differences between legal procedures for each countries, 
	 * 	concerning the collect of Internet Protocol (IP) addresses, SPAS 3.0 does
	 * 	not provides built in mechanisms to retrieve the user's IP address.</strong></p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class Analytics extends EventDispatcher implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Analytics</code> instance.
		 */
		public function Analytics() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _appId:String;
		/**
		 * 	Returns the identifier name of the main SPAS 3.0 application. The main 
		 * 	application identifier name is the name of the main <code>Document</code>
		 * 	class, which extends the <code>Application</code> class. The <code>applicationId</code>
		 * 	property is the <code>id</code> property for the first element collected
		 * 	by this <code>Analytics</code> instance.
		 * 
		 * 	@return 	The identifier name of the main SPAS 3.0 application.
		 */
		public function get applicationId():String {
			return _appId;
		}
		
		/**
		 * 	Returns a URL-encoded string that specifies values for each property 
		 * 	definedby the <code>Capabilities</code> class.
		 * 
		 * 	@return 	A URL-encoded string that specifies values for each property  
		 * 				of the <code>Capabilities</code> class.
		 * 
		 * 	@see #capabilities
		 */
		public function get capabilitiesServerString():String {
			return Capabilities.serverString;
		}
		
		private var _capabilities:CapabilitiesDTO;
		/**
		 * 	Returns the a <code>CapabilitesDTO</code> instance that contains
		 * 	the set of data defined by the <code>Capabilites</code> class.
		 * 
		 * 	@return	The set of data defined by the <code>Capabilites</code> class.
		 * 
		 * 	@see #capabilitiesServerString
		 */
		public function get capabilities():CapabilitiesDTO {
			return _capabilities;
		}
		
		private var _data:*;
		/**
		 * 	The custom set of data that will be stored by this <code>Analytics</code>
		 * 	instance to be analysed. This custom set of data is used as <code>data</code>
		 * 	property for the first element collected by this <code>Analytics</code>
		 * 	instance.
		 * 
		 *  @default null
		 */
		public function get data():* {
			return _data;
		}
		public function set data(value:*):void {
			_stack[0].data = _data = value;
		}
		
		private var _deviceID:String;
		/**
		 * 	Sets or gets the Genuine Unique Identifier which can be accessed from the
		 * 	user's device. You typically use the <code>deviceID</code> property
		 * 	to associate the user's IP address to this <code>Analytics</code> instance.
		 * 	
		 * 	<p><strong>Because of the differences between legal procedures for each   
		 * 	countries, concerning the collect of Internet Protocol (IP) addresses, 
		 * 	SPAS 3.0 does not provides built in mechanisms to retrieve the user's IP
		 * 	address.</strong></p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #getSessionID()
		 */
		public function get deviceID():String {
			return _deviceID;
		}
		public function set deviceID(value:String):void {
			_deviceID = value;
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the Analytics
		 * 	Session is processing (<code>true</code>), or not (<code>false</code>).
		 * 	<code>isAnalysing</code> returns <code>true</code> when running the
		 * 	<code>startAnalysis()</code> method; otherwise <code>isAnalysing</code>
		 * 	returns <code>false</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #startAnalysis()
		 * 	@see #stopAnalysis()
		 */
		public function get isAnalysing():Boolean {
			return _isAnalysing;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of this <code>Analytics</code> instance are killed before you delete
		 * 	it.
		 * 
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to definitely kill it.</strong></p>
		 */
		public function finalize():void {
			for (; _cursor >= 0; _cursor--) {
				_stack[_cursor].finalize();
				_stack[_cursor] = null;
			}
			_stack = null;
			_capabilities = null;
		}
		
		/**
		 * 	Starts the Analytics Session.
		 * 
		 * 	<p>After calling the <code>startAnalysis()</code> method, the <code>isAnalysing</code>
		 * 	property returns <code>true</code>.</p>
		 * 
		 * 	@see #stopAnalysis()
		 * 	@see #updateAnalysis()
		 * 	@see #isAnalysing
		 */
		public function startAnalysis():void {
			_isAnalysing = true;
		}
		
		/**
		 * 	Stops the Analytics Session.
		 * 
		 * 	<p>After calling the <code>stopAnalysis()</code> method, the <code>isAnalysing</code>
		 * 	property returns <code>false</code>.</p>
		 * 
		 * 	@see #startAnalysis()
		 * 	@see #updateAnalysis()
		 * 	@see #isAnalysing
		 */
		public function stopAnalysis():void {
			_isAnalysing = false;
		}
		
		/**
		 * 	Add an Analytics Producer Element to this <code>Analytics</code> instance,
		 * 	only if the <code>isAnalysing</code> property is <code>true</code>.
		 * 
		 * 	@param	producer	The Analytics Producer Element to be added to this 
		 * 						<code>Analytics</code> instance.
		 * 
		 * 	@see #startAnalysis()
		 * 	@see #stopAnalysis()
		 * 	@see #isAnalysing
		 */
		public function updateAnalysis(producer:AnalyticsObject):void {
			if (_isAnalysing) {
				setEventTime(producer);
				_stack.push(producer);
				_cursor++;
				this.dispatchEvent(new AnalyticsEvent(AnalyticsEvent.ANALYSIS_UPDATE));
			}
		}
		
		/**
		 * 	Returns a reference to the last <code>AnalyticsObject</code> producer that
		 * 	has been added to this <code>Analytics</code> instance.
		 * 
		 * 	@return	The last <code>AnalyticsObject</code> producer added to this
		 * 			<code>Analytics</code> instance.
		 * 
		 * 	@see #getProducers()
		 * 	@see #getProducerAt()
		 */
		public function getLastProducer():AnalyticsObject {
			return _stack[_cursor];
		}
		
		/**
		 * 	Returns an <code>Array</code> that contains all producer elements registered
		 * 	during this Analytics Session.
		 * 
		 * 	@return	All producer elements registered during this Analytics Session.
		 * 
		 * 	@see #getLastProducer()
		 * 	@see #getProducerAt()
		 */
		public function getProducers():Array {
			return _stack;
		}
		
		/**
		 * 	Returns a reference to the producer element registered at the specified
		 * 	index.
		 * 
		 * 	@param index	The index position of the producer element.
		 * 
		 * 	@return	The <code>AnalyticsObject</code> producer registered at the specified
		 * 			index.
		 * 
		 * 	@see #getLastProducer()
		 * 	@see #getProducers()
		 */
		public function getProducerAt(index:int):AnalyticsObject {
			return _stack[index];
		}
		
		private var _sessionID:String;
		/**
		 * 	Returns the Genuine Unique Identifier of this Analytics Session.
		 * 
		 * 	@return	The Genuine Unique Identifier of this Analytics Session.
		 * 
		 * 	@see #deviceID
		 */
		public function getSessionID():String {
			return _sessionID;
		}
		
		private var _userAgent:String;
		/**
		 * 	Returns the User-Agent string retrieved from the user's device.
		 * 
		 * 	@return	The User-Agent string.
		 */
		public function userAgent():String {
			return _userAgent;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _isAnalysing:Boolean;
		private var _initTime:uint;
		private var _stack:Array;
		private var _cursor:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_initTime = getTimer();
			initUserDataScript();
			_stack = [];
			_sessionID = new GUID().toString();
			
			_appId = getQualifiedClassName(UIDescriptor.getUIManager().document).toLowerCase();
			var ao:AnalyticsObject = new AnalyticsObject(this, AnalyticsType.APPLICATION, _appId);
			ao.spas_internal::timeRef = 0;
			_stack.push(ao);
			
			_capabilities = new CapabilitiesDTO();
			ao = new AnalyticsObject(this, AnalyticsType.SYSTEM, "capabilities", _capabilities);
			setEventTime(ao);
			_stack.push(ao);
			
			_cursor = 1;
			_isAnalysing = false;
		}
		
		private function initUserDataScript():void {
			if (!ExternalInterface.available) return;
			try {
				_userAgent = ExternalInterface.call("navigator.userAgent.toString").toString();
			} catch (error:Error) {
				_userAgent = "Javascript error";
			}
		}
		
		private function setEventTime(tgt:AnalyticsObject):void {
			tgt.spas_internal::timeRef = getTimer() - _initTime;
		}
	}
}