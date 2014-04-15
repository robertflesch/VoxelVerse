/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks
{
	import com.voxelengine.worldmodel.Biomes;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.tasks.landscapetasks.LandscapeTask;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class Dummy extends LandscapeTask
	{		
		public function Dummy( guid:String,layer:LayerInfo ):void {
			trace( "Dummy.construct" );					
			super(guid, layer);
		}
		
		override public function start():void {
			super.start() // AbstractTask will send event
			trace( "Dummy.start - enter/exit" );		
			super.complete() // AbstractTask will send event
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}