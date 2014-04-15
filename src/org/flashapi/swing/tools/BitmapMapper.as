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

package org.flashapi.swing.tools {
	
	// -----------------------------------------------------------
	// BitmapMapper.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/02/2009 10:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.MappedBitmapEvent;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.exceptions.NullPointerException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.net.MappedBitmapLoader;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>BitmapMapper</code> class is a tool class that creates bitmap slices
	 * 	of an original bitmapdata object. The slices are defined by an XML file.
	 * 	The bitmapdata and XML files can be set at runtime. Both source objects can
	 * 	be defined from internal and/or external assets.
	 * 
	 * 	<p>If one or both source objects are defined from internal an external file,
	 * 	you must listen the <code>MappedBitmapEvent</code> "complete" event before
	 * 	you use the <code>BitmapMapper</code> class methods and properties.</p>
	 * 
	 *  @includeExample BitmapMapperExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BitmapMapper extends MappedBitmapLoader {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BitmapMapper</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	source 	The source for the bitmap object. Possible values can be a
		 * 					<code>BitmapData</code> instance or an URI to an external
		 * 					bitmap file.
		 * 	@param	map		The source for the XML object to associate to this
		 * 					<code>BitmapMapper</code>. Possible values can be an
		 * 					ActionScript <code>XML</code> object or an URI to an 
		 * 					external XML file.
		 */
		public function BitmapMapper(source:* = null, map:* = null) {
			super(source, null);
			initObj(map);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _title:String;
		/**
		 * 	Returns the title of the source image specified by the <code>title</code>
		 * 	tag of the XML definition file. If the <code>title</code> tag is omitted,
		 * 	the returns value is <code>null</code>.
		 * 
		 * 	@default null
		 */
		public function get title():String {
			return _title;
		}
		
		/**
		 * 	@private
		 */
		override public function set map(value:*):void {
			if(!isNull(value)) {
				if (value is String) super.map = value;
				else if (value is XML) {
					if (!isNull($map)) $map = null;
					setMap(value);
				} else throw new InvalidArgumentException();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>BitmapData</code> object which is a slice of the original
		 * 	<code>BitmapData</code> specified by the <code>source</code> parameter.
		 * 	The <code>index</code> parameter indicates the zero-based index of the item
		 * 	that defines a specific part of the original <code>BitmapData</code> object,
		 * 	whithin the XML map (e.g, the first item is <code>0</code>, the second
		 * 	item is <code>1</code>, and so on).
		 * 	
		 * 
		 * 	@param	index	The zero-based index value of an item, whithin the XML map,
		 * 					that defines a part of the original <code>BitmapData</code>
		 * 					object.
		 * 
		 * 	@return	A <code>BitmapData</code> object which is a part of the source
		 * 			<code>BitmapData</code>, according to an indexed slice definition
		 * 			whithin the XML map.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.NullPointerException
		 * 			A <code>NullPointerException</code> error if the XML map and / or 
		 * 			the bitmapdata source are not defined.
		 */
		public function getItemAt(index:uint):BitmapData {
			if (isNull($map) || isNull($bmp)) throw _excp;
			var item:XML = _itemList[index];
			var a:Array = item.attribute("choords").split(",");
			var m:Matrix = new Matrix(1, 0, 0, 1, -a[0], -a[1]);
			var bmp:BitmapData = new BitmapData(a[2], a[3]);
			bmp.draw($bmp, m);
			return bmp;
		}
		
		/*
		public function getItemById(id:String):BitmapData {
			if (isNull($map) || isNull($bmp)) throw _excp;
			return new BitmapData(10, 10);
		}
		*/
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _itemList:XMLList;
		private var _excp:NullPointerException =
			new NullPointerException(Locale.spas_internal::ERRORS.BITMAP_MAPPER_ERROR);
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function onMapLoaded(e:LoaderEvent):void {
			setMap(e.data);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(map:*):void {
			if (map != null) this.map = map;
		}
		
		private function setMap(data:XML):void {
			$map = data;
			_title = ($map.title != undefined) ? $map.title : null;
			_itemList = $map.elements("item");
			dispatchEvent(new MappedBitmapEvent(MappedBitmapEvent.MAP_CHANGED));
			dispatchCompleteEvent();
		}
	}
}