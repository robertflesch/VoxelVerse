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
			
			var tunnelLength:int = Math.random() * 500;
			if ( 0 <_layer.optionalInt )
				tunnelLength =_layer.optionalInt;
            var tunnelRadius:int =_layer.range;
			var voxelType:int = _layer.type;
			
            // pick a random starting location
			var sx:int = vm.editCursor.instanceInfo.positionGet.x;
            var sy:int = vm.editCursor.instanceInfo.positionGet.y;
            var sz:int = vm.editCursor.instanceInfo.positionGet.z;
			trace( "CarveTunnel.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " starting at x: " + sx + "  y: " + sy + "  z: " + sz );					
			
			// I need a normalize view vector
			// And then expand from that location
			var vv:Vector3D = Globals.g_modelManager.getViewVectorNormalized();
			vv.scaleBy( 24 );
			for ( var i:int = 1; i < 50; i++ ) {
				vm.oxel.write_sphere( _guid, sx, sy, sz, Math.min( 32, Math.random() * 64), Globals.AIR, 3);
				//vm.oxel.write_sphere( _guid, sx, sy, sz, 48, Globals.AIR, 3);
				sx += vv.x;
				sy += vv.y;
				sz += vv.z;
				trace( "CarveTunnel.start - carving tunnel of type " + (Globals.Info[voxelType].name.toUpperCase()) + " next at x: " + sx + "  y: " + sy + "  z: " + sz );					
			}

			trace( "CarveTunnel - took: " + (getTimer() - timer) + " in queue for: " + (timer-_startTime)  );					
            super.complete() // AbstractTask will send event
		}

	}
}