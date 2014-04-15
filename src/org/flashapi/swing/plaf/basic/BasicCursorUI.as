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
	// BasicCursorUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 15/02/2009 12:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.CursorUI;
	
	/**
	 * 	The <code>BasicCursorUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>Cursor</code> instances.
	 * 
	 * 	@see org.flashapi.swing.cursor.Cursor
	 * 	@see org.flashapi.swing.plaf.CursorUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicCursorUI extends BasicUI implements CursorUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicCursorUI(dto:LafDTO) {
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
		public function drawDefaultCursor():void {
			var c:Sprite = dto.container;
			with(c.graphics) {
				clear();
				moveTo(0, 0);
				lineStyle(1, 0xFFFFFF, 1);
				beginFill(0);
				lineTo(0, 17);
				lineTo(4, 14);
				lineTo(7.5, 21);
				lineTo(9.5, 20);
				lineTo(6.5, 12);
				lineTo(11.5, 12.5);
				lineTo(0, 0);
				endFill();
			}
			if(c.rotation!=0) c.rotation = 0;
			dto.setOffsetX(0);
			dto.setOffsetY(0);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSWResizeCursor():void {
			drawResizeCursor(45, 0, 5);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSEResizeCursor():void {
			drawResizeCursor(135, 0, 5);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawNWResizeCursor():void {
			drawResizeCursor(135, 0, 3);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawNEResizeCursor():void {
			drawResizeCursor(45, 2.5, 5);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawNResizeCursor():void {
			drawResizeCursor(0, 2.5, 0);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawWResizeCursor():void {
			drawResizeCursor(90, -2.5, 5);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawEResizeCursor():void {
			drawResizeCursor(90, 2.5, 5);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawSResizeCursor():void {
			drawResizeCursor(0, 2.5, 2);
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawHDividerCursor():void {  }
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function drawResizeCursor(angle:uint, xDelay:Number, yDelay:Number):void  {
			var c:Sprite = dto.container;
			with (c.graphics) {
				clear();
				lineStyle(1, 0xFFFFFF, 1);
				beginFill(0);
				moveTo(-5, -5);
				lineTo(0, -10);
				lineTo(5, -5);
				lineTo(1.5, -5);
				lineTo(1.5, 5);
				lineTo(5, 5);
				lineTo(0, 10);
				lineTo(-5, 5);
				lineTo(-1.5, 5);
				lineTo(-1.5, -5);
				lineTo(-5, -5);
				endFill();
			}
			c.rotation = angle;
			dto.setOffsetX(xDelay);
			dto.setOffsetY(yDelay);
		}
		
		private function drawDividerCursor(angle:uint):void {
			var c:Sprite = dto.container;
			with(c.graphics) {
				/*clear();
				moveTo(0, 0);
				lineStyle(1, 0xFFFFFF, 1);
				beginFill(0);
				lineTo(0, 17);
				lineTo(4, 14);
				lineTo(7.5, 21);
				lineTo(9.5, 20);
				lineTo(6.5, 12);
				lineTo(11.5, 12.5);
				lineTo(0, 0);
				endFill();*/
			}
			c.rotation = angle;
		}
	}
}