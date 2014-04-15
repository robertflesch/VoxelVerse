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
	// VolumeButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 17/03/2010 21:37
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.media.core.MediaButtonBase;
	import org.flashapi.swing.plaf.libs.ButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 *  Not implemented yet.]
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class VolumeButton extends MediaButtonBase implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>VolumeButton</code> instance instance
		 * 					with the specified parameters.
		 * 
		 * 	@param	media	The <code>Media</code> object associated with this
		 * 					<code>PlayButton</code> instance.
		 * 	@param	width 	The width of the <code>VolumeButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_WIDTH</code>.
		 * 	@param	height 	The height of the <code>VolumeButton</code> instance, in pixels.
		 * 					Default value is <code>MediaButtonBase.DEFAULT_HEIGHT</code>.
		 */
		public function VolumeButton(media:Media = null, width:Number = MediaButtonBase.DEFAULT_WIDTH, height:Number = MediaButtonBase.DEFAULT_HEIGHT) {
			super(media, width, height, ButtonUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _volume:Number = NaN;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createEvent();
			getVolume();
			spas_internal::setSelector("volumebutton");
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
		
		private function createEvent():void {
			$evtColl.addEvent(this, UIMouseEvent.CLICK, setMediaState);
		}
		
		private function getVolume():void {
			if ($media != null) _volume = $media.volume;
		}
		
		/*private function setVolume():void {
			if ($media != null) $media.volume = _volume;
		}*/
		
		private function setMediaState(e:UIMouseEvent):void {
			//if (_media != null) 
		}
	}
}