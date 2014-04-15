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

package org.flashapi.swing.icons {
	
	// -----------------------------------------------------------
	// ImageIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/03/2011 20:08
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.Brush;
	import org.flashapi.swing.brushes.BrushBase;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	The <code>ImageIcon</code> class is the brush class used to draw image
	 * 	icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ImageIcon extends BrushBase implements Brush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function ImageIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		override public function paint():void {
			var w:Number = $rect.width;
			var h:Number = $rect.height;
			var wu:Number = w / 10;
			var hu:Number = h / 10;
			with($graphics) {
				clear();
				beginFill(0xFFFFFF);
				lineStyle(1, 0x0000cc);
				drawRect(0, 0, w, h);
				beginGradientFill(GradientType.LINEAR, [0x6699FF, 0x009966], [1, 1], [0, 250], MatrixUtil.getMatrix(w, h, Math.PI/2));
				drawRect(wu + .5, hu + .5, w - 2 * wu - 1, h - 3 * hu - 1);
				beginFill(0x996633);
				lineStyle(0, 0x996633, 0);
				drawRect(4 * wu, 5 * hu, w - 8 * wu, h - 7 * hu - .5);
				beginGradientFill(GradientType.RADIAL, [0x006633, 0x003300], [1, 1], [0, 250], MatrixUtil.getMatrix(w, h - 2*hu, Math.PI/2));
				drawEllipse( 2*wu, 2*hu, w - 4* wu, h / 2.5);
				endFill();
			}
			$isPainted = true;
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function clear():void {
			$graphics.clear();
			$isPainted = false;
		}
	}
}