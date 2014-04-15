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
	// Checkerboard Class
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 24/01/2011 14:14
	* @see http://www.flashapi.org
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.constants.PatternSize;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	
	use namespace spas_internal;
	
	[IconFile("Checkerboard.png")]
	
	/**
	 * 	<img src="Checkerboard.png" alt="Checkerboard" width="18" height="18"/>
	 * 
	 * 	In many several softwares, the transparent portions of a layer are displayed
	 * 	as a gray and white checkerboard pattern. The <code>Checkerboard</code> class
	 * 	creates this pattern with the specified width and height.
	 * 
	 * 	@includeExample CheckerboardExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class Checkerboard extends UIObject implements Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a <code>Checkerboard</code> instance with the specified
		 * 	width and height.
		 * 
		 *  @param	width	Indicates the width of the checkerboard, in pixels.
		 *  @param	height	Indicates the height of the checkerboard, in pixels.
		 */
		public function Checkerboard(width:Number = 100, height:Number = 100) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _isPainted:Boolean;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the checkerboard
		 * 	pattern is painted (<code>true</code>), or not(<code>false</code>).
		 */
		public function get isPainted():Boolean {
			return _isPainted;
		}
		
		/**
		 * 	@private
		 */
		private var _highlightColor:*;
		/**
		 * 	Sets or gets the checkerboard pattern highlight color.
		 * 
		 * 	@default 0xFFFFFF
		 * 
		 * 	@see #shadowColor
		 */
		public function get highlightColor():* {
			return _highlightColor;
		}
		public function set highlightColor(value:*):void {
			_highlightColor = ColorUtil.getColor(value);
			_canvas.dispose();
			setPattern();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		private var _shadowColor:*;
		/**
		 * 	Sets or gets the checkerboard pattern shadow color.
		 * 
		 * 	@default 0xEEEEEE
		 * 
		 * 	@see #highlightColor
		 */
		public function get shadowColor():* {
			return _shadowColor;
		}
		public function set shadowColor(value:*):void {
			_shadowColor = ColorUtil.getColor(value);
			_canvas.dispose();
			setPattern();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		private var _patternSize:String;
		/**
		 * 
		 * 	@default PatternSize.MEDIUM
		 */
		public function get patternSize():String {
			return _patternSize;
		}
		public function set patternSize(value:String):void {
			_patternSize = value;
			setSquareSize();
			setPattern();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	This method clears the pattern of this <code>Checkerboard</code> instance. 
		 */
		public function clear():void {
			spas_internal::uioSprite.graphics.clear();
			_isPainted = false;
		}
		
		/**
		 * 	Paints the pattern of this <code>Checkerboard</code> instance. This method
		 * 	is called when the contents of the <code>Checkerboard</code> object has to
		 * 	be painted; such as when the it is first being shown or it is resized.
		 */
		public function paint():void {
			with(spas_internal::uioSprite.graphics) {
				clear();
				beginBitmapFill(_canvas, null, true);
				drawRect(0, 0, $width, $height);
				endFill();
			}
			_isPainted = true;
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_canvas.dispose();
			_canvas = null;
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Initializes the checkerboard pattern. This method is called by the
		 * 	constructor function.
		 */
		protected function initPattern():void {
			this.cacheAsBitmap = true;
			_isPainted = false;
			_shadowColor = 0xEEEEEE;
			_highlightColor = 0xFFFFFF;
			_patternSize = PatternSize.MEDIUM;
			setSquareSize();
			setPattern();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			if(_isPainted) paint();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _canvas:BitmapData;
		private var _squareSize:Number;
		private var _canvasSize:Number;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			initSize(width, height);
			initPattern();
			spas_internal::isInitialized(1);
		}
		
		/**
		 * 	@private
		 * 
		 * 	Draws the checkerboard pattern with the specified color.
		 */
		private function setPattern():void {
			_canvas = new BitmapData(_canvasSize, _canvasSize, false, _highlightColor);
			var r:Rectangle = new Rectangle(0, 0, _squareSize, _squareSize);
			_canvas.fillRect(r, _shadowColor);
			r.offset(_squareSize, _squareSize);
			_canvas.fillRect(r, _shadowColor);
		}
		
		private function setSquareSize():void {
			switch(_patternSize) {
				case PatternSize.SMALL :
					_squareSize = 5;
					break;
				case PatternSize.MEDIUM :
					_squareSize = 10;
					break;
				case PatternSize.LARGE :
					_squareSize = 15;
					break;
			}
			_canvasSize = 2 * _squareSize;
		}
	}
}
