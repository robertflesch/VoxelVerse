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
	import flash.events.IOErrorEvent;

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class ParticleLoadingTask extends ParticleTask 
	{		
		// This is a low priority task, works very nicely
		public function ParticleLoadingTask( $vm:VoxelModel, $taskType:String = "ParticleLoadingTask", $taskPriority:int = TASK_PRIORITY ):void {
			//Log.out( "ParticleLoadingTask.construct " );
			super( $vm, $taskType, $taskPriority );
		}
		
		// use data = for model guid
		override public function start():void {
			var timer:int = getTimer();
			super.start() // AbstractTask will send event
			var fileName:String = _vm.modelInfo.fileName;
			var ba:ByteArray = Globals.g_modelManager.findIVM( fileName );
			if ( ba )
			{
				loadByteArray( ba );
				//Log.out("ParticleLoadingTask.start - loadByteArray: " + fileName + " took: " + (getTimer() - timer) );
				return;
			}
			loadFromFile( fileName );
			//Log.out("ParticleLoadingTask.start - loadFromFile: " + fileName + " took: " + (getTimer() - timer));
		}
		
		private	function loadFromFile( fileName:String ):void { 	
			//Log.out( "ParticleLoadingTask.loadFromFile" );
			var path:String = Globals.modelPath + fileName + ".ivm";
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest( path ));
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, onIVMLoad);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorAction);			
		}
		
		/*
		 * Load the byte array which is the visual representation of the 
		 * voxel model into the oxel
		 * */
		
		// byte array data has been successfully loaded
		private function onIVMLoad(event:Event):void	{
			
			var ba:ByteArray = event.target.data;
			Globals.g_modelManager.addIVM( _vm.modelInfo.fileName, ba );
			loadCompressedByteArray( ba );
		}
		
		private function loadCompressedByteArray( $ba:ByteArray ):void {
			if ( _vm && $ba )		
			{
				_vm.IVMLoadCompressed( $ba );
				//Log.out( "ParticleLoadingTask.start - completed - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime) + " guid: " + _guid);
			}
			else
				Log.out( "ParticleLoadingTask.loadByteArray - FAILED to find either voxel model or byte array: ", Log.ERROR );
			_vm.complete = true;
			super.complete() // AbstractTask will send event
		}
		
		private function loadByteArray( $ba:ByteArray ):void {
			if ( _vm && $ba )		
			{
				_vm.IVMLoadUncompressed( $ba );
				//Log.out( "ParticleLoadingTask.start - completed - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime) + " guid: " + _guid);
			}
			else
				Log.out( "ParticleLoadingTask.loadByteArray - FAILED to find either voxel model or byte array: ", Log.ERROR );
			_vm.complete = true;
			super.complete() // AbstractTask will send event
		}

		private function errorAction(e:IOErrorEvent):void {
			Log.out( "ParticleLoadingTask.errorAction: " + e.toString(), Log.ERROR );
			super.complete() // AbstractTask will send event
		}	
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
