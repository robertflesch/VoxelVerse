/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.oxel.GrainCursorIntersection;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	import flash.utils.ByteArray;
	import flash.display3D.Context3D;
	
	import mx.utils.StringUtil;
	
	import com.voxelengine.server.Persistance;
	import playerio.PlayerIOError;
		
	
	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.groups.TaskGroup;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.pools.*;
	import com.voxelengine.utils.CustomURLLoader;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.worldmodel.tasks.landscapetasks.CompletedModel;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LoadModelFromBigDB;
	
	/**
	 * ...
	 * @author Bob
	 */
	public class ModelManager 
	{
		static public const FRONT:int = 0;
		static public const BACK:int = 1;
		static public const LEFT:int = 2;
		static public const RIGHT:int = 3;
		static public const UP:int = 4;
		static public const DOWN:int = 5;
		// these are the active parent objects or dynamic objects
		private var _modelInstances:Dictionary = new Dictionary(true);
		
		private var _modelDynamicInstances:Dictionary = new Dictionary(true);
		
		// this acts as a holding spot for all models in game
		// whether they are parent OR child models
		private var _instanceDictionary:Dictionary = new Dictionary(true);
		
		// holds the byte data for models loaded from hard drive.
		private var _modelByteArrays:Dictionary = new Dictionary(true);
		
		// the model mjson for an model guid
		private var _modelInfo:Dictionary = new Dictionary(true);
		
		// objects that are waiting on model data to load
		private var _blocks:Dictionary = new Dictionary(true);
		
		// temporary reference to last model from by find closest model function
		private var _lastFoundModel:VoxelModel = null;
		
		private const EDIT_RANGE:int = 250;
		private var _viewDistances:Vector.<Vector3D> = null;
		
		public const MODEL_MANAGER_MODEL_EXT:String = ".mjson";

		public function modelInstancesGetDictionary():Dictionary { return _modelInstances; }
		public function modelInfoGetDictionary():Dictionary { return _modelInfo; }
		public function modelInfoGet( fileName:String ):ModelInfo {
			var mi:ModelInfo = _modelInfo[fileName]
			if ( mi )
			{
				// All guid based object are unique by definition. so no need to clone them.
				// Non guid based objects are templates, so copies of templates require a clone
				if ( Globals.isGuid(fileName) )
					return mi;
				else	
					return mi.clone( fileName );
			}
			else
				return null;
		}
		public function modelInfoAdd( modelInfo:ModelInfo ):void  { _modelInfo[modelInfo.fileName] = modelInfo; }
		public function get modelByteArrays():Dictionary { return _modelByteArrays; }
		
		public function get worldSpaceStartPoint():Vector3D 
		{
			return _worldSpaceStartPoint;
		}
		
		public function instanceInfoAdd(val:InstanceInfo):void  {  _instanceDictionary[val.instanceGuid] = val; }
		public function instanceInfoGet( instanceGuid:String ):InstanceInfo  {  return _instanceDictionary[instanceGuid]; }
		
		public function ModelManager() {
			_viewDistances = new Vector.<Vector3D>(6); 
			_viewDistances[FRONT] = new Vector3D(0, 0, -1);
			_viewDistances[BACK] = new Vector3D(0, 0, 1);
			_viewDistances[LEFT] = new Vector3D(-1, 0, 0);
			_viewDistances[RIGHT] = new Vector3D(1, 0, 0);
			_viewDistances[UP] = new Vector3D(0, 1, 0);
			_viewDistances[DOWN] = new Vector3D(0, -1, 0);
		}
		
		public function modelInstancesGet( instanceGuid:String ):VoxelModel { 
			var vm:VoxelModel = _modelInstances[instanceGuid];
			if ( vm )
				return vm;
			
			vm = _modelDynamicInstances[instanceGuid];
			
			return vm;
		}
		
		public function modelInstancesGetFirst():VoxelModel { 
			for each ( var vm:VoxelModel in _modelInstances )
				return vm;

			return null;
		}

		public function addIVM( fileName:String, ba:ByteArray ):void {
			//Log.out( "ModelManager.addIVM: " + fileName );
			_modelByteArrays[fileName] = ba;
		}
		
		public function findIVM( fileName:String ):ByteArray {
			var ba:ByteArray = _modelByteArrays[fileName];
			if ( ba )
			{
				ba.position = 0;
				return ba;
			}
			else {
				
				for (var k:Object in _modelByteArrays)
				{
					var key:String  = k as String;
					var index:int = key.indexOf( fileName, 0 );
					if ( -1 != index )
						return _modelByteArrays[k];
				}
				
			}
			return null;
		}
		
		public function create( instance:InstanceInfo ):void {
			//Log.out( "ModelManager.create: instance.templateName" + instance.templateName )
			instanceInfoAdd( instance );
			
			if ( !Globals.isGuid( instance.templateName ) && instance.templateName != "LoadModelFromBigDB" )
			{
				var modelInfo:ModelInfo = modelInfoFindOrCreate( instance.templateName, instance.instanceGuid );
				if ( modelInfo )
				{
					instantiate( instance, modelInfo );
				}		
			}
			else
			{
				// land task controller, this tells task controller not to run until it is done loading all tasks
				Globals.g_landscapeTaskController.activeTaskLimit = 0;
				// Create task group
				var taskGroup:TaskGroup = new TaskGroup("Download Model for " + instance.instanceGuid, 2);
			
				// This loads the tasks into the LandscapeTaskQueue
				//var layer:LayerInfo = new LayerInfo( "LoadModelFromBigDB", instance.instanceGuid ); 
				var task:ITask = new LoadModelFromBigDB( instance.instanceGuid );
				taskGroup.addTask(task);
				
				task = new CompletedModel( instance.instanceGuid, null );
				taskGroup.addTask(task);
				
				Globals.g_landscapeTaskController.addTask( taskGroup );
			}
		}
		
		private function addBlock( instanceGuid:String, fileName:String ):void {
			//Log.out( "ModelManager.addBlock - instanceGIUD: " + instanceGuid + "  fileName: " + fileName );
			if ( _blocks[fileName] )
			{
				var block:Vector.<String> = _blocks[fileName];
				// check to make sure its not in more then once
				for each ( var guid:String in block )
				{
					if ( guid == instanceGuid )
						return;
				}
				block.push( instanceGuid );
			}
			else
			{
				var newBlock:Vector.<String> = new Vector.<String>;
				newBlock.push( instanceGuid );
				_blocks[fileName] = newBlock;
			}
		}
		
		public function clearBlock( fileName:String, error:Boolean = false ):void {
			//Log.out( "ModelManager.clearBlock " + fileName  );
			if ( _blocks[fileName] )
			{
				var block:Vector.<String> = _blocks[fileName];
				if ( !error )
				{
					var instanceInfo:InstanceInfo = null;
					for each ( var instanceGuid:String in block )
					{
						instanceInfo = instanceInfoGet( instanceGuid );
						//Log.out( "CLEAR BLOCK " + instanceInfo.toString() + " for guid: " + instanceGuid  );
						if ( instanceInfo )
						{
							//Log.out( "CLEAR BLOCK " + instanceInfo.toString()  );
							instantiate( instanceInfo, modelInfoGet(fileName) );
						}
					}
				}
				// TODO This should create a new _blocks that doesnt include the fileName, rather then it being null
				// but whats the saving vs creating new memory...
				_blocks[fileName] = null;
			}
			//else
			//{
				//Log.out( "ModelManager.clearBlock - ERROR - didnt find fileName: " + fileName, Log.ERROR );
				//Log.out("---------- List of object bank -------------", Log.ERROR );
				//for (var k:Object in _blocks)
				  //Log.out("fileName: " + k + "\t\t  InstanceGuid: "+ _blocks[k] );
				//Log.out("---------- End List of object bank -------------", Log.ERROR );
				//Log.out( "ModelManager.clearBlock - end Dictionary listing - NOTE makes sure CASE is the same", Log.ERROR );
			//}
		}
		
		private function instantiate( $instanceInfo:InstanceInfo, $modelInfo:ModelInfo ):void {
			if ( !$instanceInfo )
				throw new Error( "ModelManager.instantiate - InstanceInfo null" );
				
			var modelAsset:String = $modelInfo.modelClass;
			var modelClass:Class = ModelLibrary.getAsset( modelAsset )
			var vm:* = new modelClass( $instanceInfo, $modelInfo );
			if ( null == vm )
				throw new Error( "ModelManager.instantiate - Model failed in creation - modelClass: " + modelClass );
			
			
			//Log.out( "ModelManager.instantiate - modelClass: " + modelClass + "  instanceInfo: " + $instanceInfo.toString() );
			modelAdd( vm );
		}
		
		// Models removed this way are not dead, just no longer part of the parent model loop
		public function changeFromParentToChild( $vm:VoxelModel ):void {
			var found:Boolean = false;
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm && $vm == vm )
				{
					_modelInstances[$vm.instanceInfo.instanceGuid] = null;
					found = true;
					break;
				}
			}
			
			if ( found )
				_modelInstances = clearDictionaryOfNullsAndDead( _modelInstances );
		}
		
		public function modelAdd( vm:VoxelModel ):void {
			// if this is a child model, give it to parent, 
			// next check to see if its a dynamic model
			//otherwise add it to modelmanager list.
			if ( vm.instanceInfo.controllingModel )
			{
				vm.instanceInfo.controllingModel.childAdd( vm );
				Globals.g_app.dispatchEvent( new ModelEvent( ModelEvent.CHILD_MODEL_ADDED, vm.instanceInfo.instanceGuid, null, null, vm.instanceInfo.controllingModel.instanceInfo.instanceGuid ) );
			}
			else if ( vm.instanceInfo.dynamicObject )
			{
				_modelDynamicInstances[vm.instanceInfo.instanceGuid] = vm;
				Globals.g_app.dispatchEvent( new ModelEvent( ModelEvent.DYNAMIC_MODEL_ADDED, vm.instanceInfo.instanceGuid ) );
			}
			else
			{
				_modelInstances[vm.instanceInfo.instanceGuid] = vm;
				Globals.g_app.dispatchEvent( new ModelEvent( ModelEvent.PARENT_MODEL_ADDED, vm.instanceInfo.instanceGuid ) );
				//Log.out( "ModelManager.instantiate - Parent Model Addd" );
			}
		}

		public function addToTaskController( fileName:String ):void {
			// land task controller
			Globals.g_landscapeTaskController.activeTaskLimit = 0;
			// Create task group
			var taskGroup:TaskGroup = new TaskGroup("Generate Model for " + fileName, 2);
        
			// This loads the tasks into the LandscapeTaskQueue
			var task:ITask = new LoadModelFromBigDB( fileName );
			taskGroup.addTask(task);
			task = null;
			task = new CompletedModel( fileName, null );
			Log.out( "ModelManager.add_to_task_controller - adding completedTask" );
			taskGroup.addTask(task);
			
			Globals.g_landscapeTaskController.addTask( taskGroup );
			
			if ( 0 == Globals.g_landscapeTaskController.activeTaskLimit )
				Globals.g_landscapeTaskController.activeTaskLimit = 1;
		}
		
		// If we want to preload the modelInfo, we dont need to block on it
		public function modelInfoPreload( fileName:String ):void {
			modelInfoFindOrCreate( fileName, "", false );
		}
		
		public function modelInfoFindOrCreate( $fileName:String, instanceGuid:String, block:Boolean = true ):ModelInfo {
			var modelInfo:ModelInfo = modelInfoGet( $fileName );
			
			if ( null == $fileName )
			{
				Log.out( "ModelManager.modelInfoFindOrCreate - ERROR fileName is NULL", Log.ERROR );
			}
			
			// if no model info found, we have to load a copy
			if ( !modelInfo )
			{
				// if we are already waiting for a copy to load, then add a block if shouldBlock is true, else add a loader.
				if ( !_blocks[$fileName] )
				{
					var fileName:String = $fileName + MODEL_MANAGER_MODEL_EXT
					//Log.out( "ModelManager.modelInfoFindOrCreate - loading: " + Globals.appPath + modelNameAndLoc );
					var request:URLRequest = new URLRequest( Globals.modelPath + fileName );
					var loader:CustomURLLoader = new CustomURLLoader(request);
					loader.addEventListener(Event.COMPLETE, onModelLoadedAction);
					loader.addEventListener(IOErrorEvent.IO_ERROR, onModelLoadErrorAction);
				}
				// If we want to preload the modelInfo, we dont need to block on it
				if ( block )
					addBlock( instanceGuid, $fileName );
			}
			
			return modelInfo;
		}
		
		public function onModelLoadErrorAction(event:IOErrorEvent):void {
			var req:URLRequest = CustomURLLoader(event.target).request;			
			var fileName:String = CustomURLLoader(event.target).fileName;			
			clearBlock( fileName );
			Log.out("----------------------------------------------------------------------------------", Log.ERROR );
			Log.out("ModelManager.onModelLoadErrorAction: ERROR LOADING MODEL: " + event.text, Log.ERROR );
			Log.out("----------------------------------------------------------------------------------", Log.ERROR );
		}	
			
		public function onModelLoadedAction(event:Event):void {
			var req:URLRequest = CustomURLLoader(event.target).request;			
//Log.out("ModelManager.onModelLoadedAction - requested: " + req.url );
			var fileName:String = CustomURLLoader(event.target).fileName;			
			
			var fileData:String = String(event.target.data);
			var jsonString:String = StringUtil.trim(fileData);
			//Log.out("ModelManager.onModelLoadedAction - loaded model from: " + event.target.data );
			try {
				var jsonResult:Object = JSON.parse(jsonString);
			}
			catch ( error:Error )
			{
				Log.out("----------------------------------------------------------------------------------" );
				Log.out("ModelManager.onModelLoadedAction - ERROR PARSING: " + fileData, Log.ERROR );
				Log.out("----------------------------------------------------------------------------------" );
				return;
			}
			var mi:ModelInfo = new ModelInfo();
			var fileNameNoExt:String = ModelManager.stripExtension( fileName );
			mi.init( fileNameNoExt, jsonResult );
			modelInfoAdd( mi );
			//Log.out("ModelManager.onModelLoadedAction - loaded model guid: " + mi.guid + MODEL_MANAGER_MODEL_EXT );

			var dotLoc:int = fileName.lastIndexOf( "." );
			fileName = fileName.substr( 0, dotLoc );
			
			clearBlock( fileName );
			Globals.g_app.dispatchEvent( new ModelEvent( ModelEvent.INFO_LOADED, fileName ) );
		}       
		
		public function save():void {
			// check all models to see if they have changed, if so save them to server.
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm.modified )
				{
					Log.out( "ModelManager.save - save changes to model: " + vm.instanceInfo.templateName );
					vm.save();
				}
				else
					Log.out( "ModelManager.save - NOT save model, unmodified: " + vm.instanceInfo.templateName );

			}
		}
		
		static private function stripExtension( fileName:String ):String {
			return fileName.substr( 0, fileName.indexOf( "." ) );
		}

		public function markDead( instanceGuid:String ):void {
			// This works on both dyamanic and regular instances
			var vm:VoxelModel = modelInstancesGet(instanceGuid);
			if ( vm )
			{
				Globals.g_app.dispatchEvent( new ModelEvent( ModelEvent.PARENT_MODEL_REMOVED, vm.instanceInfo.instanceGuid ) );
				vm.instanceInfo.dead = true;
			}
		}

		public function bringOutYourDeadDynamic():void {
			var hasDead:Boolean = false;
			for each ( var vm:VoxelModel in _modelDynamicInstances )
			{
				if ( vm && true == vm.instanceInfo.dead )
				{
					hasDead = true;
					break;
				}
			}
			
			if ( hasDead )
			{
				_modelDynamicInstances = clearDictionaryOfNullsAndDead( _modelDynamicInstances );
			}
		}
			
		public function bringOutYourDead():void {
			var hasDead:Boolean = false;
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm && true == vm.instanceInfo.dead )
				{
					hasDead = true;
					vm.removeFromBigDB();
					break;
				}
			}
			
			if ( hasDead )
			{
				_modelInstances = clearDictionaryOfNullsAndDead( _modelInstances );
				_instanceDictionary = clearInstanceInfoOfNullsAndDead( _instanceDictionary );
			}
		}
		
		private function clearInstanceInfoOfNullsAndDead( oldDic:Dictionary ):Dictionary {
			var tempDic:Dictionary = new Dictionary(true);
			for each ( var instance:InstanceInfo in oldDic )
			{
				if ( instance && true == instance.dead )
				{
					var oldGuid:String = instance.instanceGuid;
					instance = null;
					oldDic[oldGuid] = null;
				}
				else
				{
					tempDic[instance.instanceGuid] = instance;
				}
			}
			oldDic = null;
			return tempDic;
		}
		
		private function countDict( oldDic:Dictionary ):int {
			var count:int = 0;
			for each ( var instance:InstanceInfo in oldDic )
			{
				count++;
			}
			
			return count;
		}

		private function clearDictionaryOfNullsAndDead( oldDic:Dictionary ):Dictionary {
			var tempDic:Dictionary = new Dictionary(true);
			for each ( var instance:VoxelModel in oldDic )
			{
				// If its marked dead release it
				if ( instance && true == instance.instanceInfo.dead )
				{
					oldDic[instance.instanceInfo.instanceGuid] = null;
					instance.release();
					// could I just use a delete here, rather then creating new dictionary? See Dictionary class for details - RSF
				}
				else
				{
					if ( instance )
						tempDic[instance.instanceInfo.instanceGuid] = instance;
					else
						Log.out( "clearDictionaryOfNullsAndDead - Null found" );
				}
			}
			oldDic = null;
			return tempDic;
		}
		
		public function getModelInstance( instanceGuid:String ):VoxelModel {
			var vm:VoxelModel = modelInstancesGet(instanceGuid);
			
			if ( !vm )
			{
				var ii:InstanceInfo = instanceInfoGet( instanceGuid );
				if ( ii )
				{
					var parentModel:VoxelModel = ii.controllingModel;
					if ( parentModel )
						vm = parentModel.childModelFind( instanceGuid );
					else
					{
						return Globals.player;
						//Log.out("ModelManager.getModelInstance - parent model not found: " + instanceGuid, Log.ERROR );	
					}
				}
				else
					Log.out("ModelManager.getModelInstance - model not found: " + instanceGuid, Log.ERROR );	
			}
				
			return vm;	
		}
			
		public function draw( $mvp:Matrix3D, $context:Context3D ):void {
			
			// TODO Could optimize here by only making the calls needed for this shader.
			// Since only one shader is used for each, this could save a LOT OF TIME for large number of models.
			for each ( var instance:VoxelModel in _modelInstances )
			{
				if ( instance && instance.complete && instance.visible )
					instance.draw( $mvp, $context, false );	
			}
			
			// TODO - should sort models based on distance, and view frustrum - RSF
			for each ( var instanceDyn:VoxelModel in _modelDynamicInstances )
			{
				if ( instanceDyn && instanceDyn.complete && instanceDyn.visible )
					instanceDyn.draw( $mvp, $context, false );	
			}
			
			for each ( var instanceAlpha:VoxelModel in _modelInstances )
			{
				if ( instanceAlpha && instanceAlpha.complete && instanceAlpha.visible )
					instanceAlpha.drawAlpha( $mvp, $context, false );	
			}
			
			// TODO - This is expensive and not needed if I dont have projectiles without alpha.. RSF
			for each ( var instanceDynAlpha:VoxelModel in _modelDynamicInstances )
			{
				if ( instanceDynAlpha && instanceDynAlpha.complete && instanceDynAlpha.visible )
					instanceDynAlpha.drawAlpha( $mvp, $context, false );	
			}
			
			bringOutYourDead();
			bringOutYourDeadDynamic();
		}
			
		public function updateFileName( $newFileName:String, $oldFileName:String ):ModelInfo {
			var modelInfo:ModelInfo = _modelInfo[ $oldFileName ];
			if ( !modelInfo )
				throw new Error( "ModelManager.updatefileName - modelInfo not found for: " + $oldFileName );
			
			var newModelInfo:ModelInfo = modelInfo.clone($newFileName);
			_modelInfo[$newFileName] = newModelInfo;
			return newModelInfo;
		}
		
		private static const PLAYER_ID:String = "PLAYER_ID";
		public function createPlayer():void	{
			
			//private static var g_player:Player = null;			
			//Log.out("ModelManager.createPlayer" );
			var instanceInfo:InstanceInfo = new InstanceInfo();
			instanceInfo.instanceGuid = PLAYER_ID;
			instanceInfo.templateName = "Player"
			instanceInfo.grainSize = 4;
			
			Globals.g_modelManager.create( instanceInfo );
		}
		
		public function update( $elapsedTimeMS:int ):void {
			
			worldSpaceStartAndEndPointCalculate();
			
			// Make sure to call this before the model update, so that models have time to repair them selves.
			if ( 0 == Globals.g_landscapeTaskController.VVNextTask() )
			{
				Globals.g_flowTaskController.VVNextTask();
				//while ( 0 < Globals.g_lightTaskController.queueSize() )
					Globals.g_lightTaskController.VVNextTask();
			}

			if ( Globals.g_app.toolOrBlockEnabled )
				highLightEditableOxel();

			for each ( var instanceDyn:VoxelModel in _modelDynamicInstances )
			{
				instanceDyn.update( Globals.g_renderer.context,  $elapsedTimeMS );	
			}
			
			for each ( var instance:VoxelModel in _modelInstances )
			{
				instance.update( Globals.g_renderer.context, $elapsedTimeMS );	
			}
		}
		
		public function dispose():void 	{
			Log.out("ModelManager.dispose" );
			Globals.g_textureBank.dispose();
			
			for each ( var dm:VoxelModel in _modelDynamicInstances )
			{
				dm.dispose();
			}
			
			for each ( var vm:VoxelModel in _modelInstances )
			{
				vm.dispose();	
			}
		}
		
		public function reinitialize( $context:Context3D ):void 	{
			
			//Log.out("ModelManager.reinitialize" );
			Globals.g_textureBank.reinitialize( $context );
			
			for each ( var dm:VoxelModel in _modelDynamicInstances )
			{
				dm.reinitialize( $context );
			}
			
			for each ( var vm:VoxelModel in _modelInstances )
			{
				vm.reinitialize( $context );	
			}
		}
		
		private function sortIntersectionsGeneral( pointModel1:Object, pointModel2:Object ):Number	{
			var point1Rel:Number = _worldSpaceStartPoint.subtract( pointModel1.point ).length;
			var point2Rel:Number = _worldSpaceStartPoint.subtract( pointModel2.point ).length;
			if ( point1Rel < point2Rel )
				return -1;
			else if ( point1Rel > point2Rel ) 
				return 1;
			else 
				return 0;			
		}
		
		private function sortIntersections( pointModel1:GrainCursorIntersection, pointModel2:GrainCursorIntersection ):Number {
			var point1Rel:Number = _worldSpaceStartPoint.subtract( pointModel1.point ).length;
			var point2Rel:Number = _worldSpaceStartPoint.subtract( pointModel2.point ).length;
			if ( point1Rel < point2Rel )
				return -1;
			else if ( point1Rel > point2Rel ) 
				return 1;
			else 
				return 0;			
		}

		private var _totalIntersections:Vector.<GrainCursorIntersection> = new Vector.<GrainCursorIntersection>();
		private var _worldSpaceIntersections:Vector.<GrainCursorIntersection> = new Vector.<GrainCursorIntersection>();
		private var _worldSpaceStartPoint:Vector3D;
		private var _worldSpaceEndPoint:Vector3D;
		
		public function getViewVectorNormalized():Vector3D {
			var newV:Vector3D = _worldSpaceEndPoint.subtract( _worldSpaceStartPoint );
			newV.normalize();
			return newV;
		}
		
		public function highLightEditableOxel():void {
			if ( !Globals.controlledModel )
				return;
			
			_totalIntersections.length = 0;
			_worldSpaceIntersections.length = 0;
			
			// We should only use the models in the view frustrum - TODO - RSF
			var editableModel:VoxelModel = findEditableModel();
			_totalIntersections.length = 0;
			_worldSpaceIntersections.length = 0;
			if ( editableModel )
			{
				if ( _lastFoundModel != editableModel && _lastFoundModel )
					_lastFoundModel.editCursor.visible = false;	
				
				Globals.selectedModel = editableModel;
				
				if ( Globals.g_app.editing && editableModel.editCursor )
				{
					const minSize:int = editableModel.editCursor.oxel.gc.grain;
					
					editableModel.lineIntersectWithChildren( _worldSpaceStartPoint, _worldSpaceEndPoint, _worldSpaceIntersections, minSize )
						
					for each ( var gcIntersection:GrainCursorIntersection in _worldSpaceIntersections )
					{
						gcIntersection.model = editableModel;
						_totalIntersections.push( gcIntersection );
					}
					_totalIntersections.sort( sortIntersections );

					var gci:GrainCursorIntersection = _totalIntersections.shift();
					/////////////////////////////////////////
					if ( gci )
					{
						gci.point = editableModel.worldToModel( gci.point );
						editableModel.editCursor.setGCIData( gci );
					}
					else	
					{
						editableModel.editCursor.visible = false;	
						editableModel.editCursor.clearGCIData();
					}
					_lastFoundModel = editableModel;
				}
			}
			totalIntersectionsClear();
			worldSpaceIntersectionsClear()
		}
		
		public function findClosestIntersectionInDirection( $dir:int = UP ):GrainCursorIntersection	{
			if ( !Globals.controlledModel )
				return null;
			
			worldSpaceStartAndEndPointCalculate( $dir );
			
			// We should only use the models in the view frustrum - TODO - RSF
			var vm:VoxelModel = findEditableModel();
			if ( vm )
			{
				const minSize:int = 2; // TODO pass this in?
				vm.lineIntersectWithChildren( _worldSpaceStartPoint, _worldSpaceEndPoint, _worldSpaceIntersections, minSize )
					
				for each ( var gcIntersection:GrainCursorIntersection in _worldSpaceIntersections )
				{
					gcIntersection.model = vm;
					_totalIntersections.push( gcIntersection );
				}
				_totalIntersections.sort( sortIntersections );

				var gci:GrainCursorIntersection = _totalIntersections.shift();
			}
			totalIntersectionsClear();
			worldSpaceIntersectionsClear()
			
			return gci;
		}

		private	function findEditableModel():VoxelModel {
			var foundModel:VoxelModel = null;
			var intersections:Vector.<GrainCursorIntersection> = findRayIntersections();
			var intersection:GrainCursorIntersection = intersections.shift();
			if ( intersection && intersection.point.length )
			{
				//if ( intersection.point.length < EDIT_RANGE )
					foundModel = intersection.model;
				//else
				//	trace( "out of range" );
			}
			
			if ( null == foundModel && null != _lastFoundModel )
			{
				_lastFoundModel.editCursor.visible = false;
				_lastFoundModel	= null;
			}
			
			return foundModel;
		}

		
		private var _cameraMatrix:Matrix3D = new Matrix3D();
		public	function worldSpaceStartAndEndPointCalculate( $direction:int = FRONT, $editRange:int = EDIT_RANGE ):void {
/*
			var cm:VoxelModel = Globals.controlledModel;
			var wsPositionCamera:Vector3D = cm.instanceInfo.worldSpaceMatrix.transformVector( cm.camera.current.position );
			
			// Empty starting matrix
			_cameraMatrix.identity();
			
			const cmRotation:Vector3D = cm.camera.rotationGet;
			_cameraMatrix.prependRotation( -cmRotation.x, Vector3D.X_AXIS );
			_cameraMatrix.prependRotation( -cmRotation.y, Vector3D.Y_AXIS );
			_cameraMatrix.prependRotation( -cmRotation.z, Vector3D.Z_AXIS );

			// the position of the controlled model
 			_cameraMatrix.prependTranslation( wsPositionCamera.x, wsPositionCamera.y, wsPositionCamera.z ); 
			
			var viewDistance:Vector3D = _viewDistances[$direction].clone();
			viewDistance.scaleBy( $editRange );
			
			_worldSpaceStartPoint = wsPositionCamera;
			_worldSpaceEndPoint = _cameraMatrix.transformVector( viewDistance );
			*/
			/*
			var cm:VoxelModel = Globals.controlledModel;
			_cameraMatrix = cm.instanceInfo.worldSpaceMatrix.clone();
			var msCamPos:Vector3D = cm.camera.current.position;
			const cmRotation:Vector3D = cm.camera.rotationGet;
			//_cameraMatrix.appendRotation( -cmRotation.x, Vector3D.X_AXIS );
			_cameraMatrix.prependRotation( -cmRotation.x, Vector3D.X_AXIS );
			//_cameraMatrix.prependRotation( -cmRotation.y, Vector3D.Y_AXIS );
			_cameraMatrix.prependRotation( -cmRotation.z, Vector3D.Z_AXIS );

			_worldSpaceStartPoint = _cameraMatrix.transformVector( msCamPos );
			var viewDistance:Vector3D = _viewDistances[$direction].clone();
			viewDistance.scaleBy( $editRange );
			msCamPos = msCamPos.add( viewDistance );
			_worldSpaceEndPoint = _cameraMatrix.transformVector( msCamPos );
			*/
			
			//////////////////////////////////////
			// This works for camera at 0,0,0
			//////////////////////////////////////
			// Empty starting matrix
			var cm:VoxelModel = Globals.controlledModel;
			if ( cm )
			{
				
				_cameraMatrix.identity();
				
				const cmRotation:Vector3D = cm.camera.rotationGet;
				_cameraMatrix.prependRotation( -cmRotation.x, Vector3D.X_AXIS );
				//_cameraMatrix.prependRotation( -cmRotation.y, Vector3D.Y_AXIS );
				_cameraMatrix.prependRotation( -cmRotation.z, Vector3D.Z_AXIS );
				
				_cameraMatrix.append( cm.instanceInfo.worldSpaceMatrix );
				//var p:Vector3D = cm.instanceInfo.worldSpaceMatrix.position;
				//var p1:Vector3D = cm.instanceInfo.positionGet;
				
				var msCamPos:Vector3D = cm.camera.current.position;
				//_worldSpaceStartPoint = _cameraMatrix.transformVector( msCamPos );
				//trace( "ModelManager.calculate - _worldSpaceStartPoint 1: " + _worldSpaceStartPoint );
				
				// This is ugly...
				_worldSpaceStartPoint = cm.instanceInfo.worldSpaceMatrix.transformVector( msCamPos );
				_worldSpaceStartPoint.y = _cameraMatrix.transformVector( msCamPos ).y;
				//trace( "ModelManager.calculate - _worldSpaceStartPoint 2: " + _worldSpaceStartPoint + " p: " + p + "  p1: " + p1 );
				
				var viewDistance:Vector3D = _viewDistances[$direction].clone();
				viewDistance.scaleBy( $editRange );
				msCamPos = msCamPos.add( viewDistance );
				_worldSpaceEndPoint = _cameraMatrix.transformVector( msCamPos );
			}
			
/*
			var cm:VoxelModel = Globals.controlledModel;
			_worldSpaceStartPoint = cm.instanceInfo.worldSpaceMatrix.transformVector( cm.camera.current.position );
			_cameraMatrix.identity();
			
			//const cmRotation:Vector3D = cm.camera.rotationGet;
			_cameraMatrix.prependRotation( cmRotation.x, Vector3D.X_AXIS );
			_cameraMatrix.prependRotation( cmRotation.y, Vector3D.Y_AXIS );
			_cameraMatrix.prependRotation( cmRotation.z, Vector3D.Z_AXIS );

			// the position of the controlled model
 			_cameraMatrix.prependTranslation( _worldSpaceStartPoint.x, _worldSpaceStartPoint.y, _worldSpaceStartPoint.z ); 
			var viewDistance:Vector3D = _viewDistances[$direction].clone();
			viewDistance.scaleBy( $editRange );
			viewDistance = viewDistance.add( cm.camera.current.position );
			_worldSpaceEndPoint = cm.instanceInfo.worldSpaceMatrix.transformVector( viewDistance );
*/			
		}
		
		private	function worldSpaceIntersectionsClear():void { _worldSpaceIntersections.splice(0, _worldSpaceIntersections.length ); }
		private	function totalIntersectionsClear():void { _totalIntersections.splice(0, _totalIntersections.length ); }
		
		// TODO RSF - If the closest model has a hole in it, that the ray should pass thru
		// it still stops and identifies that as the closest model.
		public function findRayIntersections():Vector.<GrainCursorIntersection> {
			// We should only use the models in the view frustrum - TODO - RSF
			var cm:VoxelModel = Globals.controlledModel;
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm == cm )
					continue;
					
				// finds up to two intersecting planes per model
				if ( vm && vm.complete && vm.modelInfo.editable )
				{
					vm.lineIntersect( _worldSpaceStartPoint, _worldSpaceEndPoint, _worldSpaceIntersections );
				
					for each ( var gcIntersection:GrainCursorIntersection in _worldSpaceIntersections )
						_totalIntersections.push( gcIntersection );
					
					worldSpaceIntersectionsClear()
				}
			}
			
			_totalIntersections.sort( sortIntersections );
			return _totalIntersections;
		}
				
		// Test of basic path routing to sun
		public function pathToSun( startPoint:Vector3D, endPoint:Vector3D ):Vector.<GrainCursorIntersection> {
			// We should only use the models in the view frustrum - TODO - RSF
			_totalIntersections.length = 0;
			_worldSpaceIntersections.length = 0;
			for each ( var vm:VoxelModel in _modelInstances )
			{
				// finds up to two intersecting planes
				if ( vm && vm.complete && vm.modelInfo.editable )
				{
					vm.lineIntersect( startPoint, endPoint, _worldSpaceIntersections );
				}
			}
			
			return _worldSpaceIntersections;
		}

		public function sphereCollideWithModels( $testObject:VoxelModel ):Vector.<VoxelModel> {
			var scenter:Vector3D = $testObject.modelToWorld( $testObject.instanceInfo.center );
			var radius:int = $testObject.oxel.gc.size() / 8; //2
			var collidingModels:Vector.<VoxelModel> = new Vector.<VoxelModel>;
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm && vm.complete && vm != $testObject && vm.instanceInfo.collidable )
				{
					var bmp:Vector3D = vm.worldToModel( scenter );
					if ( vm.doesOxelIntersectSphere( bmp, radius ) )
					{
						collidingModels.push( vm );
					}
				}
			}
			return collidingModels;
		}
		
		public function presetBoundBoxCollide( testModel:VoxelModel ):Boolean {
			var modelList:Vector.<VoxelModel> = whichModelsIsThisInsideOfNew( testModel );
			var result:Boolean = false;
			var cm:VoxelModel = Globals.controlledModel;
			if ( modelList.length )
			{
				for each ( var vm:VoxelModel in modelList )
				{
					var wsCenterPointOfModel:Vector3D = cm.instanceInfo.worldSpaceMatrix.transformVector( cm.camera.current.position );

					var msp:Vector3D = vm.worldToModel( wsCenterPointOfModel );
					// RSF 9.13/13 - Verify that vm.oxel.gc.grain is correct value to pass in.
					result = vm.isPassable( msp.x, msp.y, msp.z, vm.oxel.gc.grain );
					
					// If any result fails, position is invalid, restore last position
					if ( !result )
					{
						testModel.instanceInfo.restoreOld();
						return result;
					}
				}
			}
			return true;
		}

		public function whichModelsIsThisInsideOfNew( vm:VoxelModel ):Vector.<VoxelModel> {
			const numOfCorners:int = 8;
			var points:Vector.<Vector3D> = new Vector.<Vector3D>(numOfCorners, true);
			var scratch:Vector3D = new Vector3D();
			var size:int = vm.oxel.gc.size()
			
			var origin:Vector3D = vm.worldToModel( vm.instanceInfo.positionGet );
			points[0] = vm.modelToWorld( origin );
			scratch.setTo( 0, 0, size );
			points[1] = vm.modelToWorld( origin.add( scratch ) );
			scratch.setTo( 0, size, 0 );
			points[2] = vm.modelToWorld( origin.add( scratch ) );
			scratch.setTo( 0, size, size );
			points[3] = vm.modelToWorld( origin.add( scratch ) );
			scratch.setTo( size, 0, 0 );
			points[4] = vm.modelToWorld( origin.add( scratch ) );
			scratch.setTo( size, 0, size );
			points[5] = vm.modelToWorld( origin.add( scratch ) );
			scratch.setTo( size, size, 0 );
			points[6] = vm.modelToWorld( origin.add( scratch ) );
			scratch.setTo( size, size, size );
			points[7] = vm.modelToWorld( origin.add( scratch ) );

			var modelList:Vector.<VoxelModel> = new Vector.<VoxelModel>;
			var testPoint:Vector3D = null;
			for each ( var instance:VoxelModel in _modelInstances )
			{
				if ( instance && instance.complete && instance != vm )
				{
					for each ( var cpoint:Vector3D in points )
					{
						testPoint = instance.worldToModel( cpoint );
						if ( instance.oxel.gc.containsModelSpacePoint( testPoint ) ) 
						{
							modelList.push( instance );
							break;
						}
					}
				}
			}
			return modelList;
		}
		
		// this version effective scales up models, so you show up inside of them
		// even when you are not physically in the model space. Just close.
		// This allow us to detect edges of models we are approaching
		public function whichModelsIsThisInfluencedBy( vm:VoxelModel ):Vector.<VoxelModel> {
			var worldSpaceStartPointOrigin:Vector3D = vm.instanceInfo.positionGet;
			var worldSpaceStartPointCorner:Vector3D = vm.instanceInfo.positionGet.clone();
			// add size to get corner
			// might want to do all 8 corners if we need to be through
			worldSpaceStartPointCorner.x = worldSpaceStartPointCorner.x + vm.oxel.gc.size();
			worldSpaceStartPointCorner.y = worldSpaceStartPointCorner.y + vm.oxel.gc.size();
			worldSpaceStartPointCorner.z = worldSpaceStartPointCorner.z + vm.oxel.gc.size();

			var modelList:Vector.<VoxelModel> = new Vector.<VoxelModel>;
			for each ( var collideCandidate:VoxelModel in _modelInstances )
			{
				// I suspect there is a way faster way to eliminate models that are far away.
				// TODO - optimize RSF
				if ( collideCandidate && collideCandidate.complete && collideCandidate != vm )
				{
					var sizeOfInstance:Number = collideCandidate.oxel.gc.size();
					var offset:Vector3D = new Vector3D( sizeOfInstance, sizeOfInstance, sizeOfInstance );
					offset.scaleBy( 0.05 );
					
					var mspOrigin:Vector3D = collideCandidate.worldToModel( worldSpaceStartPointOrigin );
					mspOrigin.scaleBy( 0.9 );
					mspOrigin = mspOrigin.add( offset );
//					trace( "whichModelsIsThisInsideOf - mspOrigin: " + mspOrigin );
					
					var mspHead:Vector3D = collideCandidate.worldToModel( worldSpaceStartPointCorner );
					mspHead.scaleBy( 0.9 );
					mspHead = mspHead.add( offset );
					if ( collideCandidate.oxel.gc.containsModelSpacePoint( mspOrigin ) ) 
					{
						modelList.push( collideCandidate );
					}
					else if ( collideCandidate.oxel.gc.containsModelSpacePoint( mspHead ) ) 
					{
						modelList.push( collideCandidate );
					}
				}
			}
			
			return modelList;
		}
		
		// Very similar to above, but does exact match - Not currently used
		public function whichModelsIsThisInsideOf( vm:VoxelModel ):Vector.<VoxelModel> {
			var worldSpaceStartPointOrigin:Vector3D = vm.instanceInfo.positionGet;
			var worldSpaceStartPointCorner:Vector3D = vm.instanceInfo.positionGet.clone();
			// add size to get corner
			worldSpaceStartPointCorner.x = worldSpaceStartPointCorner.x + vm.oxel.gc.size();
			worldSpaceStartPointCorner.y = worldSpaceStartPointCorner.y + vm.oxel.gc.size();
			worldSpaceStartPointCorner.z = worldSpaceStartPointCorner.z + vm.oxel.gc.size();

			var modelList:Vector.<VoxelModel> = new Vector.<VoxelModel>;
			for each ( var collideCandidate:VoxelModel in _modelInstances )
			{
				// I suspect there is a way faster way to eliminate models that are far away.
				// TODO - optimize RSF
				if ( collideCandidate && collideCandidate.complete && collideCandidate != vm )
				{
					var mspOrigin:Vector3D = collideCandidate.worldToModel( worldSpaceStartPointOrigin );
					var mspHead:Vector3D = collideCandidate.worldToModel( worldSpaceStartPointCorner );
					if ( collideCandidate.oxel.gc.containsModelSpacePoint( mspOrigin ) ) 
					{
						modelList.push( collideCandidate );
					}
					else if ( collideCandidate.oxel.gc.containsModelSpacePoint( mspHead ) ) 
					{
						modelList.push( collideCandidate );
					}
				}
			}
			
			return modelList;
		}
		
		flash.geom.Vector3D.prototype.toJSON = function (k:*):* { 
		return {x:this.x, y:this.y, z:this.z};
		} 	

		public function getModelJson( outString:String ):String {
			var count:int = 0;
			for each ( var vm:VoxelModel in _modelInstances )
				count++;
				
			for each ( var instance:VoxelModel in _modelInstances )
			{
				if ( instance )
				{
					outString += instance.getJSON();
					count--;
					// add commas to all but the last model
					if ( count )
						outString += ","
				}
			}
			return outString;
		}
		
		public function removeAllModelInstances():void {
			Log.out( "ModelManager.removeAllModelInstances" );
			// clear out old models
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm )
				{
					trace( "ModelManager.removeAllModelInstances - marking as dead: " + vm.instanceInfo.instanceGuid );
					markDead( vm.instanceInfo.instanceGuid );
				}
			}
			
			_modelInfo = null;
			_modelInfo = new Dictionary();
		}	
		
		public function createInstanceFromTemplate( vm:VoxelModel ):void {
			//if ( vm.modelInfo.template )
			{
	//			var oldGuid:String = vm.instanceInfo.templateName;
				//vm.instanceInfo.fileName = vm.modelInfo.fileName;
				//if ( Globals.MODE_PRIVATE == Globals.mode || Globals.MODE_PUBLIC == Globals.mode )
				//{
				var newLayerInfo:LayerInfo;
				newLayerInfo = new LayerInfo( "LoadModelFromBigDB", vm.instanceInfo.instanceGuid );
				vm.modelInfo.biomes.layerReset();
				vm.modelInfo.biomes.add_layer( newLayerInfo );
					//vm.modelInfo.fileName = "LoadModelFromBigDB";
				vm.modelInfo.jsonReset();
				//}
				//else
				//{
					// Not really sure when this would get called if ever
					//newLayerInfo = new LayerInfo( "LoadModelFromIVM", "./assets/models/" + vm.instanceInfo.instanceGuid );
				//}
				
			}
			//vm.instanceInfo.templateName = "LoadModelFromBigDB";
			vm.modelInfo.template = false;
		}
		
		public function loadRegionObjects( objects:Array ):int {
			var count:int = 0;
			for each ( var v:Object in objects )		   
			{
				var instance:InstanceInfo = new InstanceInfo();
				instance.initJSON( v.model );
				//trace( "ModelManager.loadObjects: ----------------  fileName:" + v.model.fileName );
				
				Log.out( "ModelManager.loadObjects - loading fileName:" + v.model.fileName + "  instance Guid: " + instance.instanceGuid + "  name: " +  instance.name);
				create( instance );
				count++;
			}
			Globals.g_landscapeTaskController.activeTaskLimit = 1;
			return count;
		}
		
		public function loadUserObjects( userName:String, callbackFunction:Function ):void {
			Persistance.loadRange( Persistance.DB_TABLE_OBJECTS
						 , "voxelModelOwner"
						 , [userName]
						 , null
						 , null
						 , 100
						, callbackFunction
						, function (e:PlayerIOError):void {  Log.out( "ModelManager.errorHandler - e: " + e ); } );
		}
		
		public function loadPublicObjects( userName:String, callbackFunction:Function ):void {
			Persistance.loadRange( Persistance.DB_TABLE_OBJECTS
						 , "voxelModelOwner"
						 , ["Public"]
						 , null
						 , null
						 , 100
						, callbackFunction
						, function (e:PlayerIOError):void {  Log.out( "ModelManager.errorHandler - e: " + e ); } );
		}

		public function TestCheckForFlow():void
		{
			for each ( var vm:VoxelModel in _modelInstances )
			{
				if ( vm is Player )
					continue;
				
				vm.flow( 6, 9 );	
			}
			
		}
	}
}