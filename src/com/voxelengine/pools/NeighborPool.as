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
import com.voxelengine.worldmodel.oxel.Oxel;
     
public final class NeighborPool 
{ 
	private static const COUNT:int = 6;
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var counter:uint; 
	private static var pool:Vector.<Vector.<Oxel>>; 
	private static var currentNeighbor:Vector.<Oxel>; 
	
	static public function remaining():uint { return counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - counter; }

	public static function initialize( initialPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = initialPoolSize; 
		GROWTH_VALUE = growthValue; 
		
		counter = _currentPoolSize; 
		var i:uint = _currentPoolSize; 
		pool = new Vector.<Vector.<Oxel>>(_currentPoolSize); 
		while( --i > -1 ) 
			pool[i] = new Vector.<Oxel>( 6 , true ); 
	} 
	 
	public static function poolGet():Vector.<Oxel> 
	{ 
		if ( counter > 0 ) {
			currentNeighbor = pool[--counter];
			return currentNeighbor; 
		}
			 
		var i:uint = GROWTH_VALUE; 
		_currentPoolSize += GROWTH_VALUE;
		Log.out( "NeighborPool  - Allocating more Neighbors: " + _currentPoolSize, Log.ERROR );
		while( --i > -1 ) 
				pool.unshift ( new Vector.<Oxel>( COUNT , true ) ); 
		counter = GROWTH_VALUE; 
		return poolGet(); 
		 
	} 

	public static function poolDispose(disposedNeighbor:Vector.<Oxel>):void 
	{ 
		for ( var i:int = 0; i < COUNT; i++ )
			disposedNeighbor[i] = null;

		pool[counter++] = disposedNeighbor; 
	} 
} 
}

