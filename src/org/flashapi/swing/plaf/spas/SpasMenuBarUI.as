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
	// SpasMenuBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/07/2009 22:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.GradientType;
	import org.flashapi.swing.color.RGB;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.MenuBarUI;
	
	/**
	 * 	The <code>SpasMenuBarUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>MenuBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.MenuBar
	 * 	@see org.flashapi.swing.plaf.MenuBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasMenuBarUI extends SpasUI implements MenuBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasMenuBarUI(dto:LafDTO) {
			super(dto);
			var c:* = dto.trayColor;
			fixTrayColor((c == null) ? DEFAULT_COLOR : c);
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
			var f:Figure = Figure.setFigure(dto.currentTarget);
			if (dto.trayColor != null) fixTrayColor(dto.trayColor);
			var a:Number = dto.trayAlpha;
			var w:Number = dto.width;
			var h:Number = dto.height;
			f.clear();
			f.beginGradientFill(GradientType.LINEAR, [_brightColor, _trayColor],
				[a, a], [0, 250], MatrixUtil.getMatrix(w, h));	
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
			f.lineGradientStyle(GradientType.LINEAR, [DEFAULT_COLOR, _darkColor], [1, 1],
				[0, 250], MatrixUtil.getMatrix(w, h));
			f.drawRectangle(0, 0, w, h);
			f.endFill();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonLaf():Class {
			return SpasMenuButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMenuLaf():Class {
			return SpasMenuUI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _brightColor:uint;
		private var _darkColor:uint;
		private var _trayColor:int = -1;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function fixTrayColor(color:uint):void {
			if (color == _trayColor) return;
			_trayColor = color;
			var rgb:RGB = new RGB(color);
			_brightColor = rgb.brighter(.2);
			_darkColor = rgb.darker();
		}
	}
}