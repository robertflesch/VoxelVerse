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
	// BasicProgressBarUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 19/03/2011 14:36
	* @see http://www.flashapi.org/
	*/

	import flash.display.GradientType;
	import org.flashapi.swing.draw.MatrixUtil;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.ProgressBarUI;
	
	/**
	 * 	The <code>BasicProgressBarUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>ProgressBar</code> instances.
	 * 
	 * 	@see org.flashapi.swing.ProgressBar
	 * 	@see org.flashapi.swing.plaf.ProgressBarUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class BasicProgressBarUI extends BasicUI implements ProgressBarUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicProgressBarUI(dto:LafDTO) {
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
			return 0xFFFFFF;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getBorderColor():uint {
			return 0X999999;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTrackHighlightColor():uint {
			return 0x888888;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTrackColor():uint {
			return 0xCCCCCC;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBar():void {
			var c:uint = dto.color;
			var p:Number = dto.progressValue;
			with(dto.currentTarget.graphics) {
				clear();
				beginGradientFill(GradientType.LINEAR, [c, c], [.4, 1], [0, 230], MatrixUtil.getMatrix(p, 4, 0));
				drawRect(.7, .5, p, 3.7);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTrack():void {
			with(dto.currentTarget.graphics) {
				clear();
				beginFill(dto.trackColor, dto.trackOpacity);
				drawRect(0, 0, dto.barLength, 4);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawTrackHighlight():void {
			with(dto.currentTarget.graphics) {
				clear();
				beginFill(dto.trackHighlightColor, dto.trackHighlightOpacity);
				drawRect(0, 0, dto.highlightValue, dto.height);
				endFill();
			}
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBorder():void {
			with(dto.currentTarget.graphics) {
				clear();
				lineStyle(1, 0X999999, dto.trackOpacity, true);
				drawRect(0, 0, dto.barLength, dto.height);
				endFill();
			}
		}
	}
}