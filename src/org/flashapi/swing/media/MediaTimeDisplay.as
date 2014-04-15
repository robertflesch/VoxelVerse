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
	// MediaTimeDisplay.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 17/03/2010 22:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.MediaEvent;
	import org.flashapi.swing.managers.MediaRessourceManager;
	import org.flashapi.swing.media.core.MediaTextBase;
	import org.flashapi.swing.plaf.libs.MediaTextUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>MediaTimeDisplay</code> class associates a <code>Media</code> 
	 * 	instance to a text object that displays the current time of the media.
	 * 	The <code>Media</code> object time is automatically updated when it is
	 * 	playing and freezed when paused or stoped.
	 * 
	 * 	@see org.flashapi.swing.media.MediaDuration
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MediaTimeDisplay extends MediaTextBase implements Observer, LafRenderer, MediaRessourceUser {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>MediaTimeDisplay</code> instance instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	media	The <code>Media</code> object associated with this
		 * 					<code>MediaTimeDisplay</code> instance.
		 * 	@param	width 	The width of the <code>MediaTimeDisplay</code> instance, in
		 * 					pixels. Default value is <code>MediaTextBase.DEFAULT_WIDTH</code>.
		 * 	@param	height 	The height of the <code>MediaTimeDisplay</code> instance, in
		 * 					pixels. Default value is <code>MediaTextBase.DEFAULT_HEIGHT</code>.
		 */
		public function MediaTimeDisplay(media:Media = null, width:Number = MediaTextBase.DEFAULT_WIDTH, height:Number = MediaTextBase.DEFAULT_HEIGHT) {
			super(media, width, height, MediaTextUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function updateAfterEvent():void {
			if (_media != null) this.text = formatTime(_media.playheadTime);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function addMediaEvents():void {
			$mediaEvtColl.addEvent(_media, MediaEvent.PLAY, playHandler);
			$mediaEvtColl.addEvent(_media, MediaEvent.PAUSE, stopHandler);
			$mediaEvtColl.addEvent(_media, MediaEvent.STOP, stopHandler);
			this.text = formatTime(0);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createEvents();
			spas_internal::setSelector("mediatimedisplay");
			spas_internal::isInitialized(1);
		}
		
		private function createEvents():void {
			if (_media != null) addMediaEvents();
		}
		
		private function playHandler(e:MediaEvent):void {
			MediaRessourceManager.spas_internal::addToMediaStack(this);
		}
		
		private function stopHandler(e:MediaEvent):void {
			MediaRessourceManager.spas_internal::removeFromMediaStack(this);
		}
	}
}