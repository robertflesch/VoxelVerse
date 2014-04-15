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

package org.flashapi.swing.draw {
	
	// -----------------------------------------------------------
	// ImageMap.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 02/06/2009 23:02
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.button.MapAreaButton;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.ImageMapEvent;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.net.DataLoader;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	The <code>ImageMap</code> class is an implementation of a client-side
	 * 	image map manager based upon HTML image map process.
	 * 	
	 * <p>The W3C specification about image maps indicates that image maps allow
	 * 	authors to specify regions of an image or object and assign a specific
	 * 	action to each region (e.g., retrieve a document, run a program, etc.)
	 * 	When the region is activated by the user, the action is executed. The
	 * 	SPAS 3.0 <code>ImageMap</code> class do not execute any action when the
	 * 	user activate a region of an image, but the associated target object
	 * 	dispatches corresponding <code>ImageMapEvent</code> events.</p>
	 * 
	 * 	<p>The object used as the image map must be a valid XML object/file:</p>
	 * 	<pre>
	 * 	&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 * 	&lt;spas:map xmlns:spas="http://www.flashapi.org/spas" name="my_map" urlPath="my_URLPath"&gt;
	 * 		&lt;area href="my_URI.html" alt="alternate text" data="my_data" shape="rect" coords="a,b,c,d" /&gt;
	 * 		...
	 * 	&lt;/spas:map&gt;
	 * 	</pre>
	 * 
	 * 	@see org.flashapi.swing.Image#usemap
	 * 	@see http://www.w3.org/TR/2004/WD-xhtml2-20040722/mod-csImgMap.html
	 * 	@see http://www.w3.org/TR/2002/WD-xhtml2-20021218/mod-csImgMap.html
	 * 	@see org.flashapi.swing.button.MapAreaButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ImageMap extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ImageMap</code> instance for the specified
		 * 	target.
		 * 
		 * 	@param	target	the <code>UIObject</code> or the <code>DisplayObjectContainer</code>
		 * 					wich will be associated to this image map.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalArgumentException An
		 * 			<code>IllegalArgumentException</code> if the target is not a
		 * 			<code>DisplayObjectContainer</code> or a <code>UIObject</code>.
		 */
		public function ImageMap(target:*) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _mapData:XML = null;
		/**
		 * 	Returns the XML object used as map for this <code>ImageMap</code> instance.
		 */
		public function get mapData():XML {
			return _mapData;
		}
		
		private var _urlPath:String = null;
		/**
		 * 	Sets or gets the URI path for all the reative areas of the image map.
		 * 
		 * 	@default null
		 */
		public function get urlPath():String {
			return _urlPath;
		}
		public function set urlPath(value:String):void {
			_urlPath = value;
		}
		
		private var _useHandCursor:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the pointing hand used
		 * 	appears when the mouse rolls over a reative areas (<code>true</code>, or not
		 * 	<code>false</code>. If <code>false</code> the arrow pointer is used instead.
		 * 
		 * 	<p>You can change the <code>useHandCursor</code> property at any time; the
		 * 	reative areas will immediately take on the new cursor appearance.</p>
		 * 
		 * 	@default false
		 */
		public function get useHandCursor():Boolean {
			return _useHandCursor;
		}
		public function set useHandCursor(value:Boolean):void {
			_useHandCursor = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Associates an image map object to this <code>ImageMap</code> instance.
		 * 
		 * 	@param	value	The XML file/object to use as map. The value parameter
		 * 					can be an URI, or a XML object. If using an URI as parameter,
		 * 					the external XML file is automatically loaded.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalArgumentException An
		 * 			<code>IllegalArgumentException</code> if the <code>value</code>
		 * 			parameter is neither an URI or a <code>XML</code> object.
		 */
		public function setMapData(value:*):void {
			_eventCollector.removeAllEvents();
			if (value == null) return;
			switch(typeof(value)) {
				case PrimitiveType.XML :
					_mapData = value;
					drawMapDataArea();
					break;
				case PrimitiveType.STRING :
					_dataLoader = new DataLoader();
					_dataLoader.load(value, DataFormat.XML);
					_dataLoader.addEventListener(LoaderEvent.COMPLETE, onDataLoaded)
				break;
				default :
					throw new IllegalArgumentException(Locale.spas_internal::ERRORS.MAP_DATA_ERROR);
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			//--> _dataLoader.close();
			_target = null;
			_eventCollector.finalize();
			_eventCollector = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var mapArea:Sprite;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _dataLoader:DataLoader;
		private var _target:*;
		private var _eventCollector:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:*):void {
			_target = target;
			mapArea = new Sprite();
			_eventCollector = new EventCollector();
			if(target is UIObject) target.spas_internal::uioSprite.addChild(mapArea);
			else if (target is DisplayObjectContainer) target.addChild(mapArea);
			else throw new IllegalArgumentException(Locale.spas_internal::ERRORS.MAP_TARGET_ERROR);
		}
		
		private function onDataLoaded(e:LoaderEvent):void {
			_mapData = e.data;
			drawMapDataArea();
		}
		
		private function drawMapDataArea():void {
			/*
			if(_xmlQuery.strictMode) {
				if(data.namespace().prefix != "spas") throw new DataFormatException("Namespace prefix mismatch: prefix must be 'spas' in strict mode.");
				if(data.namespace() != UIManager.SPAS_XML_NAMESPACE) throw new DataFormatException("Namespace mismatch: namespace must be '"+UIManager.SPAS_XML_NAMESPACE+"' in strict mode.");
				if(data.@caller != "PictureGallery") throw new DataFormatException("Caller attribute mismatch: caller must be 'PictureGallery' in strict mode.");
			}
			 */
			if(_mapData.@urlPath) _urlPath = _mapData.@urlPath.toString();
			for each(var prop:XML in _mapData.area) {
				var btn:MapAreaButton =
					new MapAreaButton(this, prop.@shape.toString(), prop.@coords.toString(),
					prop.@href.toString(), prop.@alt.toString(), prop.@name.toString(),
					prop.@shape.toString());
				_eventCollector.addEvent(btn, MouseEvent.CLICK, changeEventHandler);
				_eventCollector.addEvent(btn, MouseEvent.MOUSE_OVER, mouseOverHandler);
				_eventCollector.addEvent(btn, MouseEvent.MOUSE_OUT, mouseOutHandler);
			}
		}
		
		private function changeEventHandler(e:MouseEvent):void {
			var btn:MapAreaButton = e.target as MapAreaButton;
			var obj:Object = { alt:btn.alt, data:btn.data, name:btn.name, href:btn.href };
			_target.dispatchEvent(new ImageMapEvent(this, obj, ImageMapEvent.MAP_CLICKED));
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			_target.boxhelp.remove();
			var alt:String = e.target.alt;
			if(alt != null) {
				_target.boxhelp.label = alt;
				_target.boxhelp.display(alt);
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			_target.boxhelp.remove();
		}
	}
}