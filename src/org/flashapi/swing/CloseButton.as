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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// CloseButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 18/06/2009 19:52
	* @see http://www.flashapi.org/
	*/
	
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.icons.CloseIcon;
	import org.flashapi.swing.localization.closable.ClosableLocaleUs;
	
	use namespace spas_internal;
	
	[IconFile("CloseButton.png")]
	
	/**
	 * 	<img src="CloseButton.png" alt="CloseButton" width="18" height="18"/>
	 * 
	 * 	The <code>CloseButton</code> class is used to create button instances that
	 * 	only display a close icon on their face. You can not set a text label
	 * 	to a <code>CloseButton</code> instance.
	 * 
	 * 	<p>The classes of the <code>org.flashapi.swing.localization.closable</code>
	 * 	package contain the localization API for <code>CloseButton</code> objects.</p>
	 * 
	 *  @includeExample CloseButtonExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CloseButton extends Button {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>CloseButton</code> instance.
		 */
		public function CloseButton() {
			super("", 18, 18, false);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function set label(value:String):void { }
		
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
			this.alt = ClosableLocaleUs.CLOSE;
			this.drawIcon(CloseIcon, new Rectangle(0, 0, 14, 14));
			spas_internal::isInitialized(2);
		}
	}
}