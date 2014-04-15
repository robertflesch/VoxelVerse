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

package org.flashapi.swing.sound {
	
	// -----------------------------------------------------------
	// XSound.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/12/2009 20:57
	* @see http://www.flashapi.org/
	*/
	
	import flash.media.ID3Info;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import org.flashapi.swing.media.Media;
	
	/**
	 * 	The <code>XSound</code> interface is the base API for extending capabilities
	 * 	of sound objects within the SPAS 3.0 API.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface XSound extends Media {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Gets or sets the <code>XSound</code> identifier. The ID, which must be  
		 * 	unique in a document, is often used to retrieve the sound using
		 * 	<code>SoundUI.getSoundById()</code> method. 
		 * 	
		 *  @default null
		 * 
		 *  @throws org.flashapi.swing.exceptions.AlreadyBoundException An  
		 * 			<code>AlreadyBoundException</code> if the ID already exist.
		 * 
		 * 	@see org.flashapi.swing.SoundUI#getSoundById()
		 */
		function set id(value:String):void;
		function get id():String;
		
		/**
		 * 	Provides access to metadata that is part of a MP3 file.
		 * 
		 * 	@see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/media/ID3Info.html
		 */
		function get id3():ID3Info;
		
		/**
		 * 	The current amplitude (volume) of the left channel, from <code>0</code> (silent)
		 * 	to <code>1</code> (full amplitude).
		 * 
		 * 	<p><strong>Note: </strong>If no source is defined, returns <code>NaN</code>.</p>
		 * 
		 * 	@see #rightPeak
		 */
		function get leftPeak():Number;
		
		/**
		 * 	A value, from <code>0</code> (none) to <code>1</code> (all), specifying how much
		 * 	of the left input is played in the left speaker.
		 * 
		 * 	@default 1
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric value
		 * 			is outside acceptable range.
		 * 
		 * 	@see #leftToRight
		 * 	@see #rightToLeft
		 * 	@see #rightToRight
		 */
		function get leftToLeft():Number;
		function set leftToLeft(value:Number):void;
		
		/**
		 * 	A value, from <code>0</code> (none) to <code>1</code> (all), specifying how much
		 * 	of the left input is played in the right speaker. 
		 * 
		 * 	@default 0
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric value
		 * 			is outside acceptable range.
		 * 
		 * 	@see #leftToLeft
		 * 	@see #rightToLeft
		 * 	@see #rightToRight
		 */
		function get leftToRight():Number;
		function set leftToRight(value:Number):void;
		
		/**
		 * 	The length of the current sound, in milliseconds.
		 * 
		 * 	<p><strong>Note: </strong>If the source of the sound is an externally loaded file,
		 * 	the <code>length</code> property returns an approximated value until the sound
		 * 	file is fully loaded.</p>
		 */
		function get length():Number;
		
		/**
		 * 	The left-to-right panning of the sound, ranging from <code>-1</code> (full pan
		 * 	left) to <code>1</code> (full pan right). A value of <code>0</code> represents no
		 * 	panning (balanced center between right and left).
		 * 
		 * 	@default 0
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric value
		 * 			is outside acceptable range.
		 */
		function get pan():Number;
		function set pan(value:Number):void;
		
		/**
		 * 	The current position of the playhead within the sound.
		 */
		function get position():Number;
		function set position(value:Number):void;
		
		/**
		 * 	The current amplitude (volume) of the right channel, from <code>0</code> (silent)
		 * 	to <code>1</code> (full amplitude). 
		 * 
		 * 	<p><strong>Note: </strong>If no source is defined, returns <code>NaN</code>.</p>
		 * 
		 * 	@see #leftPeak
		 */
		function get rightPeak():Number;
		
		/**
		 * 	A value, from <code>0</code> (none) to <code>1</code> (all), specifying how much
		 * 	of the right input is played in the left speaker. 
		 * 
		 * 	@default 0
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric value
		 * 			is outside acceptable range.
		 * 
		 * 	@see #leftToLeft
		 * 	@see #leftToRight
		 * 	@see #rightToRight
		 */
		function get rightToLeft():Number;
		function set rightToLeft(value:Number):void;
		
		/**
		 * 	A value, from <code>0</code> (none) to <code>1</code> (all), specifying how much
		 * 	of the right input is played in the right speaker. 
		 * 
		 * 	@default 1
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric value
		 * 			is outside acceptable range.
		 * 
		 * 	@see #leftToLeft
		 * 	@see #leftToRight
		 * 	@see #rightToLeft
		 */
		function get rightToRight():Number;
		function set rightToRight(value:Number):void;
		
		/**
		 * 	Returns a reference of the <code>SoundChannel</code> instance used within
		 * 	this sound object.
		 * 
		 * 	@default null
		 */
		function get soundChannel():SoundChannel;
		
		/**
		 * 	Sets or gets the <code>SoundLoaderContext</code> instance used by the sound
		 * 	object.
		 * 
		 * 	@default null
		 */
		function get soundLoaderContext():SoundLoaderContext;
		function set soundLoaderContext(value:SoundLoaderContext):void;
		
		/**
		 * 	The URL from which this sound is loaded. This property is applicable only to
		 * 	sound object that loads external MP3 files. For sound objects associated with
		 * 	a sound asset from the SWF library, the value of the <code>url</code> property
		 * 	is always <code>null</code>. 
		 */
		function get url():String;
		
		/**
		 * 	Retrieves the pause status of a sound, specified by <code>pause()</code> and
		 * 	<code>resume()</code> methods. If the sound is pauseed this method returns
		 * 	<code>true</code>; it returns <code>false</code> otherwise.
		 * 
		 * 	@default false
		 * 
		 * 	@see #pause()
		 * 	@see #resume()
		 */
		function get isPaused():Boolean;
		
		/**
		 * 	Returns the buffering state of external MP3 files. If <code>true</code>, any playback
		 * 	is currently suspended while the object waits for more data. 
		 */
		function get isBuffering():Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Finalizes this <code>XSound</code> object. You must set the 
		 * 	<code>XSound</code> to <code>null</code> to make it elligible for
		 * 	garbage collection.
		 */
		function finalize():void;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether some other sound
		 * 	object is "equal to" this sound (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@param	sound	The sound object value to compare this sound with.
		 * 
		 * 	@return		<code>true</code> if this sound is the same as the one specified by 
		 * 				the <code>sound</code> parameter; <code>false</code> otherwise.
		 */
		function equals(sound:XSound):Boolean;
	}
}