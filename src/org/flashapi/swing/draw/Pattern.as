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
	// Pattern.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 30/05/2009 00:32
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.net.UILoader;
	
	/**
	 * 	A convenient class that allows to create and manage a pattern image from a
	 * 	<code>BitmapData</code>, a <code>Shape</code>, a <code>Sprite</code>, a 
	 * 	<code>Bitmap</code> object or any extenal graphical asset, specified by the
	 * 	<code>texture</code> property and constructor parameter.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Pattern {
		
		//-------------------------------------------------------------------------
		//
		//  Constructor
		//
		//-------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Pattern</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	target	The <code>DisplayObject</code> instance where the pattern
		 * 					image will be rendered.
		 * 	@param	texture	The texture image used to render this <code>Pattern</code>
		 * 					object. 
		 * 	@param	width	The width of this pattern image, in pixels.
		 * 	@param	height	The height of this pattern image, in pixels.
		 */
		public function Pattern(target:DisplayObject, texture:* = null, width:Number = 100, height:Number = 100) {
			super();
			initObj(target, texture, width, height);
		}
		
		//-------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------
		
		/**
		 * 	Sets a specific shape to this <code>Pattern</code> object that is used
		 * 	render the pattern image by using this custom shape instead of a
		 * 	rectangular area. If <code>null</code> the rectangular area defined by
		 * 	the <code>rect</code> property is used by default.
		 * 
		 * 	@param figure A <code>Figure</code> object that allows access to its
		 * 					drawing methods to draw the custom shape.
		 * 
		 * 	@default null
		 */
		public var setShape:Function;
		
		//-------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//-------------------------------------------------------------------------
		
		private var _colorTransform:ColorTransform = null;
		/**
		 * 	Sets or gets the color transformation for this <code>Pattern</code>
		 * 	object.
		 */
		public function get colorTransform():ColorTransform {
			return _colorTransform;
		}
		public function set colorTransform(value:ColorTransform):void {
			_colorTransform = value;
		}
		
		/**
		 * 	@private [Deprecated]
		 */
		public function get figure():Figure {
			return _figure;
		}
		
		private var _height:Number;
		/**
		 * 	Returns the height of this pattern image, in pixels.
		 * 
		 * 	@see #width
		 * 	@see #resize()
		 */
		public function get height():Number {
			return _height;
		}
		
		private var _rect:Rectangle;
		/**
		 * 	The rectangle that defines the size and location of the <code>Pattern</code>
		 * 	image. The top and left of the rectangle are <code>0</code>; the <code>width</code>
		 * 	and <code>height</code> are equal to the <code>width</code> and <code>height</code>
		 * 	in pixels of the <code>Pattern</code> object.
		 * 
		 * 	@see #width
		 * 	@see #height
		 */
		public function get rect():Rectangle {
			return _rect;
		}
		
		private var _texture:*;
		/**
		 * 	Sets or gets the texture image used to render this <code>Pattern</code>
		 * 	object. Texture can be a <code>BitmapData</code>, a <code>Shape</code>,
		 * 	a <code>Sprite</code>, a <code>Bitmap</code> object or any extenal
		 * 	graphical asset, specified by the <code>texture</code> property of the
		 * 	constructor parameter.
		 */
		public function get texture():* {
			return _texture;
		}
		public function set texture(value:*):void {
			_texture = value;
			createPattern();
		}
		
		private var _width:Number;
		/**
		 * 	Returns the width of this pattern image, in pixels.
		 * 
		 * 	@see #height
		 * 	@see #resize()
		 */
		public function get width():Number {
			return _width;
		}
		
		//-------------------------------------------------------------------------
		//
		//  Public methods
		//
		//-------------------------------------------------------------------------
		
		/**
		 * 	Clears the <code>Pattern</code> object.
		 */
		public function clear():void {
			_figure.clear();
		}
		
		/**
		 * 	Frees memory that is used to store the <code>Pattern</code> object.
		 */
		public function dispose():void {
			finalizeUILoader();
			_figure.clear();
			if (_bmpData != null) {
				_bmpData.dispose();
				_bmpData = null;
			}
			if (_cloneBitmap != null) {
				_cloneBitmap.dispose();
				_cloneBitmap = null;
			}
			_colorTransform = null;
			_eventCollector.finalize();
			_eventCollector = null;
			_figure = null;
		}
		
		/**
		 * 	Forces the pattern image to be redrawn. You must call this method to 
		 * 	update the <code>Pattern</code> object, each time you set a new 
		 * 	<code>setShape</code> function.
		 * 
		 * 	@see #setShape
		 */
		public function redraw():void {
			drawPattern();
		}
		
		/**
		 * 	Resizes the pattern image with the specified parameters.
		 * 
		 * 	@param	width	The width of this pattern image, in pixels.
		 * 	@param	height	The height of this pattern image, in pixels.
		 * 
		 * 	@see #width
		 * 	@see #height
		 */
		public function resize(width:Number, height:Number):void {
			_width = width;
			_height = height;
			drawPattern();
		}
		
		//-------------------------------------------------------------------------
		//
		//  Private properties
		//
		//-------------------------------------------------------------------------
		
		private var _target:DisplayObject;
		private var _bmpData:BitmapData;
		private var _eventCollector:EventCollector;
		private var _uiLoader:UILoader;
		private var _cloneBitmap:BitmapData;
		private var _figure:Figure;
		
		//-------------------------------------------------------------------------
		//
		//  Private methods
		//
		//-------------------------------------------------------------------------
		
		private function initObj(target:DisplayObject, texture:*, width:Number, height:Number):void {
			_target = target;
			_width = width;
			_height = height;
			_eventCollector = new EventCollector();
			_rect = new Rectangle(0, 0, _width, _height);
			_target.cacheAsBitmap = true;
			_texture = texture;
			_figure = new Figure(_target);
			createPattern();
		}
		
		private function createPattern():void {
			if(_texture!=null) {
				if(_texture is BitmapData) {
					_bmpData = _texture; drawPattern();
				} else if (_texture is Shape || _texture is Sprite || _texture is Bitmap) {
					_bmpData = new BitmapData(_texture.width, _texture.height, false, 0);
					_bmpData.draw(_texture);
				} else {
					switch(typeof _texture) {
						case PrimitiveType.STRING :
							finalizeUILoader();
							_uiLoader = new UILoader(_target);
							_uiLoader.load(_texture);
							_eventCollector.addEvent(_target, LoaderEvent.GRAPHIC_COMPLETE, completeEvent);
							break;
						case PrimitiveType.OBJECT : 
							setPattern(new Bitmap(new _texture(0, 0)));
							break;
					}
				}
			}
		}
		
		private function completeEvent(e:LoaderEvent):void {
			setPattern(e.data.content)
			_eventCollector.removeEvent(_target, LoaderEvent.GRAPHIC_COMPLETE, completeEvent);
		}
		
		private function setPattern(bitmap:Bitmap):void {
			_bmpData = new BitmapData(bitmap.width, bitmap.height, false, 0);
			_bmpData.draw(bitmap);
			drawPattern();
		}
		
		private function finalizeUILoader():void {
			if (_uiLoader != null) {
				_uiLoader.finalize();
				_uiLoader = null;
			}
		}
		
		private function drawPattern():void {
			if (_bmpData != null) {
				_cloneBitmap = _bmpData.clone();
				if (_colorTransform != null) _cloneBitmap.colorTransform(_rect, _colorTransform);
				_figure.clear();
				_figure.beginBitmapFill(_cloneBitmap, null, true, false);
				setShape != null ? setShape(_figure) : _figure.drawRectangle(0, 0, _width, _height);
				_figure.endFill();
			}
		}
	}
}