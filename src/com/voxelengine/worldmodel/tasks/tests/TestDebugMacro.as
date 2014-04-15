/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.tests
{
	import com.voxelengine.worldmodel.biomes.*;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.GrainCursorUtils;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.Globals;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class TestDebugMacro extends LandscapeTask 
	{		
		public function TestDebugMacro( guid:String, layer:LayerInfo ):void {
			//trace( "TestDebugMacro created" );					
			super(guid, layer);
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//////////////////////////////////////////////////////////
			// Builds Solid Cube of any grain size
			//////////////////////////////////////////////////////////
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var gc:GrainCursor = GrainCursorPool.poolGet(vm.oxel.gc.bound);
			gc.copyFrom(vm.oxel.gc);
			//GrainCursorUtils.debug_macro( gc, _layer.data, vm.oxel );
			GrainCursorPool.poolDispose(gc);
			
			
			//vm.print();
			
			trace( "TestDebugMacro.start - took: "  + (getTimer() - timer) );					
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}
