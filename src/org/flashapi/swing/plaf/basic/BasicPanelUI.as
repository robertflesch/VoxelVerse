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
	// BasicPanelUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 12/01/2009 13:48
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.core.LafDTOCornerUtil;
	import org.flashapi.swing.plaf.PanelUI;
	
	/**
	 * 	The <code>BasicPanelUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Panel</code> instances.
	 * 
	 * 	@see org.flashapi.swing.Panel
	 * 	@see org.flashapi.swing.plaf.PanelUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicPanelUI extends BasicUI implements PanelUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicPanelUI(dto:LafDTO) {
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
		public function getColor():uint {
			return DEFAULT_PANEL_COLOR;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawPanel():void {
			var manager:TextureManager = dto.textureManager;
			var cu:LafDTOCornerUtil = new LafDTOCornerUtil(dto, CURVE_DELAY);
			manager.setShape = function():void {
				with(manager.figure) {
					lineStyle(1, 0xFFFFFF, .5, true);
					drawRoundedBox(0, 0, dto.width, dto.height, cu.topLeft, cu.topRight, cu.bottomRight, cu.bottomLeft);
				}
			}
			if (manager.texture!=null) {
				manager.color = dto.color;
				manager.draw(TextureType.TEXTURE);
			} else manager.draw(TextureType.PLAIN);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		private const CURVE_DELAY:Number = 7;
	}
}