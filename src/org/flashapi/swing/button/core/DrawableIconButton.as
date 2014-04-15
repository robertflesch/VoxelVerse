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

package org.flashapi.swing.button.core {
	
	// -----------------------------------------------------------
	// DrawableIconButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/06/2009 21:29
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>DrawableIconButton</code> class is the base class for buttons
	 * 	that only display <code>Brush</code> or <code>StaeBrush</code> instances
	 * 	and have no labels.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class DrawableIconButton extends GroupButtonBase {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 * 
		 * 	@param	width	The width of the button, in pixels.
		 * 	@param	height	The height of the button, in pixels.
		 * 	@param	defaultLaf	The default look and feel class for this button object.
		 */
		public function DrawableIconButton(width:Number, height:Number, defaultLaf:Class) {
			super("", width, height, false, defaultLaf);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function getIconRect():Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			initIconColors();
			this.drawIcon(lookAndFeel.getDefaultIcon(), getIconRect());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Pvivate methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createTextureManager(spas_internal::background);
			initMinSize(5, 5);
			$padL = $padR = 10;
			$hAlign = HorizontalAlignment.CENTER;
		}
		
		//private function setIconColor(val:*, color:uint):void { if (val == "none") val = color; }
	}
}