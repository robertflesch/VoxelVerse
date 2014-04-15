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

package org.flashapi.swing.plaf.spas {

	// -----------------------------------------------------------
	// SpasSeparatorUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 18:10
	* @see http://www.flashapi.org/
	*/
	
	
	import flash.geom.Point;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.geom.Segment;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SeparatorUI;
	
	/**
	 * 	The <code>SpasSeparatorUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>Separator</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Separator
	 * 	@see org.flashapi.swing.plaf.SeparatorUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasSeparatorUI extends SpasUI implements SeparatorUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasSeparatorUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function drawLines():void {
			var s:Segment = dto.highlightLine;
			var pt1:Point = s.a;
			var pt2:Point = s.b;
			s = dto.shadowLine;
			var pt3:Point = s.a;
			var pt4:Point = s.b;
			var lineColor:uint = _line1[1];
			if(dto.glow) lineColor = 0x0099CC;
			with (dto.container.graphics) {
				clear();
				lineStyle(_line1[0], lineColor, _line1[2]);
				moveTo(pt1.x, pt1.y);
				lineTo(pt2.x, pt2.y);
				lineStyle(_line2[0], _line2[1], _line2[2]);
				moveTo(pt3.x, pt3.y);
				lineTo(pt4.x, pt4.y);
				endFill();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _line1:Array = [1, new RGB(DEFAULT_COLOR).darker(), .8];
		private var _line2:Array = [1, 0xFFFFFF, .8];
	}
}