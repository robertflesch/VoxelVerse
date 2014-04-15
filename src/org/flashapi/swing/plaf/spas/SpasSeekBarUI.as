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
	// SpasSeekBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 05/11/2010 20:33
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.SeekBarUI;
	
	/**
	 * 	The <code>SpasSeekBarUI</code> class is the SPAS 3.0 default look and feel
	 * 	for <code>SeekBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.SeekBar
	 * 	@see org.flashapi.swing.plaf.SeekBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpasSeekBarUI extends SpasUI implements SeekBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function SpasSeekBarUI(dto:LafDTO) {
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
		public function getThumbLaf():Class {
			return SpasSeekBarThumbUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawHighlight():void {
			var h:Number = dto.trackHeight;
			with(dto.highlightTrackContainer.graphics) {
				clear();
				beginFill(dto.highlightColor);
				drawRect(dto.minimum+.5, 0.5, dto.maximum-.5, h - 0.5);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearHighlight():void {
			dto.highlightTrackContainer.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawProgressBar():void {
			var h:Number = dto.trackHeight;
			with(dto.progressBarContainer.graphics) {
				clear();
				beginFill(0,.25);
				drawRect(dto.minimum+.5, 0.5, dto.maximum-.5, h - 0.5);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearProgressBar():void {
			dto.progressBarContainer.graphics.clear();
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getSeekBarThickness():Number {
			return 10;
		}
		
		/*public function getMinLength():Number {
			return 10;
		}*/
		
		/**
		 *  @inheritDoc 
		 */
		public function getHighlightColor():uint {
			return 0x3399FF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBackgroundColor():uint {
			return 0x666666;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0x333333;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderAlpha():Number {
			return 1;
		}
	}
}