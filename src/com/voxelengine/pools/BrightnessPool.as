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
import com.voxelengine.worldmodel.oxel.Brightness;
     
public final class BrightnessPool
{ 
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Brightness>; 
	
	static public function remaining():uint { return _counter; }
	static public function totalUsed():uint { return _currentPoolSize - _counter; }
	static public function total():uint { return _currentPoolSize; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		GROWTH_VALUE = growthValue; 
		_counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		_pool = new Vector.<Brightness>(_currentPoolSize); 
		while( --i > -1 ) 
			_pool[i] = new Brightness(); 
	} 
	 
	public static function poolGet():Brightness 
	{ 
		if ( _counter > 0 ) 
		{
			return _pool[--_counter]; 
		}
			 
		Log.out( "BrightnessPool.poolGet - Allocating more Brightness: " + _currentPoolSize, Log.ERROR );

		const newPoolSize:int = _currentPoolSize + GROWTH_VALUE;
		var newPool:Vector.<Brightness> = new Vector.<Brightness>(newPoolSize);
		for ( var index:int = 0; index < _currentPoolSize; index++ )
		{
			newPool[index] = _pool[index];
		}
		for ( var newIndex:int = _currentPoolSize; newIndex < newPoolSize; newIndex++ )
		{
			newPool[newIndex] = new Brightness();
		}
		
		_counter = _currentPoolSize; 
		_currentPoolSize += GROWTH_VALUE;
		_pool = null
		_pool = newPool;
		newPool = null;
		
		return poolGet(); 
		 
	} 

	public static function poolReturn( $disposedBrightness:Brightness ):void 
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

