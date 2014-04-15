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

package org.flashapi.swing.fx.basicfx {
	
	// -----------------------------------------------------------
	// Reflection.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 22/12/2008 13:09
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.flashapi.swing.fx.FX;
	import org.flashapi.swing.geom.Geometry;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 */
	public class Reflection implements FX {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Reflection(target:DisplayObjectContainer, gap:Number = 0, alpha:Number = 1.0, ratio:Number = 255, interval:Number = -1) {
			super();
			initObj(target, gap, alpha, ratio, interval);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */
		public var useReflectionTextFix:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _alpha:Number;
		/**
		 * 	@default 1.0
		 */
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void { _alpha = value; update(); }
		
		private var _gap:Number;
		/**
		 * 	@default 0
		 */
		public function get gap():Number { return _gap; }
		public function set gap(value:Number):void { _gap = value; setPosition(); }
		
		/**
		 * 	Returns the height of the reflection.
		 */
		public function get height():Number { return _container.height; }
		
		private var _interval:Number;
		/**
		 * 	@default -1
		 */
		public function get interval():Number { return _interval; }
		public function set interval(value:Number):void {
			_interval = value;
			value ? startAutoUpdate() : stopAutoUpdate();
		}
		
		private var _ratio:Number;
		/**
		 * 	@default 255
		 */
		public function get ratio():Number { return _ratio; }
		public function set ratio(value:Number):void { _ratio = value;  update(); }
		
		private var _skew:Number = 0;
		/**
		 * 	@default 0
		 */
		public function get skewH():Number { return _skew; }
		public function set skewH(value:Number):void { _skew = value;  update(); }
		
		private var _target:DisplayObjectContainer;
		/**
		 * 	Returns the display object container for which we want to render the the mirroring effect.
		 */
		public function get target():DisplayObjectContainer { return _target; }
		
		/**
		 * 	Returns the width of the reflection.
		 */
		public function get width():Number { return _container.width; }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */
		public function hide():void { _container.parent.removeChild(_container); }
		
		/**
		 *  @inheritDoc
		 */
		public function remove():void {
			if(_container.contains(_bitmap)) {
				_container.removeChild(_bitmap);
				stopAutoUpdate();
				_bitmapData.dispose();
				_maskBitmap.dispose();
				_tmpBitmap.dispose();
				hide();
				_removed = true;
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function render():void {
			if(_removed) addBitmapRenderer();
			setBounds();
			update();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function finalize():void {
			stopAutoUpdate();
		}
		
		/**
		 * 
		 */
		public function show():void { _target.addChild(_container); }
		
		/**
		 * 
		 */
		public function getBounds():Rectangle {
			var r:Rectangle = _container.getRect(_container);
			//r.height -= _realHeight;
			return r;
		}
		
		/**
		 *  
		 */
		public function getRect():Rectangle {
			var r:Rectangle = _container.getRect(_container);
			//r.height -= _realHeight;
			return r;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _container:Sprite;
		private var _mask:Shape;
		private var _bitmapData:BitmapData;
		private var _tmpBitmap:BitmapData;
		private var _maskBitmap:BitmapData;
		private var _bitmap:Bitmap;
		private var _bounds:Rectangle;
		private var _realHeight:Number;
		private const ORIGIN:Point = Geometry.ORIGIN;
		private var _removed:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:DisplayObjectContainer, gap:Number, alpha:Number, ratio:Number, interval:Number):void {
			_target = target;
			_alpha = alpha;
			_ratio = ratio;
			_container = new Sprite();
			_mask = new Shape();
			_bitmap = new Bitmap();
			_gap = gap > 0 ? gap : 0;
			_interval = interval;
			_bitmap.cacheAsBitmap = true;
			addBitmapRenderer();
			show();
			if(_interval > -1) startAutoUpdate();
		}
		
		private function addBitmapRenderer():void {
			_container.addChild(_bitmap);
			_removed = false;
		}
		
		private function setBounds(rect:Rectangle = null):void{
			if(rect!=null) _bounds = rect;
			else {
				if(_target.contains(_container)) hide();
				var r:Rectangle = _target.getBounds(null);
				_bounds = new Rectangle(r.x, r.y, r.width, r.height + Math.abs(r.y));
				r = null;
				show();
			}
		}
		
		private function startAutoUpdate():void {
			render();
			_interval = setInterval(update, _interval);
		}
		
		private function stopAutoUpdate():void { clearInterval(_interval); }
		
		private function setPosition():void {
			_container.y = _bounds.height + _gap;
		}
		
		private function setRealHeight():void {
			_realHeight = _bounds.height/ (255 / _ratio);
		}
		
		private function update():void {
			setRealHeight();
			drawBitmap();
			_bitmap.bitmapData = _bitmapData;
			setPosition();
		}
		
		private function drawBitmap():void {
			var m:Matrix = new Matrix();
			m.d = -1;
			_skew = 0;
			m.c = _skew;
			//var tx:Number = Math.tan(_skew) * (_realHeight);
			//trace(tx);
			//m.tx = tx;
			_tmpBitmap = new BitmapData(_bounds.width, _bounds.height, true, 0);
			m.ty = _bounds.height;
			if(!useReflectionTextFix) _tmpBitmap.draw(_target, m);
			else {
				var txtFixBitmap:BitmapData = new BitmapData(_bounds.width, _bounds.height, true, 0);
				txtFixBitmap.draw(_target);
				_tmpBitmap.draw(txtFixBitmap, m);
				txtFixBitmap.dispose();
				txtFixBitmap = null;
			}
			drawMask();
			_bitmapData = new BitmapData(_bounds.width, _realHeight, true, 0);
			var r:Rectangle = new Rectangle(_bounds.x, _bounds.y, _bounds.width, _bounds.height);
			_bitmapData.copyPixels(_tmpBitmap, r, ORIGIN, _maskBitmap);
			_tmpBitmap.dispose();
			_maskBitmap.dispose();
		}
		
		private function drawMask():void {
			var fillType:String = GradientType.LINEAR;
		 	var colors:Array = [0, 0];
		 	var alphas:Array = [_alpha, 0];
		  	var ratios:Array = [0, _ratio];
			var spreadMethod:String = SpreadMethod.PAD;
		  	var m:Matrix = new Matrix();
			m.createGradientBox(_bounds.width, _bounds.height, (90 / 180) * Math.PI, 0, 0);
			var g:Graphics = _mask.graphics;
			g.clear();
			g.beginGradientFill(fillType, colors, alphas, ratios, m, spreadMethod);  
		    g.drawRect(0, 0, _bounds.width, _realHeight);
			g.endFill();
			_maskBitmap = new BitmapData(_bounds.width, _bounds.height, true, 0);
			_maskBitmap.draw(_mask);
			
		}
	}
}