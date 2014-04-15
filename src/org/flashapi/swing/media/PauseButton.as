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
	// PauseButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 17/03/2010 22:41
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.media.core.MediaButtonBase;
	import org.flashapi.swing.plaf.libs.PauseButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>PauseButton</code> class associates a <code>Media</code> 
	 * 	instance to a button object that is able to pause the media.
	 * 
	 * 	@see org.flashapi.swing.media.PlayButton
	 * 	@see org.flashapi.swing.media.PlayPauseButton
	 * 	@see org.flashapi.swing.media.StopButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PauseButton extends MediaButtonBase implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>PauseButton</code> instance instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	media	The <code>Media</code> object associated with this
		 * 					<code>PauseButton</code> instance.
		 * 	@param	width 	The width of the <code>PauseButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_WIDTH</code>.
		 * 	@param	height 	The height of the <code>PauseButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_HEIGHT</code>.
		 */
		public function PauseButton(media:Media = null, width:Number = MediaButtonBase.DEFAULT_WIDTH, height:Number = MediaButtonBase.DEFAULT_HEIGHT) {
			super(media, width, height, PauseButtonUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createEvent();
			spas_internal::setSelector("playbutton");
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
		
		private function createEvent():void {
			$evtColl.addEvent(this, UIMouseEvent.CLICK, setMediaState);
		}
		
		private function setMediaState(e:UIMouseEvent):void {
			if ($media != null) $media.pause();
		}
	}
}