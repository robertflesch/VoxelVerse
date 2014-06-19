/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.events
{
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 */
	public class LightEvent extends Event
	{
		static public const ADD:String 					= "ADD";
		static public const REMOVE:String				= "REMOVE";
		static public const SOLID_TO_ALPHA:String		= "CHANGE";
		static public const ALPHA_TO_SOLID:String		= "BLOCK";
		
		private var _instanceGuid:String;
		private var _gc:GrainCursor;
		private var _lightID:uint;
		
		public function get instanceGuid():String 	{ return _instanceGuid; }
		public function get gc():GrainCursor  		{ return _gc; }
		public function get lightID():uint 			{ return _lightID; }
		
		public function LightEvent( $eventType:String, $instanceGuid:String, $gc:GrainCursor, $lightID:uint = 0, $bubbles:Boolean = false, $cancellable:Boolean = false )
		{
			super( $eventType, $bubbles, $cancellable );
			_instanceGuid = $instanceGuid;
			_gc = $gc;
			_lightID = $lightID;
		}
		
		public override function clone():Event
		{
			return new LightEvent( type, _instanceGuid, _gc, _lightID );
		}
	   
		public override function toString():String
		{
			return formatToString("LightEvent", "bubbles", "cancelable") + " instanceGuid: " + _instanceGuid + " _gc: " + _gc + " lightID: " + _lightID;
		}
		
		
	}
}
