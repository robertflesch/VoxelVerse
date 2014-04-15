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

package org.flashapi.swing.fx.basicfx.firelib {
	
	// -----------------------------------------------------------
	// BlueFlameDTO.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/07/2008 15:26
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 */
	public class BlueFlameDTO extends FireFxDTO {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		public function BlueFlameDTO() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			this.redOffset = 210;
			this.greenOffset = 210;
			this.blueOffset = 255;
			this.redFadeMult = 0.55;
			this.greenFadeMult = 0.48;
			this.blueFadeMult = 0.35;
			this.redR = 0.8;
			this.redG = 0;
			this.redB = 0;
			this.redA = 0;
			this.redO = 0;
			this.greenR = 0;
			this.greenG = 0.93;
			this.greenB = 0;
			this.greenA = 0;
			this.greenO = 0;
			this.blueR = 0;
			this.blueG = 0.1;
			this.blueB = 0.96;
			this.blueA = 0;
			this.blueO = 0;
		}
	}
}