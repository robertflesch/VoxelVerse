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
	public class ModeChoiceEvent extends Event
	{
		static public const MODE_SANDBOX:String		= "MODE_SANDBOX";
		static public const MODE_ONLINE:String		= "MODE_ONLINE";
		
		public function ModeChoiceEvent( $type:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
		}
		
		public override function clone():Event
		{
			return new ModeChoiceEvent(type, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("ModeChoiceEvent", "bubbles", "cancelable");
		}
		
	}
}
