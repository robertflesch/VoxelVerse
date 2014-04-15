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
	// MediaDuration.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 17/03/2010 22:45
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.MediaEvent;
	import org.flashapi.swing.media.core.MediaTextBase;
	import org.flashapi.swing.plaf.libs.MediaTextUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 *  The <code>MediaDuration</code> class associates a <code>Media</code> instance
	 * 	to a text object that displays the total duration of the media.
	 * 
	 * 	@see org.flashapi.swing.media.MediaTimeDisplay
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MediaDuration extends MediaTextBase implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>MediaDuration</code> instance instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	media	The <code>Media</code> object associated with this
		 * 					<code>MediaDuration</code> instance.
		 * 	@param	width 	The width of the <code>MediaDuration</code> instance, in
		 * 					pixels. Default value is <code>MediaTextBase.DEFAULT_WIDTH</code>.
		 * 	@param	height 	The height of the <code>MediaDuration</code> instance, in
		 * 					pixels. Default value is <code>MediaTextBase.DEFAULT_HEIGHT</code>.
		 */
		public function MediaDuration(media:Media = null, width:Number = MediaTextBase.DEFAULT_WIDTH, height:Number = MediaTextBase.DEFAULT_HEIGHT) {
			super(media, width, height, MediaTextUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createEvent();
			setMediaDuration();
			spas_internal::setSelector("mediaduration");
			spas_internal::isInitialized(1);
		}
		
		private function createEvent():void {
			if (_media != null)
				$mediaEvtColl.addEvent(_media, MediaEvent.DURATION_CHANGED, setMediaDuration);
		}
		
		private function setMediaDuration(e:MediaEvent = null):void {
			if (_media != null) this.text = formatTime(_media.duration);
		}
	}
}