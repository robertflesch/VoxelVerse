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
	// MappedBitmapLoader.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 06/03/2009 14:46
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.MappedBitmapEvent;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.net.DataLoader;
	
	use namespace spas_internal;
	
	/**
	 *  Dispatched when the <code>map</code> and/or the <code>source</code> properties
	 * 	of the <code>MappedBitmapLoader</code> instance have been set by using URIs
	 * 	and all data is fully loaded.
	 *
	 *  @eventType org.flashapi.swing.event.MappedBitmapEvent.COMPLETE
	 */
	[Event(name = "complete", type = "org.flashapi.swing.event.MappedBitmapEvent")]
	
	/**
	 *  Dispatched when the <code>source</code> property of the <code>MappedBitmapLoader</code>
	 * 	instance has been set by using an ActionScript <code>BitmapData</code> object.
	 * .
	 *  @eventType org.flashapi.swing.event.MappedBitmapEvent.BITMAP_CHANGED
	 */
	[Event(name = "bitmapChanged", type = "org.flashapi.swing.event.MappedBitmapEvent")]
	
	/**
	 *  Dispatched when the <code>map</code> property of the <code>MappedBitmapLoader</code>
	 * 	instance has been set by using an ActionScript <code>XML</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.MappedBitmapEvent.MAP_CHANGED
	 */
	[Event(name = "mapChanged", type = "org.flashapi.swing.event.MappedBitmapEvent")]
	
	/**
	 * 	The <code>MappedBitmapLoader</code> class is a tool class that create bitmapdata
	 * 	objects assiocated with XML map files. The bitmapdata and XML map file can be
	 * 	changed at runtime. Both sources for these objects can be defined from internal
	 * 	and/or external assets.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MappedBitmapLoader extends EventDispatcher implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>MappedBitmapLoader</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	source 	The source for the bitmap object. Possible values can be a
		 * 					<code>BitmapData</code> instance or an URI to an external
		 * 					bitmap file.
		 * 	@param	map		The source for the XML object to associate to this
		 * 					<code>MappedBitmapLoader</code>. Possible values can be an
		 * 					ActionScript <code>XML</code> object or an URI to an external
		 * 					XML file.
		 */
		public function MappedBitmapLoader(source:* = null, map:* = null) {
			super();
			initObj(source, map);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>source</code> property.
		 * 
		 * 	@see #source
		 */
		protected  var $bmp:BitmapData;
		/**
		 * 	Sets or gets the bitmap source for this <code>MappedBitmapLoader</code>
		 * 	object. Possible values can be a <code>BitmapData</code> instance or an
		 * 	URI to an external bitmap file.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An
		 * 	<code>InvalidArgumentException</code> error if the <code>source</code>
		 * 	is not a <code>BitmapData</code> instance or an URI to an external
		 * 	bitmap file.
		 * 
		 * 	@default null
		 * 
		 * 	@see #sourceURI
		 * 	@see #map
		 */
		public function get source():* {
			return $bmp;
		}
		public function set source(value:*):void {
			setSrc(value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>sourceURI</code> property.
		 * 
		 * 	@see #sourceURI
		 */
		protected var $srcURI:String;
		/**
		 * 	Returns the URI of the external bitmap asset for the <code>source</code>
		 * 	property, if exists; <code>null</code> otherwise.
		 * 
		 * 	@default null
		 * 
		 * 	@see #source
		 */
		public function get sourceURI():String {
			return $srcURI;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>xmlURI</code> property.
		 * 
		 * 	@see #xmlURI
		 */
		protected var $xmlURI:String;
		/**
		 * 	Returns the URI of the external XML asset for the <code>map</code>
		 * 	property, if exists; <code>null</code> otherwise.
		 * 
		 * 	@default null
		 * 
		 * 	@see #map
		 */
		public function get xmlURI():String {
			return $xmlURI;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>map</code> property.
		 * 
		 * 	@see #map
		 */
		protected var $map:XML;
		/**
		 * 	Sets or gets the xml map for this <code>MappedBitmapLoader</code>
		 * 	object. Possible values can be an ActionScript <code>XML</code> 
		 * 	object or an URI to an external XML file.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An
		 * 	<code>InvalidArgumentException</code> error if the <code>map</code>
		 * 	is not an ActionScript <code>XML</code> object or an URI to an external
		 * 	XML file.
		 * 
		 * 	@default null
		 * 
		 * 	@see #source
		 * 	@see #xmlURI
		 */
		public function get map():* {
			return $map;
		}
		public function set map(value:*):void {
			setMap(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>Boolean</code> that indicates whether the <code>map</code>
		 * 	property of this <code>MappedBitmapLoader</code> is <code>null</code>
		 * 	(<code>false</code>), or not (<code>true</code>).
		 * 
		 * 	@return	A <code>Boolean</code> that indicates whether the <code>map</code>
		 * 			property is <code>null</code> or not.
		 * 
		 * 	@see #hasSource()
		 */
		public function hasMap():Boolean {
			return Boolean($map != null);
		}
		
		/**
		 * 	Returns a <code>Boolean</code> that indicates whether the <code>source</code>
		 * 	property of this <code>MappedBitmapLoader</code> is <code>null</code>
		 * 	(<code>false</code>), or not (<code>true</code>).
		 * 
		 * 	@return	A <code>Boolean</code> that indicates whether the <code>source</code>
		 * 			property is <code>null</code> or not.
		 * 
		 * 	@see #hasMap()
		 */
		public function hasSource():Boolean {
			return Boolean($bmp != null);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>EventCollector</code> instance
		 * 	for this <code>MappedBitmapLoader</code>.
		 */
		protected var $evtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onMapLoaded(e:LoaderEvent):void {
			$map = e.data;
			dispatchEvent(new MappedBitmapEvent(MappedBitmapEvent.MAP_CHANGED));
			dispatchCompleteEvent();
		}
		
		/**
		 * @private
		 */
		protected function onBitmapLoaded(e:LoaderEvent):void {
			var l:Loader = e.data;
			$bmp = new BitmapData(l.width, l.height);
			$bmp.draw(l);
			dispatchEvent(new MappedBitmapEvent(MappedBitmapEvent.BITMAP_CHANGED));
			dispatchCompleteEvent();
		}
		
		/**
		 * @private
		 */
		protected function dispatchCompleteEvent():void {
			if (!isNull($map) && !isNull($bmp))
				this.dispatchEvent(new MappedBitmapEvent(MappedBitmapEvent.COMPLETE));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(source:*, map:*):void {
			$evtColl = new EventCollector();
			setSrc(source);
			setMap(map);
		}
		
		private function setSrc(src:*):void {
			if (!isNull($bmp)) $bmp.dispose();
			if (!isNull(src)) {
				if (src is String) loadBitmap(src);
				else if (src is BitmapData) {
					$bmp = src;
					dispatchEvent(new MappedBitmapEvent(MappedBitmapEvent.BITMAP_CHANGED));
					dispatchCompleteEvent();
				} else throw new InvalidArgumentException(
							Locale.spas_internal::ERRORS.BITMAP_INVALID_BITMAP_ERROR
						);
			}
		}
		
		private function setMap(map:*):void {
			if (!isNull($map)) $map = null;
			if(!isNull(map)) {
				if (map is String) loadMap(map);
				else if (map is XML) {
					$map = map;
					dispatchEvent(new MappedBitmapEvent(MappedBitmapEvent.MAP_CHANGED));
					dispatchCompleteEvent();
				} else throw new InvalidArgumentException(
							Locale.spas_internal::ERRORS.BITMAP_INVALID_MAP_ERROR
						);
			}
		}
		
		private function loadBitmap(uri:String):void {
			$srcURI = uri;
			var bdl:DataLoader = new DataLoader();
			$evtColl.addOneShotEvent(bdl, LoaderEvent.GRAPHIC_COMPLETE, onBitmapLoaded);
			bdl.load(uri);
		}
		
		private function loadMap(uri:String):void {
			$xmlURI = uri;
			var dl:DataLoader = new DataLoader();
			$evtColl.addOneShotEvent(dl, LoaderEvent.XML_COMPLETE, onMapLoaded);
			dl.load(uri, DataFormat.XML);
		}
	}
}