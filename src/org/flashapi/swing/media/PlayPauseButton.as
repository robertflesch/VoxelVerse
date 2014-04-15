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
	// PlayPauseButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 22:37
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.MediaEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.media.core.MediaButtonBase;
	import org.flashapi.swing.plaf.libs.PlayPauseButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>PlayPauseButton</code> class associates a <code>Media</code> 
	 * 	instance to a button object that is able to toggle between play and 
	 * 	mute for the media.
	 * 
	 * 	@see org.flashapi.swing.media.PauseButton
	 * 	@see org.flashapi.swing.media.PauseButton
	 * 	@see org.flashapi.swing.media.StopButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PlayPauseButton extends MediaButtonBase implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>PlayPauseButton</code> instance instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	media	The <code>Media</code> object associated with this
		 * 					<code>PlayPauseButton</code> instance.
		 * 	@param	width 	The width of the <code>PlayPauseButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_WIDTH</code>.
		 * 	@param	height 	The height of the <code>PlayPauseButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_HEIGHT</code>.
		 */
		public function PlayPauseButton(media:Media = null, width:Number = MediaButtonBase.DEFAULT_WIDTH, height:Number = MediaButtonBase.DEFAULT_HEIGHT) {
			super(media, width, height, PlayPauseButtonUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function addMediaEvents():void {
			var collection:Array = [MediaEvent.PLAY, MediaEvent.PAUSE, MediaEvent.STOP, MediaEvent.SOURCE_CHANGED, MediaEvent.RESUME];
			$mediaEvtColl.addEventsByTypes($media, fixNextState, collection);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createEvents();
			spas_internal::setSelector("playpausebutton");
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
		
		private function createEvents():void {
			$evtColl.addEvent(this, UIMouseEvent.PRESS, setNextState);
			$evtColl.addEvent(this, UIMouseEvent.CLICK, setMediaState);
			if ($media != null) addMediaEvents();
		}
		
		private function setMediaState(e:UIMouseEvent):void {
			if ($media != null) $media.togglePause();
		}
		
		private function setNextState(e:UIMouseEvent):void {
			if ($media != null && icon.brush is StateIcon) {
				var br:StateIcon = icon.brush as StateIcon;
				br.nextState = br.nextState == 0 ? 1 : 0;
			}
		}
		
		private function fixNextState(e:MediaEvent):void {
			var br:StateIcon = icon.brush as StateIcon;
			switch(e.type) {
				case MediaEvent.PLAY :
					br.nextState = 1;
					break;
				case MediaEvent.PAUSE : 
				case MediaEvent.STOP : 
				case MediaEvent.SOURCE_CHANGED :
					br.nextState = 0;
					break;
			}
			icon.brush.paint();
		}
	}
}