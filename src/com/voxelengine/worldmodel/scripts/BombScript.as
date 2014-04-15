package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import com.voxelengine.worldmodel.weapons.Bomb;
	import com.voxelengine.worldmodel.SoundBank;
	import com.voxelengine.worldmodel.models.*;
	import flash.media.Sound;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.geom.Vector3D;
	
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.events.WeaponEvent;
	import com.voxelengine.Globals;

	public class BombScript extends Script 
	{
		private var _bulletSize:int = 2;
		private var _channel:SoundChannel;
		protected var _soundFile:String = "BombDrop.mp3";		
		
		public function BombScript( bulletSize:int = 2 ) 
		{
			_bulletSize = bulletSize;
			addKeyboardListeners();
			SoundBank.getSound( _soundFile ); // Preload the sound file
			Globals.g_app.addEventListener( WeaponEvent.FIRE, onWeaponEventDrop, false, 0, true );
		}
		
		override public function dispose():void
		{
			if ( _channel )
				_channel.stop();
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
            trace("BombScript.ioErrorHandler: " + event);
        }		
		
		private function addKeyboardListeners() : void
		{
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
		}

		private function onKeyPressed( e : KeyboardEvent) : void
		{
			if ( Keyboard.B == e.keyCode )
			{
				drop();
			}
		}
		
		private function drop():void
		{
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
			
			var snd:Sound = SoundBank.getSound( _soundFile );
			_channel = snd.play();
			
			var bomb:Bomb = Globals.g_modelManager.getModelInstance( instanceGuid ) as Bomb;
			if ( bomb )
			{
				var ship:VoxelModel = bomb.instanceInfo.controllingModel;
				if ( ship )
				{
					createReplacementBomb( bomb.instanceInfo.clone() , ship.instanceInfo.instanceGuid );
			
					ship.childDetach( bomb );

					bomb.instanceInfo.addTransform( 0, -5, 0, ModelTransform.INFINITE_TIME, ModelTransform.VELOCITY, "Gravity" );
					bomb.instanceInfo.addTransform( 0, 0, 0, 10, ModelTransform.LIFE );
				}
				else
					trace( "BombScript.drop - ship not found: " + bomb.instanceInfo.controllingModel );
			}
			else
				trace( "BombScript.drop - bomb not found: " + instanceGuid );
		}
		
		public function createReplacementBomb( ii:InstanceInfo, shipGuid:String ):void
		{
			// this was important, dont recall why
			var newShip:VoxelModel = Globals.g_modelManager.getModelInstance( shipGuid );
			ii.controllingModel = newShip;

			Globals.g_modelManager.create( ii );    
			
		}
		
		
		public function onWeaponEventDrop( $event:WeaponEvent ):void 
		{
			if ( instanceGuid != $event.instanceGuid )
			{
				trace( "onWeaponEvent: BombScript - ignoring event for someone else" + $event + " guid: " + instanceGuid );
				return;
			}
			
			drop();	
		}
	}
}