/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.server.Persistance;
	import com.voxelengine.server.Network;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.pools.OxelPool;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import com.developmentarc.core.tasks.tasks.ITask;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.developmentarc.core.tasks.tasks.AbstractTask;

	import playerio.DatabaseObject;
	import playerio.PlayerIOError;
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LoadModelFromBigDB extends AbstractTask 
	{		
		private var _fileName:String;
		protected var _startTime:int;
		
		public function LoadModelFromBigDB( $fileName:String ):void {
			Log.out( "LoadModelFromBigDB.construct " );
			_fileName = $fileName
			_startTime = getTimer();
			super( _fileName );
		}
		
		// use data = for model guid
		override public function start():void
		{
			Log.out( "LoadModelFromBigDB.start" );
			var timer:int = getTimer();
			super.start() // AbstractTask will send event
			
			Persistance.loadObject( "voxelModels", _fileName, successHandler, errorHandler );
		}
		
		private static const MANIFEST_VERSION:int = 100;
		private 	function successHandler(o:DatabaseObject):void 
		{ 
			Log.out( "LoadModelFromBigDB.successHandler" );
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//var timer:int = getTimer();
			if ( !o )
			{
				Log.out( "LoadModelFromBigDB.successHandler - NULL DBObject" );
				super.complete() // AbstractTask will send event
				return;
			}

			var fileName:String = o.key;
			var $ba:ByteArray = o.data as ByteArray;
			$ba.uncompress();
			$ba.position = 0;
			
			// Read off 3 bytes, the data format "ivm"
			var format:String = VoxelModel.readFormat( $ba );
			if ( "ivm" != format ) 
			{
				Log.out( "LoadModelFromBigDB.successHandler - Exception - unsupported format: " + format, Log.ERROR );
				super.complete() // AbstractTask will send event
				return;
			}

			// Read off 3 bytes, the data version 
			var version:String = VoxelModel.readVersion( $ba );
				
			// Read off 1 bytes, the manifestVersion 
			var manifestVersion:int = $ba.readByte();
			if ( MANIFEST_VERSION != manifestVersion )
			{
				Log.out( "LoadModelFromBigDB.successHandler - Exception - bad version: " + manifestVersion, Log.ERROR );
				super.complete() // AbstractTask will send event
				return;
			}
			
			// how many bytes is the modelInfo
			var strLen:int = $ba.readInt();
			// read off that many bytes
			var modelInfoJson:String = $ba.readUTFBytes( strLen );
			modelInfoJson = decodeURI(modelInfoJson);
			
			// create the modelInfo object from embedded metadata
			var mi:ModelInfo = new ModelInfo();
			var jsonResult:Object = JSON.parse(modelInfoJson);
			mi.init( fileName, jsonResult );
			
			// add the modelInfo to the repo
			Globals.g_modelManager.modelInfoAdd( mi );
			var ii:InstanceInfo = Globals.g_modelManager.instanceInfoGet( fileName );
			if ( ii )
			{
				var modelAsset:String = mi.modelClass;
				var modelClass:Class = ModelLibrary.getAsset( modelAsset )
				var vm:* = new modelClass( ii, mi );
				if ( null == vm )
				{
					Log.out( "LoadModelFromBigDB.successHandler - failed to create new instance of modelClass: " + modelClass, Log.ERROR );
					super.complete() // AbstractTask will send event
					return;
				}
				
				if ( "Player" == modelAsset )
				{
					Globals.player = vm;
					Globals.controlledModel = vm;
					super.complete() // AbstractTask will send event
					return;
				}
				
				Globals.g_modelManager.modelAdd( vm );
			}
			else
			{
				Log.out( "LoadModelFromBigDB.successHandler - No instanceInfo was found for: " + mi.fileName, Log.ERROR );
				super.complete() // AbstractTask will send event
				return;
			}
			
			vm.databaseObject = o;
			
			// Finally we get to the byte array which holds the oxel data
			var rootGrainSize:int = $ba.readByte();
			var gc:GrainCursor = GrainCursorPool.poolGet(rootGrainSize);
			gc.grain = rootGrainSize;
			
			vm.statisics.gather( $ba, rootGrainSize );
			
			vm.oxelReset();
			var oxel:Oxel = OxelPool.poolGet();	
			vm.oxel = oxel;
			vm.oxel.byteArrayLoad( null, gc, $ba, vm.statisics );
				
			vm.oxel.gc.bound = rootGrainSize;
			vm.instanceInfo.grainSize = rootGrainSize;
//			if ( vm.mi.editable && Globals.g_app.configManager.showEditMenu )
//				vm._editCursor.oxel.gc.bound = oxel.gc.bound;
			GrainCursorPool.poolDispose(gc);
			vm.calculateCenter();
	//		set_camera_data();
			Log.out( "LoadModelFromBigDB.successHandler - completed: " + fileName );
			
			super.complete() // AbstractTask will send event
		}
		
		static private	function errorHandler(e:PlayerIOError):void	
		{ 
			Log.out( "LoadModelFromBigDB.errorHandler" );
			Log.out( "LoadModelFromBigDB.errorHandler - e: " + e );
			trace(e); 
		}	
	}
}
