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
	// BitmapClip.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 01/06/2009 15:17
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.geom.Vector2D;
	
	[IconFile("BitmapClip.png")]
	
	/**
	 * 	<img src="BitmapClip.png" alt="BitmapClip" width="18" height="18"/>
	 * 
	 * 	The <code>BitmapClip</code> class provides the API to apply a scaling grid
	 * 	to a <code>BitmapData</code> object. A common use for using a scaling grid
	 * 	is to set up a display object to be used as a component, in which edge
	 * 	regions retain the same width when the component is scaled.
	 * 
	 *  @includeExample BitmapClipExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BitmapClip extends Sprite implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BitmapClip</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	bitmapData	The source <code>BitmapData</code> instance of the
		 * 						bitmap clip.
		 * 	@param	smoothing	Controls whether or not the bitmap clip is smoothed
		 * 						when scaled (<code>true</code>).
		 */
		public function BitmapClip(bitmapData:BitmapData = null, smoothing:Boolean = false) {
			super();
			initObj(bitmapData, smoothing);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _bitmapData:BitmapData = null;
		/**
		 * 	Sets or gets the source <code>BitmapData</code> instance of the bitmap clip.
		 * 
		 * 	@default null
		 */
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
		public function set bitmapData(value:BitmapData):void {
			_bitmapData = value.clone();
			resize(_bitmapData.width, _bitmapData.height);
		}
		
		private var _height:Number = 0;
		/**
		 *  Indicates the height of the <code>BitmapClip</code>, in pixels.
		 * 
		 * 	@default 0
		 * 
		 *  @see #width
		 */
		override public function get height():Number {
			return _height;
		}
		override public function set height(value:Number):void {
			resize(_width, value);
		}
		
		private var _scale9Grid:Rectangle = null;
		/**
		 * 	Sets or gets the current scaling grid for this bitmap clip. If set to <code>null</code>,
		 * 	the entire bitmap clip is scaled normally when any scale transformation is applied.
		 * 
		 * 	<p>When you define the <code>scale9Grid</code> property, the bitmap clip is divided
		 * 	into a grid with nine regions based on the <code>scale9Grid</code> rectangle, which
		 * 	defines the center region of the grid. The eight other regions of the grid are the
		 * 	following areas:</p>
		 * 	<ul>
		 * 		<li>the upper-left corner outside of the rectangle,</li>
		 * 		<li>the area above the rectangle,</li>
		 * 		<li>the upper-right corner outside of the rectangle,</li>
		 * 		<li>the area to the left of the rectangle,</li>
		 * 		<li>the area to the right of the rectangle,</li>
		 * 		<li>the lower-left corner outside of the rectangle,</li>
		 * 		<li>the area below the rectangle,</li>
		 * 		<li>the lower-right corner outside of the rectangle.</li>
		 * 	</ul>
		 * 
		 * 	<p>When the <code>scale9Grid</code> property is defined and a bitmap clip is scaled,
		 * 	the following rules apply:</p>
		 * 	<ul>
		 * 		<li>Content in the center region is scaled normally.</li>
		 * 		<li>Content in the corners is not scaled.</li>
		 * 		<li>Content in the top and bottom regions is scaled horizontally only.</li>
		 * 		<li>Content in the left and right regions is scaled vertically only.</li>
		 * 	</ul>
		 * 
		 * 	@default null
		 * 
		 * 	@see #showGrid
		 */
		override public function get scale9Grid():Rectangle {
			return _scale9Grid;
		}
		override public function set scale9Grid(value:Rectangle):void  {
			//if (!value.equals(_scale9Grid)) {
				_scale9Grid = value;
				if(_bitmapData != null) drawScale9Grid();
			//}
		}
		
		private var _showGrid:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the rectangle defined by the
		 * 	<code>scale9Grid</code> property is visible (<code>true</code>), or not
		 * 	(<code>false</code>). The <code>showGrid</code> property does not refresh the 
		 * 	bitmap clip, so you need to call the <code>redraw()</code> method to make the
		 * 	new grid parameters effective.
		 * 
		 * 	@default false
		 * 
		 * 	@see #scale9Grid
		 * 	@see #redraw()
		 */
		public function get showGrid():Boolean {
			return _showGrid;
		}
		public function set showGrid(value:Boolean):void  {
			_showGrid = value;
		}
		
		private var _width:Number = 0;
		/**
		 *  Indicates the width of the <code>BitmapClip</code>, in pixels.
		 * 
		 * 	@default 0
		 * 
		 *  @see #height
		 */
		override public function get width():Number {
			return _width;
		}
		override public function set width(value:Number):void {
			resize(value, _height);
		}
		
		/**
		 * @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, _width, _height);
		}
		
		/**
		 * @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, _width, _height);
		}
		
		private var _smoothing:Boolean;
		/**
		 * 	Controls whether the bitmap clip is smoothed when scaled (<code>true</code>),
		 * 	or not (<code>false</code>). If <code>true</code>, upscaled bitmap images are
		 * 	rendered by using a bilinear algorithm.  If <code>false</code>, upscaled bitmap
		 * 	images are rendered by using a nearest-neighbor algorithm and look pixelated.
		 * 	Rendering by using the nearest neighbor algorithm is usually faster.
		 * 
		 * 	@default false
		 */
		public function get smoothing():Boolean {
			return _smoothing;
		}
		public function set smoothing(value:Boolean):void {
			_smoothing = value;
			this.redraw();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Resizes the bitmap clip with the specified <code>width</code> and
		 * 	<code>height</code>.
		 * 
		 * 	@param The new width for this bitmap clip, in pixels.
		 * 	@param The new height for this bitmap clip, in pixels.
		 */
		public function resize(width:Number, height:Number):void {
			_width = width;
			_height = height;
			this.redraw();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			if(_bitmapData != null) _bitmapData.dispose();
		}
		
		/**
		 * 	Forces the bitmap clip to be refreshed.
		 */
		public function redraw():void {
			if (_scale9Grid == null) {
				drawBitmapData();
			} else drawScale9Grid();
			drawMask();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _scaleMatrix:Matrix;
		private var _scale9GridMap:Array;
		private var _mask:Shape;
		private static const ARRAY_LENGTH:uint = 8;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(bitmapData:BitmapData, smoothing:Boolean):void {
			_smoothing = smoothing;
			this.cacheAsBitmap = true;
			_scaleMatrix = new Matrix();
			_mask = new Shape();
			addChild(_mask);
			this.mask = _mask;
			if (bitmapData != null) {
				_bitmapData = bitmapData.clone();
				_width = bitmapData.width;
				_height = bitmapData.height;
				drawBitmapData();
				drawMask();
			}
		}
		
		private function drawBitmapData():void {
			var g:Graphics = this.graphics;
			g.clear();
			_scaleMatrix.identity();
			_scaleMatrix.a = _width / _bitmapData.width;
			_scaleMatrix.d = _height / _bitmapData.height;
			g.beginBitmapFill(_bitmapData, _scaleMatrix, false, _smoothing);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
		}
		
		private function drawScale9Grid():void {
			getScale9GridMap(_width, _height);
			var l:int = ARRAY_LENGTH;
			var r1:Rectangle;
			var r2:Rectangle;
			var g:Graphics = this.graphics;
			g.clear();
			for (; l >= 0; l--) {
				r1 = _scale9GridMap[l][0].getRect();
				r2 = _scale9GridMap[l][1].getRect();
				_scaleMatrix.identity();
				_scaleMatrix.a = r2.width / r1.width;
				_scaleMatrix.d = r2.height / r1.height;
				_scaleMatrix.tx = r2.x - r1.x * _scaleMatrix.a;
				_scaleMatrix.ty = r2.y - r1.y * _scaleMatrix.d;
				g.beginBitmapFill(_bitmapData, _scaleMatrix, false, _smoothing);
				g.drawRect(r2.x, r2.y, r2.width, r2.height);
			}
			g.endFill();
			if(_showGrid) {
				g.lineStyle(1, 0xFF0000);
				g.drawRect(_scale9Grid.x, _scale9Grid.y, _scale9Grid.width, _scale9Grid.height);
				g.endFill();
			}
		}
		
		private function getScale9GridMap(w:Number, h:Number):void {
			var r:Rectangle = _scale9Grid;
			var bmpW:Number = _bitmapData.width;
			var bmpH:Number = _bitmapData.height;
			var bottomHeight:Number = h - (bmpH - r.bottom);
			var rightWidth:Number = w - (bmpW - r.right);
			_scale9GridMap = [
				[new Vector2D(0, 0, r.left, r.top),
					new Vector2D(0, 0, r.left, r.top)],
				[new Vector2D(0, r.top, r.left, r.bottom - r.top),
					new Vector2D(0, r.top, r.left, h - (bmpH - r.bottom) - r.top)],
				[new Vector2D(0, r.bottom, r.left, bmpH - r.bottom),
					new Vector2D(0, h - (bmpH - r.bottom), r.left, h - bottomHeight)],
				[new Vector2D(r.left, 0, r.right - r.left, r.top),
					new Vector2D(r.left, 0, w - (bmpW - r.right) - r.left, r.top)],
				[new Vector2D(r.left, r.top, r.right - r.left, r.bottom - r.top),
					new Vector2D(r.left, r.top, w - (bmpW - r.right) - r.left, h - (bmpH - r.bottom) - r.top)],
				[new Vector2D(r.left, r.bottom, r.right - r.left, bmpH - r.bottom),
					new Vector2D(r.left, h - (bmpH - r.bottom), w - (bmpW - r.right) - r.left, h - bottomHeight)],
				[new Vector2D(r.right, 0, bmpW - r.right, r.top),
					new Vector2D(w - (bmpW - r.right), 0, w - rightWidth, r.top)],
				[new Vector2D(r.right, r.top, bmpW - r.right, r.bottom - r.top),
					new Vector2D(w - (bmpW - r.right), r.top, w - rightWidth, h - (bmpH - r.bottom) - r.top)],
				[new Vector2D(r.right, r.bottom, bmpW - r.right, bmpH - r.bottom),
					new Vector2D(w - (bmpW - r.right), h - (bmpH - r.bottom), w - rightWidth, h - bottomHeight)]
			];
		}
		
		private function drawMask():void {
			/*_mask.x = this.x;
			_mask.y = this.x;*/
			with (_mask.graphics) {
				clear();
				beginFill(0, 0);
				drawRect(0, 0, _width, _height);
				endFill();
			}
		}
	}
}