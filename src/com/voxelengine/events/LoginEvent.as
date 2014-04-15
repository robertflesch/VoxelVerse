/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.events
{
	import adobe.utils.ProductManager;
	import flash.events.Event;
	import playerio.PlayerIOError;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class LoginEvent extends Event
	{
		static public const LOGIN_SUCCESS:String		= "LOGIN_SUCCESS";
		static public const LOGIN_FAILURE:String		= "LOGIN_FAILURE";
		static public const SANDBOX_SUCCESS:String		= "SANDBOX_SUCCESS";
		
		private var _error:PlayerIOError;
		public function get error():PlayerIOError { return _error; }
		
		public function LoginEvent( $type:String, error:PlayerIOError , $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
		}
		
		public override function clone():Event
		{
			return new LoginEvent(type, error, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("LoginEvent", "bubbles", "cancelable") + _error ? _error.message : "";
		}
		
	}
}
