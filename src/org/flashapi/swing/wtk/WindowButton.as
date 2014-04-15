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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// WindowButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 13/11/2010 16:28
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Button;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.util.Observer;
	
	/**
	 * 	The <code>WindowButton</code> class allows to create buttons that are used
	 * 	within windows title bars, to control <code>WTK</code> objects.
	 * 
	 * 	@see org.flashapi.swing.wtk.WTK
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WindowButton extends Button implements Observer, WTKButton {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>WindowButton</code> instance.
		 */
		public function WindowButton() {
			super("", 18, 18, false);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$padL = $padR = 0;
			$vAlign = VerticalAlignment.TOP;
			$hAlign = HorizontalAlignment.LEFT; 
			$labelPlacement = LabelPlacement.RIGHT;
		}
	}
}