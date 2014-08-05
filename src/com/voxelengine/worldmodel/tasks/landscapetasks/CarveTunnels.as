/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.groups.TaskGroup;
	
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	
	public class CarveTunnels extends LandscapeTask 
	{		
		public var startLoc:Vector3D;
		public var view:Vector3D;
		public var radiusMultiplierMax:Number = 16;
		public var radiusMultiplierMin:Number = 0.85;
		public var stepSize:int = 24;
		
		static private var _crossList:Vector.<Vector3D>;
		static private const CROSS_LIST_SIZE:int = 26;
		
		static public function contructor( $guid:String, $start:Vector3D, $view:Vector3D, $type:int, $length:int, $radius:int, $minGrain:int = 4 ):void {
			
			//public function LayerInfo( functionName:String = null, data:String = "", type:int = 0 , range:int = 0, offset:int = 0, optional1:String = "", optional2:int = 0 )
			var layer:LayerInfo = new LayerInfo( "CarveTunnels", "", $type, $length, $radius, "", $minGrain );
			var ct:CarveTunnels = new CarveTunnels( $guid, layer );
			ct.startLoc = $start.clone();
			ct.view = $view.clone();
			var taskGroup:TaskGroup = new TaskGroup("CarveTunnels for " + $guid, 2);
			taskGroup.addTask( ct );
			Globals.g_landscapeTaskController.addTask( taskGroup );
		}
		
		public function CarveTunnels( guid:String,layer:LayerInfo ):void {
			super(guid,layer);
		}
		
		static private function crossListGet():Vector3D { 
		
			if ( null == _crossList )
				crossListCreate();
			var index:int = Math.random() * CROSS_LIST_SIZE;
			if ( CROSS_LIST_SIZE <= index )
				index = Math.random() * CROSS_LIST_SIZE;
				
			trace( "CrossLIst index: " + index );
			return _crossList[index];	
		}
		
		static private function crossListCreate():void { 
			_crossList = new Vector.<Vector3D>(CROSS_LIST_SIZE, true);
			var index:int
			_crossList[index++] = new Vector3D( 0, 0, 1 );
			_crossList[index++] = new Vector3D( 0, 0, -1 );
			_crossList[index++] = new Vector3D( 0, 1, 0 );
			_crossList[index++] = new Vector3D( 0, -1, 0 );
			_crossList[index++] = new Vector3D( 0, 1, 1 );
			_crossList[index++] = new Vector3D( 0, -1, 1 );
			_crossList[index++] = new Vector3D( 0, 1, -1 );
			_crossList[index++] = new Vector3D( 0, -1, -1 );
			_crossList[index++] = new Vector3D( 1, 0, 0 );
			_crossList[index++] = new Vector3D( -1, 0, 0 );
			_crossList[index++] = new Vector3D( 1, 0, 1 );
			_crossList[index++] = new Vector3D( 1, 0, -1 );
			_crossList[index++] = new Vector3D( -1, 0, 1 );
			_crossList[index++] = new Vector3D( -1, 0, -1 );
			_crossList[index++] = new Vector3D( 1, 1, 0 );
			_crossList[index++] = new Vector3D( 1, -1, 0 );
			_crossList[index++] = new Vector3D( -1, 1, 0 );
			_crossList[index++] = new Vector3D( -1, -1, 0 );
			_crossList[index++] = new Vector3D( 1, 1, 1 );
			_crossList[index++] = new Vector3D( 1, 1, -1 );
			_crossList[index++] = new Vector3D( 1, -1, 1 );
			_crossList[index++] = new Vector3D( 1, -1, -1 );
			_crossList[index++] = new Vector3D( -1, 1, 1 );
			_crossList[index++] = new Vector3D( -1, 1, -1 );
			_crossList[index++] = new Vector3D( -1, -1, 1 );
			_crossList[index++] = new Vector3D( -1, -1, -1 );
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			var timer:int = getTimer();
            var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			if ( !vm ) {
				super.complete() // AbstractTask will send event
				return;
			}
			
            var tunnelLength:int =_layer.range;
            var tunnelRadius:int =_layer.offset;
			var voxelType:int = _layer.type;
			var minGrain:int = _layer.optionalInt;
			
			trace( "CarveTunnels.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " starting at x: " + startLoc.x + "  y: " + startLoc.y + "  z: " + startLoc.z );					
			
			view.scaleBy( stepSize );
			for ( var i:int = 1; i < tunnelLength / stepSize; i++ ) {
				
				var radius:int = Math.min( tunnelRadius * radiusMultiplierMin, Math.random() * tunnelRadius * radiusMultiplierMax );
				vm.oxel.write_sphere( _guid, startLoc.x, startLoc.y, startLoc.z, radius, Globals.AIR, minGrain );
				startLoc.x += view.x + rndOffset( tunnelRadius );
				startLoc.y += view.y + rndOffset( tunnelRadius );
				startLoc.z += view.z + rndOffset( tunnelRadius );
				if ( 0.90 < Math.random() ) {
					trace( "CarveTunnels.start - Carve SIDE TUNNEL ---------------------------------------------------------------" );					
					var vv:Vector3D = Globals.g_modelManager.viewVectorNormalizedGet();
					vv = vv.crossProduct( crossListGet() );
					CarveTunnels.contructor( _guid
								 , startLoc
								 , vv
								 , Globals.AIR
								 , tunnelLength / 2
								 , tunnelRadius * 0.75 );

				}
				//trace( "CarveTunnels.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " next at x: " + startLoc.x + "  y: " + startLoc.y + "  z: " + startLoc.z );					
			}

			trace( "CarveTunnels - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime)  );
			merge( vm.oxel );
            super.complete() // AbstractTask will send event
		}
		
		private function rndOffset( $max:int ):int {
			
			var offset:int = 0.5 < Math.random() ? -Math.random() * $max/2 : Math.random() * $max/2
			//trace( "rndOffset: " + offset );
			return offset;
		}

	}
}