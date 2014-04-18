/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	//import com.voxelengine.utils.MP3Pitch;
/*
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	*/
	/*
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flintparticles.threeD.renderers.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.renderers.BitmapRenderer;
	import org.flintparticles.threeD.renderers.controllers.OrbitCamera;
	import com.voxelengine.utils.Snow;
	import com.voxelengine.utils.Fire;
	//import com.voxelengine.utils.SmokeSmoke;
	*/
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Engine extends VoxelModel 
	{
		// Todo: This needs to be global?
		static private const SHIP_VELOCITY:String 	= "velocity"
		
		
		// Todo: From metadata (someday)
		private var _maxThrust:int = 10;
		
		public function Engine( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			
			if ( mi.json && mi.json.model && mi.json.model.engine )
			{
				var EngineInfo:Object = mi.json.model.engine;
				if ( EngineInfo.maxThrust )
					_maxThrust = EngineInfo.maxThrust;
			}
			else
				trace( "Engine - NO Engine INFO FOUND - Setting to defaults" );
				
//			SoundBank.getSound( _soundFile ); // Preload the sound file
		}

		override public function update(context:Context3D, elapsedTimeMS:int):void 
		{
			super.update(context, elapsedTimeMS);
		}
		
		public function start( $val:Number, $parentModel:VoxelModel, $useThrust:Boolean = true ):void 
		{
			Log.out( "Engine.start - val: " + $val );
			var ms:Number = _maxThrust * $val; // movementSpeed
			if ( $useThrust )
				$parentModel.instanceInfo.addNamedTransform( ms, 0, ms, ModelTransform.INFINITE_TIME, ModelTransform.VELOCITY, SHIP_VELOCITY );
			
			// Animation plays the sound
			updateAnimations( "Rotate", ms );

			//emitterTest();
		}
		
		public function stop( $parentModel:VoxelModel, $useThrust:Boolean = true ):void 
		{
			if ( $useThrust )
				$parentModel.instanceInfo.removeNamedTransform( ModelTransform.VELOCITY, SHIP_VELOCITY );

			updateAnimations( "Stop", 0 );
		}
		
		/*
		//private	var _soundChannel:SoundChannel = null;
		//private	var _soundTransform:SoundTransform = null;
		private function playEngineSound( val:Number ):void
		{
			// volume is 0 to 1
			var volume:Number = Math.abs(val) * 2;
			if ( null == _soundChannel )
			{
				var snd:Sound = SoundBank.getSound( _soundFile );
				if ( snd )
				{
					Log.out( "Ship.playEngineSound - play sound: " + snd );
					_soundTransform = new SoundTransform();
					_soundChannel = snd.play(0, 10000000, _soundTransform );
					_soundTransform.volume = volume;
					_soundChannel.soundTransform = _soundTransform;
				}
			}
			else
			{
				if ( _soundChannel && _soundTransform )
				{
					_soundTransform.volume = volume;
					_soundChannel.soundTransform = _soundTransform;
				}
			}
			
		}
		
		private function stopEngineSound(): void
		{
			if ( _soundChannel )
			{
				_soundChannel.stop();
				_soundChannel = null;
				Log.out("Ship.stopEngineSound" );
			}
		}
		*/
		/*
		private var _particles:Fire	= null;
		private var _renderer:DisplayObjectRenderer	= null;
		private var _camera:OrbitCamera = null;
		// This works but is incredibly slow....
		// it looks like I need to write a custom renderer for it
		private function emitterTest():void
		{
			_particles = new Fire();
			_particles.start( );

			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( -200, -200, 400, 400 ) );
			renderer.x = 200;
			renderer.y = 200;
//			renderer.addEmitter( smoke );
			renderer.addEmitter( _particles );
			Globals.g_app.addChild( renderer );

			renderer.camera.position = new Vector3D( 0, -150, -400 );
			renderer.camera.target = new Vector3D( 0, -150, 0 );
			renderer.camera.projectionDistance = 400;
			_camera = new OrbitCamera( Globals.g_app.stage, renderer.camera );
			_camera.start();			
		}
		*/
	}
}
