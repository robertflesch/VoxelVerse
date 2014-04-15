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
	// Grid.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 01/04/2009 01:38
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Graphics;
	import org.flashapi.swing.constants.GridHorizontalHanchor;
	import org.flashapi.swing.constants.GridVerticalHanchor;
	
	/**
	 * 	The <code>Grid</code> class defines a flexible grid area that consists
	 * 	of columns and rows. <code>Grid</code> objects allow to snap objects
	 * 	within a container element after a free dragging operations.
	 * 
	 *  @includeExample GridExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Grid {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Grid</code> instance with the specified
		 * 					parameters.
		 * 
		 * 	@param	target	A <code>Sprite</code> or a <code>Shape</code> object used  
		 * 					to display the lines of the <code>Grid</code> instance.
		 * 	@param	width	The width of the <code>Grid</code> instance, in pixels.
		 * 	@param	height	The height of the <code>Grid</code> instance, in pixels.
		 */
		public function Grid(target:*, width:Number = 400, height:Number = 400) {
			super();
			initObj(target, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _alpha:Number = 1;
		/**
		 * 	Sets or gets the opacity of the lines that physically define the
		 * 	<code>Grid</code> object when the <code>draw()</code> method has
		 * 	been called, from <code>0</code> (fully tranparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 * 	@default 1
		 * 
		 * 	@see #draw()
		 */
		public function get alpha():Number {
			return _alpha;
		}
		public function set alpha(value:Number):void {
			_alpha = value;
			setRefresh();
		}
		
		private var _color:uint = 0x999999;
		/**
		 * 	Sets or gets the colors of the lines that physically define the
		 * 	<code>Grid</code> object when the <code>draw()</code> method has
		 * 	been called.
		 * 
		 * 	@default 0x999999
		 * 
		 * 	@see #draw()
		 */
		public function get color():uint {
			return _color;
		}
		public function set color(value:uint):void {
			_color = value;
			setRefresh();
		}
		
		private var _height:Number;
		/**
		 * 	Sets or gets the height of the <code>Grid</code> object, in pixels.
		 * 
		 * 	@default 400
		 * 
		 * 	@see #width
		 */
		public function get height():Number {
			return _height;
		}
		public function set height(value:Number):void {
			_height = value;
			setRefresh();
		}
		
		private var _thickness:Number = 1;
		/**
		 * 	Sets or gets the thickness of the lines that physically define the
		 * 	<code>Grid</code> object when the <code>draw()</code> method has
		 * 	been called.
		 * 
		 * 	@default 1
		 * 
		 * 	@see #draw()
		 */
		public function get thickness():Number {
			return _thickness;
		}
		public function set thickness(value:Number):void {
			_thickness = value;
			setRefresh();
		}
		
		private var _width:Number;
		/**
		 * 	Sets or gets the width of the <code>Grid</code> object, in pixels.
		 * 
		 * 	@default 400
		 * 
		 * 	@see #height
		 */
		public function get width():Number {
			return _width;
		}
		public function set width(value:Number):void {
			_width = value;
			setRefresh();
		}
		
		private var _xSpan:Number = 10;
		/**
		 * 	Sets or gets the horizontal span of the <code>Grid</code> object, in pixels.
		 * 
		 * 	@default 10
		 * 
		 * 	@see #ySpan
		 */
		public function get xSpan():Number {
			return _xSpan;
		}
		public function set xSpan(value:Number):void {
			_xSpan = value;
			setRefresh();
		}
		
		private var _ySpan:Number = 10;
		/**
		 * 	Sets or gets the horizontal span of the <code>Grid</code> object, in pixels.
		 * 
		 * 	@default 10
		 * 
		 * 	@see #xSpan
		 */
		public function get ySpan():Number {
			return _ySpan;
		}
		public function set ySpan(value:Number):void {
			_ySpan = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Draws (displays) the lines that physically define the <code>Grid</code>
		 * 	object.
		 * 
		 * 	@see #clear()
		 */
		public function draw():void {
			_displayed = true;
			_graphics.clear();
			_displayed = true;
			_graphics.lineStyle(_thickness, _color, _alpha);
			var i:Number = 0;
			do {
				_graphics.moveTo(i, 0);
				_graphics.lineTo(i, _height);
				i += _xSpan;
			} while (i < _width);
			i = 0;
			do {
				_graphics.moveTo(0, i);
				_graphics.lineTo(_width, i);
				i += _ySpan;
			} while (i < _height);
			_graphics.endFill();
		}
		
		/**
		 * 	Clears (removes) the lines that physically define the <code>Grid</code>
		 * 	object.
		 * 
		 * 	@see #draw()
		 */
		public function clear():void {
			_graphics.clear();
			_displayed = false;
		}
		
		/**
		 * 	Snaps the element specified by the <code>obj</code> parameter to the grid.
		 * 
		 * 	@param	obj	The <code>DisplayObject</code> to snap to the grid.
		 * 	@param	horizontalHanchor	Specifies the horizontal position from which
		 * 								the object will be anchored to the the grid.
		 * 								Valid values are <code>GridHorizontalHanchor</code>
		 * 								constants.
		 * 	@param	verticalHanchor		Specifies the vertical position from which
		 * 								the object will be anchored to the the grid.
		 * 								Valid values are <code>GridVerticalHanchor</code>
		 * 								constants.
		 */
		public function snapToGrid(obj:*, horizontalHanchor:String = "left", verticalHanchor:String = "top"):void {
			var dx:Number;
			var dy:Number;
			switch(horizontalHanchor) {
				case GridHorizontalHanchor.LEFT :
					obj.x = Math.round(obj.x / _xSpan) * _xSpan;
					break;
				case GridHorizontalHanchor.CENTER :
					dx = obj.width / 2;
					obj.x = Math.round((obj.x + dx) / _xSpan) * _xSpan - dx;
					break;
				case GridHorizontalHanchor.RIGHT :
					dx = obj.width;
					obj.x = Math.round((obj.x + dx) / _xSpan) * _xSpan - dx;
					break;
			}
			switch(verticalHanchor) {
				case GridVerticalHanchor.TOP :
					obj.y = Math.round(obj.y / _ySpan) * _ySpan;
					break;
				case GridVerticalHanchor.MIDDLE :
					dy = obj.height / 2;
					obj.y = Math.round((obj.y + dy) / _ySpan) * _ySpan - dy;
					break;
				case GridVerticalHanchor.BOTTOM :
					obj.y = Math.round(obj.y / _ySpan) * _ySpan; 
					break;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _target:*;
		private var _graphics:Graphics; 
		private var _displayed:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:*, width:Number, height:Number):void {
			_target = target;
			_graphics = target.graphics;
			_width = width;
			_height = height;
		}
		
		private function setRefresh():void {
			if(_displayed) draw();
		}
	}
}