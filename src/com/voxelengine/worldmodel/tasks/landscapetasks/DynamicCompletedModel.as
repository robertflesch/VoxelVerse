/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import flash.utils.getTimer;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class DynamicCompletedModel extends LandscapeTask 
	{		
		public function DynamicCompletedModel( instanceGuid:String, layer:LayerInfo, taskType:String = TASK_TYPE, taskPriority:int = TASK_PRIORITY ):void {
			//Log.out( "DynamicCompletedModel.construct for guid: " + instanceGuid );
			_layer = layer;
			_startTime = getTimer();
			super( instanceGuid, layer, "DynamicCompletedModel" );
		}
		
		override public function start():void
		{
			super.start() // AbstractTask will send event

			try
			{
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
				if ( vm )
				{
 					vm.complete = true;
					// a hack here since we dont get a region loaded message if it is already loaded...
				}
				else
					Log.out( "DynamicCompletedModel.start - VoxelModel Not found: " + _guid, Log.WARN );
					
				//Log.out( "DynamicCompletedModel.start - VoxelModel marked complete guid: " + _guid );
			}
			catch ( error:Error )
			{
				Log.out( "DynamicCompletedModel.start - exception was thrown for model guid: " + _guid, Log.ERROR );
			}
			
			super.complete() // This MUST be called for tasks to continue
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
