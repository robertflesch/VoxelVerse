/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{

import flash.utils.getTimer;
import com.voxelengine.worldmodel.oxel.GrainCursor
import com.voxelengine.Log;
     
public final class GrainCursorPool 
{ 
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var counter:uint; 
	private static var pool:Vector.<GrainCursor>; 
	private static var currentGrainCursor:GrainCursor; 
	
	static public function remaining():uint { return counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - counter; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		GROWTH_VALUE = growthValue; 
		counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		pool = new Vector.<GrainCursor>(_currentPoolSize); 
		while( --i > -1 ) 
			pool[i] = new GrainCursor(); 
	} 
	 
	public static function poolGet( boundingGrain:int ):GrainCursor 
	{ 
		if ( counter > 0 ) {
			currentGrainCursor = pool[--counter];
			currentGrainCursor.bound = boundingGrain;
			return currentGrainCursor; 
		}
			 
		Log.out( "GrainCursorPool.poolGet - Allocating more GrainCursors: " + _currentPoolSize, Log.ERROR );
		var timer:int = getTimer();

		const newPoolSize:int = _currentPoolSize + GROWTH_VALUE;
		var newPool:Vector.<GrainCursor> = new Vector.<GrainCursor>(newPoolSize);
		for ( var index:int = 0; index < _currentPoolSize; index++ )
		{
			newPool[index] = pool[index];
		}
		for ( var newIndex:int = _currentPoolSize; newIndex < newPoolSize; newIndex++ )
		{
			newPool[newIndex] = new GrainCursor();
		}
		
		counter = _currentPoolSize; 
		_currentPoolSize += GROWTH_VALUE;
		pool = null
		pool = newPool;
		newPool = null;
		
		Log.out( "GrainCursorPool.poolGet - Done allocating more GrainCursors: " + newPoolSize  + " took: " + (getTimer() - timer), Log.ERROR );
		return poolGet(boundingGrain); 
		 
	} 

	public static function poolDispose(disposedGrainCursor:GrainCursor):void 
	{ 
		disposedGrainCursor.reset();
		pool[counter++] = disposedGrainCursor; 
	} 
} 
}

