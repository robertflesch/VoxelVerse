/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
import flash.utils.getTimer;

import com.voxelengine.Globals;
import com.voxelengine.Log;

import com.voxelengine.worldmodel.oxel.GrainCursor;
import com.voxelengine.pools.GrainCursorPool;
import com.voxelengine.worldmodel.biomes.LayerInfo;
import com.voxelengine.worldmodel.oxel.Oxel;
import com.voxelengine.worldmodel.models.VoxelModel;
import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;

/**
 * ...
 * @author Robert Flesch
 */
public class GenerateWater extends LandscapeTask 
{		
	public function GenerateWater( guid:String, layer:LayerInfo ):void {
		trace( "GenerateWater - created" );					
		super(guid, layer);
	}
	
	override public function start():void {
		super.start();
		var timer:int = getTimer();
		trace( "GenerateWater.start - enter: ", Log.ERROR );					
		var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
		if ( vm )
		{
			// this gives us a general range
			var rangeInG0:int = vm.oxel.size_in_world_coordinates() * _layer.offset / 100;
			var gct:GrainCursor = GrainCursorPool.poolGet( vm.oxel.gc.bound );
			// this finds a g0 at that point
			GrainCursor.getFromPoint( 0, rangeInG0, 0, gct );
			// this gives us the minGrain loction that holds the g0
			var minGrain:int = 4; // make it to the closest meter
			gct.become_ancestor( minGrain );
			// so our grain height is forced to be a subset of the g minGrain range.
			// so we don't end up on odd grain values.
			rangeInG0 = gct.getModelY();
			GrainCursorPool.poolDispose( gct );
			
			trace( "GenerateWater.start - water height: " + rangeInG0 );	
			vm.oxel.layDownWater( rangeInG0 );
			Log.out( "GenerateWater.start - CREATED CHILDREN: " + Oxel.TEMP_COUNT );

		}
		else
			Log.out( "GenerateWater.start - VM not found for guid: " + _guid );
		
		trace( "GenerateWater.start - complete - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime), Log.ERROR );	
		super.complete();
	}
	
	override public function cancel():void {
		// TODO stop this somehow?
		super.cancel();
	}
}
}