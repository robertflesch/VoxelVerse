/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.animation
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.SoundBank;
	import com.voxelengine.utils.MP3Pitch;
		
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class AnimationSound
	{
		private var _soundFile:String = "INVALID";
		private var _pitch:MP3Pitch = null;
		private var _soundRangeMax:int = 2000;
		private var _soundRangeMin:int = 10;
//		private var _checked:Boolean = false; // Could be expensive, dont check more then once a frame

		private var _owner:VoxelModel = null;
		
		public function AnimationSound() {}
		
		public function init( $soundInfo:Object ):void 
		{
			if ( $soundInfo.name )
			{
				_soundFile = $soundInfo.name;
				SoundBank.getSound( _soundFile );
				if ( $soundInfo.soundRangeMax )
					_soundRangeMax = $soundInfo.soundRangeMax;
				if ( $soundInfo.soundRangeMin )
					_soundRangeMin = $soundInfo.soundRangeMin;
			}
		}
		
		public function play( $owner:VoxelModel, $val:Number ):void
		{
			Globals.g_app.addEventListener( ModelEvent.MOVED, onModelMoved );
			_pitch = SoundBank.playSoundWithPitch( $val, _soundFile, _pitch  );
			_owner = $owner
		}
		
		public function stop():void
		{
			Globals.g_app.removeEventListener( ModelEvent.MOVED, onModelMoved );
			SoundBank.stopSoundWithPitch( _pitch );
			_pitch = null;
			_owner = null;
		}
		
		public function update( $val:Number ):void
		{
			_pitch = SoundBank.playSoundWithPitch( $val, _soundFile, _pitch  );
		}
		
		private function onModelMoved( event:ModelEvent ):void
		{
			if ( event.instanceGuid == Globals.player.instanceInfo.instanceGuid && null != _pitch )
			{
				//trace( "AnimationSound.onModelMoved - Player moved" );
				// dont want to do this more then once per frame, really once every ten would be ok ??
				//_checked = true;
				
				// Timing check for early start up
				if (  _owner.instanceInfo.controllingModel )
				{
					var totalModelRotation:Number = _owner.getAccumulatedYRotation( _owner.instanceInfo.rotationGet.y );
					var effectiveRotation:Number = totalModelRotation + Globals.controlledModel.instanceInfo.rotationGet.y;
					
					_pitch.adjustVolumeAndPan( _owner.instanceInfo.controllingModel.worldToModel( Globals.controlledModel.instanceInfo.positionGet )
											 , effectiveRotation
											 , _owner.instanceInfo.positionGet.clone()
											 , _soundRangeMax
											 , _soundRangeMin );
				}
			}
		}
	}
}
