/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import flash.utils.getTimer;
	
	import com.voxelengine.Globals;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class OutlineBoundries extends LandscapeTask 
	{		
		public function OutlineBoundries( guid:String,layer:LayerInfo ):void {
			trace( "OutlineBoundries" );					
			super(guid, layer);
		}
		
		override public function start():void {
            super.start() // AbstractTask will send event
			
			var timer:int = getTimer();
			
			//Globals.g_seed = 0;
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var masterMapSize:uint = Math.min( vm.oxel.size_in_world_coordinates(), 1024 );
			
			var gc:GrainCursor = GrainCursorPool.poolGet( vm.oxel.gc.bound );
			
			
			
			var index:int = 0;
			var bid:int = 0;
			const end:int = vm.oxel.gc.size();
			
			var y:int = 0;

			gc.set_values( 0, 0, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_RED, true );
				gc.move_posy();
			}
			
			gc.set_values( end - 1, 0, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_RED, true );
				gc.move_posy();
			}
			
			gc.set_values( end - 1, 0, end - 1, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_RED, true );
				gc.move_posy();
			}
			
			gc.set_values( 0, 0, end - 1, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_RED, true );
				gc.move_posy();
			}
			
		
			gc.set_values( 0, 0, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_BLUE, true );
				gc.move_posx();
			}
			
			gc.set_values( 0, end - 1, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_BLUE, true );
				gc.move_posx();
			}
			
			gc.set_values( 0, 0, end - 1, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_BLUE, true );
				gc.move_posx();
			}
			
			gc.set_values( 0, end - 1, end - 1, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_BLUE, true );
				gc.move_posx();
			}
			
			gc.set_values( 0, 0, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_GREEN, true );
				gc.move_posz();
			}
			
			gc.set_values( end - 1, 0, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_GREEN, true );
				gc.move_posz();
			}
			
			gc.set_values( 0, end - 1, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_GREEN, true );
				gc.move_posz();
			}
			
			gc.set_values( end - 1, end - 1, 0, 0 );
			for ( y = 0; y < end; y++ ) 
			{
				vm.oxel.write(  gc, Globals.BORDER_GREEN, true );
				gc.move_posz();
			}
			
			//trace( "OutlineBoundries - completed layer of type: " + (Globals.Info[_layer.type].name.toUpperCase()) + "  range: " + _layer.range + "  offset: " + _layer.offset + " took: " + (getTimer()-timer) + " in queue for: " + (timer-_startTime));
            super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}