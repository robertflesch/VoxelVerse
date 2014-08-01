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
	import flash.geom.Vector3D;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.events.LoadingEvent;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class CompletedModel extends LandscapeTask 
	{		
		static private var _count:int = 0;
		static private var _playerLoaded:Boolean = false;
		
		public function CompletedModel( instanceGuid:String, layer:LayerInfo, taskType:String = TASK_TYPE, taskPriority:int = TASK_PRIORITY ):void {
			//Log.out( "CompletedModel.construct for guid: " + instanceGuid + "  count: " + _count );
			_startTime = getTimer();
			_count++;
			super( instanceGuid, layer, "CompletedModel" );
		}
		
		override public function start():void
		{
			super.start() // AbstractTask will send event

			try
			{
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
				if ( vm )
 					vm.complete = true;
				else
				{
					createPlaceholder( _guid );
					Log.out( "CompletedModel.start - VoxelModel Not found: " + _guid, Log.WARN );
					super.complete();
					return
				}
					
				//Log.out( "CompletedModel.start - VoxelModel marked complete guid: " + _guid );
			}
			catch ( error:Error )
			{
				if ( Globals.player.instanceInfo.instanceGuid == _guid )
					Globals.player.complete = true;
				else
					Log.out( "CompletedModel.start - exception was thrown for model guid: " + _guid, Log.ERROR );
			}
			
			_count--;
			//Log.out( "CompletedModel.start - completedModel: " + vm.instanceInfo.templateName + "  count: " + _count );
			if ( vm is Player )
			{
				Globals.g_app.dispatchEvent( new LoadingEvent( LoadingEvent.PLAYER_LOAD_COMPLETE, vm.instanceInfo.instanceGuid ) );
				_playerLoaded = true;
			}
			
			vm.calculateCenter();
			
			if (vm.modelInfo.editable && Globals.g_app.configManager.showEditMenu) {
				if ( null == vm.editCursor )
					vm.editCursor = EditCursor.create();
				vm.editCursor.oxel.gc.bound = vm.oxel.gc.bound;
			}
				
			if ( 0 == _count && _playerLoaded )
			{
				Log.out( "CompletedModel.start - ALL MODELS LOADED - dispatching the LoadingEvent.LOAD_COMPLETE event vm: " + vm.modelInfo.fileName );
				Globals.g_app.dispatchEvent( new LoadingEvent( LoadingEvent.LOAD_COMPLETE ) );
			}
			
			super.complete(); // This MUST be called for tasks to continue
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
		private function createPlaceholder( guid:String ):void 
		{
			var ii:InstanceInfo = new InstanceInfo();
			ii.instanceGuid = guid;
			ii.templateName = "GenerateCube";
			ii.name = "Missing Object";
			// preload the modelInfo for the GenerateCube
			Globals.g_modelManager.modelInfoPreload( ii.templateName );
			var viewDistance:Vector3D = new Vector3D(0, 0, -75);
			ii.positionSet = Globals.controlledModel.instanceInfo.worldSpaceMatrix.transformVector( viewDistance );
			Globals.g_modelManager.create( ii );
		}
	}
}
