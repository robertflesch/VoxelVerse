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

package org.flashapi.swing.plaf.wireframe.brushes {
	
	// -----------------------------------------------------------
	// WFCheckBoxIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/03/2011 01:38
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.ColorStateUtil;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.StateBrushBase;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>WFCheckBoxIcon</code> class renders icons used by <code>CheckBox</code>
	 * 	objects for the wireframe-like Look and Feel.
	 * 
	 * 	@see org.flashapi.swing.CheckBox
	 * 	@see org.flashapi.swing.plaf.CheckBoxUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class WFCheckBoxIcon extends StateBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function WFCheckBoxIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function drawBrushShape(state:String):void {
			drawRadioButtonIcon(state);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawRadioButtonIcon(state:String):void {
			var c:uint = ColorStateUtil.getColor(state, $colors);
			with($graphics){
				clear();
				lineStyle(1, 0, 1);
				beginFill(0xffffff);
				drawRect(0, 0, 16, 16);
				if (state == States.OUT) {
					endFill();
					return;
				}
				lineStyle(0, c);
				beginFill(c);
				moveTo(4, 5);
				lineTo(9, 13);
				lineTo(15, 1);
				lineTo(9, 8);
				lineTo(4, 5);
				endFill();
			}
		}
	}
}