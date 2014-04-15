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
	// BasicMenuBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/07/2009 22:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.MenuBarUI;
	
	/**
	 * 	The <code>BasicAccordionUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>MenuBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.MenuBar
	 * 	@see org.flashapi.swing.plaf.MenuBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicMenuBarUI extends BasicUI implements MenuBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicMenuBarUI(dto:LafDTO) {
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
		public function drawTray():void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			var a:Number = dto.trayAlpha;
			f.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEBEBEB], [a, a], [0, 250], MatrixUtil.getMatrix(w, h));	
			f.drawRectangle(0, 0, w, h);
			f.endFill();
		}
		/**
		 *  @inheritDoc 
		 */
		public function drawBorder():void {
			var w:Number = dto.width;
			var h:Number = dto.height;
			var f:Figure = Figure.setFigure(dto.currentTarget);
			f.clear();
			f.lineStyle(1, 0x666666, 1, true);
			f.lineGradientStyle(GradientType.LINEAR, [0xB7BABC, 0x8A8D8F], [1, 1], [0, 250], MatrixUtil.getMatrix(w, h));
			f.drawRectangle(0, 0, w, h);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonLaf():Class {
			return BasicMenuButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMenuLaf():Class {
			return BasicMenuUI;
		}
	}
}