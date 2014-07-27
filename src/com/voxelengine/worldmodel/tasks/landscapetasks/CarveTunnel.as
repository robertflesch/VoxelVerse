/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.biomes.*;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.Globals;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * 
	 * 	const numOfTunnel:uint = 1;
		const tunnelLength:uint = 256;
		const tunnelRadius:uint = 64;
		var layer:LayerInfo = new LayerInfo( "CarveTunnel", "", Globals.AIR, tunnelRadius, numOfTunnel, "", tunnelLength );
	 * 
	 * 
	 * @author Robert Flesch
	 */
	public class CarveTunnel extends LandscapeTask 
	{		
		public function CarveTunnel( guid:String,layer:LayerInfo ):void {
			trace( "CarveTunnel - created" );					
			super(guid,layer);
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
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
			
			if ( Globals.g_modelManager._gci ) {
				
				var sx:int = Globals.g_modelManager._gci.point.x;				
				var sy:int = Globals.g_modelManager._gci.point.y;				
				var sz:int = Globals.g_modelManager._gci.point.z;				
			}
			else 
			{
				super.complete()
				return;
			}
				
			trace( "CarveTunnel.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " starting at x: " + sx + "  y: " + sy + "  z: " + sz );					
			
			// I need a normalize view vector
			// And then expand from that location
			var vv:Vector3D = Globals.g_modelManager.viewVectorNormalizedGet();
			var stepSize:int = 24;
			vv.scaleBy( stepSize );
			for ( var i:int = 1; i < tunnelLength/stepSize; i++ ) {
				//vm.oxel.write_sphere( _guid, sx, sy, sz, Math.min( 36, Math.random() * 96), Globals.AIR, 3);
				//vm.oxel.write_sphere( _guid, sx, sy, sz, stepSize * 1.5, Globals.AIR, 3);
				var dia:int = Math.min( tunnelRadius * 0.85, Math.random() * tunnelRadius * 4);
				vm.oxel.write_sphere( _guid, sx, sy, sz, dia, Globals.AIR, 3);
				sx += vv.x + Math.random() * 5;
				sy += vv.y + Math.random() * 5;
				sz += vv.z + Math.random() * 5;
				trace( "CarveTunnel.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " next at x: " + sx + "  y: " + sy + "  z: " + sz );					
			}

			trace( "CarveTunnel - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime)  );
			merge( vm.oxel );
            super.complete() // AbstractTask will send event
		}

	}
}