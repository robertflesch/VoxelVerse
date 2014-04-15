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

package org.flashapi.swing.databinding {
	
	// -----------------------------------------------------------
	//  XMLQuery.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.3, 28/04/2009 17:55
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.exceptions.DataFormatException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.net.DataLoader;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a XML file has been successfully loaded by the
	 * 	<code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.XML_COMPLETE
	 */
	[Event(name = "xmlComplete", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 * 	The <code>XMLQuery</code> class helps developers to simplify the management
	 * 	for <code>Listable</code> objects by parsing XML objects that are internally
	 * 	treated by <code>Listable</code> instances.
	 * 
	 * 	@see org.flashapi.swing.list.Listable
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class XMLQuery extends EventDispatcher implements XMLQueryObject, IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>XMLQuery</code> instance
		 */
		public function XMLQuery() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _strictMode:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get strictMode():Boolean {
			return _strictMode;
		}
		public function set strictMode(value:Boolean):void {
			_strictMode = value;
		}
		
		private var _urlPath:String;
		/**
		 * 	@inheritDoc
		 */
		public function get urlPath():String {
			return _urlPath;
		}
		
		private var _xml:XML = null;
		/**
		 * 	@inheritDoc
		 */
		public function get xml():XML {
			return _xml;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get length():int {
			return _xml != null ? _xml.children().length() : -1;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function add(value:XML):void {
			_xml = value;
			getURLPath();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function load(value:String):void {
			_loader = new DataLoader();
			_evtColl.addEvent(_loader, LoaderEvent.COMPLETE, setNewXML);
			_loader.load(value, DataFormat.XML);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getItemAt(index:uint):XMLList {
			//Throws if the index does not exist in the XMLQuery list. 
			var child:XML = _strictMode ? _xml.child("item")[index] : _xml.children()[index];
			return new XMLList(child);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_evtColl.finalize();
			_evtColl = null;
			//if(_loader != null) _loader.finalize(); _loader = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function checkStrictMode(caller:String):void {
			if(_strictMode) {
				if (_xml.namespace().prefix != "spas")
					throw new DataFormatException(
						Locale.spas_internal::ERRORS.SPAS_PREFIX_NAMESPACE_MISMATCH);
				if (_xml.namespace() != UIDescriptor.spas_internal::SPAS_XML_NAMESPACE)
					throw new DataFormatException(
						Locale.spas_internal::ERRORS.SPAS_NAMESPACE_MISMATCH
						+ UIDescriptor.spas_internal::SPAS_XML_NAMESPACE);
				if (_xml.@caller != caller)
					throw new DataFormatException(
					Locale.spas_internal::ERRORS.SPAS_CALLER_MISMATCH + caller);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _loader:DataLoader;
		private var _evtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_evtColl = new EventCollector();
		}
		
		private function setNewXML(e:LoaderEvent):void {
			_evtColl.removeEvent(_loader, LoaderEvent.COMPLETE, setNewXML);
			_xml = e.data;
			getURLPath();
			_loader = null;
			this.dispatchEvent(new LoaderEvent(LoaderEvent.XML_COMPLETE));
		}
		
		private function getURLPath():void {
			_urlPath = (_xml.attribute("urlPath")[0] != undefined) ?
				_xml.attribute("urlPath")[0].toXMLString() : null;
		}
	}
}