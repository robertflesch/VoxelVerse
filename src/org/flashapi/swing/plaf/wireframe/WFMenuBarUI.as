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
	// WFMenuBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/04/2011 13:49
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.MenuBarUI;
	
	/**
	 * 	The <code>WFMenuBarUI</code> class is the SPAS 3.0 wireframe-like look and feel
	 * 	for <code>MenuBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.MenuBar
	 * 	@see org.flashapi.swing.plaf.MenuBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class WFMenuBarUI extends WFUI implements MenuBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function WFMenuBarUI(dto:LafDTO) {
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
			with(dto.currentTarget.graphics) {
				clear();
				beginFill(DEFAULT_BACKGROUND_COLOR);	
				drawRect(0, 0, dto.width, dto.height);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBorder():void {
			with(dto.currentTarget.graphics) {
				clear();
				lineStyle(1, DEFAULT_BORDER_COLOR, 1);
				drawRect(0, 0, dto.width, dto.height);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getButtonLaf():Class {
			return WFMenuButtonUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getMenuLaf():Class {
			return WFMenuUI;
		}
	}
}