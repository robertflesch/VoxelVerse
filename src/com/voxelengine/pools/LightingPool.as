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
import com.voxelengine.Log;
import com.voxelengine.worldmodel.oxel.Lighting;
     
public final class LightingPool
{ 
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Lighting>; 
	
	static public function remaining():uint { return _counter; }
	static public function totalUsed():uint { return _currentPoolSize - _counter; }
	static public function total():uint { return _currentPoolSize; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		GROWTH_VALUE = growthValue; 
		_counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		_pool = new Vector.<Lighting>(_currentPoolSize); 
		while( --i > -1 ) 
			_pool[i] = new Lighting(); 
	} 
	 
	public static function poolGet():Lighting 
	{ 
		if ( _counter > 0 ) 
		{
			return _pool[--_counter]; 
		}
			 
		Log.out( "BrightnessPool.poolGet - Allocating more Brightness: " + _currentPoolSize );
		var timer:int = getTimer();

		_currentPoolSize += GROWTH_VALUE;
		_pool = null
		_pool = new Vector.<Lighting>(_currentPoolSize);
		for ( var newIndex:int = 0; newIndex < GROWTH_VALUE; newIndex++ )
		{
			_pool[newIndex] = new Lighting();
		}
		_counter = newIndex - 1; 
		
		Log.out( "BrightnessPool.poolGet - Done allocating more Brightness: " + _currentPoolSize  + " took: " + (getTimer() - timer) );
		return poolGet(); 
	} 

	public static function poolReturn( $disposedBrightness:Lighting ):void 
	{ 
		if ( !$disposedBrightness )
		{
			Log.out( "BrightnessPool.poolReturn - displosedBrightness is NULL" );
			return;
		}
		$disposedBrightness.reset();	
		_pool[_counter++] = $disposedBrightness; 
	} 
} 
}

