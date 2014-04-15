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
	public class CollisionEvent extends Event
	{
		static public const COLLIDED:String			= "COLLIDED";
		
		private var _instanceGuid:String;
		
		public function get instanceGuid():String   { return _instanceGuid; }
		
		public function CollisionEvent( $type:String, $instanceGuid:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_instanceGuid = $instanceGuid;
		}
		
		public override function clone():Event
		{
			return new CollisionEvent(type, _instanceGuid, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("CollisionEvent", "_instanceGuid", "bubbles", "cancelable");
		}
		
	}
}
