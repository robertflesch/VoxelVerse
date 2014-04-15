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
 
package org.flashapi.swing.geom.distort {
	
	// -----------------------------------------------------------
	// Distortion.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/04/2011 19:22
	* @see http://www.flashapi.org/
	* 
	* Original class: DistordImage by Thomas Pfeiffer (kiroukou) - 2006, no license.
	* From an idea and a first implementation by Andre Michelle.
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * 	Tesselates an area into several triangles to allow free transform distortion
	 * 	on <code>BitmapData</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class Distortion {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Distortion</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	source		A <code>DisplayObject</code> to distort.
		 * 	@param	target		The <code>Sprite</code> object where the effect will
		 * 						be displayed.
		 * 	@param	vPrecision 	The vertical precision of this <code>Distortion</code>
		 * 						object.
		 * 	@param	hPrecision	The horizontal precision of this <code>Distortion</code>
		 * 						object.
		 * 	@param	smooth		indicates whether distortion is rendered by using a
		 * 						nearest-neighbor algorithm and look pixelated
		 * 						(<code>true</code>), or not (<code>false</code>).
		 * 						Rendering by using the nearest neighbor algorithm is
		 * 						usually faster.
		 */
		public function Distortion(source:*, target:Sprite, vPrecision:Number = 4, hPrecision:Number = 4, smooth:Boolean = true) {
			super();
			initObj(source, target, vPrecision, hPrecision, smooth);
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the <code>x</code> value of the target container where
		 * 	the <code>Distortion</code> object is displayed, in pixels.
		 */
		public function get x():Number {
			return _tgt.x;
		}
		public function set x(value:Number):void {
			_tgt.x = value;
		}
		
		/**
		 * 	Sets or gets the <code>y</code> value of the target container where
		 * 	the <code>Distortion</code> object is displayed, in pixels.
		 */
		public function get y():Number {
			return _tgt.y;
		}
		public function set y(value:Number):void {
			_tgt.y = value;
		}
		
		private var _texture:BitmapData;
		/**
		 * 	Returns the <code>BitmapData</code> object that is used to render the
		 * 	distortion.
		 */
		public function get texture():BitmapData {
			return _texture;
		}
		
		private var _smooth:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether distortions are rendered
		 * 	by using a nearest-neighbor algorithm and look pixelated (<code>true</code>),
		 * 	or not (<code>false</code>). Rendering by using the nearest neighbor
		 * 	algorithm is usually faster.
		 * 
		 * 	@default true
		 */
		public function get smooth():Boolean {
			return _smooth;
		}
		public function set smooth(value:Boolean):void {
			_smooth = value;
		}
		
		private var _vPrec:Number;
		/**
		 * 	Sets or gets the vertical precision of this <code>Distortion</code>
		 * 	instance. When you set this property, you must call the <code>render()</code>
		 * 	to update the <code>Distortion</code> object with the new vertical
		 * 	precision.
		 * 	
		 * 	@see #hPrecision
		 */
		public function get vPrecision():Number {
			return _vPrec;
		}
		public function set vPrecision(value:Number):void {
			_vPrec = value;
		}
		
		private var _hPrec:Number;
		/**
		 * 	Sets or gets the horizontal precision of this <code>Distortion</code>
		 * 	instance. When you set this property, you must call the <code>render()</code>
		 * 	to update the <code>Distortion</code> object with the new horizontal
		 * 	precision.
		 * 	
		 * 	@see #vPrecision
		 */
		public function get hPrecision():Number {
			return _hPrec;
		}
		public function set hPrecision(value:Number):void {
			_hPrec = value;
		}
		
		private var _width:Number;
		/**
		 * 	Returns the width of the <code>Distortion</code> object, in pixels.
		 */
		public function get width():Number {
			return _height;
		}
		
		private var _height:Number;
		/**
		 * 	Returns the height of the <code>Distortion</code> object, in pixels.
		 */
		public function get height():Number {
			return _height;
		}
		
		private var _src:*;
		/**
		 * 	Returns a reference to the <code>DisplayObject</code> instance which is
		 * 	distorted by this <code>Distortion</code> object.
		 */
		public function get source():* {
			return _src;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Re-initializes the triangular grid and redraws the distortion.
		 */
		public function render():void {
			refresh();
		}
		
		/**
		 * 	Frees memory that is used to store the <code>Distortion</code> object.
		 * 	When the <code>dispose()</code> method is called on an <code>Distortion</code>
		 * 	instance, all subsequent calls to its methods or properties fail, and an
		 * 	exception is thrown.
		 */
		public function dispose():void {
			_texture.dispose();
			_texture = null;
			//if (_src is BitmapData) _src.dispose();
			_src = null;
			_tgt = null;
			_vertexStack = [];
			_vertexStack = null;
			_triangles = [];
			_triangles = null;
			_sMat = null;
			_tMat = null;
		}
		
		/**
		 * 	Applies a distortion according to the provided <code>Point</code> instances and
		 * 	draws it onto the <code>Graphics</code> object of the provided <code>target</code>
		 * 	sprite.
		 * 
		 * 	@param	topLeft		A <code>Point</code> specifying the coordinates of
		 * 						the top-left corner.
		 * 	@param	topRight	A <code>Point</code> specifying the coordinates of
		 * 						the top-right corner.
		 * 	@param	bottomRight	A <code>Point</code> specifying the coordinates of
		 * 						the bottom-right corner.
		 * 	@param	bottomLeft	A <code>Point</code> specifying the coordinates of
		 * 						the bottom-left corner.
		 * 
		 * 	@see #setChoordTransform()
		 */
		public function setTransform(topLeft:Point, topRight:Point, bottomRight:Point, bottomLeft:Point):void {
			defineTransform(bottomLeft.x - topLeft.x, bottomLeft.y - topLeft.y,
							bottomRight.x - topRight.x, bottomRight.y - topRight.y,
							topLeft.x, topLeft.y, topRight.x, topRight.y);
		}
		
		/**
		 * 	Applies a distortion according to the provided coordinates and draws it
		 * 	onto the <code>Graphics</code> object of the provided <code>target</code>
		 * 	sprite.
		 * 
		 * 	@param	x1	The <code>x</code> value specifying the coordinates of
		 * 				the top-left corner.
		 * 	@param	y1	The <code>y</code> value specifying the coordinates of
		 * 				the top-left corner.
		 * 	@param	x2	The <code>x</code> value specifying the coordinates of
		 * 				the top-right corner.
		 * 	@param	y2	The <code>y</code> value specifying the coordinates of
		 * 				the top-right corner.
		 * 	@param	x3	The <code>x</code> value specifying the coordinates of
		 * 				the bottom-right corner.
		 * 	@param	y3	The <code>y</code> value specifying the coordinates of
		 * 				the bottom-right corner.
		 * 	@param	x4	The <code>x</code> value specifying the coordinates of
		 * 				the bottom-left corner.
		 * 	@param	y4	The <code>y</code> value specifying the coordinates of
		 * 				the bottom-left corner.
		 * 
		 * 	@see #setTransform()
		 */
		public function setChoordTransform(x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number, x4:Number, y4:Number):void {
			defineTransform(x4 - x1, y4 - y1, x3 - x2, y3 - y2, x1, y1, x2, y2);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _xMin:Number;
		private var _xMax:Number;
		private var _yMin:Number;
		private var _yMax:Number;
		private var _hsLength:Number;
		private var _vsLength:Number;
		private var _vertexStack:Array;
		private var _triangles:Array;
		private var _tgt:Sprite;
		// -- skew and translation matrix
		private var _sMat:Matrix;
		private	var _tMat:Matrix;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(source:*, target:Sprite, vPrecision:Number, hPrecision:Number, smooth:Boolean):void {
			_tgt = target;
			_src = source;
			_vPrec = vPrecision;
			_hPrec = hPrecision;
			_smooth = smooth;
			initDistortion();
		}
		
		private function initDistortion():void {
			initTexture();
			
			_vertexStack = [];
			_triangles = [];
			
			var ix:Number = 0;
			var iy:Number;
			
			_xMin = _yMin = 0;
			_xMax = _width;
			_yMax = _height;
			
			_hsLength = _width / (_hPrec + 1);
			_vsLength = _height / (_vPrec + 1);
	 
			var x:Number;
			var y:Number;
			var vp:VertexPoint;
			for (; ix < _vPrec + 2 ; ++ix) {
				iy = 0;
				for (; iy < _hPrec + 2 ; ++iy) {
					x = ix * _hsLength;
					y = iy * _vsLength;
					vp = new VertexPoint(x, y, x, y);
					_vertexStack.push(vp);
				}
			}
			var tri:Triangle;
			ix = 0;
			for (; ix < _vPrec + 1 ; ++ix) {
				iy = 0;
				for (; iy < _hPrec + 1 ; ++iy) {
					tri = new Triangle(	_vertexStack[iy + ix * (_hPrec + 2)],
										_vertexStack[iy + ix * (_hPrec + 2) + 1],
										_vertexStack[iy + (ix + 1) * (_hPrec + 2) ]);
					_triangles.push(tri);
					tri = new Triangle(	_vertexStack[iy + (ix + 1) * (_hPrec + 2) + 1],
										_vertexStack[iy + (ix + 1) * (_hPrec + 2)],
										_vertexStack[iy + ix * (_hPrec + 2) + 1]);
					_triangles.push(tri);
				}
			}
			_sMat = new Matrix();
			_tMat = new Matrix();
			refresh();
		}
		
		private function initTexture():void {
			if(_src is BitmapData) {
				_texture = _src as BitmapData;
				_width = _texture.width;
				_height = _texture.height;
			} else {
				var src:DisplayObject = _src as DisplayObject;
				_texture = new BitmapData(src.width, src.height, true, 0x00000000);
				_width = _texture.width;
				_height = _texture.height;
				_texture.draw(src);
			}
			_texture.lock();
		}
		
		
		private function refresh():void {
			var p0:VertexPoint;
			var p1:VertexPoint;
			var p2:VertexPoint;
			var gfx:Graphics = _tgt.graphics;
			
			gfx.clear();
			_sMat.identity();
			_tMat.identity();
			
			var l:Number = _triangles.length - 1;
			var x0:Number;
			var y0:Number;
			var x1:Number;
			var y1:Number;
			var x2:Number;
			var y2:Number;
			var u0:Number;
			var v0:Number;
			var u1:Number;
			var v1:Number;
			var u2:Number;
			var v2:Number;
			var tri:Triangle;
			for (; l >= 0; l--) {
				tri = _triangles[l];
				p0 = tri.vertex0;
				p1 = tri.vertex1;
				p2 = tri.vertex2;
				x0 = p0.sx;
				y0 = p0.sy;
				x1 = p1.sx;
				y1 = p1.sy;
				x2 = p2.sx;
				y2 = p2.sy;
				
				u0 = p0.x;
				v0 = p0.y;
				u1 = p1.x;
				v1 = p1.y;
				u2 = p2.x;
				v2 = p2.y;
				
				_tMat.tx = u0;
				_tMat.ty = v0;
				
				_tMat.a = (u1 - u0) / _width;
				_tMat.b = (v1 - v0) / _width;
				_tMat.c = (u2 - u0) / _height;
				_tMat.d = (v2 - v0) / _height;
				
				_sMat.a = (x1 - x0) / _width;
				_sMat.b = (y1 - y0) / _width;
				_sMat.c = (x2 - x0) / _height;
				_sMat.d = (y2 - y0) / _height;
				
				_sMat.tx = x0;
				_sMat.ty = y0;
				
				_tMat.invert();
				_tMat.concat(_sMat);
				
				gfx.beginBitmapFill(_texture, _tMat, false, _smooth);
				gfx.moveTo(x0, y0);
				gfx.lineTo(x1, y1);
				gfx.lineTo(x2, y2);
				gfx.endFill();
			}
		}
		
		private function defineTransform(dx41:Number, dy41:Number, dx32:Number, dy32:Number, x1:Number, y1:Number, x2:Number, y2:Number):void {
			var l:int = _vertexStack.length - 1;
			var vp:VertexPoint;
			var gx:Number;
			var gy:Number;
			var bx:Number;
			var by:Number;
			for (; l >= 0; l--) {
				vp = _vertexStack[l];
				gx = (vp.x - _xMin) / _width;
				gy = (vp.y - _yMin) / _height;
				bx = x1 + gy * (dx41);
				by = y1 + gy * (dy41);
				vp.sx = bx + gx * ((x2 + gy * (dx32)) - bx);
				vp.sy = by + gx * ((y2 + gy * (dy32)) - by);
			}
			refresh();
		}
	}
}