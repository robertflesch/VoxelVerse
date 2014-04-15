/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{

import com.voxelengine.renderer.VertexIndexBuilder;
import com.voxelengine.Log;
     
public final class VertexIndexBuilderPool 
{ 
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var counter:uint; 
	private static var pool:Vector.<VertexIndexBuilder>; 
	private static var currentVIB:VertexIndexBuilder; 
	
	static public function remaining():uint { return counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - counter; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		GROWTH_VALUE = growthValue; 
		counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		pool = new Vector.<VertexIndexBuilder>(_currentPoolSize); 
		while( --i > -1 ) 
			pool[i] = new VertexIndexBuilder(); 
	} 
	 
	public static function poolGet():VertexIndexBuilder 
	{ 
		if ( counter > 0 ) 
			return currentVIB = pool[--counter]; 
			 
		var i:uint = GROWTH_VALUE;
		_currentPoolSize += GROWTH_VALUE;
		Log.out( "VertexIndexBuilderPool.poolGet - Allocating more VertexBuffers: " + _currentPoolSize, Log.ERROR );
		if ( 4096 < _currentPoolSize )
			Log.out( "VertexIndexBuilderPool.poolGet - Trying to allocated more then 4096 total VertexBuffers: " + _currentPoolSize, Log.ERROR );
		while( --i > -1 ) 
				pool.unshift ( new VertexIndexBuilder() ); 
		counter = GROWTH_VALUE; 
		return poolGet(); 
		 
	} 

	public static function poolDispose(disposedVIB:VertexIndexBuilder):void 
	{ 
		disposedVIB.release();
		pool[counter++] = disposedVIB; 
	} 
} 
}

