/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
	import com.voxelengine.events.RegionEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	import mx.utils.StringUtil;

	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.LoadingEvent;
	
	/**
	 * ...
	 * @author Bob
	 */
	public class ConfigManager 
	{
		private var _showHelp:Boolean = true;
		private var _showEditMenu:Boolean = true;
		private var _showButtons:Boolean = true;
		
		public 	var _sr:String = "";
		
		public function get showHelp():Boolean { return _showHelp; }
		public function get showEditMenu():Boolean { return _showEditMenu; }
		public function get showButtons():Boolean { return _showButtons; }

		public function ConfigManager():void 
		{
			var _urlLoader:URLLoader = new URLLoader();
			Log.out( "ConfigManager.new - loading: " + Globals.appPath + "config.json", Log.INFO );
			_urlLoader.load(new URLRequest(Globals.appPath + "config.json"));
			_urlLoader.addEventListener(Event.COMPLETE, onConfigLoadedAction);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorAction);			
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgressAction);
		}
		
		public function onConfigLoadedAction(event:Event):void
		{
			var jsonString:String = StringUtil.trim(String(event.target.data));
			var regionJson:Object = JSON.parse(jsonString);
			var type:String = regionJson.config.typeName;
			_showHelp = regionJson.config.showHelp;
			_showEditMenu = regionJson.config.showEditMenu;
			_showButtons = regionJson.config.showButtons;
			TypeInfo.loadTypeData(type);
			
			//trace( 	regionJson.config.region.startingRegion );
			// So if this contains
			// "region": { "startingRegion":"zeppelin"  },
			// it will use zeppelin.rjson as starting region.
			// if it contains startingRegion, it will load the default region
			if ( regionJson.config.region.startingRegion == "startingRegion" )
				Globals.g_regionManager.loadDefault();
			else	
			{
				Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, regionJson.config.region.startingRegion ) );
				Globals.g_app.addEventListener( RegionEvent.REGION_CACHE_COMPLETE, onRegionCacheComplete );
			}
			
			Globals.g_app.addEventListener( LoadingEvent.LOAD_TYPES_COMPLETE, onTypesLoaded );
		}   
		
		private function onTypesLoaded( $e:LoadingEvent ):void
		{
			Globals.g_app.removeEventListener( LoadingEvent.LOAD_TYPES_COMPLETE, onTypesLoaded );
			if ( !Globals.player )
				Globals.g_modelManager.createPlayer();
		}

		private function onRegionCacheComplete( $e:RegionEvent ):void
		{
			Globals.g_app.removeEventListener( RegionEvent.REGION_CACHE_COMPLETE, onRegionCacheComplete );
			Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_LOCAL_LOAD, $e.regionId ) ); 
		}
		
		public function onProgressAction(event:ProgressEvent):void
		{
			var percentLoaded:Number=event.bytesLoaded/event.bytesTotal*100;
			//trace("ConfigManager.onProgressAction: "+percentLoaded+"%");
		}
		
		public function errorAction(e:IOErrorEvent):void
		{
			trace( "ConfigManager.errorAction: " + e.toString());
		}	
		
	} // ConfigManager
} // Package