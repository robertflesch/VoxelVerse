/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
import com.voxelengine.Globals;
import com.voxelengine.Log;
import com.voxelengine.worldmodel.biomes.LayerInfo;
import com.voxelengine.worldmodel.models.VoxelModel;
import com.voxelengine.worldmodel.oxel.Oxel;
import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;

import flash.utils.getTimer;

/**
 * ...
 * @author Robert Flesch
 */
public class GrowTreesOn extends LandscapeTask 
{		
	public function GrowTreesOn( guid:String, layer:LayerInfo ):void {
		Log.out( "GrowTreesOn.created", Log.WARN );					
		super(guid, layer);
	}
	
	override public function start():void {
		super.start();
		var timer:int = getTimer();
		
		Log.out( "GrowTreesOn.start - enter: ", Log.ERROR);					
		var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
		if ( vm )
		{
			// This should be 1 - 100 range
			//var outOf:int = _layer.range;
			//vm.oxel.growTreesOn( _layer.type, outOf ? outOf : 2000 );
			// 100 is 100
			// 1 is 2000
			var outOf:int = 81 + 1900/_layer.range;
			vm.oxel.growTreesOn( _guid, _layer.type, outOf ? outOf : 1000 );
		}
		else
			Log.out( "GrowTreesOn.start - VM not found for guid: " + _guid );

		Log.out( "GrowTreesOn.start - took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime), Log.ERROR );	
		
		super.complete();
	}
	
	override public function cancel():void {
		// TODO stop this somehow?
		super.cancel();
	}
}
}