/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import com.developmentarc.core.tasks.tasks.ITask;
	
	import playerio.DatabaseObject;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.models.VoxelModel;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LoadModelFromIVM extends LandscapeTask 
	{		
		public function LoadModelFromIVM( $guid:String, $layer:LayerInfo, $taskType:String = "LoadModelFromIVM", $taskPriority:int = TASK_PRIORITY ):void {
			//Log.out( "LoadModelFromIVM.construct " );
			_layer = $layer;
			_startTime = getTimer();
			super( $guid, $layer, $taskType, $taskPriority );
		}
		
		// use data = for model guid
		override public function start():void {
			var timer:int = getTimer();
			super.start() // AbstractTask will send event

			var fileName:String = _layer.data;
			var index:int = fileName.indexOf( '*' );
			if ( -1 != index )
			{
				var rand:int = Math.random() * 4 + 1;
				fileName = fileName.replace( "*", String( rand ) );
				_layer.replaceData( fileName );
			}
				
			var ba:ByteArray = Globals.g_modelManager.findIVM( fileName );
			if ( ba )
			{
				//Log.out("LoadModelFromIVM.start - IVM found in modelManager: " + fileName );
				loadByteArray( ba );
				return;
			}
			
			if ( !Globals.isGuid( fileName ) )
			{
				loadFromFile( fileName )
			}
			else
			{
				// ModelManager is already loading this
				Log.out( "LoadModelFromIVM.start - How do I end up here?", Log.ERROR );
				super.complete() // AbstractTask will send event
			}
		}
		
		private	function loadFromFile( fileName:String ):void { 	
			var path:String = Globals.modelPath + fileName + ".ivm";
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest( path ));
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, onIVMLoad);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorAction);			
		}
		
		// once this is downloaded, we already have everything we need
		// why is this still around?
		private	function loaded(o:DatabaseObject):void 	{ 	
			Log.out( "LoadModelFromIVM.loaded: " + o );
			//var ba:ByteArray = o.;
			//
			//Globals.g_modelManager.addIVM( _layer.data, ba );
			//addLoadFromByteArray();
			super.complete() // AbstractTask will send event
		}

		/*
		 * Load the byte array which is the visual representation of the 
		 * voxel model into the oxel
		 * */
		private function loadByteArray( $ba:ByteArray ):void {
			
			var task:ITask = new LoadFromByteArray( _guid, _layer );
			Globals.g_landscapeTaskController.addTask( task );

			super.complete() // AbstractTask will send event
		}

		// byte array data has been successfully loaded
		public function onIVMLoad(event:Event):void	{
			
			var ba:ByteArray = event.target.data;
			Globals.g_modelManager.addIVM( _layer.data, ba );
			loadByteArray( ba );
		}
		

		public function errorAction(e:IOErrorEvent):void {
			Log.out( "LoadModelFromIVM.errorAction: " + e.toString(), Log.ERROR );
			super.complete() // AbstractTask will send event
		}	
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
