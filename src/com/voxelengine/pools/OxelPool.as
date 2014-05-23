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
import com.voxelengine.worldmodel.oxel.Oxel
     
public final class OxelPool 
{ 
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Oxel>; 
	private static var _currentOxel:Oxel; 
	
	static public function remaining():uint { return _counter; }
	static public function totalUsed():uint { return _currentPoolSize - _counter; }
	static public function total():uint { return _currentPoolSize; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		GROWTH_VALUE = growthValue; 
		_counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		_pool = new Vector.<Oxel>(_currentPoolSize); 
		while( --i > -1 ) 
			_pool[i] = new Oxel(); 
	} 
	 
	public static function poolGet():Oxel 
	{ 
		if ( _counter > 0 ) 
		{
			_currentOxel = _pool[--_counter]; 
			
			//Log.out( "OxelPool.oxel_get: " + getMemoryHash( _currentOxel ) + " currentCount: " + _counter );
			return _currentOxel;
		}
			 
		Log.out( "OxelPool.poolGet - Allocating more Oxel: " + _currentPoolSize, Log.ERROR );
		var timer:int = getTimer();

		const newPoolSize:int = _currentPoolSize + GROWTH_VALUE;
		var newPool:Vector.<Oxel> = new Vector.<Oxel>(newPoolSize);
		for ( var index:int = 0; index < _currentPoolSize; index++ )
		{
			newPool[index] = _pool[index];
		}
		for ( var newIndex:int = _currentPoolSize; newIndex < newPoolSize; newIndex++ )
		{
			newPool[newIndex] = new Oxel();
		}
		
		_counter = _currentPoolSize; 
		_currentPoolSize += GROWTH_VALUE;
		_pool = null
		_pool = newPool;
		newPool = null;
		
		Log.out( "OxelPool.poolGet - Done allocating more Oxel: " + newPoolSize  + " took: " + (getTimer() - timer), Log.ERROR );
		
		return poolGet(); 
		 
	} 

	public static function poolDispose( $disposedOxel:Oxel):void 
	{ 
		_pool[_counter++] = $disposedOxel; 
	} 
	
	static private function getMemoryHash( oxel:Oxel ):String
	{
		var memoryHash:String;
		try
		{
			FakeClass(_currentOxel);
		}
		catch (e:Error)
		{
			memoryHash = String(e).replace(/.*([@|\$].*?) to .*$/gi, '$1');
		}
		return memoryHash;
	}
} 
}

internal final class FakeClass { }
