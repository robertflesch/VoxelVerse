/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine
{

	import com.furusystems.dconsole2.DConsole;
	import com.furusystems.logging.slf4as.Logging;
	import com.furusystems.logging.slf4as.ILogger;
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.ControllableVoxelModel;
	import com.voxelengine.worldmodel.models.EditCursor;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.landscapetasks.*;
	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.groups.TaskGroup;

	
	public class ConsoleCommands {
		
		private static function reset():void
		{
			if ( Globals.player )
				Globals.player.instanceInfo.reset();
		}
		
		private static function trail():void
		{
			if ( Globals.controlledModel )
			{
				var vm:ControllableVoxelModel = Globals.controlledModel as ControllableVoxelModel;
				vm.leaveTrail = ! vm.leaveTrail;
				Log.out( "Trail is " + (vm.leaveTrail ? "ON" : "OFF") );
			}
			else
				Log.out( "No model is under control to use trail on" );
		}
		
		private static function markers():void
		{
			if ( Globals.controlledModel )
			{
				var vm:ControllableVoxelModel = Globals.controlledModel as ControllableVoxelModel;
				vm.collisionMarkers = ! vm.collisionMarkers;
				Log.out( "CollisionPoints are " + (vm.collisionMarkers ? "ON" : "OFF") );
			}
			else
				Log.out( "No model is under control to use collisionPoints on" );
		}
		
		private static function gravity():void
		{
			if ( Globals.controlledModel )
			{
				Globals.controlledModel.usesGravity = ! Globals.controlledModel.usesGravity;
				Log.out( "Gravity is " + (Globals.controlledModel.usesGravity ? "ON" : "OFF") );
			}
			else
				Log.out( "No model is under control to use gravity on" );
		}
		
		private static function trees():void
		{
			if ( Globals.selectedModel )
			{
				Globals.selectedModel.oxel.growTreesOn( Globals.selectedModel.instanceInfo.instanceGuid, Globals.GRASS );
			}
			else
				Log.out( "No selected model" );
		}
		
		private static function tree():void
		{
			if ( Globals.selectedModel )
			{
				var oxel:Oxel = EditCursor.getHighlightedOxel();
				if ( Globals.BAD_OXEL == oxel )
				{
					Log.out( "EditCursor.insertOxel - Invalid location" );
					return;
				}

				TreeGenerator.generateTree( Globals.selectedModel.instanceInfo.instanceGuid, oxel, 1 );
			}
			else
				Log.out( "No selected model" );
		}
		
		
		private static function sand():void
		{
			if ( Globals.selectedModel )
			{
				Globals.selectedModel.oxel.dirtToGrassAndSand();
			}
			else
				Log.out( "No selected model" );
		}
		
		private static function vines():void
		{
			if ( Globals.selectedModel )
			{
				Globals.selectedModel.oxel.vines( Globals.selectedModel.instanceInfo.instanceGuid );
			}
			else
				Log.out( "No selected model" );
		}
		
		private static function lightingSun():void
		{
			/*
			if ( Globals.selectedModel )
			{
				var ol:Vector.<Oxel> = new Vector.<Oxel>();
				Globals.selectedModel.oxel.lightingSunGatherList( ol );
			}
			else {
				Log.out( "No selected model" );
				return;
			}
			
			var count:int;
			for each ( var oxel:Oxel in ol )
			{
				//if ( count < 200 )
					LightSunCheck.addTask( Globals.selectedModel.instanceInfo.instanceGuid, oxel.gc, 1, Globals.POSY );
				//count++;
			}
			*/
		}
		
		private static function lightingReset():void
		{
			if ( Globals.selectedModel )
			{
				Globals.selectedModel.oxel.lightingReset();
				Globals.selectedModel.oxel.rebuildAll();
			}
			else
				Log.out( "No selected model" );
		}
		
		private static function harvestTrees():void
		{
			if ( Globals.selectedModel )
			{
				Globals.selectedModel.oxel.harvestTrees( Globals.selectedModel.instanceInfo.instanceGuid );
			}
			else
				Log.out( "No selected model" );
		}
		
		
		private static function collide():void
		{
			if ( Globals.controlledModel )
			{
				Globals.controlledModel.instanceInfo.usesCollision = !Globals.controlledModel.instanceInfo.usesCollision;
				Log.out( "Collide is " + (Globals.controlledModel.instanceInfo.usesCollision ? "ON" : "OFF") );
			}
		}
		
		private static function flow():void
		{
			Globals.autoFlow = !Globals.autoFlow;
			Log.out( "autoFlow is " + (Globals.autoFlow ? "ON" : "OFF") );
		}
		
		private static function carveTunnel():void
		{
//			Globals.g_landscapeTaskController.activeTaskLimit = 0;
			if ( !Globals.selectedModel ) {
				Log.out( "ConsoleCommands.carveTunnel  No model selected" );
				return;
			}
			
			if ( !Globals.selectedModel.instanceInfo ) {
				Log.out( "ConsoleCommands.carveTunnel  No instanceInfo for selected model" );
				return;
			}

			if ( !Globals.g_modelManager._gci ) {
				Log.out( "ConsoleCommands.carveTunnel  No location selected" );
				return;
			}
				
			CarveTunnel.contructor( Globals.selectedModel.instanceInfo.instanceGuid
			                      , Globals.g_modelManager._gci.point
			                      , Globals.g_modelManager.viewVectorNormalizedGet()
			                      , Globals.AIR
			                      , 2048
			                      , 64 );
		}
		
		private static function carveTunnels():void
		{
//			Globals.g_landscapeTaskController.activeTaskLimit = 0;
			if ( !Globals.selectedModel ) {
				Log.out( "ConsoleCommands.CarveTunnels  No model selected" );
				return;
			}
			
			if ( !Globals.selectedModel.instanceInfo ) {
				Log.out( "ConsoleCommands.CarveTunnels  No instanceInfo for selected model" );
				return;
			}

			if ( !Globals.g_modelManager._gci ) {
				Log.out( "ConsoleCommands.CarveTunnels  No location selected" );
				return;
			}
				
			CarveTunnels.contructor( Globals.selectedModel.instanceInfo.instanceGuid
								   , Globals.g_modelManager._gci.point
								   , Globals.g_modelManager.viewVectorNormalizedGet()
								   , Globals.AIR
								   , 2048
								   , 64 );
		}
		
		import flash.geom.Vector3D;
		private static function carveSphere():void
		{
//			Globals.g_landscapeTaskController.activeTaskLimit = 0;
			if ( !Globals.selectedModel ) {
				Log.out( "ConsoleCommands.carveTunnel  No model selected" );
				return;
			}
			
			if ( !Globals.selectedModel.instanceInfo ) {
				Log.out( "ConsoleCommands.carveTunnel  No instanceInfo for selected model" );
				return;
			}

			if ( !Globals.g_modelManager._gci ) {
				Log.out( "ConsoleCommands.carveTunnel  No location selected" );
				return;
			}
				
			var loc:Vector3D = Globals.g_modelManager._gci.point;
			Globals.selectedModel.oxel.write_sphere( Globals.selectedModel.instanceInfo.instanceGuid
			                                       , loc.x
												   , loc.y
												   , loc.z
												   , 16
												   , Globals.AIR
												   , 2 );
		}
		
		public static function addCommands():void
		{
			DConsole.createCommand( "reset", reset );
			DConsole.createCommand( "gravity", gravity );
			DConsole.createCommand( "collide", collide );
			DConsole.createCommand( "trail", trail );
			DConsole.createCommand( "trees", trees );
			DConsole.createCommand( "tree", tree );
			DConsole.createCommand( "sand", sand );
			DConsole.createCommand( "vines", vines );
			DConsole.createCommand( "lightingReset", lightingReset );
			DConsole.createCommand( "sun", lightingSun );
			DConsole.createCommand( "harvestTrees", harvestTrees );
			DConsole.createCommand( "markers", markers );
			DConsole.createCommand( "flow", flow );
			DConsole.createCommand( "carveTunnel", carveTunnel );
			DConsole.createCommand( "carveSphere", carveSphere );
		}
	}
}