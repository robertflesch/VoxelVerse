/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LoadFromTox extends LandscapeTask 
	{		
		public function LoadFromTox( guid:String, layer:LayerInfo, taskType:String = TASK_TYPE, taskPriority:int = TASK_PRIORITY ):void {
			trace( "LoadFromTox.construct " );
			_layer = layer;
			_startTime = getTimer();
			super(guid, layer, "LoadFromTox" );
		}
		
		
		override public function start():void
		{
			super.start() // AbstractTask will send event

			var timer:int = getTimer();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			trace( "LoadFromTox.start - loading from byte array: " + _guid );
			var ba:ByteArray = Globals.g_modelManager.findIVM( _layer.data );
			if ( vm && ba )		
			{
				vm.loadFromTox( ba );
				trace( "LoadFromTox.start - completed - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime));
			}
			else
				trace( "LoadFromTox.start - FAILED: guid: " + _guid + "  data: " + _layer.data );

			super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
