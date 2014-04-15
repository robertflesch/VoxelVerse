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

package org.flashapi.swing.net {
	
	// -----------------------------------------------------------
	// UILoader.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 12/05/2011 23:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.xml.XMLDocument;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>UILoader</code> class decorates SPAS 3.0 objects to let them
	 * 	take in charge loading of external assets.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UILoader extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>UILoader</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	obj	The <code>EventDispatcher</code> which is associated
		 * 					with this <code>UILoader</code> instance.
		 * 	@param	dataType	A <code>DataFormat</code> constant that indicates the 
		 * 						primitive type of data the object which you pass in 
		 * 						the uri parameter is. Default value is <code>DataFormat.GRAPHIC</code>.
		 * 	@param	callbackFunction	Not implemented yet.
		 */
		public function UILoader(obj:EventDispatcher, dataType:String = "graphic", callbackFunction:Function = null) {
			super();
			initObj(obj, dataType, callbackFunction);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Not yet implemented.]
		 */
		public var info:UILoaderInfo;
		
		/**
		 * 	A <code>LoaderContext</code> object, which has properties that define the
		 * 	following: 
		 * 	<ul>
		 * 		<li>Whether or not Flash Player should check for the existence of a
		 * 		policy file upon loading the object.</li>
		 * 		<li>The <code>ApplicationDomain</code> for the loaded object.</li>
		 * 		<li>The <code>SecurityDomain</code> for the loaded object.</li>
		 * 	</ul>
		 * 
		 * 	<p>For full details, see the description of properties defined by the
		 * 	<code>LoaderContext</code> class.</p>
		 * 
		 * 	@default null
		 */
		public var loaderContext:LoaderContext = null;
		
		/**
		 * 	The output function used to display expressions, or write to log files,
		 * 	while debugging.
		 */
		public var output:Function = trace;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _dataType:String;
		/**
		 *  Sest or gets the type of data loaded by this <code>UILoader</code> instance.
		 * 	<p>Possible values are defined by the <code>DataFormat</code> class constants:
		 *  <ul>
		 * 		<li><code>DataFormat.XML</code>,</li>
		 * 		<li><code>DataFormat.HTML</code>,</li>
		 * 		<li><code>DataFormat.CSS</code>,</li>
		 * 		<li><code>DataFormat.TEXT</code>,</li>
		 * 		<li><code>DataFormat.CSV</code>,</li>
		 * 		<li><code>DataFormat.GRAPHIC</code>,</li>
		 * 		<li><code>DataFormat.CACHED_GRAPHIC</code>,</li>
		 * 		<li><code>DataFormat.VARIABLES</code>,</li>
		 * 		<li><code>DataFormat.BITMAP</code>,</li>
		 * 		<li><code>DataFormat.FONT</code>.</li>
		 *  </ul>
		 *	</p>
		 * 
		 * 	@default null
		 */
		public function get dataType():String {
			return _dataType;
		}
		public function set dataType(value:String):void {
			_dataType = value;
		}
		
		/**
		 * 	Returns a reference to the object that is charged to load external
		 * 	assets.
		 * 
		 * 	<p>Returns a <code>Loader</code> instance if the type of data for this
		 * 	<code>UILoader</code> is on of the following:</p>
		 * 	<ul>
		 * 		<li><code>DataFormat.GRAPHIC</code>,</li>
		 * 		<li><code>DataFormat.BITMAP</code>,</li>
		 * 		<li><code>DataFormat.FONT</code>.</li>
		 *  </ul>
		 * 	
		 * 	<p>Returns a <code>URLLoader</code> instance if the type of data for this
		 * 	<code>UILoader</code> is on of the following:</p>
		 * 	<ul>
		 * 		<li><code>DataFormat.XML</code>,</li>
		 * 		<li><code>DataFormat.HTML</code>,</li>
		 * 		<li><code>DataFormat.CSS</code>,</li>
		 * 		<li><code>DataFormat.TEXT</code>,</li>
		 * 		<li><code>DataFormat.CSV</code>,</li>
		 * 		<li><code>DataFormat.CACHED_GRAPHIC</code>,</li>
		 * 		<li><code>DataFormat.VARIABLES</code>.</li>
		 *  </ul>
		 */
		public function get loader():* {
			return _loader;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Loads an external asset from the specified URI.
		 * 
		 * 	@param	url	The path to the external asset to load.
		 * 	@param	parameters	A <code>LoaderParameters</code> object that defines
		 * 						additional parameters for loading the external asset.
		 */
		public function load(url:String, parameters:LoaderParameters = null):void {
			var request:URLRequest = new URLRequest(url);
			if (parameters != null) {
				if (parameters.urlVariables != null) {
					request.data = parameters.urlVariables;
					request.method = parameters.method;
				}
			}
			try {
				(_loader is Loader) ?
					_loader.load(request, loaderContext) :
					_loader.load(request);
			} catch (e:Error) {
				output(Locale.spas_internal::ERRORS.LOADING_ERROR + url);
			}
		}
		
		/**
		 * 	Closes the load operation in progress. Any load operation in progress is
		 * 	immediately terminated. 
		 */
		public function close():void {
			try {
				_loader.close();
			} catch (e:Error) {}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_evtColl.finalize();
			_evtColl = null;
			try {
				_loader.close();
			} catch (e:Error) {}
			_loader = null;
			_callbackFunction = null;
			_evtColl = null;
			_obj = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _loader:*;
		private var _obj:EventDispatcher;
		private var _callbackFunction:Function;
		private var _evtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(obj:EventDispatcher, dataType:String, callbackFunction:Function):void {
			_obj = obj;
			_dataType = dataType;
			if(callbackFunction != null) _callbackFunction = callbackFunction;
			_evtColl = new EventCollector();
			switch(_dataType) {
				case DataFormat.XML :
					_loader = new URLLoader();
					_loader.dataFormat = URLLoaderDataFormat.TEXT;
					_evtColl.addEvent(_loader, Event.COMPLETE, xmlComplete);
					createDataIOError();
					break;
				case DataFormat.HTML :
					_loader = new URLLoader();
					_loader.dataFormat = URLLoaderDataFormat.TEXT;
					_evtColl.addEvent(_loader, Event.COMPLETE, htmlComplete);
					createDataIOError();
					break;
				case DataFormat.CSS :
					_loader = new URLLoader();
					_evtColl.addEvent(_loader, Event.COMPLETE, cssComplete);
					createDataIOError();
					break;
				case DataFormat.TEXT :
					_loader = new URLLoader();
					_loader.dataFormat = URLLoaderDataFormat.TEXT;
					_evtColl.addEvent(_loader, Event.COMPLETE, textComplete);
					createDataIOError();
					break;
				case DataFormat.FONT :
					_loader = new Loader()
					_evtColl.addEvent(_loader.contentLoaderInfo, Event.COMPLETE, fontComplete);
					createDataIOError();
					break;
				case DataFormat.CSV :
					_loader = new URLLoader();
					_loader.dataFormat = URLLoaderDataFormat.TEXT;
					_evtColl.addEvent(_loader, Event.COMPLETE, csvComplete);
					createDataIOError();
					break;
				case DataFormat.GRAPHIC :
				case DataFormat.BITMAP :
					_loader = new Loader();
					_evtColl.addEvent(_loader.contentLoaderInfo, Event.COMPLETE, graphicComplete);
					createGraphicIOError();
					break;
				case DataFormat.CACHED_GRAPHIC :
					_loader = new URLLoader();
					_loader.dataFormat = URLLoaderDataFormat.BINARY;
					_evtColl.addEvent(_loader, Event.COMPLETE, cachedGraphicComplete);
					break;
				case DataFormat.VARIABLES :
					_loader = new URLLoader ();
					_loader.dataFormat = URLLoaderDataFormat.VARIABLES;
					_evtColl.addEvent(_loader, Event.COMPLETE, varsComplete);
					createDataIOError();
					break;
			}
			createProgressEvent();
			_evtColl.addEvent(_loader, SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function createDataIOError():void {
			_evtColl.addEvent(_loader, IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function createGraphicIOError():void {
			_evtColl.addEvent(_loader.contentLoaderInfo, IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function createProgressEvent():void {
			if (_dataType == DataFormat.GRAPHIC || _dataType == DataFormat.BITMAP_DATA)
				_evtColl.addEvent(_loader.contentLoaderInfo, ProgressEvent.PROGRESS, onProgress);
			else _evtColl.addEvent(_loader, ProgressEvent.PROGRESS, onProgress);
		}
		
		private function xmlComplete(e:Event):void {
			_evtColl.removeAllEvents();
			dispatchCompleteEvent(LoaderEvent.XML_COMPLETE, new XML(e.target.data));
		}
		
		private function htmlComplete(e:Event):void {
			_evtColl.removeAllEvents();
			var html:XMLDocument = new XMLDocument();
			html.ignoreWhite = true;
			html.parseXML(_loader.data);
			dispatchCompleteEvent(LoaderEvent.HTML_COMPLETE, html.toString());
		}
		
		private function cssComplete(e:Event):void {
			_evtColl.removeAllEvents();
			dispatchCompleteEvent(LoaderEvent.CSS_COMPLETE, URLLoader(e.target).data);
		}
		
		private function textComplete(e:Event):void {
			_evtColl.removeAllEvents();
			e.target.data = _loader.data;
			dispatchCompleteEvent(LoaderEvent.TEXT_COMPLETE, e.target.data);
		}
		
		private function csvComplete(e:Event):void {
			_evtColl.removeAllEvents();
			var arr:Array = _loader.data.split(",");
			dispatchCompleteEvent(LoaderEvent.CSV_COMPLETE, arr);
		}
		
		private function graphicComplete(e:Event):void {
			_evtColl.removeAllEvents();
			dispatchCompleteEvent(LoaderEvent.GRAPHIC_COMPLETE, _loader);
		}
		
		private function cachedGraphicComplete(e:Event):void {
			_evtColl.removeAllEvents();
			dispatchCompleteEvent(LoaderEvent.CACHED_GRAPHIC_COMPLETE, _loader.data);
		}
		
		private function fontComplete(e:Event):void {
			_evtColl.removeAllEvents();
			dispatchCompleteEvent(LoaderEvent.FONT_COMPLETE, null);
		}
		
		private function varsComplete(e:Event):void {
			_evtColl.removeAllEvents();
			dispatchCompleteEvent(LoaderEvent.VARIABLES_COMPLETE,  e.target.data);
		}
		
		private function dispatchCompleteEvent(type:String, data:*):void {
			_obj.dispatchEvent(new LoaderEvent(type, data, this));
			_obj.dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, data, this));
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void {
			_evtColl.removeAllEvents();
			_obj.dispatchEvent(new LoaderEvent(LoaderEvent.IO_ERROR, null, this));
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			_evtColl.removeAllEvents();
			_obj.dispatchEvent(new LoaderEvent(LoaderEvent.SECURITY_ERROR, e.text, this));
		}
		
		private function onProgress(e:ProgressEvent):void {
			_obj.dispatchEvent(e.clone());
		}
	}
}