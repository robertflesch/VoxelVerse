/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.biomes
{
	
	import com.voxelengine.worldmodel.tasks.landscapetasks.*;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;

	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.groups.TaskGroup;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class Biomes
	{
		private var _createHeightMap:Boolean = false; // NOT USED
		private var _layers:Vector.<LayerInfo> = new Vector.<LayerInfo>;

		// getters/setters
		public function isEmpty():Boolean { return 0 == _layers.length; }
		public function get layers():Vector.<LayerInfo> { return _layers; }
		
		public function Biomes( createHeightMap:Boolean = false ) {
			// This allows me to use heightmap larger then a single region
			_createHeightMap = createHeightMap;
		}
		
		public function clone():Biomes
		{
			var newBiomes:Biomes = new Biomes( _createHeightMap );
			for each ( var layer:LayerInfo in _layers )
				newBiomes.add_layer( layer.clone() );
				
			return newBiomes;	
		}
		
		public function add_to_task_controller( instanceInfo:InstanceInfo ):void 
		{
			// land task controller
			Globals.g_landscapeTaskController.activeTaskLimit = 0;
			var guid:String = instanceInfo.instanceGuid;

			// Create task group
			var taskGroup:TaskGroup = new TaskGroup("Generate Model for " + guid, 2);
        
			// This loads the tasks into the LandscapeTaskQueue
			var task:ITask = null;
			for each ( var layer:LayerInfo in layers ) 
			{
				// instanceInfo can override type
				if ( -1 != instanceInfo.type )
					layer.type = instanceInfo.type;
					
				task = new layer.task( guid, layer );
				//Log.out( "Biomes.add_to_task_controller - creating task: " + layer.task );
				taskGroup.addTask(task);
				task = null;
			}

			//task =  new OutlineBoundries( guid, null );
			//taskGroup.addTask(task);
			
			//Log.out( "Biomes.add_to_task_controller - adding completedTask" );
			if ( instanceInfo.dynamicObject )
				task = new DynamicCompletedModel( guid, null );
			else
				task = new CompletedModel( guid, null );
			taskGroup.addTask(task);
			
			Globals.g_landscapeTaskController.addTask( taskGroup );
		}
		
		public function addParticleTaskToController( $vm:VoxelModel ):void 
		{
			Globals.g_landscapeTaskController.activeTaskLimit = 0;
			var guid:String = $vm.instanceInfo.instanceGuid;

			// Create task group
			var taskGroup:TaskGroup = new TaskGroup("addParticleTaskToController: " + guid, 15);
			// This loads the tasks into the LandscapeTaskQueue
			var task:ITask = new ParticleLoadingTask( $vm );
			taskGroup.addTask(task);
			
			Globals.g_landscapeTaskController.addTask( taskGroup );
		}

		
		public function	load_biomes_data( layers:Object):void
		{
			for each ( var layerObject:Object in layers )
			{
				if ( layerObject )
				{
					//var layer:Object = layerObject.layer;
					var layerInfo:LayerInfo = new LayerInfo();
					layerInfo.initJSON( layerObject );	
					add_layer( layerInfo );
					//Log.out( "Biomes.load_biomes_data - layer data: " + layerInfo.toString() );
				}
			}
		}
		
		public function add_layer( li:LayerInfo ):void
		{
			_layers.push( li );
		}
		
		public function layerReset():void
		{
			for each ( var li:LayerInfo in _layers )
				li = null;
				
			_layers = new Vector.<LayerInfo>;
			_createHeightMap = false;
		}

		public static function sky( biomes:Biomes ):void 
		{
			biomes.add_layer( new LayerInfo( "LoadSky", "",  Globals.INVALID, 0, 0 ) );
		}

		public static function testSphere( biomes:Biomes ):void 
		{
			biomes.add_layer( new LayerInfo( "TestSphere", "",  Globals.DIRT, 7, 0 ) );
		}
		
		public static function testQuarterSphere( biomes:Biomes ):void 
		{
			biomes.add_layer( new LayerInfo( "TestQuarterSphere", "",  Globals.STONE, 8, 0 ) );
		}
		
		public static function testDebugMacro( biomes:Biomes ):void {
			biomes.add_layer( new LayerInfo( "TestDebugMacro", "",  Globals.GRASS,   4, 0 ) );
		}
		
		public static function testSolid( biomes:Biomes ):void {
			//biomes.add_layer( new LayerInfo( TestSingleOxelFaces,  Globals.GRASS,   1, 0 ) );
			biomes.add_layer( new LayerInfo( "TestSolid", "",  Globals.GRAVEL,   1, 0 ) );
			//biomes.add_layer( new LayerInfo( TestRemoveSequential,  Globals.INVALID,   0, 0 ) );
		}
		
		public static function testGrain0inCorner( biomes:Biomes ):void {
			biomes.add_layer( new LayerInfo( "TestGrain0inCorner", "",  Globals.STONE,   0, 0 ) );
		}
		
		public static function testZBuffer( biomes:Biomes ):void {
			biomes.add_layer( new LayerInfo( "TestZBuffer",  "", Globals.BARK,   100, Globals.SAND ) );
		}
	}
	
}