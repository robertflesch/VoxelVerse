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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// ApplicationLoader.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/04/2009 22:05
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.ApplicationLoaderEvent;
	
	use namespace spas_internal;
	
	[IconFile("ApplicationLoader.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched while a SPAS 3.0 <code>Application</code> is currently loading.
	 *
	 *  @eventType org.flashapi.swing.event.ApplicationLoaderEvent.PROGRESS
	 */
	[Event(name = "progress", type = "org.flashapi.swing.event.ApplicationLoaderEvent")]
	
	/**
	 *  Dispatched when a SPAS 3.0 <code>Application</code> has been successfully loaded.
	 *
	 *  @eventType org.flashapi.swing.event.ApplicationLoaderEvent.COMPLETE
	 */
	[Event(name = "complete", type = "org.flashapi.swing.event.ApplicationLoaderEvent")]
	
	/**
	 * 	<img src="ApplicationLoader.png" alt="ApplicationLoader" width="18" height="18"/>
	 * 
	 * 	The <code>ApplicationLoader</code> class provides a lightweight API to
	 * 	control the loading of a SPAS 3.0 <code>Application</code> instance.
	 * 
	 * 	@see org.flashapi.swing.Application
	 * 
	 *  @includeExample ApplicationLoaderExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ApplicationLoader extends MovieClip {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>ApplicationLoader</code> instance.
		 */
		public function ApplicationLoader() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		private var _tgt:String;
		/**
		 * 	Sets the URL of the SPAS 3.0 <code>Application</code> instance to load
		 * 	with this <code>ApplicationLoader</code> object.
		 * 
		 * 	@see #start()
		 */
		public function set target(value:String):void {
			_tgt = value;
		}
		
		private var _rsl:String = null;
		/**
		 * 	[Experimental]
		 */
		public function set rsl(value:String):void {
			_rsl = value;
		}
		
		private var _cacheTgt:Boolean = false;
		/**
		 * 	[Experimental]
		 */
		public function set cacheTarget(value:Boolean):void {
			_cacheTgt = value;
		}
		
		private var _cacheRSL:Boolean = false;
		/**
		 * 	[Experimental]
		 */
		public function set cacheRSL(value:Boolean):void {
			_cacheRSL = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Starts the of the SPAS 3.0 <code>Application</code> instance to load,
		 * 	specified by the <code>target</code> parameter.
		 * 
		 * 	@see #target
		 */
		public function start():void {
			if (_rsl != null) _cacheRSL ? cache(_rsl, 1) : load(_rsl, 1);
			else loadTgt();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _ldr:Loader;
		private var _urlLdr:URLLoader;
		private var _query:URLRequest;
		private var _mode:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			this.stop();
		}
		
		private function cache(uri:String, mode:int = 0):void {
			_mode = mode;
			_ldr = new Loader();
			_urlLdr = new URLLoader()
			_urlLdr.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLdr.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _urlLdr.addEventListener(Event.COMPLETE, cached);
			_query = new URLRequest(uri);
            _urlLdr.load(_query);
		}
		
		private function load(uri:String, mode:int = 0):void {
			_mode = mode;
			_ldr = new Loader();
			_ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			_query = new URLRequest(uri);
			_ldr.load(_query);
		}
		
		private function onProgress(pe:ProgressEvent):void {
			var e:ApplicationLoaderEvent = new ApplicationLoaderEvent(ApplicationLoaderEvent.PROGRESS);
			e.spas_internal::loaded = pe.bytesLoaded;
			e.spas_internal::total = pe.bytesTotal;
			dispatchEvent(e);
		}
		
		private function loaded(e:Event):void {
			_mode == 0 ? init() : loadTgt();
		}
		
		private function cached(e:Event):void {
            var cl:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_ldr.loadBytes(_urlLdr.data as ByteArray, cl);
			/*if (ApplicationDomain.currentDomain.hasDefinition("SpasRSL")) {
				trace(ApplicationDomain.currentDomain.getDefinition("SpasRSL"));
			}*/
			_mode == 0 ? init() : loadTgt();
        }
		
		private function loadTgt():void {
			_mode = 0;
			_cacheTgt ? cache(_tgt) : load(_tgt);
		}
		
		private function init():void {
			var e:ApplicationLoaderEvent = new ApplicationLoaderEvent(ApplicationLoaderEvent.COMPLETE);
			e.spas_internal::app = _ldr
			dispatchEvent(e);
		}
	}
}