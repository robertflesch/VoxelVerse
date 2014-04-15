/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.events
{
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class ImpactEvent extends Event
	{
		static public const EXPLODE:String		= "EXPLODE";
		static public const DFIRE:String		= "DFIRE";
		static public const ACID:String			= "ACID";
		static public const DICE:String			= "ICE";
		static public const WIND:String			= "WIND";
		
		private var _position:Vector3D;
		private var _radius:int;
		private var _detail:int;
		private var _instanceGuid:String;
		
		public function get position():Vector3D     { return _position; }
		public function get radius():int            { return _radius; }
		public function get detail():int            { return _detail; }
		public function get instanceGuid():String   { return _instanceGuid; }
		
		public function ImpactEvent( $type:String, $position:Vector3D, $radius:int, $detail:int, $instanceGuid:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_position = $position;
			_radius = $radius;
			_detail = $detail;
			_instanceGuid = $instanceGuid;
		}
		
		public override function clone():Event
		{
			return new ImpactEvent(type, _position, _radius, _detail, _instanceGuid, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("ImpactEvent", "_position", "_radius", "_detail", "_instanceGuid", "bubbles", "cancelable");
		}
		
	}
}
