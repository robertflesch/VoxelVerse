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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DnDImageProxy.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/07/2009 13:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	A utility class used by the <code>DnDManager</code> singleton to display a
	 * 	visual representation of an object during a Drag and Drop operation.
	 * 
	 * 	@see org.flashapi.swing.managers.DnDManager
	 * 	@see org.flashapi.swing.UIManager#dragManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DnDImageProxy extends Sprite implements DnDImage {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DnDImageProxy</code> instance.
		 * 
		 * 	@param	src The source for <code>DnDImageProxy</code> object.
		 */
		public function DnDImageProxy(src:DisplayObject) {
			super();
			initObj(src);
		}
		
		//--------------------------------------------------------------------------
		//
		// DnDImage API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			drawImage();
		}
		
		/**
		 * @inheritDoc
		 */
		public function finalize():void {
			_bounds = null;
			_bitmap.dispose();
			_bitmap = null;
			_matrix = null;
		}
		
		private var _opacity:Number;
		/**
		 * @inheritDoc
		 */
		public function set opacity(value:Number):void {
			_opacity = value;
			var ct:ColorTransform = new ColorTransform(1, 1, 1, _opacity, 0, 0, 0, 0);
			_bitmap.colorTransform(_bounds, ct);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _bounds:Rectangle;
		private var _matrix:Matrix;
		private var _bitmap:BitmapData;
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(src:DisplayObject):void {
			cacheAsBitmap = true;
			_bounds = src.getBounds(null);
			initBitmap(src);
			_matrix = new Matrix();
		}
		
		private function drawImage():void {
			with (graphics) {
				beginBitmapFill(_bitmap, _matrix, true, false);
				drawRect(_bounds.x, _bounds.y, _bounds.width, _bounds.height);
				endFill();
			}
		}
		
		private function initBitmap(src:DisplayObject):void {
			_bitmap = new BitmapData(_bounds.width - _bounds.x, _bounds.height - _bounds.y, true, 0);
			src is UIObject ? _bitmap.draw((src as UIObject).spas_internal::uioSprite, _matrix) :
				_bitmap.draw(src as IBitmapDrawable, _matrix);
		}
	}
}