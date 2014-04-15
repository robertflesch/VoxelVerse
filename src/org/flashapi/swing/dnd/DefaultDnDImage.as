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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DefaultDnDImage.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/06/2009 15:49
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	
	/**
	 * 	The <code>DefaultDragImage</code> class represents the default image
	 * 	displayed during a Drag and Drop operation.
	 * 
	 * 	@see org.flashapi.swing.managers.DnDManager
	 * 	@see org.flashapi.swing.UIManager#dragManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DefaultDnDImage extends Sprite implements DnDImage {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DefaultDragImage</code> instance.
		 */
		public function DefaultDnDImage() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		// DnDImage API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			drawImage(width, height);
		}
		
		/**
		 * @inheritDoc
		 */
		public function finalize():void { }
		
		private var _opacity:Number;
		/**
		 * @inheritDoc
		 */
		public function set opacity(value:Number):void {
			_opacity = value;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			cacheAsBitmap = true;
		}
		
		private function drawImage(w:Number, h:Number):void {
			with (graphics) {
				lineStyle(1, 0x666666, _opacity);
				beginFill(0xcccccc, _opacity);
				drawRect(0, 0, w, h);
				endFill();
			}
		}
	}
}