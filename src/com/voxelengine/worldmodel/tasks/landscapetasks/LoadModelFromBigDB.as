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
		private var _keyName:String;
		protected var _startTime:int;
		
		public function LoadModelFromBigDB( $keyName:String, $layer:LayerInfo = null ):void {
			Log.out( "LoadModelFromBigDB.construct " );
			_keyName = $keyName
			_startTime = getTimer();
			super( _keyName );
		}
		
		// use data = for model guid
		override public function start():void
		{
			Log.out( "LoadModelFromBigDB.start" );
			var timer:int = getTimer();
			super.start() // AbstractTask will send event
			
			Persistance.loadObject( "voxelModels", _keyName, successHandler, errorHandler );
		}
		
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

			var keyName:String = o.key;
			var $ba:ByteArray = o.data as ByteArray;
			$ba.uncompress();
			$ba.position = 0;
			
			var vm:VoxelModel = VoxelModel.loadFromManifestByteArray( $ba, keyName );
			if ( vm )
				vm.databaseObject = o;
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
