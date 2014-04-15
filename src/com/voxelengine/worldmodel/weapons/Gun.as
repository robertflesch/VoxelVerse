/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.weapons
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.weapons.Ammo;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.events.WeaponEvent;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;	
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Gun extends VoxelModel 
	{
		protected var _armory:Vector.<Ammo> = new Vector.<Ammo>;
		protected var _ammo:Ammo;
		protected var _reloadSpeed:Number;

		public function get ammo():Ammo { return _ammo; }
		public function set ammo( $ammo:Ammo ):void { _ammo = $ammo; }
		public function get armory():Vector.<Ammo>  { return _armory; }
		
		public function get reloadSpeed():Number { return _reloadSpeed; }
		//Barrel
		//Stand
		//Sight
		public function Gun( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			var centerLoc:int = 2 << (mi.grainSize - 2);
			calculateCenter( centerLoc );
			
			// Process the gun specific info
			processJsonInfo();
			
			var script:Script = instanceInfo.addScript( "FireProjectileScript" );
			//script.processJsonInfo( modelInfo );
		}

		public function fire():void
		{
			Globals.g_app.dispatchEvent( new WeaponEvent( WeaponEvent.FIRE, instanceInfo.instanceGuid, ammo ) );			
		}
		
		private	function processJsonInfo():void {
			
			if ( modelInfo.json && modelInfo.json.model && modelInfo.json.model.gun )
			{
				var gunInfo:Object = modelInfo.json.model.gun;
				if ( gunInfo.reloadSpeed )
					_reloadSpeed = gunInfo.reloadSpeed;
					
				if ( modelInfo.json.model.gun.ammos )
				{
					var ammosJson:Object = modelInfo.json.model.gun.ammos;
					for each ( var ammoInfo:Object in ammosJson )
					{
						var ammo:Ammo = new Ammo();
						ammo.processJsonInfo( ammoInfo );
						_armory.push( ammo );
					}
				}
				if ( _armory.length )
					_ammo = _armory[0];
			}
			else
				trace( "Gun - NO GUN INFO FOUND" );
		}
		

		override public function update(context:Context3D, elapsedTimeMS:int):void 
		{
			super.update(context, elapsedTimeMS);
		}
		
		override protected function onKeyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode) {
				case 87: case Keyboard.UP: 
					instanceInfo.addNamedTransform( _turnRate, 0, 0, ModelTransform.INFINITE_TIME, ModelTransform.ROTATION, "rotation" );			
					break;
				case 83: case Keyboard.DOWN: 
					instanceInfo.addNamedTransform( -_turnRate, 0, 0, ModelTransform.INFINITE_TIME, ModelTransform.ROTATION, "rotation" );			
					break;
				case 65: case Keyboard.LEFT: 
					instanceInfo.addNamedTransform( 0, _turnRate, 0, ModelTransform.INFINITE_TIME, ModelTransform.ROTATION, "rotation" );			
					break;
				case 68: case Keyboard.RIGHT: 
					instanceInfo.addNamedTransform( 0, -_turnRate, 0, ModelTransform.INFINITE_TIME, ModelTransform.ROTATION, "rotation" );			
					break;
			}
        }
		
		override protected function onKeyUp(e:KeyboardEvent):void 
		{
			switch (e.keyCode) {
				case 87: case Keyboard.UP:
				case 83: case Keyboard.DOWN:
				case 65: case Keyboard.LEFT: 
				case 68: case Keyboard.RIGHT: 
					instanceInfo.addNamedTransform( 0, 0, 0, 0.1, ModelTransform.ROTATION, "rotation" );			
					break;
			}
        }
		
	}
}
