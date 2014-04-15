package com.voxelengine.utils
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
 
	/**
	 * @author Andre Michelle (andr...@gmail.com)
         * Modified by Zach Foley aka The Plastic Sturgeon
	 */
	public class MP3Pitch
	{
		private const BLOCK_SIZE: int = 3072;
 
		private var _mp3: Sound;
		private var _sound: Sound;
 
		private var _target: ByteArray;
 
		private var _position: Number;
		private var _rate: Number;
		private var _repeat:SoundChannel;
		private var byteArray:ByteArray;
 
                // Pass in your looped Sound
		public function MP3Pitch( pitchedSound: Sound)
		{
			_target = new ByteArray();
			_mp3 =  pitchedSound;
 
			_position = 0.0;
			_rate = 1.0;
 
			_sound = new Sound();
			_sound.addEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );
			_repeat = _sound.play();
		}
 
		public function get rate(): Number
		{
			return _rate;
		}
 
                // Also added a handy volume setter
		public function volume( $volume: Number, $pan:Number = 0 ): void
		{
//			trace( "MP3Pitch.volume - value: " + value + "  pan: " + pan );
			_repeat.soundTransform = new SoundTransform( $volume, $pan );
		}
 
                // use this to set the pitch of your sound
		public function set rate( value: Number ): void
		{
			if( value < 0.0 )
				value = 0;
 
			_rate =  value;
		}
		
		public function stop():void
		{
			_repeat.stop();
		}
 
		private function sampleData( event: SampleDataEvent ): void
		{
			//-- REUSE INSTEAD OF RECREATION
			_target.position = 0;
 
			//-- SHORTCUT
			var data: ByteArray = event.data;
 
			var scaledBlockSize: Number = BLOCK_SIZE * _rate;
			var positionInt: int = _position;
			var alpha: Number = _position - positionInt;
 
			var positionTargetNum: Number = alpha;
			var positionTargetInt: int = -1;
 
			//-- COMPUTE NUMBER OF SAMPLES NEED TO PROCESS BLOCK (+2 FOR INTERPOLATION)
			var need: int = Math.ceil( scaledBlockSize ) + 2;
 
			//-- EXTRACT SAMPLES
			var read: int = _mp3.extract( _target, need, positionInt );
 
			var n: int = read == need ? BLOCK_SIZE : read / _rate;
 
			var l0: Number;
			var r0: Number;
			var l1: Number;
			var r1: Number;
 
			for( var i: int = 0 ; i < n ; ++i )
			{
				//-- AVOID READING EQUAL SAMPLES, IF RATE &lt; 1.0
				if( int( positionTargetNum ) != positionTargetInt )
				{
					positionTargetInt = positionTargetNum;
 
					//-- SET TARGET READ POSITION
					_target.position = positionTargetInt << 3;
					//-- READ TWO STEREO SAMPLES FOR LINEAR INTERPOLATION
 					l0 = _target.readFloat();
 					r0 = _target.readFloat();
 					l1 = _target.readFloat();
 					r1 = _target.readFloat();
				}
				//-- WRITE INTERPOLATED AMPLITUDES INTO STREAM
 				data.writeFloat( l0 + alpha * ( l1 - l0 ) );
 				data.writeFloat( r0 + alpha * ( r1 - r0 ) );
				//-- INCREASE TARGET POSITION
 				positionTargetNum += _rate;
				//-- INCREASE FRACTION AND CLAMP BETWEEN 0 AND 1
 				alpha += _rate;
 				while ( alpha >= 1.0 ) 
					--alpha;
			}
 
			//-- FILL REST OF STREAM WITH ZEROs
			if( i < BLOCK_SIZE )
			{
				while ( i < BLOCK_SIZE )
 				{
 					data.writeFloat( 0.0 );
 					data.writeFloat( 0.0 );
					++i;
				}
			}
 			//-- INCREASE SOUND POSITION
 			_position += scaledBlockSize;
			// My little addition here:
 			if (_position > _mp3.length * 44.1) 
			{
				_position = 0;
				_target.position = 0;
			}
		}
		
		public function adjustVolumeAndPan( $avatarPosition:Vector3D, $avatarRotationY:Number, $objectPosition:Vector3D, $maxRange:Number, $minRange:Number ):void
		{
			// --------------------------------------------- calculating pan
			var angleRadians:Number = -Math.atan2( $avatarPosition.x - $objectPosition.x, $avatarPosition.z - $objectPosition.z );
			// Now add in the avatars rotation
			angleRadians -= ( $avatarRotationY * Math.PI / 180 );
			var cpan:Number = Math.sin( angleRadians );				
			//trace( "Engine.adjustVolumeAndPan - angle: " + angleRadians * 180 / Math.PI + "  cpan: " + cpan );
			// --------------------------------------------- calculating pan

			//trace( "Engine.ModelEvent: position of engine: " + distance + "position of avatar: " + msAvatarPosition + "   guid: " + instanceInfo.instanceGuid );
			$objectPosition.decrementBy( $avatarPosition );
			//trace( "Engine.ModelEvent: " + distance.length );
			
			if ( $objectPosition.length > $maxRange )
			{
				stop();
				return;
			}
			
			if ( $objectPosition.length < $minRange )
			{
				volume( 1, 0 );
			}
			else
			{
				// linear
				// so if distance is 300, its 100 into a range of MAX - MIN so volume should be (2000 - abs(200 - 300))/1800 (max - min)	
				//var volume:Number = (_soundRangeMax - (distance.length-_soundRangeMin)) / (_soundRangeMax - _soundRangeMin);
				var soundVolume:Number = $minRange / $objectPosition.length;
				//trace ( "ModelEvent - Volume " + volume );
				volume( soundVolume, cpan );
			}
		}
	}
}
