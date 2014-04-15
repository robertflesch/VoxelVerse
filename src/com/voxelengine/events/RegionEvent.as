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
	public class RegionEvent extends Event
	{
		static public const REGION_CACHE_REQUEST_PRIVATE:String		= "REGION_CACHE_REQUEST_PRIVATE";
		static public const REGION_CACHE_REQUEST_PUBLIC:String		= "REGION_CACHE_REQUEST_PUBLIC";
		static public const REGION_CACHE_REQUEST_LOCAL:String		= "REGION_CACHE_REQUEST_LOCAL";
		static public const REGION_CACHE_COMPLETE:String			= "REGION_CACHE_COMPLETE";
		
		static public const REGION_LOAD_BEGUN:String				= "REGION_LOAD_BEGUN";
		//static public const REGION_LOAD_COMPLETE:String				= "REGION_LOAD_COMPLETE";
		static public const REGION_UNLOAD:String					= "REGION_UNLOAD";
		
		static public const REGION_CREATE_SUCCESS:String			= "REGION_CREATE_SUCCESS";
		static public const REGION_CREATE_CANCEL:String				= "REGION_CREATE_CANCEL";

		// CRUD create retrieve update delete		
		static public const REGION_LOCAL_CREATE:String				= "REGION_LOCAL_CREATE";
		static public const REGION_LOCAL_LOAD:String				= "REGION_LOCAL_LOAD";
		static public const REGION_LOCAL_UPDATE:String				= "REGION_LOCAL_UPDATE";
		
		// CRUD create retrieve update delete		
		static public const REGION_PERSISTANCE_CREATE:String		= "REGION_PERSISTANCE_CREATE";
		static public const REGION_PERSISTANCE_LOAD:String			= "REGION_PERSISTANCE_LOAD";
		static public const REGION_PERSISTANCE_UPDATE:String		= "REGION_PERSISTANCE_UPDATE";
		static public const REGION_PERSISTANCE_DELETE:String		= "REGION_PERSISTANCE_DELETE";
		
		private var _regionId:String;
		
		public function get regionId():String { return _regionId; } 
		
		public function RegionEvent( $type:String, $regionId:String = "", $bubbles:Boolean = true, $cancellable:Boolean = false )
		{
			super( $type, $bubbles, $cancellable );
			_regionId = $regionId;
		}
		
		public override function clone():Event
		{
			return new RegionEvent(type, _regionId, bubbles, cancelable);
		}
	   
		public override function toString():String
		{
			return formatToString("RegionEvent", "bubbles", "cancelable") + " regionId: " + _regionId;
		}
		
	}
}
