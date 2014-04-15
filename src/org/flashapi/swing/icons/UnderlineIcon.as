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

package org.flashapi.swing.icons {
	
	// -----------------------------------------------------------
	// UnderlineIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 20/01/2009 00:56
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.brushes.TextBrushBase;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>UnderlineIcon</code> class is used to draw "underline" text icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UnderlineIcon extends TextBrushBase implements StateBrush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.brushes.BrushBase#BrushBase()
		 */
		public function UnderlineIcon(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super(target, rect, dto);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var tf:TextFormat = new TextFormat(WebFonts.VERDANA, 12, 0, true, false, true);
			textfield.text = "U";
			textfield.setTextFormat(tf);
		}
	}
}