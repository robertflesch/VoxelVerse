﻿package com.voxelengine.server 
{
	import com.voxelengine.events.PersistanceEvent;
	import com.voxelengine.events.RegionEvent;
	import com.voxelengine.events.RegionLoadedEvent;
	import com.voxelengine.Globals;
	import com.voxelengine.events.LoginEvent;
	import com.voxelengine.worldmodel.Region;
	import playerio.Client;
	import playerio.BigDB;
	import playerio.PlayerIOError;
	import playerio.DatabaseObject;
	import flash.utils.ByteArray;
		
	import com.voxelengine.Log;
	
	public class Persistance
	{
		static public const DB_TABLE_OBJECTS:String = "voxelModels";
		static public const DB_TABLE_REGIONS:String = "regions";
		
		static private var _table:String;
		static private var _key:String;
		static private var _data:Object;
		static private var _successHandler:Function;
		static private var _errorHandler:Function;
		static private var _isCreate:Boolean;
		
		static public function deleteKeys( $table:String, $keys:Array, $successHandler:Function, $errorHandler:Function ):void
		{
			if ( Network.client )
			{
				Network.client.bigDB.deleteKeys( $table, $keys, $successHandler, $errorHandler );
			}
			else
			{
				$errorHandler( new PlayerIOError( "No connection", 0 ) );
			}
		}

		static public function createObject( $table:String, $key:String, $data:Object, $successHandler:Function, $errorHandler:Function ):void
		{
			if ( Network.client )
			{
				Network.client.bigDB.createObject( $table, $key, $data, $successHandler, $errorHandler );
			}
			else
			{
				Globals.g_app.stage.addEventListener( LoginEvent.LOGIN_SUCCESS, onLoginSuccessCreateObject );
				Globals.g_app.stage.addEventListener( LoginEvent.LOGIN_FAILURE, onLoginFailureCreateObject );
				_table = $table;
				_key = $key;
				_data = $data;
				_successHandler = $successHandler;
				_errorHandler = $errorHandler;
				_isCreate = true;
				new WindowLogin();
			}
		}
		
		static public function loadObject( $table:String, $key:String, $successHandler:Function, $errorHandler:Function ):void
		{
			if ( Network.client )
				Network.client.bigDB.load( $table, $key, $successHandler, $errorHandler );
			else
			{
				Globals.g_app.stage.addEventListener( LoginEvent.LOGIN_SUCCESS, onLoginSuccessCreateObject );
				Globals.g_app.stage.addEventListener( LoginEvent.LOGIN_FAILURE, onLoginFailureCreateObject );
				_table = $table;
				_key = $key;
				_successHandler = $successHandler;
				_errorHandler = $errorHandler;
				_isCreate = false;
				new WindowLogin();
			}
		}
		
		static public function loadKeys( $table:String, $key:Array, $successHandler:Function, $errorHandler:Function ):void
		{
			if ( Network.client )
				Network.client.bigDB.loadKeys( $table, $key , $successHandler, $errorHandler );
			else
			{
				$errorHandler( new PlayerIOError( "LoadKeys", 0 ) );
			}
		}
		
		static public function loadRange( $table:String, $index:String, $path:Array, $start:Object, $stop:Object, $limit:int, $successHandler:Function, $errorHandler:Function ):void
		{
			/*
			 * Load a range of DatabaseObjects from a table using the specified index.
			 * @param table The table to load the DatabaseObject from
			 * @param index The name of the index to query for the DatabaseObject
			 * @param path Where in the index to start the range search: An array of objects of the same types as the index properties, specifying where in the index to start loading DatabaseObjects from. For instance, in the index [Mode,Map,Score] you might use ["expert","skyland"] as the indexPath and use the start and stop arguments to determine the range of scores you wish to return. IndexPath can be set to null if there is only one property in the index.
			 * @param start Where to start the range search. For instance, if the index is [Mode,Map,Score] and indexPath is ["expert","skyland"], then start defines the minimum score to include in the results
			 * @param stop Where to stop the range search. For instance, if the index is [Mode,Map,Score] and indexPath is ["expert","skyland"], then stop defines the maximum score to include in the results
			 * @param limit The max amount of objects to return
			 * @param callback Function executed when the DatabaseObjects are successfully loaded: An array of DatabaseObjects are passed to the method: function(dbarr:Array):void{...}
			 * @param errorHandler Function executed if an error occurs while loading the DatabaseObjects
			 * 
			function loadRange(table:String, index:String, path:Array, start:Object, stop:Object,  limit:int, callback:Function=null, errorHandler:Function=null):void;
			*/

			if ( Network.client )
				Network.client.bigDB.loadRange( $table, $index , $path, $start, $stop,  $limit, $successHandler, $errorHandler );
			else
			{
				$errorHandler( new PlayerIOError( "LoadKeys", 0 ) );
			}
		}
		
		static private function onLoginSuccessCreateObject(event : LoginEvent ) : void
		{
			Globals.g_app.stage.removeEventListener( LoginEvent.LOGIN_SUCCESS, onLoginSuccessCreateObject );
			if ( _isCreate )
			{
				if ( Network.client )
					Network.client.bigDB.createObject( _table, _key, _data, _successHandler, _errorHandler );
				else
				{
					//Globals.g_app.dispatchEvent( new PersistanceEvent( PersistanceEvent.BIGDB_CONNECTION_FAILURE ) );
					_errorHandler( event.error );
					Log.out( "Persistance.onLoginSuccessCreateObject.createObject - ERROR - ERROR - ERROR Login Failure", Log.ERROR );
				}
			}
			else
			{
				if ( Network.client )
					Network.client.bigDB.load( _table, _key, _successHandler, _errorHandler );
				else
				{
					_errorHandler( event.error );
					Log.out( "Persistance.onLoginSuccessCreateObject.loadObject - ERROR - ERROR - ERROR Login Failure", Log.ERROR );
				}
			}
		}
		
		static private function onLoginFailureCreateObject(event : LoginEvent ) : void
		{
			Globals.g_app.stage.removeEventListener( LoginEvent.LOGIN_FAILURE, onLoginFailureCreateObject );
			if ( _isCreate )
				Log.out( "Persistance.onLoginFailureCreateObject.createObject - ERROR - ERROR - ERROR Login Failure", Log.ERROR );
			else	
				Log.out( "Persistance.onLoginFailureCreateObject.loadObject - ERROR - ERROR - ERROR Login Failure", Log.ERROR );
				
			_errorHandler( event.error );	
		}

		static public function loadRegions( $userName:String ):void {
			
			loadRange( Persistance.DB_TABLE_REGIONS
						 , "regionOwner"
						 , [$userName]
						 , null
						 , null
						 , 100
						, loadKeysSuccessHandler
						, function (e:PlayerIOError):void {  Log.out( "Persistance.errorHandler - e: " + e ); } );
		}
		
		static private function loadKeysSuccessHandler( dba:Array ):void
		{
			trace( "Persistance.loadKeysSuccessHandler - regions loaded: " + dba.length );
			for each ( var dbo:DatabaseObject in dba )
			{
				loadFromDBO( dbo );
			}
		}
		
		static public function loadFromDBO( dbo:DatabaseObject):void
		{
			var newRegion:Region = new Region();
			//var regionGuid:String = dbo.key;
			newRegion.databaseObject = dbo;
			newRegion.name = dbo.name;
			newRegion.desc = dbo.description;
			//newRegion.worldId = dbo.world;
			newRegion.regionId = dbo.region;
			//newRegion.template = dbo.template;
			//newRegion.owner = dbo.owner
			//newRegion.editors	: GetEditorsList(),
			//newRegion.admin: GetAdminList(),
			//newRegion.created = dbo.created;
			//newRegion.modified = dbo.modified;
			
			var $ba:ByteArray = dbo.data as ByteArray;
			//$ba.uncompress();
			$ba.position = 0;
			// how many bytes is the modelInfo
			var strLen:int = $ba.readInt();
			// read off that many bytes
			var regionJson:String = $ba.readUTFBytes( strLen );
			Log.out( "Persistance.loadFromDBO - regionJson: " + regionJson );
			//regionJson = decodeURI(regionJson);
			newRegion.processRegionJson( regionJson );
		}

		
		
	}	
}
