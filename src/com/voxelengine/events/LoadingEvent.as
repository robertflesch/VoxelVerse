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
	public class LoadingEvent extends Event
	{
		static public const LOAD_COMPLETE:String			= "LOAD_COMPLETE";
		static public const PLAYER_LOAD_COMPLETE:String		= "PLAYER_LOAD_COMPLETE";
		
		static public const SPLASH_LOAD_COMPLETE:String		= "SPLASH_LOAD_COMPLETE";
		static public const LOAD_TYPES_COMPLETE:String		= "LOAD_TYPES_COMPLETE";
		
		static public const ANIMATION_LOAD_COMPLETE:String	= "ANIMATION_LOAD_COMPLETE";

		private var _name:String = "";
		public function LoadingEvent( $type:String, $name:String = "", $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_name = $name;
		}
		
		public override function clone():Event
		{
			return new LoadingEvent(type, _name, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("LoadingEvent", "name", "bubbles", "cancelable");
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}
}
