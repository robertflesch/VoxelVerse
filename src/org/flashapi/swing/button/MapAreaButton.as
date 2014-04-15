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

package org.flashapi.swing.button {
	
	// -----------------------------------------------------------
	// MapAreaButton.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 31/12/2007 03:01
	* @see http://www.flashapi.org/
	*/

	import flash.display.Sprite;
	import org.flashapi.swing.constants.MapShape;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.draw.ImageMap;
	import org.flashapi.swing.util.StringUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>MapAreaButton</code> class defines defines a geometric region
	 * 	associated with an <code>ImageMap</code> object, and associates that region
	 * 	with events and external references. This area can be either a rectangle, a
	 * 	circle or a polygonal shape.
	 * 
	 * 	@see org.flashapi.swing.draw.ImageMap
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MapAreaButton extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Constructor. Creates a new <code>MapAreaButton</code> instance.
		 * 
		 * 	@param	imageMap	The reference to the <code>ImageMap</code> object
		 * 						associated with this <code>MapAreaButton</code>.
		 * 	@param	shape	The type of shape area for this <code>MapAreaButton</code>.
		 * 					Must be constant of the <code>MapShape</code> class.
		 * 	@param	coords	The coordinates of the shape area.
		 * 	@param	href	The destination of the link associated with this <code>MapAreaButton</code>.
		 * 	@param	alt		The alternate text for this <code>MapAreaButton</code>.
		 * 	@param	name	The name of this <code>MapAreaButton</code>.
		 * 	@param	data	The data object passed to this <code>MapAreaButton</code>.
		 */
		public function MapAreaButton(imageMap:ImageMap, shape:String, coords:String, href:String, alt:String, name:String, data:String) {
			super();
			initObj(imageMap, shape, coords, href, alt, name, data);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The alternate text for the <code>MapAreaButton</code> object. The alternate
		 * 	text is displayed in a <code>Boxhelp</code> tooltip when the user rolls
		 * 	the mouse over the button.
		 */
		public var alt:String;
		
		/**
		 *  The <code>data</code> property lets you pass a value to the <code>MapAreaButton</code>
		 * 	object.
		 */
		public var data:String;
		
		/**
		 * 	Specifies the destination of the link associated with this <code>MapAreaButton</code> 
		 * 	object.
		 */
		public var href:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _imageMap:ImageMap;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(imageMap:ImageMap, shape:String, coords:String, href:String, alt:String, name:String, data:String):void {
			_imageMap = imageMap;
			this.name = name;
			this.href = href;
			this.alt = alt;
			this.data = data;
			switch(shape) {
				case MapShape.DEFAULT :
					//drawRectangle();
					//break;
				case MapShape.RECT :
					drawRectangle(coords);
					break;
				case MapShape.CIRCLE :
					drawCircle(coords);
					break;
				case MapShape.POLY :
					drawPolygon(coords);
					break;
			}
			_imageMap.spas_internal::mapArea.addChild(this);
			cacheAsBitmap = true;
			buttonMode = useHandCursor = imageMap.useHandCursor;
		}
		
		private function getCoords(value:String):Array {
			var coords:String = StringUtil.trim(value);
			return coords.split(",");
		}
		
		private function drawRectangle(coords:String):void {
			var c:Array = getCoords(coords);
			with(graphics) {
				beginFill(0xFF0000, 0);
				drawRect(0, 0, c[2]-c[0], c[3]-c[1]);
				endFill();
			}
			this.x = c[0];
			this.y = c[1];
		}
		
		private function drawCircle(coords:String):void {
			var c:Array = getCoords(coords);
			with(graphics) {
				beginFill(0xFF0000, 0);
				drawCircle(0, 0, c[2]);
				endFill();
			}
			this.x = c[0];
			this.y = c[1];
		}
		
		private function drawPolygon(coords:String):void {
			var c:Array = getCoords(coords);
			var len:uint = c.length - 2;
			var i:uint = 2;
			with(graphics) {
				moveTo(c[0], c[1]);
				beginFill(0xFF0000, 0);
				do {
					lineTo(c[i], c[i + 1]); i += 2;
				} while (i < len);
				endFill();
			}
		}
	}
}