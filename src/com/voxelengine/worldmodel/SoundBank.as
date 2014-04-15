/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.utils.MP3Pitch;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class SoundBank 
	{
		static private var _sounds:Dictionary = new Dictionary(true);
		static private var _soundsLoading:Dictionary = new Dictionary(true);

		static public function getSound( soundName:String ):Sound
		{
			var snd:Sound = _sounds[ soundName ];
			if ( snd )
				return snd;
				
			var isLoading:Boolean = _soundsLoading[ soundName ];
			if ( true == isLoading )
				return null;

			// its not loading, and its not in bank, load it!
			loadSound( soundName );
			
			return null;
		}
		
		// Need to use different loader here then customLoader since this is a static class. So 
		// I cant keep a reference to the loader around.
		static private function loadSound( soundName:String ):void 
		{
			var snd:Sound = new Sound()
			//Log.out( "SoundBank.loadSound - loading: " + Globals.appPath + soundName, Log.WARN );
			
			//Log.out("SoundBank.loadSound: " + Globals.soundPath + soundName );
			snd.load( new URLRequest( Globals.soundPath + soundName ) );
			snd.addEventListener(Event.COMPLETE, onSoundLoadComplete, false, 0, true);
			snd.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
			
			_soundsLoading[soundName] = true;
			_sounds[soundName] = snd;
		}

		
		static public function onSoundLoadComplete (event:Event):void 
		{
			var fileNameAndPath:String = event.target.url
			//Log.out( "SoundBank.onSoundLoadComplete: " + fileNameAndPath, Log.WARN );		
			var soundName:String = removeGlobalAppPath(fileNameAndPath);
			_soundsLoading[soundName] = false;

			//Log.out("SoundBank.onSoundLoadComplete: " + Globals.soundPath + soundName );
			function removeGlobalAppPath( completePath:String ):String 
			{
				var lastIndex:int = completePath.lastIndexOf( Globals.soundPath );
				var fileName:String = completePath;
				if ( -1 != lastIndex )
					fileName = completePath.substr( Globals.soundPath.length );
					
				return fileName;	
			}
		}			
		
		static private function onFileLoadError(event:IOErrorEvent):void
		{
			Log.out("----------------------------------------------------------------------------------" );
			Log.out("SoundBank.onFileLoadError - FILE LOAD ERROR, DIDNT FIND: " + event.target.url, Log.ERROR );
			Log.out("----------------------------------------------------------------------------------" );
		}	
		
		static public function playSoundWithPitch( $val:Number, $soundFile:String, $pitch:MP3Pitch  ):MP3Pitch
		{
			if ( null == $soundFile || "INVALID" == $soundFile )
				return null;
				
			// pitch is 0 to 1, but I find that values less then 0.5 dont work
			var pitchRate:Number = 0.5 + Math.abs($val) * 2 ;
			if ( $pitch )
			{
				//_pitch.volume = volume;
				$pitch.rate = pitchRate;
			}
			else
			{
				var snd:Sound = SoundBank.getSound( $soundFile );
				if ( snd )
				{
					//Log.out( "Ship.playSoundwWithPitch - play sound: " + snd.url );
					$pitch = new MP3Pitch( snd );
					$pitch.rate = pitchRate;
				}
			}
			return $pitch;
		}
		
		static public function stopSoundWithPitch( $pitch:MP3Pitch ): void
		{
			if ( $pitch )
			{
				$pitch.stop();
			}
		}
		

		static public function playSound( snd:Sound, $startTime:Number = 0, $loops:int = 0, $sndTransform:SoundTransform = null) : flash.media.SoundChannel
		{
			if ( snd && !Globals.muted )
				return snd.play( $startTime, $loops, $sndTransform );
			return null;	
		}
		

	}
}
