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

package org.flashapi.swing.ui.analytics {
	
	// -----------------------------------------------------------
	// AnalyticsObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2011 22:29
	* @see http://www.flashapi.org/
	*/
	
	import flash.system.Capabilities;
	
	/**
	 * 	The <code>CapabilitiesDTO</code> class creates a proxy object that contains
	 * 	most of the properties, accessible through the <code>flash.system.Capabilities</code>
	 * 	class, to serialize the user's device <code>Capabilities</code> data.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class CapabilitiesDTO {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>CapabilitiesDTO</code> instance.
		 */
		public function CapabilitiesDTO() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		private var _avHardwareDisable:Boolean;
		/**
		 * 	Specifies whether access to the user's camera and microphone has been
		 * 	administratively prohibited (<code>true</code>) or allowed (<code>false</code>).
		 */
		public function get avHardwareDisable():Boolean {
			return _avHardwareDisable;
		}
		
		private var _cpuArchitecture:String;
		/**
		 * 	Specifies the current CPU architecture on the machine. The <code>cpuArchitecture</code>
		 * 	property can return the following strings: <code>"PowerPC"</code>,
		 * 	<code>"x86"</code>, <code>"SPARC"</code>, and <code>"ARM"</code>. 
		 */
		public function get cpuArchitecture():String {
			return _cpuArchitecture;
		}
		
		private var _hasAccessibility:Boolean;
		/**
		 * 	Specifies whether the system supports (<code>true</code>) or does not
		 * 	support (<code>false</code>) communication with accessibility aids.
		 */
		public function get hasAccessibility():Boolean {
			return _hasAccessibility;
		}
		
		private var _hasAudio:Boolean;
		/**
		 * 	Specifies whether the system has audio capabilities. This property is always
		 * 	<code>true</code>. 
		 */
		public function get hasAudio():Boolean {
			return _hasAudio;
		}
		
		private var _hasAudioEncoder:Boolean;
		/**
		 * 	Specifies whether the system can (<code>true</code>) or cannot
		 * 	(<code>false</code>) encode an audio stream, such as that
		 * 	coming from a microphone.
		 */
		public function get hasAudioEncoder():Boolean {
			return _hasAudioEncoder;
		}
		
		private var _hasEmbeddedVideo:Boolean;
		/**
		 * 	Specifies whether the system supports (<code>true</code>) or
		 * 	does not support (<code>false</code>) embedded video.
		 */
		public function get hasEmbeddedVideo():Boolean {
			return _hasEmbeddedVideo;
		}
		
		private var _hasIME:Boolean;
		/**
		 * 	Specifies whether the system does (<code>true</code>) or does
		 * 	not (<code>false</code>) have an input method editor (IME) installed.
		 */
		public function get hasIME():Boolean {
			return _hasIME;
		}
		
		private var _hasMP3:Boolean;
		/**
		 * 	Specifies whether the system does (<code>true</code>) or does not
		 * 	(<code>false</code>) have an MP3 decoder.
		 */
		public function get hasMP3():Boolean {
			return _hasMP3;
		}
		
		private var _hasPrinting:Boolean;
		/**
		 * 	Specifies whether the system does (<code>true</code>) or does not
		 * 	(<code>false</code>) support printing.
		 */
		public function get hasPrinting():Boolean {
			return _hasPrinting;
		}
		
		private var _hasScreenBroadcast:Boolean;
		/**
		 * 	Specifies whether the system does (<code>true</code>) or does not
		 * 	(<code>false</code>) support the development of screen broadcast
		 * 	applications to be run through Flash Media Server.
		 */
		public function get hasScreenBroadcast():Boolean {
			return _hasScreenBroadcast;
		}
		
		private var _hasScreenPlayback:Boolean;
		/**
		 * 	Specifies whether the system does (<code>true</code>) or does not
		 * 	(<code>false</code>) support the playback of screen broadcast
		 * 	applications that are being run through Flash Media Server.
		 */
		public function get hasScreenPlayback():Boolean {
			return _hasScreenPlayback;
		}
		
		private var _hasStreamingAudio:Boolean;
		/**
		 * 	Specifies whether the system can (<code>true</code>) or cannot
		 * 	(<code>false</code>) play streaming audio.
		 */
		public function get hasStreamingAudio():Boolean {
			return _hasStreamingAudio;
		}
		
		private var _hasStreamingVideo:Boolean;
		/**
		 * 	Specifies whether the system can (<code>true</code>) or cannot
		 * 	(<code>false</code>) play streaming video.
		 */
		public function get hasStreamingVideo():Boolean {
			return _hasStreamingVideo;
		}
		
		private var _hasTLS:Boolean;
		/**
		 * 	Specifies whether the system supports native SSL sockets through
		 * 	<code>NetConnection</code> (<code>true</code>) or does not
		 * 	(<code>false</code>).
		 */
		public function get hasTLS():Boolean {
			return _hasTLS;
		}
		
		private var _hasVideoEncoder:Boolean;
		/**
		 * 	Specifies whether the system can (<code>true</code>) or cannot
		 * 	(<code>false</code>) encode a video stream, such as that coming
		 * 	from a web camera.
		 */
		public function get hasVideoEncoder():Boolean {
			return _hasVideoEncoder;
		}
		
		private var _language:String;
		/**
		 * 	Specifies the language code of the system on which the content is
		 * 	running. The language is specified as a lowercase two-letter language
		 * 	code from ISO 639-1. For Chinese, an additional uppercase two-letter
		 * 	country code from ISO 3166 distinguishes between Simplified and
		 * 	Traditional Chinese. The languages codes are based on the English
		 * 	names of the language: for example, <code>hu</code> specifies Hungarian.
		 * 
		 * 	<p>On English systems, this property returns only the language code
		 * 	(<code>en</code>), not the country code. On Microsoft Windows systems,
		 * 	this property returns the user interface (UI) language, which refers to
		 * 	the language used for all menus, dialog boxes, error messages, and help 
		 * 	files.</p>
		 */
		public function get language():String {
			return _language;
		}
		
		private var _localFileReadDisable:Boolean;
		/**
		 * 	Specifies whether read access to the user's hard disk has been 
		 * 	administratively prohibited (<code>true</code>) or allowed 
		 * 	(<code>false</code>). For content in Adobe AIR, this property 
		 * 	applies only to content in security sandboxes other than the application
		 * 	security sandbox. (Content in the application security sandbox can
		 * 	always read from the file system.) If this property is <code>true</code>,
		 * 	Flash Player cannot read files (including the first file that
		 * 	Flash Player launches with) from the user's hard disk. If this property
		 * 	is <code>true</code>, AIR content outside of the application security
		 * 	sandbox cannot read files from the user's hard disk.
		 * 
		 * 	<p>Reading runtime shared libraries is also blocked if this property
		 * 	is set to <code>true</code>, but reading local shared objects 
		 * 	is allowed without regard to the value of this property.</p>
		 */
		public function get localFileReadDisable():Boolean {
			return _localFileReadDisable;
		}
		
		private var _manufacturer:String;
		/**
		 * 	Specifies the manufacturer of the running version of Flash Player or
		 * 	the AIR runtime, in the format <code>"AdobeOSName"</code>. The value
		 * 	for <code>OSName</code> could be <code>"Windows"</code>,
		 * 	<code>"Macintosh"</code>, <code>"Linux"</code>, or another operating
		 * 	system name.
		 */
		public function get manufacturer():String {
			return _manufacturer;
		}
		
		private var _maxLevelIDC:String;
		/**
		 * 	Retrieves the highest H.264 Level IDC that the client hardware
		 * 	supports. Media run at this level are guaranteed to run; however,
		 * 	media run at the highest level might not run with the highest
		 * 	quality.
		 */
		public function get maxLevelIDC():String {
			return _maxLevelIDC;
		}
		
		private var _os:String;
		/**
		 * 	Specifies the current operating system. The <code>as</code> property
		 * 	can return the following strings:
		 * 	<ul>
		 * 	<li><code>"Windows XP"</code>,</li>
		 * 	<li><code>"Windows 2000"</code>,</li>
		 * 	<li><code>"Windows NT"</code>,</li>
		 * 	<li><code>"Windows 98/ME"</code>,</li>
		 * 	<li><code>"Windows 95"</code>,</li>
		 * 	<li><code>"Windows CE"</code> (available only in Flash Player SDK,
		 * 	not in the desktop version),</li>
		 * 	<li><code>"Linux"</code>,</li>
		 * 	<li><code>"Mac OS X.Y.Z"</code> (where X.Y.Z is the version number,
		 * 	for example: <code>Mac OS 10.5.2</code>).</li>
		 * 	</ul>
		 */
		public function get os():String {
			return _os;
		}
		
		private var _pixelAspectRatio:Number;
		/**
		 * 	Specifies the pixel aspect ratio of the screen.
		 */
		public function get pixelAspectRatio():Number {
			return _pixelAspectRatio;
		}
		
		private var _playerType:String;
		/**
		 * 	Specifies the type of runtime environment. This property can have one
		 * 	of the following values:
		 * 	<ul>
		 * 	<li><code>"ActiveX"</code> for the Flash Player ActiveX control used by
		 * 	Microsoft Internet Explorer,</li>
		 * 	<li><code>"Desktop"</code> for the Adobe AIR runtime (except for SWF
		 * 	content loaded by an HTML page, which has <code>Capabilities.playerType</code>
		 * 	set to <code>"PlugIn"</code>),</li>
		 * 	<li><code>"External"</code> for the external Flash Player or in test
		 * 	mode,</li>
		 * 	<li><code>"PlugIn"</code> for the Flash Player browser plug-in (and for
		 * 	SWF content loaded by an HTML page in an AIR application),</li>
		 * 	<li><code>"StandAlone"</code> for the stand-alone Flash PlayerThe server
		 * 	string is <code>PT</code>.</li>
		 * 	</ul>
		 */
		public function get playerType():String {
			return _playerType;
		}
		
		private var _screenColor:String;
		/**
		 * 	Specifies the screen color. This property can have the value <code>"color"</code>,
		 * 	<code>"gray"</code> (for grayscale), or <code>"bw"</code> (for black and
		 * 	white).
		 */
		public function get screenColor():String {
			return _screenColor;
		}
		
		private var _screenDPI:Number;
		/**
		 * 	Specifies the dots-per-inch (dpi) resolution of the screen, in pixels.
		 */
		public function get screenDPI():Number {
			return _screenDPI;
		}
		
		private var _screenResolutionX:Number;
		/**
		 * 	Specifies the maximum horizontal resolution of the screen. 
		 */
		public function get screenResolutionX():Number {
			return _screenResolutionX;
		}
		
		private var _screenResolutionY:Number;
		/**
		 * 	Specifies the maximum vertical resolution of the screen. 
		 */
		public function get screenResolutionY():Number {
			return _screenResolutionY;
		}
		
		private var _supports32BitProcesses:Boolean;
		/**
		 * 	Specifies whether the system supports running 32-bit processes.
		 */
		public function get supports32BitProcesses():Boolean {
			return _supports32BitProcesses;
		}
		
		private var _supports64BitProcesses:Boolean;
		/**
		 * 	Specifies whether the system supports running 64-bit processes.
		 */
		public function get supports64BitProcesses():Boolean {
			return _supports64BitProcesses;
		}
		
		private var _version:String;
		/**
		 * 	Specifies the Flash Player or Adobe® AIR® platform and version
		 * 	information. The format of the version number is:
		 * 	platform <code>majorVersion</code>, <code>minorVersion</code>,
		 * 	<code>buildNumber</code>, <code>internalBuildNumber</code>.
		 * 
		 * 	<p>Possible values for platform are <code>"WIN"</code>,
		 * 	<code>"MAC"</code>, and <code>"LNX"</code>.</p>
		 */
		public function get version():String {
			return _version;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_avHardwareDisable = Capabilities.avHardwareDisable;
			_cpuArchitecture = Capabilities.cpuArchitecture;
			_hasAccessibility = Capabilities.hasAccessibility;
			_hasAudio = Capabilities.hasAudio;
			_hasAudioEncoder = Capabilities.hasAudioEncoder;
			_hasEmbeddedVideo = Capabilities.hasEmbeddedVideo;
			_hasIME = Capabilities.hasIME;
			_hasMP3 = Capabilities.hasMP3;
			_hasPrinting = Capabilities.hasPrinting;
			_hasScreenBroadcast = Capabilities.hasScreenBroadcast;
			_hasScreenPlayback = Capabilities.hasScreenPlayback;
			_hasStreamingAudio = Capabilities.hasStreamingAudio;
			_hasStreamingVideo = Capabilities.hasStreamingVideo;
			_hasTLS = Capabilities.hasTLS;
			_hasVideoEncoder = Capabilities.hasVideoEncoder;
			_language = Capabilities.language;
			_localFileReadDisable = Capabilities.localFileReadDisable;
			_manufacturer = Capabilities.manufacturer;
			_maxLevelIDC = Capabilities.maxLevelIDC;
			_os = Capabilities.os;
			_pixelAspectRatio = Capabilities.pixelAspectRatio;
			_playerType = Capabilities.playerType;
			_screenColor = Capabilities.screenColor;
			_screenDPI = Capabilities.screenDPI;
			_screenResolutionX = Capabilities.screenResolutionX;
			_screenResolutionY = Capabilities.screenResolutionY;
			_supports32BitProcesses = Capabilities.supports32BitProcesses;
			_supports64BitProcesses = Capabilities.supports64BitProcesses;
			_version = Capabilities.version;
		}
	}
}