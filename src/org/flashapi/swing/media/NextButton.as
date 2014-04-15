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

package org.flashapi.swing.media {
	
	// -----------------------------------------------------------
	// NextButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 17/03/2010 22:42
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.media.core.MediaButtonBase;
	import org.flashapi.swing.plaf.libs.NextButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 *  <code>NextButton</code> instances are used to navigate from a <code>Media</code> 
	 * 	object to the next one within a list of medias.
	 * 
	 * 	@see org.flashapi.swing.media.PreviousButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class NextButton extends MediaButtonBase implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>NextButton</code> instance instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	media	The <code>Media</code> object associated with this
		 * 					<code>NextButton</code> instance.
		 * 	@param	width 	The width of the <code>NextButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_WIDTH</code>.
		 * 	@param	height 	The height of the <code>NextButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_HEIGHT</code>.
		 */
		public function NextButton(media:Media = null, width:Number = MediaButtonBase.DEFAULT_WIDTH, height:Number = MediaButtonBase.DEFAULT_HEIGHT) {
			super(media, width, height, NextButtonUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::setSelector("nextbutton");
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
	}
}