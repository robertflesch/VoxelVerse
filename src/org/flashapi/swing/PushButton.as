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
	// PushButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 19:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.GroupButtonBase;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.PushButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("PushButton.png")]
	
	/**
	 * 	<img src="PushButton.png" alt="PushButton" width="18" height="18"/>
	 * 
	 *  The <code>PushButton</code> class is a commonly used circular button. Buttons look
	 * 	like they can be pressed. They can only have an icon on their face.
	 * 	
	 * 	<p>You can customize the look of a <code>PushButton</code> instance and change 
	 * 	its functionality from a push button to a toggle button. You can change the button
	 * 	appearance by using a Look and Feel class that implement the <code>ButtonUI</code>
	 * 	interface.</p>
	 * 
	 * 	<p>The <code>paddingLeft</code> and <code>paddingRight</code> properties are 
	 * 	set by default to <code>10</code> pixels.</p>
	 * 
	 *  @includeExample PushButtonExample.as
	 *
	 * 	@see org.flashapi.swing.plaf.PushButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 * */
	public class PushButton extends GroupButtonBase implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>PushButton</code> instance with the 
		 * 					specified radius.
		 * 
		 * 	@param	radius	The radius of the <code>PushButton</code> instance, in
		 * 					pixels.
		 */
		public function PushButton(radius:Number = 20) {
			super("", 2*radius, 2*radius, false, PushButtonUIRef);
			initObj(radius);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(radius:Number):void {
			spas_internal::lafDTO.radius = radius;
			createTextureManager(spas_internal::background);
			initMinSize(5, 5);
			$hAlign = HorizontalAlignment.CENTER;
			$vAlign = VerticalAlignment.MIDDLE;
			spas_internal::setSelector(Selectors.PUSH_BUTTON);
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
	}
}