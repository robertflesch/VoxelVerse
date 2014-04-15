/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.ParticlePool;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import flash.display3D.Context3D;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Particle extends VoxelModel 
	{
		public function Particle( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
		}

		override public function update(context:Context3D, elapsedTimeMS:int):void 
		{
			super.update(context, elapsedTimeMS);
		}
		
		// Since these stick around in the pools, we dont want to fully release them.
		override public function release():void 
		{
			//Log.out( "Particle.release - guid: " + instanceInfo.instanceGuid );
			instanceInfo.dead = false;
			ParticlePool.poolDispose( this );
		}
		
	}
}
