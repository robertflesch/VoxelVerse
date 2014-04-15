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
	// IconizedButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 20:15
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("IconizedButton.png")]
	
	/**
	 * 	<img src="IconizedButton.png" alt="IconizedButton" width="18" height="18"/>
	 * 
	 * 	Iconized buttons are a special kind of buttons which have no label displayed
	 * 	on their face, but only a graphical icon.
	 * 	<code>IconizedButton</code> instance are useful to create toolbars, such as
	 * 	media toolbars, or intuitive applications. The <code>IconizedButton</code>
	 * 	shares the same Look and Feel as the <code>Button</code> class.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * @includeExample IconizedButtonExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class IconizedButton extends Button implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>IconizedButton</code> instance with the
		 * 					specified parameters
		 * 
		 * @param	brush	The brush class to use to render the icon within this
		 * 					<code>IconizedButton</code> instance. Default value is
		 * 					<code>null</code>.
		 * 	@param	width 	The width of the <code>IconizedButton</code> instance, in pixels.
		 * 					Default value is <code>16</code>.
		 * 	@param	height 	The height of the <code>IconizedButton</code> instance, in pixels.
		 * 					Default value is <code>16</code>.
		 */
		public function IconizedButton(brush:Class = null, width:Number = 16, height:Number = 16) {
			super("", width, height, false);
			initObj(brush);
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
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(brush:Class):void {
			$padL = $padR = 0;
			$vAlign = VerticalAlignment.MIDDLE;
			$hAlign = HorizontalAlignment.CENTER; 
			$labelPlacement = LabelPlacement.RIGHT;
			if (brush) drawIcon(brush);
			spas_internal::isInitialized(2);
		}
	}
}