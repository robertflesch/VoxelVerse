/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.tests
{
	import com.voxelengine.worldmodel.Biomes;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.Globals;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestGrain0inCenter extends LandscapeTask 
	{		
		public function TestGrain0inCenter( guid:String,layer:LayerInfo ):void {
			trace( "TestGrain0inCorner of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer);
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//////////////////////////////////////////////////////////
			// Builds Solid Cube of any grain size
			//////////////////////////////////////////////////////////
			var grain_size:int = 0;
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var gc:GrainCursor = GrainCursorPool.poolGet(vm.oxel.size_of_grain());
			//var max:uint = gc.edgeval( vm.oxel.size_of_grain() );
			//trace( gc.edgeval( vm.oxel.size_of_grain() ) );
			//var oxel:Oxel;
			//
			//gc.set_values( max/2, max/2, max/2, gc.grain );
			//oxel = vm.oxel.childFind( gc, true );
			//oxel.type = Globals.AIR;
			
			trace( gc.edgeval( vm.oxel.size_of_grain() ) );
			trace( vm.oxel.size_of_grain() / 120 );
			
			trace( "TestGrain0inCorner - took: "  + (getTimer() - timer) );					
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
