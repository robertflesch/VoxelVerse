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

package org.flashapi.swing.plaf.wireframe {
	
	// -----------------------------------------------------------
	// WFKnobButtonUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/04/2011 15:37
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.KnobButtonUI;
	
	/**
	 * 	The <code>WFKnobButtonUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>KnobButton</code> instances.
	 * 
	 * 	@see org.flashapi.swing.KnobButton
	 * 	@see org.flashapi.swing.plaf.KnobButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class WFKnobButtonUI extends WFUI implements KnobButtonUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFKnobButtonUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function drawButton():void {
			var pt:Point = dto.origin;
			with (dto.currentTarget.graphics) {
				clear();
				lineStyle(1, 0, 1);
				beginFill(DEFAULT_COLOR);
				drawCircle(pt.x, pt.y, dto.radius-11);
				drawCircle(pt.x, pt.y - 25, 5);
				endFill();
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function drawTrack():void {
			var pt:Point = dto.origin;
			with (dto.currentTarget.graphics) {
				clear();
				beginFill(DEFAULT_COLOR);
				lineStyle(1, 0, 1);
				drawCircle(pt.x, pt.y, dto.radius);
				endFill();
				
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getColor():uint {
			return DEFAULT_COLOR;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getThumbColor():uint {
			return 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function getBorderColor():uint {
			return DEFAULT_BORDER_COLOR;
		}
	}
}