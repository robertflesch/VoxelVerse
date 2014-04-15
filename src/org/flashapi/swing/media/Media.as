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
	// Media.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 08/01/2009 02:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	
	/**
	 * 	The <code>Media</code> interface defines the basic set of APIs that you must  
	 * 	implement to create a SPAS 3.0 media object. 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Media extends IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the currently available number of bytes in this <code>Media</code>
		 * 	object. This is usually only useful for externally loaded files.
		 */
		function get bytesLoaded():uint;
		
		/**
		 * 	Returns the total number of bytes in this <code>Media</code> object. 
		 */
		function get bytesTotal():uint;
		
		/**
		 * 	Returns the length of the current <code>Media</code> object, in seconds.
		 */
		function get duration():Number;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the <code>Media</code>
		 * 	object is playing (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get isPlaying():Boolean;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the the signal
		 * 	associated with this <code>Media</code> is mutted (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #toggleMute()
		 */
		function get isMutted():Boolean;
		
		/**
		 * 	The current position of the playhead within this <code>Media</code> object.
		 * 
		 * 	@default 0
		 */
		function get playheadTime():Number;
		function set playheadTime(value:Number):void;
		
		/**
		 * 	Sets or gets the source of the <code>Media</code> object.
		 * 
		 * 	@default null
		 */
		function get source():*;
		function set source(value:*):void;
		
		/**
		 * 	Sets or gets the volume of the <code>Media</code> object, from <code>0</code>
		 * 	(silent) to <code>1</code>  (full volume).
		 * 
		 * 	@default 1.0
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException
		 * 	An <code>IndexOutOfBoundsException</code> exception if the numeric
		 * 	value is outside acceptable range.
		 */
		function get volume():Number;
		function set volume(value:Number):void;
		
		/**
		 * 	Returns the current state of this <code>Media</code> object.
		 */
		function get state():String;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Pauses the <code>Media</code> object.
		 * 
		 * 	@see #togglePause()
		 */
		function pause():void;
		
		/**
		 * 	Plays the <code>Media</code> object.
		 * 
		 * 	@see #stop()
		 * 	@see #isPlaying
		 */
		function play():void;
		
		/**
		 * 	Stops the <code>Media</code> object.
		 * 
		 * 	@see #play()
		 */
		function stop():void;
		
		/**
		 * 	Pauses or resumes playback of a <code>Media</code> object.
		 * 
		 * 	@see #pause()
		 */
		function togglePause():void;
		
		/**
		 * 	Toggles the mute of a <code>Media</code> object.
		 * 
		 * 	@see #isMutted
		 */
		function toggleMute():void;
	}
}