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
	//  SoundUI.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.5, 12/05/2011 23:26
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.MediaState;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.event.MediaEvent;
	import org.flashapi.swing.event.SoundEvent;
	import org.flashapi.swing.exceptions.AlreadyBoundException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.managers.MediaRessourceManager;
	import org.flashapi.swing.media.core.VolumeControl;
	import org.flashapi.swing.media.MediaRessourceUser;
	import org.flashapi.swing.sound.XSound;
	import org.flashapi.swing.util.RangeChecker;
	
	use namespace spas_internal;
	
	[IconFile("SoundUI.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the <code>SoundUI</code> instance has finished playing.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.COMPLETE
	 */
	[Event(name = "complete", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched when the source for this <code>SoundUI</code> instance has
	 * 	changed.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.SOURCE_CHANGED
	 */
	[Event(name = "sourceChanged", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched when this <code>SoundUI</code> instance has loaded successfully.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.LOAD_COMPLETE
	 */
	[Event(name = "loadComplete", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched by the <code>SoundUI</code> instance when ID3 data is
	 * 	available for the MP3 source sound.
	 *
	 *  @eventType org.flashapi.swing.event.SoundEvent.ID3
	 */
	[Event(name="id3", type="org.flashapi.swing.event.SoundEvent")]
	
	/**
	 * 	<img src="SoundUI.png" alt="SoundUI" width="18" height="18"/>
	 * 
	 *  The <code>SoundUI</code> class provides a complete User Interface to easily 
	 * 	manage sound objects within a SPAS 3.0 application.
	 * 
	 * 	<p>If you pass a valid URL string to the <code>SoundUI</code> constructor
	 * 	function, it will automatically load the external MP3 file.<br />
	 * 	If you do not pass a valid URL string or a linked embeded sound file to
	 * 	the constructor function, you can set later the <code>source</code> property
	 * 	of the <code>SoundUI</code> object.</p>
	 * 
	 *  @includeExample SoundUIExample.as
	 *
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class SoundUI extends EventDispatcher implements Finalizable, MediaRessourceUser, XSound {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>SoundUI</code> instance with the
		 * 					specified parameters
		 * 
		 * 	@param	source	A <code>String</code> representing the URI of an external
		 * 					MP3 file, or a reference to an embeded <code>Sound</code>
		 * 					instance.
		 * 	@param	context	An optional <code>SoundLoader</code> context object, which
		 * 					can define the buffer time (the minimum number of milliseconds
		 * 					of MP3 data to hold in the <code>SoundUI</code> buffer)
		 * 					and can specify whether the application should check for
		 * 					a cross-domain policy file prior to loading the sound.
		 */
		public function SoundUI(source:* = null, context:SoundLoaderContext = null) {
			super();
			initObj(source, context);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get bytesLoaded():uint {
			return _sound.bytesLoaded;
		}
		
		/**
		 * 	@inheritDoc 
		 */
		public function get bytesTotal():uint {
			return _sound.bytesTotal;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get duration():Number {
			return _sound.length / 1000;
		}
		
		/**
		 *  @private
		 */
		protected var _id:String = null;
		/**
		 * 	@inheritDoc
		 */
		public function get id():String {
			return _id;
		}
		public function set id(value:String):void {
			if(value.toLowerCase() == _id) return;
			else if (SoundUI.IDStack[value.toLowerCase()] != null) {
				throw new AlreadyBoundException(Locale.spas_internal::ERRORS.SOUNDUI_ID_ERROR+value);
			}
			_id = value.toLowerCase();
			SoundUI.IDStack[value.toLowerCase()] = this;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get id3():ID3Info {
			return _sound.id3;
		}
		
		private var _isPlaying:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		private var _isPaused:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get isPaused():Boolean {
			return _isPaused;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get isMutted():Boolean {
			return _volCtrl.isMutted;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get isBuffering():Boolean {
			return _sound.isBuffering;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get leftPeak():Number {
			if (_soundChannel == null) return 0;
			return _soundChannel.leftPeak;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get leftToLeft():Number {
			return _soundTransform.leftToLeft;
		}
		public function set leftToLeft(value:Number):void {
			RangeChecker.checkNum(value, 0, 1, "leftToLeft");
			_soundTransform.leftToLeft = value;
			setSoundTransform();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get leftToRight():Number {
			return _soundTransform.leftToRight;
		}
		public function set leftToRight(value:Number):void {
			RangeChecker.checkNum(value, 0, 1, "leftToRight");
			_soundTransform.leftToRight = value;
			setSoundTransform();
		}
		
		private var _length:Number = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get length():Number {
			if(isNaN(_length)) {
				var l:int = _sound.bytesLoaded;
				var t:int = _sound.bytesTotal;
				var sl:Number = _sound.length;
				return sl /= l / t;
			}
			else return _length;
		}
		
		private var _pan:uint = 0;
		/**
		 * 	@inheritDoc
		 */
		public function get pan():Number {
			return _pan;
		}
		public function set pan(value:Number):void {
			RangeChecker.checkNum(value, 1, -1, "pan");
			_soundTransform.pan = value;
			setSoundTransform();
		}
		
		private var _playheadTime:Number = 0;
		/**
		 * 	@inheritDoc
		 */
		public function get playheadTime():Number {
			//--> http://livedocs.adobe.com/flash/9.0_fr/main/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts_bak&file=00000291.html
			var pht:Number = _isPlaying ? 100 * (_soundChannel.position / _sound.length) : _playheadTime;
			return pht;
		}
		public function set playheadTime(value:Number):void {
			RangeChecker.checkNum(value, 100, 0, "playheadTime");
			//_playheadTime = value;
			_playheadTime = _position = _sound.length / value;
			seek(_position);
		}
		
		private var _position:Number = 0;
		/**
		 * 	The current position of the playhead within the sound.
		 */
		public function get position():Number {
			if(_soundChannel != null) return _soundChannel.position;
			else return _position;
		}
		public function set position(value:Number):void {
			_position = value;
			seek(_position);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get rightPeak():Number {
			if (_soundChannel == null) return 0;
			return _soundChannel.rightPeak;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get rightToLeft():Number {
			return _soundTransform.leftToRight;
		}
		public function set rightToLeft(value:Number):void {
			RangeChecker.checkNum(value, 0, 1, "rightToLeft");
			_soundTransform.rightToLeft = value;
			setSoundTransform();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get rightToRight():Number {
			return _soundTransform.rightToRight;
		}
		public function set rightToRight(value:Number):void {
			RangeChecker.checkNum(value, 0, 1, "rightToRight");
			_soundTransform.rightToRight = value;
			setSoundTransform();
		}
		
		private var _soundChannel:SoundChannel = null;
		/**
		 * 	@inheritDoc
		 */
		public function get soundChannel():SoundChannel {
			return _soundChannel;
		}
		
		private var _slc:SoundLoaderContext;
		/**
		 * 	@inheritDoc
		 */
		public function get soundLoaderContext():SoundLoaderContext {
			return _slc;
		}
		public function set soundLoaderContext(value:SoundLoaderContext):void {
			_slc = value;
		}
		
		private var _source:*;
		/**
		 * 	@inheritDoc
		 */
		public function get source():* {
			return _source;
		}
		public function set source(value:*):void {
			setSource(value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get url():String {
			return _sound.url;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get volume():Number {
			return _volCtrl.volume;
		}
		public function set volume(value:Number):void {
			_volCtrl.volume = value;
			setSoundTransform();
		}
		
		private var _state:String;
		/**
		 * 	@inheritDoc
		 */
		public function get state():String {
			return _sound.isBuffering ? MediaState.BUFFERING : _state;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the <code>XSound</code> instance with the specified ID.
		 * 
		 * 	@param	value A string representing the unique ID of the sound being sought.
		 * 
		 *  @return The <code>XSound</code> instance with the specified ID.
		 * 
		 * 	@see #id
		 */
		public static function getSoundById(value:String):XSound {
			return SoundUI.IDStack[value];
		}
		
		
		/**
		 * 	@inheritDoc
		 */
		public function equals(sound:XSound):Boolean {
			return sound == this;
		}
		
		/**
		 * 	Pauses the sound without changing its position. Use the <code>stop()</code>
		 * 	method to stop the playback and return the sound to its initial position.
		 * 	Use the <code>resume()</code> method to continue playing from the paused
		 * 	position.
		 * 
		 * 	@see #stop()
		 * 	@see #resume()
		 */
		public function pause():void {
			stopUpdate();
			_isPaused = true;
			_isPlaying = false;
			if(_soundChannel != null) {
				_position = _soundChannel.position;
				_soundChannel.stop();
			}
			_state = MediaState.PAUSED;
			fireEvent(MediaEvent.PAUSE);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function play():void {
			this.playSound();
		}
		
		/**
		 * 	Start playing the sound object. This method returns a <code>SoundChannel</code> instance,
		 * 	which you access to stop the sound and to monitor volume.
		 * 
		 * 	@param	startTime	The initial position, in milliseconds, at which playback should start.
		 * 	@param	loops		Defines the number of times a sound loops before the sound channel
		 * 						stops playback.
		 * 	@param	sndTransform	The initial <code>SoundTransform</code> object assigned to the
		 * 							sound channel.
		 * 	@return	A <code>SoundChannel</code> object which you use to control the sound.
		 * 			This method returns <code>null</code> if you have no sound card or if you run out
		 * 			of available sound channels. The maximum number of sound channels available at
		 * 			once is <code>32</code>.
		 * 
		 * 	@see #stop()
		 * 	@see #reset()
		 */
		public function playSound(startTime:Number = NaN, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel {
			_evtColl.removeAllEvents();
			if (sndTransform != null) {
				_volCtrl.source = _soundTransform = sndTransform;
			}
			_loops = loops;
			var pos:Number = isNaN(startTime) ? _position : startTime;
			_soundChannel = _sound.play(pos, loops, _soundTransform);
			_evtColl.addOneShotEvent(_soundChannel, Event.SOUND_COMPLETE, onSoundComplete);
			_isPlaying = true;
			_isPaused = false;
			_state = MediaState.PLAYING;
			startUpdate();
			fireEvent(MediaEvent.PLAY);
			return _soundChannel;
		}
		
		/**
		 * 	Starts playing the sound, from the current <code>position</code> value, after it has
		 * 	been paused
		 * 
		 * 	@see #pause()
		 */
		public function resume():void {
			_isPaused = false;
			_isPlaying = true;
			startUpdate();
			seek(_position);
			fireEvent(MediaEvent.RESUME);
		}
		
		/**
		 * 	Resets all properties of this sound object.
		 * 
		 * 	@see #play()
		 * 	@see #resume()
		 */
		public function reset():void {
			resetSound();
			_slc = null;
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether some other
		 * 	source values is "equal to" this sound object.
		 * 
		 * 	@param	value	The source value to compare this sound object with.
		 * 
		 * 	@return			<code>true</code> if the this sound object is the same
		 * 					as the sound passed to the <code>value</code> parameter;
		 * 					<code>false</code> otherwise.
		 */
		public function sourceEquals(value:*):Boolean {
			var isEqual:Boolean;
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					var obj:URLRequest = new URLRequest(value);
					isEqual = _source == obj;
					obj = null;
					break;
				default :
					isEqual = _source == value;
			}
			return isEqual;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			stopUpdate();
			_isPlaying = _isPaused = false;
			if (_soundChannel != null) _soundChannel.stop();
			try {
				_sound.close();
			} catch (e:Error) {}
			_soundChannel = null;
			_position = 0;
			_state = MediaState.STOPPED;
			fireEvent(MediaEvent.STOP);
		}
		
		/**
		 * 	Stops all sounds wich are currently playing within the Flash Player.
		 * 
		 * 	@see	http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/media/SoundMixer.html#stopAll()
		 */
		public static function stopAllSounds():void {
			SoundMixer.stopAll();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function toggleMute():void {
			_volCtrl.toggleMute();
			setSoundTransform();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function togglePause():void {
			_isPlaying ? this.pause() : this.playSound(_position);
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAfterEvent():void { }
		
		/**
		 * @inheritDoc
		 */
		public function finalize():void {
			_evtColl.finalize();
			_evtColl = null;
			if(_hasStreamingStartHandler) removeStreamingStartHandler();
			stopUpdate();
			_volCtrl.source = null;
			_volCtrl = null;
			_soundTransform = null;
			if (_soundChannel != null) _soundChannel.stop();
			try { _sound.close(); }
			catch (e:Error) {}
			_soundChannel = null;
			_sound = null;
			_stage = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static var IDStack:Dictionary = new Dictionary(true);
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _sound:Sound;
		private var _evtColl:EventCollector;
		private var _soundTransform:SoundTransform;
		private var _volCtrl:VolumeControl;
		private var _loops:uint;
		private var _hasStreamingStartHandler:Boolean = false;
		private var _stage:Stage;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(source:*, context:SoundLoaderContext):void {
			_slc = context;
			_stage = UIDescriptor.getUIManager().stage;
			_sound = new Sound();
			_evtColl = new EventCollector();
			_soundTransform = new SoundTransform();
			_volCtrl = new VolumeControl(_soundTransform);
			if(source != null) setSource(source);
		}
		
		private function setSource(value:*):void {
			resetSound();
			switch(typeof(value)) {
				case PrimitiveType.STRING :
					_source = new URLRequest(value);
					addId3Listener();
					if (!_hasStreamingStartHandler) {
						_hasStreamingStartHandler = true;
						_stage.addEventListener(Event.ENTER_FRAME, detectStreamingStart);
					}
					_evtColl.addOneShotEvent(_sound, Event.COMPLETE, onSoundLoaded);
					_sound.load(_source, _slc);
					break;
				default :
					_source = value;
					_sound = new _source();
					addId3Listener();
			}
			fireEvent(MediaEvent.DURATION_CHANGED);
			fireEvent(MediaEvent.SOURCE_CHANGED);
		}
		
		private function detectStreamingStart(e:Event):void {
			if (_sound.isBuffering) return;
			fireEvent(MediaEvent.STREAM_PLAY_STARTED);
			removeStreamingStartHandler();
			_hasStreamingStartHandler = false;
		}
		
		private function removeStreamingStartHandler():void {
			_stage.removeEventListener(Event.ENTER_FRAME, detectStreamingStart);
		}
		
		private function onSoundComplete(e:Event):void {
			_length = _sound.length;
			if (_loops-- <= 0) {
				_loops = 0;
				stopUpdate();
				_isPaused = true;
				_isPlaying = false;
				_state = MediaState.PAUSED;
				fireEvent(MediaEvent.PAUSE);
			}
			fireEvent(MediaEvent.COMPLETE);
		}
		
		private function onID3Released(e:Event):void {
			removeId3Listener();
			dispatchEvent(new SoundEvent(SoundEvent.ID3));
		}
		
		private function onSoundLoaded(e:Event):void {
			fireEvent(MediaEvent.LOAD_COMPLETE);
		}
		
		private function addId3Listener():void {
			_sound.addEventListener(Event.ID3, onID3Released);
		}
		
		private function removeId3Listener():void {
			_sound.removeEventListener(Event.ID3, onID3Released);
		}
		
		private function setSoundTransform():void {
			if (_soundChannel == null) return;
			_soundChannel.soundTransform = _soundTransform;
		}
		
		private function seek(pos:Number):void {
			if (_isPlaying && !_isPaused && _soundChannel != null) this.playSound(pos);
		}
		
		private function fireEvent(type:String):void {
			dispatchEvent(new MediaEvent(type));
		}
		
		private function startUpdate():void {
			MediaRessourceManager.spas_internal::addToMediaStack(this);
		}
		
		private function stopUpdate():void {
			MediaRessourceManager.spas_internal::removeFromMediaStack(this);
		}
		
		private function resetSound():void {
			stopUpdate();
			this.stop();
			if (_sound.hasEventListener(Event.ID3)) removeId3Listener();
			_evtColl.removeAllEvents();
			_sound = new Sound();
			_soundTransform = new SoundTransform();
			_volCtrl.source = _soundTransform;
			_volCtrl.volume = 1;
			_source = null;
			_soundChannel = null;
			_pan = 0;
			_length = NaN;
			delete SoundUI.IDStack[_id];
			_id = null;
		}
	}
}