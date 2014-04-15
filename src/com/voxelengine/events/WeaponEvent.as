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
	 */
	public class WeaponEvent extends Event
	{
		static public const INVALID:String					= "INVALID";
		
		static public const FIRE:String 					= "FIRE";
		
		private var _ammo:Ammo;
		private var _instanceGuid:String;
		
		public function get ammo():Ammo { return _ammo; }
		public function get instanceGuid():String { return _instanceGuid; }
		
		public function WeaponEvent( $type:String, $instanceGuid:String, $ammo:Ammo, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_ammo = $ammo;
			if ( null == $ammo )
				throw new Error( "WeaponEvent.construction - NO AMMO DEFINED" );
			_instanceGuid = $instanceGuid;
		}
		
		public override function clone():Event
		{
			return new WeaponEvent(type, _instanceGuid, _ammo, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("WeaponEvent", "bubbles", "cancelable") + " instanceGuid: " + _instanceGuid + " _ammo: " + _ammo;
		}
		
		
	}
}
