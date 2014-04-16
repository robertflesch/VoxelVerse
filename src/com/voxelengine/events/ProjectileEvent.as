/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.events
{
	import com.voxelengine.worldmodel.weapons.Ammo;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class ProjectileEvent extends Event
	{
		static public const PROJECTILE_SHOT:String			= "PROJECTILE_SHOT";
		static public const PROJECTILE_CREATED:String		= "PROJECTILE_CREATED";
		static public const PROJECTILE_DESTROYED:String		= "PROJECTILE_DESTROYED";
		
		private var _position:Vector3D;
		private var _direction:Vector3D;
		private var _ammo:Ammo = null;
		private var _ownerGuid:String = "NOT SET";
		
		public function get position():Vector3D { return _position; }
		public function get direction():Vector3D { return _direction; }
		public function get ammo():Ammo { return _ammo;}
		public function get owner():String { return _ownerGuid; }
		
		public function set position(val:Vector3D):void { _position = val; }
		public function set direction(val:Vector3D):void { _direction = val; }
		public function set ammo(value:Ammo):void  { _ammo = value; }
		public function set owner(val:String):void { _ownerGuid = val; }
		
		public function ProjectileEvent( $type:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
		}
		
		public override function clone():Event
		{
			// Use the change type method, but use the same type
			return changeType( type );
		}
	   
		public function changeType( $newType:String ):ProjectileEvent
		{
			var pe:ProjectileEvent = new ProjectileEvent( $newType, bubbles, cancelable);
			pe.position = position.clone();
			pe.ammo = _ammo.clone();
			pe.direction = direction.clone();
			pe.owner = owner;
			return pe;
		}
	   
		public override function toString():String
		{
			return formatToString("ProjectileEvent", "bubbles", "cancelable") + " ownerId: " + owner + "  position: " + position + "  direction: " + direction + " ammo: " + ammo;
		}
		
	}
}
