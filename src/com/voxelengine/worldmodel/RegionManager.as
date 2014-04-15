/*==============================================================================
Copyright 2011-2013 Robert Flesch
All rights reserved.  This product contains computer programs, screen
displays and printed documentation which are original works of
authorship protected under United States Copyright Act.
Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
import com.voxelengine.events.PersistanceEvent;
import com.voxelengine.events.LoginEvent;
import com.voxelengine.events.RegionEvent;
import com.voxelengine.Globals;
import com.voxelengine.GUI.WindowRegionNew;
import com.voxelengine.GUI.WindowSandboxList;
import com.voxelengine.GUI.WindowSplash;
import com.voxelengine.Log;
import com.voxelengine.server.Network;
import flash.net.FileReference;
import org.flashapi.swing.Alert;
import playerio.PlayerIOError;
import playerio.DatabaseObject;
import com.voxelengine.server.Persistance;
import com.voxelengine.server.Network;

import com.voxelengine.worldmodel.Region;
/**
 * ...
 * @author Bob
 */
public class RegionManager 
{
	private var _regions:Vector.<Region> = null
	private var _currentRegion:Region = null
	
	public function RegionManager():void 
	{
		_regions = new Vector.<Region>;
		
		Globals.g_app.addEventListener( RegionEvent.REGION_CACHE_REQUEST_LOCAL, cacheRequestLocal ); 
		Globals.g_app.addEventListener( RegionEvent.REGION_CACHE_REQUEST_PUBLIC, cacheRequestPublic ); 
		Globals.g_app.addEventListener( RegionEvent.REGION_CACHE_REQUEST_PRIVATE, cacheRequestPrivate ); 
		
		// CRUD create retrieve update delete		
		//static public const REGION_LOCAL_CREATE:String		= "REGION_LOCAL_CREATE";
		Globals.g_app.addEventListener( RegionEvent.REGION_LOCAL_CREATE, create ); 
		//static public const REGION_LOCAL_LOAD:String		= "REGION_LOCAL_LOAD";
		Globals.g_app.addEventListener( RegionEvent.REGION_LOCAL_LOAD, loadLocal ); 
		//static public const REGION_LOCAL_UPDATE:String		= "REGION_LOCAL_UPDATE";
		//static public const REGION_LOCAL_DELETE:String		= "REGION_LOCAL_DELETE";
		//
		// CRUD create retrieve update delete		
		//static public const REGION_PERSISTANCE_CREATE:String		= "REGION_PERSISTANCE_CREATE";
		Globals.g_app.addEventListener( RegionEvent.REGION_PERSISTANCE_CREATE, createBigDB ); 
		//static public const REGION_PERSISTANCE_LOAD:String		= "REGION_PERSISTANCE_LOAD";
		Globals.g_app.addEventListener( RegionEvent.REGION_PERSISTANCE_LOAD, loadBigDB ); 
		//static public const REGION_PERSISTANCE_UPDATE:String		= "REGION_PERSISTANCE_UPDATE";
		//static public const REGION_PERSISTANCE_DELETE:String		= "REGION_PERSISTANCE_DELETE";
	}
	
	public function get size():int { return _regions.length; }
	
	public function get currentRegion():Region { return _currentRegion; }
	public function set currentRegion(val:Region):void { 
		_currentRegion = val; 
		//Log.out("RegionManager.currentRegion - set to: " + val.regionId ) 
	}
	
	public function get regions():Vector.<Region> { return _regions; }
	
	public function cacheRequestPrivate( e:RegionEvent ):void
	{
		cacheRequest( Network.userId );
	}
	public function cacheRequestPublic( e:RegionEvent ):void
	{
		cacheRequest( "public" )
	}
	public function cacheRequest( userName:String ):void
	{
		Persistance.loadRange( Persistance.DB_TABLE_REGIONS
					 , "regionOwner"
					 , [userName]
					 , null
					 , null
					 , 100
					, loadKeysSuccessHandler
					, function (e:PlayerIOError):void {  Log.out( "Region.errorHandler - e: " + e ); } );
	}
	
	private function loadKeysSuccessHandler( dba:Array ):void
	{
		trace( "loadKeysSuccessHandler: " + dba );
		for each ( var dbo:DatabaseObject in dba )
		{
			var newRegion:Region = new Region();
			_regions.push( newRegion );
			Region.loadFromDBO( newRegion, dbo );
		}
	}

	
	public function cacheRequestLocal( e:RegionEvent ):void
	{
		var region:Region = getRegion( e.regionId );
		if ( region )
		{
			Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_COMPLETE, region.regionId ) );
			return;
		}

		// region not cached yet.	
		var newRegion:Region = new Region();
		currentRegion = newRegion;
		_regions.push( newRegion );
		newRegion.request( e.regionId );
	}

	public function getRegion( $regionId:String ):Region
	{
		for each ( var region:Region in _regions )
		{
			if ( region && region.regionId == $regionId )
			{
				return region;
			}
		}
		return null;
	}
	
	public function loadDefault():void 
	{
		var newRegion:Region = new Region();
		currentRegion = newRegion;
		newRegion.name = "defaultRegion";
		_regions.push( newRegion );
		newRegion.createEmptyRegion();
		newRegion.load();
	}
	
	//////////////////////////////////// REGION_BIGDB_CREATE //////////////
	private function createBigDB( e:RegionEvent ):void
	{
		var region:Region = getRegion( e.regionId );
		if ( region )
			region.saveBigDB();
			
		Globals.g_app.addEventListener( PersistanceEvent.PERSISTANCE_CREATE_SUCCESS, newRegionCreateSucceed ); 
		Globals.g_app.addEventListener( PersistanceEvent.PERSISTANCE_CREATE_FAILURE, newRegionCreateFailure ); 
	}
	private function newRegionCreateSucceed( e:PersistanceEvent ):void
	{
		Globals.g_app.removeEventListener( PersistanceEvent.PERSISTANCE_CREATE_SUCCESS, newRegionCreateSucceed ); 
		Globals.g_app.removeEventListener( PersistanceEvent.PERSISTANCE_CREATE_FAILURE, newRegionCreateFailure );
		if ( !WindowSandboxList.isActive )
			WindowSandboxList.create();
	}
	private function newRegionCreateFailure( e:PersistanceEvent ):void
	{
		Globals.g_app.removeEventListener( PersistanceEvent.PERSISTANCE_CREATE_SUCCESS, newRegionCreateSucceed ); 
		Globals.g_app.removeEventListener( PersistanceEvent.PERSISTANCE_CREATE_FAILURE, newRegionCreateFailure ); 
		new Alert( "Failed to create new Region on Server" );
		if ( !WindowSandboxList.isActive )
			WindowSandboxList.create();
	}
	//////////////////////////////////// REGION_LOCAL_CREATE //////////////
	private function create( e:RegionEvent ):void
	{
		var newRegion:Region = new Region();
		newRegion.regionId = Globals.getUID();
		Log.out( "RegionManager.create - new regionid: " + newRegion.regionId );
		_regions.push( newRegion );
		newRegion.createEmptyRegion();
		new WindowRegionNew( newRegion );
		Globals.g_app.addEventListener( RegionEvent.REGION_CREATE_CANCEL, newRegionCancel ); 
		Globals.g_app.addEventListener( RegionEvent.REGION_CREATE_SUCCESS, newRegionCreate ); 
	}

	private function newRegionCreate( e:RegionEvent ):void
	{
		Globals.g_app.removeEventListener( RegionEvent.REGION_CREATE_CANCEL, newRegionCreate ); 
		Globals.g_app.removeEventListener( RegionEvent.REGION_CREATE_SUCCESS, newRegionCancel ); 
		loadRegion( e.regionId );
		Globals.g_app.dispatchEvent( new LoginEvent( LoginEvent.SANDBOX_SUCCESS, null ) );
	}
	
	private function newRegionCancel( e:RegionEvent ):void
	{
		Globals.g_app.removeEventListener( RegionEvent.REGION_CREATE_CANCEL, newRegionCreate ); 
		Globals.g_app.removeEventListener( RegionEvent.REGION_CREATE_SUCCESS, newRegionCancel ); 
		var index:int = 0
		for each ( var region:Region in _regions )
		{
			
			if ( region && region.regionId == e.regionId )
			{
				_regions.splice( index, 1 );
				break;
			}
			index++;
		}
		if ( !WindowSandboxList.isActive )
			WindowSandboxList.create();
	}
	//////////////////////////////////// END REGION_LOCAL_CREATE //////////////
	
	private function loadLocal( e:RegionEvent ):void
	{
		loadRegion( e.regionId );
		Globals.g_app.dispatchEvent( new LoginEvent( LoginEvent.SANDBOX_SUCCESS, null ) );
	}
	
	private function loadBigDB( e:RegionEvent ):void
	{
		loadRegion( e.regionId );
	}

	public function loadRegion( $regionId:String ):void
	{
		if ( !WindowSplash.isActive )
			WindowSplash.create();
		
		if ( currentRegion )
			Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_UNLOAD, currentRegion.regionId ) );

		var region:Region = getRegion( $regionId );
		if ( region )
		{
				currentRegion = region;
				region.load();
				return;
		}
		
		// Should never get here
		// No matching region found, so we have to go load it
		var newRegion:Region = new Region();
		currentRegion = newRegion;
		//newRegion.loadRegion( $regionId );
		//_regions.push( newRegion );
		Log.out( "RegionManager.loadRegion - ERROR creating new region: " + $regionId, Log.ERROR );
	}
/*	
	public function writeRegion():void 
	{
		var fr:FileReference = new FileReference();
		var outString:String;

		for each ( var region:Region in _regions )
		{
			outString = region.getJSON();
		}
		fr.save( outString, region.regionId );
	}
	*/
	public function save():void
	{
		for each ( var region:Region in _regions )
		{
			if ( region && "" != region.regionId  )
				if ( region.changed )
					region.saveBigDB();
		}
	}
} // RegionManager
} // Package