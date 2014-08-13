/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.events
{
	import com.voxelengine.worldmodel.Region;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class RegionLoadedEvent extends Event
	{
		static public const REGION_EVENT_LOADED:String					= "REGION_EVENT_LOADED";
		
		private var _region:Region;
		
		public function get region():Region { return _region; } 
		
		public function RegionLoadedEvent( $type:String, $region:Region )
		{
			super( $type, false, false );
			_region = $region;
		}
		
		public override function clone():Event
		{
			return new RegionLoadedEvent(type, _region);
		}
	   
		public override function toString():String
		{
			return formatToString("RegionLoadedEvent", "bubbles", "cancelable") + " regionId: " + _region.regionId;
		}
		
	}
}
