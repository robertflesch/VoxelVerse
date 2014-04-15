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

package org.flashapi.swing.icons.core {
	
	// -----------------------------------------------------------
	// DirectionIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 22/04/2011 23:48
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>DirectionIcon</code> class is the base class for <code>StateBrush</code>
	 * 	icons that are use to indicate a direction by using a triangular arrow.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DirectionIcon extends StateBrushBase implements StateBrush {
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function DirectionIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _size:Number = 4;
		/**
		 * 	Sets or gets the size of the arrow, in pixels.
		 * 
		 * 	@default 4
		 */
		public function get size():Number {
			return _size;
		}
		public function set size(value:Number):void {
			_size = value;
			drawBrushShape($state);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the direction of the arrow within this <code>StateBrush</code>
		 * 	object.
		 */
		protected var $direction:String;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function drawBrushShape(state:String):void {
			var c:uint = ColorStateUtil.getColor(state, $colors);
			var w:Number = $rect.width / 2;
			var h:Number = $rect.height / 2;
			var f:Figure = new Figure($target);
			f.clear();
			f.beginFill(c);
			switch($direction) {
				case Direction.RIGHT :
					f.drawTriangle(w + _size, h, w - _size + 1, h - _size, w - _size + 1, h + _size);
					break;
				case Direction.LEFT :
					f.drawTriangle(w - _size, h, w + _size - 1, h - _size, w + _size - 1, h + _size);
					break;
				case Direction.UP :
					f.drawTriangle(w, h - _size, w - _size, h + _size - 1, w + _size, h + _size - 1);
					break;
				case Direction.DOWN :
					f.drawTriangle(w, h + _size, w - _size, h - _size + 1, w + _size, h - _size + 1);
					break;
			}
			f.endFill();
		}
	}
}