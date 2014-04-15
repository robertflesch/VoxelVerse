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
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.Globals;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestZBuffer extends LandscapeTask 
	{		
		public function TestZBuffer( guid:String,layer:LayerInfo ):void {
			trace( "TestZBuffer of type: " + (Globals.Info[layer.type].name.toUpperCase()) );					
			super(guid, layer);
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//////////////////////////////////////////////////////////
			// Builds Solid Cube of any grain size
			//////////////////////////////////////////////////////////
			var grain_size:int = 1;
			var oxel:Oxel;
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var gc:GrainCursor = GrainCursorPool.poolGet(vm.oxel.size_of_grain());
			var bg:uint = vm.oxel.size_of_grain();
			
			gc.set_values( 0, 0, 0, gc.grain );
			for ( var i:int = 0; i < _layer.range; i++ )
			{
				for ( var j:int = 0; j < _layer.range; j++ )
				{
					gc.grainX = i;
					gc.grainY = j;
					vm.write( gc, _layer.type );
				}
			}

			gc.set_values( 0, 0, 0, gc.grain );
			gc.move_posz();
			gc.become_child();
			gc.move_posz();
			
			for ( i = 0; i < (_layer.range * 2); i++ )
			{
				for ( j = 0; j < (_layer.range * 2); j++ )
				{
					gc.grainX = i;
					gc.grainY = j;
					vm.write( gc, _layer.offset );
				}
			}
			
			trace( "TestZBuffer - took: "  + (getTimer() - timer) );					
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
