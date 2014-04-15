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
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 */
	public class ShipEvent extends Event
	{
		static public const INVALID:String					= "INVALID";
		
		static public const THROTTLE_CHANGED:String	= "THROTTLE_CHANGED";
		static public const ALTITUDE_CHANGED:String	= "ALTITUDE_CHANGED";
		static public const DIRECTION_CHANGED:String	= "DIRECTION_CHANGED";
		
		private var _instanceGuid:String;
		public function get instanceGuid():String { return _instanceGuid; }
		
		private var _value:Number = 0;
		public function get value():Number { return _value; }
		
		public function ShipEvent( $type:String, $instanceGuid:String, $value:Number, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_value = $value;
			_instanceGuid = $instanceGuid;
		}
		
		public override function clone():Event
		{
			return new ShipEvent(type, _instanceGuid, _value, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("ShipEvent", "bubbles", "cancelable") + " _instanceGuid: " + _instanceGuid + " value: " + _value;
		}
		
	}
}
