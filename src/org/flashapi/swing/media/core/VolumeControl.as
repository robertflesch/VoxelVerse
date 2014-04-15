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

package org.flashapi.swing.media.core {
	
	// -----------------------------------------------------------
	// VolumeControl.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/01/2009 02:02
	* @see http://www.flashapi.org/
	*/
	
	import flash.media.SoundTransform;
	import org.flashapi.swing.util.RangeChecker;
	
	/**
	 *  The <code>VolumeControl</code> class is used for manipulating the audio volume
	 * 	of a <code>Media</code> object. 
	 * 
	 * 	@see org.flashapi.swing.media.Media
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class VolumeControl {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>VolumeControl</code> instance.
		 * 
		 * 	@param	source	A <code>SoundTransform</code> instance that represent the
		 * 					signal associated with this <code>VolumeControl</code>
		 * 					instance. The default value is <code>null</code>.
		 */
		public function VolumeControl(source:SoundTransform = null) {
			super();
			initObj(source);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _volume:Number = 1.0;
		/**
		 * 	@copy org.flashapi.swing.media.Media#volume
		 */
		public function get volume():Number {
			return _volume;
		}
		public function set volume(value:Number):void {
			RangeChecker.checkNum(value, 1, 0, "volume");
			_volume = value;
			if(!_isMutted) setSoundProp(_volume);
		}
		
		private var _isMutted:Boolean = false;
		/**
		 * 	@copy org.flashapi.swing.media.Media#isMutted()
		 */
		public function get isMutted():Boolean {
			return _isMutted;
		}
		
		private var _source:SoundTransform;
		/**
		 * 	Sets or gets the <code>SoundTransform</code> instance that represent the 
		 * 	signal associated with this <code>VolumeControl</code> instance. 
		 * 
		 * 	@default null
		 */
		public function get source():SoundTransform {
			return _source;
		}
		public function set source(value:SoundTransform):void {
			_source = value;
			setCondMute();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Toggles the mute of the associated media object.
		 */
		public function toggleMute():void {
			_isMutted = !_isMutted;
			setCondMute();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(source:SoundTransform):void {
			_source = source;
		}
		
		private function setSoundProp(value:Number):void {
			if (_source != null) _source.volume = value;
		}
		
		private function setCondMute():void {
			_isMutted ? setSoundProp(0) : setSoundProp(_volume);
		}
	}
}