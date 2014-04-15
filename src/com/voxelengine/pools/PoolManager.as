/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{

import com.voxelengine.Log;
import com.voxelengine.pools.*;
import com.voxelengine.worldmodel.MemoryManager;
     
	public final class PoolManager
	{ 
		// this uses up 3.6 gig of memory
		//private static const INITIAL_POOL_SETTINGS:int = 1200000;
		// this uses up ?? gig of memory
		//private static const INITIAL_POOL_SETTINGS:int = 600000;
		// this uses up 1.2 gig of memory
		//private static const INITIAL_POOL_SETTINGS:int = 400000;
		// USE THIS FOR ISLANDS (g12)
		// this uses up 687 meg of memory
		//private static const INITIAL_POOL_SETTINGS:int = 250000;
		// this uses up 424 meg of memory
		// This is minimum kickstarter setting
		//private static const INITIAL_POOL_SETTINGS:int = 100000;
		private static const INITIAL_POOL_SETTINGS:int = 30000;
		// this uses up 157 meg of memory
		//private static const INITIAL_POOL_SETTINGS:int = 1000;
		
		public function PoolManager()
		{
			MemoryManager.initialize();
			ChildOxelPool.initialize( INITIAL_POOL_SETTINGS, INITIAL_POOL_SETTINGS* 2/8 );
			QuadPool.initialize( INITIAL_POOL_SETTINGS * 4, INITIAL_POOL_SETTINGS/2 );
			QuadsPool.initialize( INITIAL_POOL_SETTINGS * 1.7, INITIAL_POOL_SETTINGS/6 );
			BrightnessPool.initialize( INITIAL_POOL_SETTINGS * 10, INITIAL_POOL_SETTINGS/50 );
			NeighborPool.initialize( INITIAL_POOL_SETTINGS * 2.5, INITIAL_POOL_SETTINGS );
			VertexIndexBuilderPool.initialize( INITIAL_POOL_SETTINGS/100, INITIAL_POOL_SETTINGS/200 );
			// These two should always be the same
			GrainCursorPool.initialize( INITIAL_POOL_SETTINGS * 6, INITIAL_POOL_SETTINGS );
			OxelPool.initialize( INITIAL_POOL_SETTINGS * 6, INITIAL_POOL_SETTINGS );
			ParticlePool.initialize( INITIAL_POOL_SETTINGS/1000, INITIAL_POOL_SETTINGS/200 );
			ProjectilePool.initialize( INITIAL_POOL_SETTINGS/1000, INITIAL_POOL_SETTINGS/200 );
		}
	}

}

