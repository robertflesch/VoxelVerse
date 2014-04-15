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
	// VideoStream.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version beta 3.1, 17/03/2010 22:32
	* @see http://www.flashapi.org/
	*/
	
	//http://www.thetechlabs.com/video/how-to-build-a-as3-videoplayer/
	
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.border.AbstractBorder;
	import org.flashapi.swing.constants.MediaState;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.event.MediaEvent;
	import org.flashapi.swing.event.VideoEvent;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.managers.MediaRessourceManager;
	import org.flashapi.swing.media.core.VolumeControl;
	import org.flashapi.swing.media.Media;
	import org.flashapi.swing.media.MediaRessourceUser;
	import org.flashapi.swing.plaf.libs.VideoStreamUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Accordion.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched each time the <code>pause()</code> method of the <code>VideoStream</code>
	 * 	instance is called.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.PAUSE
	 */
	[Event(name = "pause", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched each time the <code>play()</code> method of the <code>VideoStream</code>
	 * 	instance is called.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.PLAY
	 */
	[Event(name = "play", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched each time the <code>resume()</code> method of the <code>VideoStream</code>
	 * 	instance is called.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.RESUME
	 */
	[Event(name = "resume", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched each time the <code>stop()</code> method of the <code>VideoStream</code>
	 * 	instance is called.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.STOP
	 */
	[Event(name = "stop", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched each time the <code>VideoStream</code> instance receives
	 * 	metadata from a FLV file.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.ON_METADATA
	 */
	[Event(name = "onMetadata", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched each time the duration of the <code>VideoStream</code> instance
	 * 	changes.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.DURATION_CHANGED
	 */
	[Event(name = "durationChanged", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched when the <code>VideoStream</code> has finished playing.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.COMPLETE
	 */
	[Event(name = "complete", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 *  Dispatched when the source for this <code>VideoStream</code> instance has
	 * 	changed.
	 *
	 *  @eventType org.flashapi.swing.event.MediaEvent.SOURCE_CHANGED
	 */
	[Event(name = "sourceChanged", type = "org.flashapi.swing.event.MediaEvent")]
	
	/**
	 * 	[Deprecated.]
	 * 
	 * 	<img src="VideoStream.png" alt="VideoStream" width="18" height="18"/>
	 * 
	 *  The <code>VideoStream</code> class lets you play an FLV file within a
	 * 	SPAS 3.0 application.
	 * 
	 * 	<p>The <code>VideoStream</code> class is deprecated since the
	 * 	Strobe Media Playback project is release under the Open Source Media
	 * 	Framework (OSMF). For more information about OSMF see:
	 * 	<a href="http://www.opensourcemediaframework.com/" title="OSMF Website">
	 * 	http://www.opensourcemediaframework.com/</a>.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class VideoStream extends AbstractBorder implements Observer, Media, LafRenderer, MediaRessourceUser, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>VideoStream</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>VideoStream</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>VideoStream</code> instance, in
		 * 					pixels.
		 * 	@param	source	The video source for this <code>VideoStream</code> instance.
		 * 	@param	server	If you are connecting to a server, set this parameter to
		 * 					the URI of the application that contains the video file
		 * 					on the server. If <code>null</code> the <code>VideoStream</code>
		 * 					instance will not be connected to any server.
		 */
		public function VideoStream(width:Number = 200, height:Number = 150, source:String = null, server:String = null) {
			super();
			initSize(width, height);
			initObj(source, server);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _autoPlay:Boolean;
		/**
		 * 	A <code>Boolean</code> that indicates whether this <code>VideoStream</code>
		 * 	instance should start playing immediately when the source property is set
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get autoPlay():Boolean {
			return _autoPlay;
		}
		public function set autoPlay(value:Boolean):void {
			_autoPlay = value;
		}
		
		private var _autoRewind:Boolean;
		/**
		 * 	A <code>Boolean</code> that indicates whether this <code>VideoStream</code>
		 * 	instance should be rewound to the starting position when play stops
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 	If <code>true</code>, the video is rewound to the starting position
		 * 	either by calling the <code>stop()</code> method or by reaching the
		 * 
		 * 	@default true
		 */
		public function get autoRewind():Boolean {
			return _autoRewind;
		}
		public function set autoRewind(value:Boolean):void {
			_autoRewind = value;
		}
		
		private var _bufferLength:Number;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	The number of seconds of data currently in the buffer. You can use this
		 * 	property with the <code>bufferTime</code> property to estimate how close
		 * 	the buffer is to being full — for example, to display feedback to a user
		 * 	who is waiting for data to be loaded into the buffer.
		 * 
		 * 	@see #bufferTime
		 */
		public function get bufferLength():Number {
			return _stream != null ? _bufferLength : 0;
		}
		
		private var _bufferTime:Number = 0.1;
		/**
		 * 	Sets or gets the number of seconds of video to buffer in memory before
		 * 	starting to play the video file. For slow connections streaming over RTMP,
		 * 	it is important to increase this property from the default.
		 * 
		 * 	@default 0.1
		 * 
		 * 	@see #bufferLength
		 */
		public function get bufferTime():Number {
			return _bufferTime;
		}
		public function set bufferTime(value:Number):void {
			getStreamValue(_bufferTime, "bufferTime", value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get bytesLoaded():uint {
			return _stream != null ? _stream.bytesLoaded : 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get bytesTotal():uint {
			return _stream != null ? _stream.bytesTotal : 0;
		}
		
		private var _checkPolicyFile:Boolean;
		/**
		 * 	Specifies whether Flash Player should try to download a URL policy file
		 * 	from the loaded video file's server before beginning to load the vide
		 * 	file.
		 */
		public function get checkPolicyFile():Boolean  {
			return _checkPolicyFile;
		}
		public function set checkPolicyFile(value:Boolean ):void {
			getStreamValue(_checkPolicyFile, "checkPolicyFile", value);
		}
		
		private var _client:Object;
		/**
		 * 	Specifies the object on which callback methods are invoked to handle
		 * 	streaming or FLV file data.
		 */
		public function get client():Object {
			return _stream != null ? _client : null;
		}
		
		/**
		 * 	The number of frames per second being displayed. If you are exporting
		 * 	video files to be played back on a number of systems, you can check
		 * 	this value during testing to help you determine how much compression
		 * 	to apply when exporting the file.
		 */
		public function get currentFPS():Number {
			return _stream != null ? _stream.currentFPS : NaN;
		}
		
		/**
		 * 	Indicates the type of filter applied to decoded video as part of
		 * 	post-processing. The default value is <code>0</code>, which lets
		 * 	the video compressor apply a deblocking filter as needed.
		 * 
		 * 	Two deblocking filters are available: one in the Sorenson codec
		 * 	and one in the On2 VP6 codec. In addition, a deringing filter is
		 * 	available when you use the On2 VP6 codec. To set a filter, use one
		 * 	of the following values:
		 * 
		 * 	<ul>
		 * 		<li><code>0</code> — Lets the video compressor apply the
		 * 		deblocking filter as needed.</li>
		 * 		<li><code>1</code> — Does not use a deblocking filter.</li>
		 * 		<li><code>2</code> — Uses the Sorenson deblocking filter.</li>
		 * 		<li><code>3</code> — For On2 video only, uses the On2 deblocking
		 * 		filter but no deringing filter.</li>
		 * 		<li><code>4</code> — For On2 video only, uses the On2 deblocking
		 * 		and deringing filter.</li>
		 * 		<li><code>4</code> — For On2 video only, uses the On2 deblocking
		 * 		and a higher-performance On2 deringing filter.</li>
		 * 	</ul>
		 * 
		 * 	<p>If a value greater than <code>2</code> is selected for video
		 * 	when you are using the Sorenson codec, the Sorenson decoder
		 * 	defaults to <code>2</code>.</p>
		 * 
		 * 	@default 0
		 */
		public function get deblocking():int {
			return _video.deblocking;
		}
		public function set deblocking(value:int):void {
			_video.deblocking = value;
		}
		
		private var _duration:Number = 0;
		/**
		 * 	@inheritDoc
		 */
		public function get duration():Number {
			return _duration;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get isPlaying():Boolean {
			return (_state == MediaState.PLAYING);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get isMutted():Boolean {
			return _volCtrl.isMutted;
		}
		
		private var _leftToLeft:Number;
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
		public function get leftToLeft():Number {
			return _leftToLeft;
		}
		public function set leftToLeft(value:Number):void {
			getTransformValue("leftToLeft", _leftToLeft);
		}
		
		private var _leftToRight:Number;
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
		public function get leftToRight():Number {
			return _leftToRight;
		}
		public function set leftToRight(value:Number):void {
			getTransformValue("leftToRight", _leftToRight);
		}
		
		/**
		 * 	Returns the number of seconds of data in the subscribing stream's
		 * 	buffer in live (unbuffered) mode. This property specifies the current
		 * 	network transmission delay (lag time).
		 * 
		 * 	<p>This property is intended primarily for use with a server such
		 * 	as Flash Media Server.</p>
		 * 
		 * 	<p>You can get the value of this property to roughly gauge the
		 * 	transmission quality of the stream and communicate it to the user.</p>
		 */
		public function get liveDelay():Number {
			return _stream != null ? _stream.liveDelay : NaN;
		}
		
		private var _loop:Boolean;
		/**
		 * 	 A <code>Boolean</code> that indicates whether the media should play
		 * 	again after playback has completed (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get loop():Boolean {
			return _loop;
		}
		public function set loop(value:Boolean):void {
			_loop = value;
		}
		
		private var _metadata:Object;
		/**
		 * 	Returns the <code>Object</code> that contains the metadata received by this
		 * 	<code>VideoStream</code> instance. The <code>metadata</code> object is
		 * 	updated each time the <code>MediaEvent.ON_METADATA</code> event is
		 * 	dispatched by this <code>VideoStream</code> instance.
		 */
		public function get metadata():Object {
			return _metadata;
		}  
		
		/**
		 * 	The object encoding (AMF version) for this <code>VideoStream</code> object.
		 * 	The <code>VideoStream</code> object inherits its <code>objectEncoding</code>
		 * 	value from the internal associated <code>NetConnection</code> object.
		 */
		public function get objectEncoding():uint {
			if (_stream == null) {
				throw new ArgumentError(Locale.spas_internal::ERRORS.NETCONNECTION_ERROR);
			}
			else return _stream.objectEncoding;
		}
		
		private var _pan:Number;
		/**
		 * 	The left-to-right panning of the sound for this <code>VideoStream</code> instance,
		 * 	ranging from <code>-1</code> (full pan left) to <code>1</code> (full pan right).
		 * 	A value of <code>0</code> represents no panning (balanced center between right
		 * 	and left).
		 * 
		 * 	@default 0
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric 
		 * 			value is outside acceptable range.
		 */
		public function get pan():Number {
			return _pan;
		}
		public function set pan(value:Number):void {
			getTransformValue("pan", _pan);
		}
		
		private var _rightToLeft:Number;
		/**
		 * 	A value, from <code>0</code> (none) to <code>1</code> (all), specifying how much
		 * 	of the left input of the sound is played in the left speaker. 
		 * 
		 * 	@default 1
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric 
		 * 			value is outside acceptable range.
		 * 
		 * 	@see #leftToLeft
		 * 	@see #leftToRight
		 * 	@see #rightToRight
		 */
		public function get rightToLeft():Number {
			return _rightToLeft;
		}
		public function set rightToLeft(value:Number):void {
			getTransformValue("rightToLeft", _rightToLeft);
		}
		
		private var _rightToRight:Number;
		/**
		 * 	A value, from <code>0</code> (none) to <code>1</code> (all), specifying how much
		 * 	of the right input of the sound is played in the right speaker. 
		 * 
		 * 	@default 1
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> exception if the numeric 
		 * 			value is outside acceptable range.
		 * 
		 * 	@see #leftToLeft
		 * 	@see #leftToRight
		 * 	@see #rightToLeft
		 */
		public function get rightToRight():Number {
			return _rightToRight;
		}
		public function set rightToRight(value:Number):void {
			getTransformValue("rightToRight", _rightToRight);
		}
		
		private var _server:String;
		/**
		 * 	Sets or gets set the URI of the application that contains a video file on
		 * 	a distant server. Set this parameter to <code>null</code> if you are
		 * 	connecting to a video file on the local computer.
		 * 
		 * 	@default null
		 */
		public function get server():String {
			return _server;
		}
		public function set server(value:String ):void {
			_server = value;
			_sourceChanged = true;
			autoPlayStream();
		}
		
		/**
		 * 	Specifies whether the <code>VideoStream</code> instance should be smoothed
		 * 	(interpolated) when it is scaled (<code>true</code>), or not (<code>false</code>).
		 * 	For smoothing to work, the player must be in high-quality mode.
		 * 
		 * 	@default false
		 */
		public function get smoothing():Boolean {
			return _video.smoothing;
		}
		public function set smoothing(value:Boolean):void {
			_video.smoothing = value;
		}
		
		private var _soundTransform:SoundTransform;
		/**
		 * 	A <code>SoundTransform</code> object which lets you to control the sound
		 * 	of this <code>VideoStream</code> instance.
		 */
		override public function get soundTransform():SoundTransform {
			return _soundTransform;
		}
		override public function set soundTransform(value:SoundTransform):void {
			_soundTransform = value;
			setSoundTransform();
		}
		
		private var _source:*;
		/**
		 * 	@inheritDoc
		 */
		public function get source():* {
			return _source;
		}
		public function set source(value:* ):void {
			_source = value;
			_sourceChanged = true;
			autoPlayStream();
		}
		
		private var _playheadTime:Number = 0;
		/**
		 * 	@inheritDoc
		 */
		public function get playheadTime():Number {
			if (_isSeeking) return _playheadTime;
			return _stream != null ? _stream.time : _playheadTime; }
		public function set playheadTime(value:Number):void {
			_isSeeking = true;
			_playheadTime = value;
			if (_stream == null) return;
			_stream.seek(_playheadTime);
		}
		
		private var _state:String;
		/**
		 * 	@inheritDoc
		 */
		public function get state():String {
			return _state;
		}
		
		/**
		 * 	An integer specifying the height of the video stream, in pixels.
		 * 	This value is the height of the file that was exported as FLV.
		 * 
		 * 	 You may want to use this property, for example, to ensure that the
		 * 	user is seeing the video at the same size at which it was captured,
		 * 	regardless of the actual size of the <code>VideoStream</code> object.
		 * 
		 * 	@see #videoWidth
		 */
		public function get videoHeight():int {
			return _video.videoHeight;
		}
		
		/**
		 * 	An integer specifying the width of the video stream, in pixels.
		 * 	This value is the width of the file that was exported as FLV.
		 * 
		 * 	 You may want to use this property, for example, to ensure that the
		 * 	user is seeing the video at the same size at which it was captured,
		 * 	regardless of the actual size of the <code>VideoStream</code> object.
		 * 
		 * 	@see #videoHeight
		 */
		public function get videoWidth():int {
			return _video.videoWidth;
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
		
		//--------------------------------------------------------------------------
		//
		//  Overriden getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			$backgroundTextureManager.height = value;
			super.height = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			$backgroundTextureManager.width = value;
			super.width = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Clears the image currently displayed in the <code>VideoStream</code> object.
		 * 	This is useful when you want to display standby information without having
		 * 	to hide the <code>VideoStream</code> object.
		 */
		public function clear():void {
			_video.clear();
		}
		
		/**
		 * 	Closes the video stream. Stops playing all data on the stream, sets
		 * 	the time property to <code>0</code>, and makes the stream available
		 * 	for another use. 
		 */
		public function close():void {
			_closeCalled = true;
			if (_stream) {
				_stream.close();
				_stream = null;
			}
			stopUpdate();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
            if(!$displayed) {
				createUIObject(x, y);
				autoPlayStream();
				doStartEffect();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function pause():void {
			_stream.pause();
			stopUpdate();
			_state = MediaState.PAUSED;
			fireEvent(MediaEvent.PAUSE);
		}
		
		/**
		 * @inheritDoc
		 */
		public function play():void {
			if(_sourceChanged || _closeCalled) {
				initConnection();
				initStream();
				_sourceChanged = _closeCalled = false;
				_stream.play(_source);
			} else if (Math.floor(_stream.time) == Math.floor(_duration)) {
				_stream.play(_source);
			}
			else _stream.resume(), startUpdate();
			_state = MediaState.PLAYING;
			fireEvent(MediaEvent.PLAY);
		}
		
		/**
		 * 
		 */
		public function resume():void {
			_stream.resume();
			startUpdate();
			_state = MediaState.PLAYING;
			fireEvent(MediaEvent.RESUME);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			if(_stream) {
				_stream.pause();
				_stream.seek(0);
			}
			stopUpdate();
			_state = MediaState.STOPPED;
			fireEvent(MediaEvent.STOP);
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
			_state == MediaState.PLAYING ? this.pause() : this.play();
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAfterEvent():void {
			var ct:Number = this.playheadTime;
			switch (_state) {
				case MediaState.STOPPED :
				case MediaState.PAUSED :
				case MediaState.DISCONNECTED :
				case MediaState.CONNECTION_ERROR :
					if (MediaRessourceManager.spas_internal::hasRegistredUser(this)) {
						stopUpdate();
					}
					break;
			}
			if(_lastUpdatedTime != ct) dispatchEvent(new VideoEvent(VideoEvent.UPDATE));
			else stopUpdate();
			_lastUpdatedTime = _playheadTime = ct;
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			close();
			clear();
			$borderDecorator.finalize();
			_volCtrl.source = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			$borderDecorator.drawBackground();
			$borderDecorator.drawBorders();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _video:Video;
		private var _connection:NetConnection;
		private var _streamEvtColl:EventCollector;
		private var _stream:NetStream = null;
		private var _sourceChanged:Boolean;
		private var _closeCalled:Boolean;
		private var _isStopped:Boolean;
		private var _bufferIsEmpty:Boolean;
		private var _lastUpdatedTime:Number;
		private var _isSeeking:Boolean = false;
		private var _volCtrl:VolumeControl;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(source:String, server:String):void {
			_source = source;
			_server = server;
			_connection = new NetConnection();
			_streamEvtColl = new EventCollector();
			initLaf(VideoStreamUIRef);
			initVideo();
			createContainers();
			createBackgroundTextureManager(spas_internal::background);
			$borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			_soundTransform = new SoundTransform();
			_volCtrl = new VolumeControl(_soundTransform);
			_autoRewind = _sourceChanged = _isStopped = _bufferIsEmpty = true;
			_loop = _autoPlay = _checkPolicyFile = false;
			_leftToLeft = _leftToRight = _pan = _rightToLeft = _rightToRight = NaN;
			resetMetadata();
			_lastUpdatedTime = -1;
			spas_internal::setSelector(Selectors.VIDEO); 
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			createBackground();
			spas_internal::uioSprite.addChild(spas_internal::background);
			spas_internal::uioSprite.addChild(_video);
			spas_internal::uioSprite.addChild(spas_internal::borders);
		}
		
		private function initVideo():void {
			_video = new Video($width, $height);
		}
		
		private function initConnection():void {
			_connection.connect(_server);
		}
		
		private function initStream():void {
			_streamEvtColl.removeAllEvents();
			resetMetadata();
			_client = null;
			_stream = new NetStream(_connection);
			_stream.bufferTime = _bufferTime;
			if (server == null)
				_streamEvtColl.addEvent(_stream, NetStatusEvent.NET_STATUS, httpStatusHandler);
			_video.attachNetStream(_stream);
			_lastUpdatedTime = -1;
			setSoundTransform();
			_client = new Object();
			_client.onMetaData = function(data:Object):void {
				_metadata = data;
				_duration = data.duration;
				fireEvent(MediaEvent.ON_METADATA);
				fireEvent(MediaEvent.DURATION_CHANGED);
			}
			_client.onPlayStatus = function(data:Object):void { 
				
			}
			_stream.client = _client;
		}
		
		private function doAutoSize():void {
			if($autoSize && _video.videoWidth>0) {
				$width =_video.width = _video.videoWidth;
				$height = _video.height = _video.videoHeight;
				setRefresh();
			}
		}
		
		private function checkCompleteStream():void {
			if (_isStopped && _bufferIsEmpty) {
				fireEvent(MediaEvent.COMPLETE);
				if(_loop) _stream.seek(0);
				else if (_autoRewind && !_loop) {
					_stream.pause();
					_stream.seek(0);
					stopUpdate();
				}
				else stopUpdate();
				_state = MediaState.STOPPED;
			}
		}
		
		private function resetMetadata():void {
			_metadata = null;
		}
		
		private function getStreamValue(property:*, streamProp:String, value:*):void {
			property = value;
			if(_stream != null) _stream[streamProp] = value;
		}
		
		private function getTransformValue(property:String, value:*):void {
			_soundTransform[property] = value;
			setSoundTransform();
		}
		
		private function setSoundTransform():void {
			if(_stream != null) _stream.soundTransform = _soundTransform;
		}
		
		private function autoPlayStream():void {
			if (_sourceChanged) {
				_duration = 0;
				fireEvent(MediaEvent.DURATION_CHANGED);
				fireEvent(MediaEvent.SOURCE_CHANGED);
			}
			if(_source != null && _autoPlay) play();
		}
		
		private function httpStatusHandler(e:NetStatusEvent):void {
			doAutoSize();
			switch(e.info.code) {
				case "NetStream.Play.Stop" :
					_isStopped = true;
					checkCompleteStream();
					break;
				case "NetStream.Buffer.Empty" :
					_bufferIsEmpty = true;
					checkCompleteStream();
					break;
				case "NetStream.Buffer.Flush" :
					_bufferIsEmpty = false;
					break;
				case "NetStream.Buffer.Full" :
					_bufferIsEmpty = false;
					_state = MediaState.PLAYING;
					break;
				case "NetStream.Play.Start" :
					_isStopped = false;
					_bufferIsEmpty = true;
					_state = MediaState.BUFFERING;
					startUpdate();
					break;
				case "NetStream.Seek.Failed" :
					_isSeeking = false;
					break;
				case "NetStream.Seek.InvalidTime" :
					_isSeeking = false;
					break;
				case "NetStream.Seek.Notify" :
					_isSeeking = false;
					break;
            }
		}
		
		private function startUpdate():void {
			MediaRessourceManager.spas_internal::addToMediaStack(this);
		}
		
		private function stopUpdate():void {
			MediaRessourceManager.spas_internal::removeFromMediaStack(this);
		}
		
		private function fireEvent(type:String):void {
			dispatchEvent(new MediaEvent(type));
		}
	}
}