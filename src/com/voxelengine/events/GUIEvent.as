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
	import playerio.PlayerIOError;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class GUIEvent extends Event
	{
		static public const TOOLBAR_HIDE:String		= "TOOLBAR_HIDE";
		static public const TOOLBAR_SHOW:String		= "TOOLBAR_SHOW";
		
		static public const APP_ACTIVATE:String		= "APP_ACTIVATE";
		static public const APP_DEACTIVATE:String	= "APP_DEACTIVATE";
		
		private var _error:PlayerIOError;
		public function get error():PlayerIOError { return _error; }
		
		public function GUIEvent( $type:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
		}
		
		public override function clone():Event
		{
			return new GUIEvent(type, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("GUIEvent", "bubbles", "cancelable");
		}
		
	}
}
