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
	// DragOutIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/07/2009 21:21
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.Brush;
	import org.flashapi.swing.icons.core.DndBaseIcon;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>DragOutIcon</code> class is used by the <code>DragManager</code>
	 * 	class to draw the icon that is displayed during a Drag and Drop operation
	 * 	when the mouse is not over a <code>UIObject</code> instance.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DragOutIcon extends DndBaseIcon implements Brush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function DragOutIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
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
			$graphics.clear();
			_origin = new Point(10, 15);
			drawArrow(0);
			drawArrow(Math.PI/2);
			drawArrow(Math.PI);
			drawArrow(3*Math.PI/2);
			$isPainted = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawArrow(theta:Number):void {
			_theta = theta;
			$graphics.lineStyle(1, 0xFFFFFF, 1);
			$graphics.beginFill(0);
			moveToByTheta(1, 0);
			lineToByTheta(1, 5);
			lineToByTheta(5, 5);
			lineToByTheta(0, 10);
			lineToByTheta(-5, 5);
			lineToByTheta(-1, 5);
			lineToByTheta( -1, 0);
			$graphics.lineStyle(1, 0);
			lineToByTheta(1, 0);
			$graphics.endFill();
		}
		
		private var _theta:Number = 0;
		private var _origin:Point;
		
		private function moveToByTheta(x:Number, y:Number):void {
			var pt:Point = rotateByTheta(x, y);
			$graphics.moveTo(pt.x, pt.y);
		}
		
		private function lineToByTheta(x:Number, y:Number):void {
			var pt:Point = rotateByTheta(x, y);
			$graphics.lineTo(pt.x, pt.y);
		}
		
		private function rotateByTheta(x:Number, y:Number):Point {
			return new Point(Math.cos(_theta) * x - Math.sin(_theta) * y +
						_origin.x, Math.sin(_theta) * x + Math.cos(_theta) * y +
						_origin.y);
		}
	}
}