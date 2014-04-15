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

package org.flashapi.swing.plaf.basic {
	
	// -----------------------------------------------------------
	// BasicColorButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/05/2009 23:09
	* @see http://www.flashapi.org/
	*/

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.ColorButtonUI;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BasicColorButtonUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>ColorButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ColorButton
	 * 	@see org.flashapi.swing.plaf.ColorButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicColorButtonUI extends BasicUI implements ColorButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicColorButtonUI(dto:LafDTO) { 
			super(dto);
			dto.container.addChild(_bitmap);
			_drawBitmap();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function getColor():uint {
			return DEFAULT_PANEL_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOutState():void {
			drawButtonShape();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawOverState():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPressedState():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSelectedState():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function drawInactiveState():void { }
		
		/**
		 *  @private
		 */
		override public function onChange():void {
			_bitmapShape.dispose();
			//if(uio.container.contains(_bitmap)) uio.container.removeChild(_bitmap);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _bitmapShape:BitmapData;
		private var _bitmap:Bitmap = new Bitmap();
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function _drawBitmap():void {
			var bf:BevelFilter = new BevelFilter(1);
			bf.type = BitmapFilterType.OUTER;
			bf.blurX = bf.blurY = 0;
			bf.highlightAlpha = .5;
			bf.shadowAlpha = .5;
			bf.quality = 7;
			var w:Number = dto.width;
			var h:Number = dto.height;
			var bufferShape:Shape = new Shape();
			var f:Figure = new Figure(bufferShape);
			f.clear();
			f.lineStyle(4, 0xCCCCCC);
			f.drawRectangle(0, 0, w, h);
			f.endFill();
			f.lineStyle(0, 0xCCCCCC);
			f.beginFill(0xCCCCCC, 1);
			f.drawRectangle(w - 8, h - 6, w, h);
			f.beginFill(0, 1);
			f.lineStyle(0, 0);
			f.drawTriangle(w - 6, h - 4, w - 2, h - 4, w - 4, h - 2);
			f.endFill();
			bufferShape.filters = [bf];
			_bitmapShape = new BitmapData(w, h, true, 0x00FFFFFF);
			_bitmapShape.draw(bufferShape, null, null, BlendMode.NORMAL);
			bufferShape = null;
			_bitmap.bitmapData = _bitmapShape;
		}
		
		private function drawButtonShape():void {
			with(dto.container.graphics) {
				beginFill(dto.selectedColor, 1);
				drawRect(1, 1, dto.width-1, dto.height-1);
				endFill();
			}
		}
	}
}