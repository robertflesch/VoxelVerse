/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import flash.geom.Vector3D;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	import com.voxelengine.events.TargetEvent;
	import com.voxelengine.events.ImpactEvent;
	
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	//import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Target extends VoxelModel 
	{
		private var _pointValue:int = 10;
		
		public function Target( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			Globals.g_app.dispatchEvent( new TargetEvent( TargetEvent.CREATED, instanceInfo.instanceGuid, _pointValue ) );
			//WindowScore.instance.register();
		}

		// I removed the responses, not sure what should be done here.
		//override public function explosionResponse( center:Vector3D, ee:ImpactEvent ):void
		//{
			/*
			var ba:ByteArray = Globals.g_modelManager.findIVM( modelInfo.biomes.layers[0].data );
			statisics.gather( ba, oxel.gc.grain );
			statisics.statsPrint();
			var oldCount:int = statisics.countInMeters;
			trace( "old count in meters: " + oldCount );
			
//			super.explosionResponse( center, ee );
			

			var newBa:ByteArray = new ByteArray();
			newBa.clear();
			oxel.writeData( newBa );
			newBa.position = 0;
			statisics.gather( newBa, oxel.gc.grain );
			statisics.statsPrint();
			var newCount:int = statisics.countInMeters;
			trace( "new count in meters: " + newCount );
			if ( 0 == newCount )
				Globals.g_app.dispatchEvent( new TargetEvent( TargetEvent.DESTROYED, instanceInfo.instanceGuid, 10 ) );
			else
				Globals.g_app.dispatchEvent( new TargetEvent( TargetEvent.DAMAGED, instanceInfo.instanceGuid, 10 ) );
			*/				
			//Globals.g_app.dispatchEvent( new TargetEvent( TargetEvent.DESTROYED, instanceInfo.instanceGuid, _pointValue ) );
//			explode(1);	
			//instanceInfo.dead = true;
		//}
	}
}
