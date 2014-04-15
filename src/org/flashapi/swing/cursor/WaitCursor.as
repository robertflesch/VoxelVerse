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

package org.flashapi.swing.cursor {
	
	// -----------------------------------------------------------
	// WaitCursor.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/01/2011 21:23
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.geom.Geometry;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>WaitCursor</code> class creates an animated rotating cursor that
	 * 	you can use to indicate that your application is processing, or that a file
	 * 	is currently being loaded within a SPAS 3.0 container.
	 * 
	 *  @includeExample WaitCursorExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WaitCursor extends UIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>WaitCursor</code> instance with the
		 * 					specified parameter.
		 * 
		 * @param	size	The size of the <code>WaitCursor</code> instance, in pixels.
		 */
		public function WaitCursor(size:Number = 100) {
			super();
			initObj(size);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _opacity:Number = 1.0;
		/**
		 * 	Sets or gets the transparency of the cursor from <code>0</code> (fully
		 * 	transparent) to <code>1.0</code> fully opaque.
		 * 
		 * 	@default 1.0
		 */
		public function get opacity():Number {
			return _radius;
		}
		public function set opacity(value:Number):void {
			_opacity = value;
		}
		
		private var _radius:Number = 5;
		/**
		 * 	Sets or gets the size of the circular shape, in pixels.
		 * 
		 * 	@default 5
		 */
		public function get shapeRadius():Number {
			return _radius;
		}
		public function set shapeRadius(value:Number):void {
			_radius = value;
		}
		
		private var _size:Number;
		/**
		 * 	Sets or gets the size of the <code>WaitCursor</code> instance,
		 * 	in pixels.
		 * 
		 * 	@default 100
		 */
		public function get size():Number {
			return _size;
		}
		public function set size(value:Number):void {
			_bounds.width = _bounds.height = _size = value;
			setSizeProps();
		}
		
		private var _speed:Number = .25;
		/**
		 * 	Sets or gets the speed of the cursor rotation. As the <code>WaitCursor</code>
		 * 	class uses an enter frame event tu update the cursor rotation, you can
		 * 	use the <code>rotationSpeed</code> property to adjust the speed according
		 * 	to the current Flash Player frame rate.
		 * 
		 * 	@default 0.25
		 */
		public function get rotationSpeed():Number {
			return _speed;
		}
		public function set rotationSpeed(value:Number):void {
			_speed = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
            if(!$displayed) {
				spas_internal::uioSprite.visible = true;
				doStartEffect();
				refresh();
				$evtColl.addEvent(this, Event.ENTER_FRAME, drawCursor);
				//DepthManager.setOverAll(this);
			}
		}
		
		/**
		 * @private
		 */
		override public function remove():void {
			if ($displayed) {
				$evtColl.removeEvent(this, Event.ENTER_FRAME, drawCursor);
				unload();
			}
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return _bounds;
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return _bounds;
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			if ($evtColl.hasRegisteredEvent(this, Event.ENTER_FRAME, drawCursor))
				$evtColl.removeEvent(this, Event.ENTER_FRAME, drawCursor);
			_colorMatrix = null;
			_bmpd.dispose();
			_bmpd = null;
			_blur = null;
			_shape = null;
			_bounds = null;
			spas_internal::uioSprite.removeChild(_bmp);
			_bmp = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			setEffects();
			//DepthManager.setOverAll(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _shape:Shape;
		private var _bmpd:BitmapData;
		private var _bmp:Bitmap;
		private var _blur:BlurFilter;
		private var _rate:Number = .95;//this will make the effect fade to black
		private var _colorMatrix:ColorMatrixFilter;
		private var _bounds:Rectangle;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _range:Number;
		private var _currAngle:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(size:Number):void {
			_size = size;
			$color = 0xffffff;
			createContainer();
		}
		
		private function drawCursor(e:Event):void {
			var newX:Number = Math.sin(_currAngle)*_range+_xPos;
			var newY:Number = Math.cos(_currAngle) * _range + _yPos;
			with (_shape.graphics) {
				clear();
				beginFill($color, _opacity);
				drawCircle(newX, newY, _radius);
				endFill();
			}
			_bmpd.unlock();
			_bmpd.draw(_shape);
			_bmpd.applyFilter(_bmpd, _bounds, Geometry.ORIGIN, _colorMatrix);
			_bmpd.lock();
			
			_currAngle += _speed;
		}
		
		private function createContainer():void {
			_currAngle = 180 / Math.PI * 2;
			_shape = new Shape();
			_blur = new BlurFilter(3,3,3);
			_shape.filters = [_blur];
			_bmp = new Bitmap();
			_colorMatrix = new ColorMatrixFilter(
			[
			   _rate,0,0,0,1,
			   0,_rate,0,0,1,
			   0,0,_rate,0,1,
			   0,0,0,_rate,
			]);
			_bounds = new Rectangle(0, 0, _size, _size);
			setSizeProps();
			spas_internal::uioSprite.addChild(_bmp);
		}
		
		private function setSizeProps():void {
			_yPos = _xPos = _size / 2;
			_range = _size / 5;
			if (_bmpd != null) {
				_bmpd.dispose();
				_bmpd = null;
			}
			_bmpd = new BitmapData(_size, _size, true, 0);
			_bmp.bitmapData = _bmpd;
		}
	}
}