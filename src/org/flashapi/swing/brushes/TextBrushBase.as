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

package org.flashapi.swing.brushes {
	
	// -----------------------------------------------------------
	// TextBrushBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 20/01/2009 01:07
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>TextBrushBase</code> class is the base class for text-based brushes.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextBrushBase extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function TextBrushBase(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function clear():void {
			bitmapData.dispose();
			bitmapData = null;
			super.clear();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected var textfield:TextField;
		
		/**
		 * 	@private
		 */
		protected var bitmapData:BitmapData;
		
		/**
		 * 	@private
		 */
		protected var matrix:Matrix;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function createTextImage():void {
			matrix = new Matrix();
			textfield = new TextField();
			textfield.background = false;
			textfield.autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**
		 * 	@private
		 */
		protected function setMatrixProperties():void {
			var xPos:Number = $rect.x + ($rect.width - textfield.width) / 2;
			var yPos:Number = $rect.y + ($rect.height - textfield.height) / 2;
			matrix.createBox(1, 1, 0, xPos, yPos);
		}
		
		/**
		 * 	@private
		 */
		protected function createBitmapData():void {
			bitmapData = new BitmapData(textfield.width, textfield.height, true, 0x00000000);
		}
		
		/**
		 * 	@private
		 */
		override protected function drawBrushShape(state:String):void {
			if ($rect == null) return;
			textfield.textColor = ColorStateUtil.getColor(state, $colors);
			setMatrixProperties();
			if (bitmapData == null) createBitmapData();
			bitmapData.draw(textfield);
			with($graphics) {
				clear();
				beginBitmapFill(bitmapData, matrix, false);
				drawRect($rect.x, $rect.y, $rect.width, $rect.height);
				endFill();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createTextImage();
		}
	}
}