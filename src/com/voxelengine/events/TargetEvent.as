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
	 * 
	 */
	public class TargetEvent extends Event
	{
		private var _instanceGuid:String;
		private var _points:int;
		
		public function get instanceGuid():String { return _instanceGuid; }
		public function get points():int { return _points; }
		
		public function TargetEvent( $type:String, $instanceGuid:String, $points:int, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_instanceGuid = $instanceGuid;
			_points = $points;
		}
		
		static public const DESTROYED:String		= "DESTROYED";
		static public const DAMAGED:String			= "DAMAGED";
		static public const CREATED:String			= "CREATED";
		static public const REMOVED:String			= "REMOVED";
	}
}
