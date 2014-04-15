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
	public class PersistanceEvent extends Event
	{
		static public const PERSISTANCE_CREATE_SUCCESS:String		= "PERSISTANCE_CREATE_SUCCESS";
		static public const PERSISTANCE_CREATE_FAILURE:String		= "PERSISTANCE_CREATE_FAILURE";
		
		static public const PERSISTANCE_SAVE_SUCCESS:String			= "PERSISTANCE_SAVE_SUCCESS";
		static public const PERSISTANCE_SAVE_FAILURE:String			= "PERSISTANCE_SAVE_FAILURE";
		
		static public const PERSISTANCE_CONNECTION_FAILURE:String	= "PERSISTANCE_CONNECTION_FAILURE";
		
		public function PersistanceEvent( $type:String, $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
		}
		
		public override function clone():Event
		{
			return new PersistanceEvent(type, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("PersistanceEvent", "bubbles", "cancelable");
		}
		
	}
}
