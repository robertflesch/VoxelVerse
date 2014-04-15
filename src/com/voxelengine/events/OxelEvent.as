/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.events
{
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	
	import flash.events.Event;
	public class OxelEvent extends Event
	{
		static public const CREATE:String 			= "CREATE";
		static public const DESTROY:String 			= "DESTROY";
		
		static public const INSIDE:String 			= "INSIDE";
		static public const OUTSIDE:String 			= "OUTSIDE";
		
		private var _instanceGuid:String = "";

		public function get instanceGuid():String { return _instanceGuid; }
		
		public function OxelEvent( $type:String, $owner:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_instanceGuid = $owner;
		}
		
		public override function clone():Event
		{
			return new OxelEvent(type, _instanceGuid, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("OxelEvent: instanceGuid: " + _instanceGuid, "type", "bubbles", "cancelable");
		}
		
	}
}
